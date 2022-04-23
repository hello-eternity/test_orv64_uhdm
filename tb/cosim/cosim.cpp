#include <stdio.h>
#include <stdlib.h>
#include <svdpi.h>
#include <fcntl.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <unistd.h>
#include <errno.h>
#include <signal.h>
#include <vector>

int io = -1;
pid_t spike_pid;

int lsexec3(int* io_fd, char *img_path)
{
    int fd[2];
    char buf[BUFSIZ];
    int len = 0;
    int flags;
    
    socketpair(AF_UNIX, SOCK_STREAM, 0, fd);

    spike_pid = fork();
    if(spike_pid < 0) 
    {
      fprintf(stdout, "fork error!\n");
      exit(-1);
    }
    if(spike_pid > 0)
    { //parent
        close(fd[1]);
        *io_fd = fd[0];
        sleep(1);
        return 0;
    }
    else
    { //child
        close(fd[0]);
        dup2(fd[1], STDERR_FILENO);
        return execlp("spike", "spike", "--isa=RV64IMAFDC", "-d", img_path, (int*)0);
    }
}

int exec_spike_cmd(int fd, char *cmd, char *out, int size, bool has_echo)
{
    int timer = 0;
    int len = 0, len_total = 0;
    write(fd, cmd, strlen(cmd)); 
    while (1)
    {
        len = read(fd, out + len_total, size);
        if (len >= 0)
        {
            len_total += len;
            if (has_echo && (out[len_total - 1] == ' ' && out[len_total - 2] == ':' && out[len_total - 3] == '\n'))
                break;
            if ((!has_echo) && (out[len_total - 1] == ' ' && out[len_total - 2] == ':'))
                break;
        }
        usleep(10);
        if (timer ++ >= 100000)   //~10s
        {
            out[len_total] = 0;
            fprintf(stdout, "cmd: %s, out: %s, len_total: %d\n", cmd, out, len_total);
            fprintf(stdout, "reading from spike time out!\n");
            kill(spike_pid, SIGKILL);
            exit(-1);
        }
    }
    out[len_total] = '\0';
    return len_total;
}

static const char *reg_name[31]=
{
  "ra", "sp", "gp", "tp", "t0", "t1", "t2", "s0", "s1", "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7", "s2", "s3",
  "s4", "s5", "s6", "s7", "s8", "s9", "s10", "s11", "t3", "t4", "t5", "t6"
};

//char outputbuf[BUFSIZ] = {0};

static void get_regs_from_spike(unsigned long long *regs, unsigned long long *pc)
{
  char buf[BUFSIZ];
  char cmpstr[256];
  int len;
  int i, k;

  buf[exec_spike_cmd(io, "pc 0\n", buf, BUFSIZ, true) - 3] = '\0';
  for (i = 0; buf[i] != '0' && i < 16; i++);
  *pc = strtoull(&buf[i], NULL, 16);
  len = exec_spike_cmd(io, "reg 0\n", buf, BUFSIZ, true) - 3;
  buf[len] = '\0';
  //strcpy(outputbuf, buf);
  //fprintf(stdout, "spike read regs: \"%s\"\n", buf);

  i = 0;
  for (k = 0; k < sizeof(reg_name) / sizeof(reg_name[0]); k++)
  {
    strcpy(cmpstr, reg_name[k]);
    strcat(cmpstr, strlen(reg_name[k]) == 2 ? "  : " : " : ");
    for (; i < len && memcmp(buf + i, cmpstr, strlen(cmpstr)); i++);
    if (i == len)
    {
      fprintf(stdout, "read reg err! can't find \"%s\" (%s)\n", reg_name[k], cmpstr);
      fprintf(stdout, "oringal output: \"%s\"\n", buf);
      fprintf(stdout, "len: %d\n", len);
      kill(spike_pid, SIGKILL);
      exit(-1);
    }
    regs[k] = strtoull(buf + i + strlen(cmpstr), NULL, 16);
  }

}

extern "C" void step_spike();
void step_spike()
{
  char buf[BUFSIZ];
  exec_spike_cmd(io, "\n", buf, BUFSIZ, true);
}

extern "C" void cosim_setup_callback(char* image);
void cosim_setup_callback(char* image)
{
  char buf[BUFSIZ];
  int len;
  fprintf(stdout, "cosim_setup_callback call\n");
  if(lsexec3(&io, (char *)image) == -1)
  {
      fprintf(stdout, "%s\n", strerror(errno));
      exit(-1);
  }
  fcntl(io, F_SETFL, fcntl(io, F_GETFL) | O_NONBLOCK);
  fprintf(stdout, "path: %s\n", image);
  len = exec_spike_cmd(io, "until pc 0 0x80000000\n", buf, BUFSIZ, false);
  fprintf(stdout, "spike running\n");
}


extern "C" void inst_finish_callback(svLogicVecVal regs[62], svLogicVecVal pc[2]);
void inst_finish_callback(svLogicVecVal regs[62], svLogicVecVal pc[2])
{
  int i;
  char cmd[256] = {0};
  bool incon = false;
  int incon_array[32] = {0};
  unsigned long long reg, addr;
  unsigned long long regs_spike[31];
  unsigned long long addr_spike;
  // get data from spike
  get_regs_from_spike(regs_spike, &addr_spike); // Gets the PC value of the instruction to be executed
  step_spike();                                 // actually execute the instruction
  // get_regs_from_spike(regs_spike, &addr);       // after execution, get the regfile
  // get data from simulator
  addr_spike &= 0x7fffffffff;
  addr = (((unsigned long long)(pc[1].aval)) << 32) | pc[0].aval;
  if (addr != addr_spike)
  {
    // fprintf(stdout, "spike pc: %016llx, simu pc: %016llx\n", addr_spike, addr);
    incon_array[0] = 1;
    incon = true;
  }
  for (i = 0; i < 31; i++)
  {
    reg = (((unsigned long long)(regs[i * 2 + 1].aval)) << 32) | regs[i * 2].aval;
    if (reg != regs_spike[i])
    {
      incon_array[i + 1] = 1;
      incon = true;
    }
  }

  if (incon)
  {
    fprintf(stdout, "\ninconsistency found!\ninconsist reg(s): ");
    for (i = 0; i < 32; i++)
    {
      if(incon_array[i])
      {
        i == 0 ? fprintf(stdout, "pc ") : fprintf(stdout, "%s ", reg_name[i - 1]);
      }
    }
    fprintf(stdout, "\nspike:    pc:%016llx\n", addr_spike);
    for (i = 0; i < 31; i++)
    {
      fprintf(stdout, "%s: %016llx\t", reg_name[i], regs_spike[i]);
      if (!((i + 1) % 4))
        fprintf(stdout, "\n");
    }

    fprintf(stdout, "\nsimulator:    pc:%016llx\n", addr);
    for (i = 0; i < 31; i++)
    {
      reg = (((unsigned long long)(regs[i * 2 + 1].aval)) << 32) | regs[i * 2].aval;
      fprintf(stdout, "%s: %016llx\t", reg_name[i], reg);
      if (!((i + 1) % 4))
        fprintf(stdout, "\n");
    }
    fprintf(stdout, "\n");
    kill(spike_pid, SIGKILL);
    exit(-1);
  }
}

extern "C" void cosim_exit_callback();
void cosim_exit_callback()
{
  kill(spike_pid, SIGKILL);
  fprintf(stdout, "cosim_exit_callback call\n");
}
