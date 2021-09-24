#ifndef _SOCKET_SERVER_C
#define _SOCKET_SERVER_C
#include "socket_server.h"

int main() {
  //! Declaration
  int serverSock; //Server Socket Descriptor
  int clientSock; //Client Socket Descriptor
  struct sockaddr_in serverAddr; // Local Address
  struct sockaddr_in clientAddr; // Client Addrress
  unsigned short serverPort = 8081;
  unsigned int clientLen; //Length of Client Address struct
  int clientSts;
  clientSts = 1;
  //! Create Server Socket
  createServerSock(&serverSock);
  fprintf(stdout,"Server: Created serverSock=%0d!\n",serverSock);
  //! Construct Local Address Struct
  configureServerAddr(&serverAddr,&clientLen,&clientAddr,&serverPort);
  fprintf(stdout,"Server: Configured clientLen=%0d!\n",clientLen);
  //! Bind Server
  bindServerSock(&serverSock,&serverAddr); 
  //! Listen to incoming client connections
  startListening(&serverSock);
  // !open dev mem and return fd
  open_fd();
  while(clientSts==1){
    acceptClientSock(&serverSock,&clientSock,&clientAddr,&clientLen);
    for(;;){
        clientSts = handleTcpClient(&clientSock);
        if(clientSts == 1){
          break;
        }
    }
    close(clientSock);
  }
  close_fd();
  exit(EXIT_SUCCESS);
}

void procReqDataFrmCl(uint8_t *buff, enum rst_mode_t rst_mode) {
  uint64_t gpio_addr = 0;
  int len = 16; //Bytes
  enum cmd_t cmd;
  enum rst_ctrl_t rst_ctrl;
  //fprintf(stdout,"Server: Processing CMD from Client...\n");
  if(buff[1] == 0x10){//BLOCK RAM
    if(buff[0] == 0x05){
      cmd = BREAD;
      //fprintf(stdout,"Server: Got CMD_BREAD...\n");
    }
    else if(buff[0] == 0x04) {
      cmd = BWRITE;
      //fprintf(stdout,"Server: Got CMD_BWRITE...\n");
    }
    else {
      cmd = ERR;
      fprintf(stderr,"Server: Illegal BRAM...\n");
      exit(EXIT_FAILURE);
    }
  }//RST or SPI FIXME SPI DISABLED
  else if(buff[0] == 0x05){
    cmd = READ;
    //fprintf(stdout,"Server: Got CMD_READ...\n");
    //fprintf(stderr,"ERROR CMD NOT EXPECTED: 0x%" PRIx8 "!\n",buff[0]);
    //exit(EXIT_FAILURE);
  }
  else if(buff[0] == 0x04) {
    cmd = WRITE;
    //fprintf(stdout,"Server: Got CMD_WRITE...\n");
    //fprintf(stderr,"ERROR CMD NOT EXPECTED: 0x%" PRIx8 "!\n",buff[0]);
    //exit(EXIT_FAILURE);
  }
  else if(buff[0] == 0xaa){
    cmd = STATUS;
    fprintf(stdout,"Server: Got CMD_STATUS...\n");
    //fprintf(stderr,"ERROR CMD NOT EXPECTED: 0x%" PRIx8 "!\n",buff[0]);
    //exit(EXIT_FAILURE);
  }
  else if(buff[0] == 0xb0) { 
    cmd = RST;
    fprintf(stdout,"Server: Got CMD_RESET...\n");
  }
  else {
    cmd = ERR;
    fprintf(stderr,"ERROR CMD NOT EXPECTED: 0x%" PRIx8 "!\n",buff[0]);
    exit(EXIT_FAILURE);
  }
  if(cmd == RST) {
   //gpio_addr = 0xA0010000; 
   gpio_addr = 0x4000000000; 
   if (buff[2] == 1) {
      rst_ctrl = SET;
      fprintf(stdout,"Server: Set Reset...\n");
   }
   else {
      rst_ctrl = REL;
      fprintf(stdout,"Server: Rel Reset...\n");
   }
   if(rst_mode == ACTIVE_HIGH) { 
     if(rst_ctrl == SET) {
       if(write_gpio(gpio_addr, 1)==-1){
         fprintf(stderr,"write_gpio failed!");
         exit(EXIT_FAILURE);
       }
     }
    else {
       if(write_gpio(gpio_addr, 0)==-1){
         fprintf(stderr,"write_gpio failed!");
         exit(EXIT_FAILURE);
       }
    }
   }
   else {
     if(rst_ctrl == SET) {
       if(write_gpio(gpio_addr, 0)==-1){
         fprintf(stderr,"write_gpio failed!");
         exit(EXIT_FAILURE);
       }
     }
    else {
       if(write_gpio(gpio_addr, 1)==-1){
         fprintf(stderr,"write_gpio failed!");
         exit(EXIT_FAILURE);
       }
    }
   }
  }
  //AXI2SPI DBG ONLY
  /*
  else if(cmd == WRITE) {
    unsigned long value;
    gpio_addr =  ((unsigned long)buff[1] << 32 |
                  (unsigned long)buff[2] << 24 |
                  (unsigned long)buff[3] << 16 |
                  (unsigned long)buff[4] << 8  |
                  (unsigned long)buff[5] << 0);
    value = ((unsigned long)buff[6] << 24 | 
             (unsigned long)buff[7] << 16 | 
             (unsigned long)buff[8] << 8  | 
             (unsigned long)buff[9]);
      fprintf(stdout,"Server: Writing @%lx Data=%lx\n",gpio_addr,value);
      if(write_gpio(gpio_addr, value)==-1){//32bit Operation. Total 128bits
         fprintf(stderr,"write_gpio failed!");
         exit(EXIT_FAILURE);
       }
  }
  else if(cmd == READ) {
    unsigned long rdata0;
    uint8_t  p[sizeof(rdata0)];
    gpio_addr =  ((unsigned long)buff[1] << 32 |
                  (unsigned long)buff[2] << 24 |
                  (unsigned long)buff[3] << 16 |
                  (unsigned long)buff[4] << 8  |
                  (unsigned long)buff[5] << 0);
    rdata0 = read_gpio(gpio_addr);
    fprintf(stdout,"Server: Reading @%lx Data0=%lx\n",gpio_addr,rdata0);
    memcpy(p,&rdata0,sizeof(rdata0));
    buff[6]  = p[0];
    buff[7]  = p[1];
    buff[8]  = p[2];
    buff[9]  = p[3];
    buff[10] = p[4];
    buff[11] = p[5];
    buff[12] = p[6];
    buff[13] = p[7];
    for (int i = 0; i < len; i ++) {
     fprintf(stdout,"Server: Read buffer[%0d]: 0x%" PRIx8 "\n",i,buff[i]);
    }
  }
  */

  //AXI2OURSRING
  ///*
  if(cmd == WRITE) {
    uint64_t addr = ((uint64_t) buff[1] << 32 |
                          (uint64_t) buff[2] << 24 |
                          (uint64_t) buff[3] << 16 |
                          (uint64_t) buff[4] <<  8 |
                          (uint64_t) buff[5]);

    uint64_t value = ((uint64_t) buff[6] << 56 |
                           (uint64_t) buff[7] << 48 |
                           (uint64_t) buff[8] << 40 |
                           (uint64_t) buff[9] << 32 |
                           (uint64_t) buff[10] << 24 |
                           (uint64_t) buff[11] << 16 |
                           (uint64_t) buff[12] <<  8 |
                           (uint64_t) buff[13]);

    write_gpio(addr, value);
    // gpio_addr = 0xA0040010;
    // //fprintf(stdout,"Server: Writing @%lx Data=%lx\n",gpio_addr,addr);
    // if(write_gpio(gpio_addr, addr)==-1){//32bit Operation. Total 128bits
    //    fprintf(stderr,"write_gpio failed!");
    //    exit(EXIT_FAILURE);
    // }
    // gpio_addr = 0xA0040018;
    // //fprintf(stdout,"Server: Writing @%lx Data=%lx\n",gpio_addr,value);
    // if(write_gpio(gpio_addr, value)==-1){//32bit Operation. Total 128bits
    //    fprintf(stderr,"write_gpio failed!");
    //    exit(EXIT_FAILURE);
    // }
    // //CMD
    // gpio_addr = 0xA0040008;
    // //fprintf(stdout,"Server: Writing Execute @%lx\n",gpio_addr);
    // if(write_gpio(gpio_addr, 1)==-1){//32bit Operation. Total 128bits
    //      fprintf(stderr,"write_gpio failed!");
    //      exit(EXIT_FAILURE);
    // }
    // //Execute
    // gpio_addr = 0xA0040000;
    // //fprintf(stdout,"Server: Writing Execute @%lx\n",gpio_addr);
    // if(write_gpio(gpio_addr, 1)==-1){//32bit Operation. Total 128bits
    //      fprintf(stderr,"write_gpio failed!");
    //      exit(EXIT_FAILURE);
    // }
  }//*/
  ///*
  if(cmd == READ) { //Read Data 32bits
    uint64_t poll_data;
    uint64_t rdata0;
    uint8_t  p0[sizeof(rdata0)];
    uint64_t addr = ((uint64_t) buff[1] << 32 |
                     (uint64_t) buff[2] << 24 |
                     (uint64_t) buff[3] << 16 |
                     (uint64_t) buff[4] <<  8 |
                     (uint64_t) buff[5]);

    uint64_t value = ((uint64_t) buff[6] << 56 |
                      (uint64_t) buff[7] << 48 |
                      (uint64_t) buff[8] << 40 |
                      (uint64_t) buff[9] << 32 |
                      (uint64_t) buff[10] << 24 |
                      (uint64_t) buff[11] << 16 |
                      (uint64_t) buff[12] <<  8 |
                      (uint64_t) buff[13]);

    gpio_addr = 0xA0040010;
    //fprintf(stdout,"Server: Writing @%lx Data=%lx\n",gpio_addr,addr);
    if(write_gpio(gpio_addr, addr)==-1){//32bit Operation. Total 128bits
      fprintf(stderr,"write_gpio failed!");
      exit(EXIT_FAILURE);
    }

    //CMD
    gpio_addr = 0xA0040008;
    //fprintf(stdout,"Server: Writing Execute @%lx\n",gpio_addr);
    if(write_gpio(gpio_addr, 0)==-1){//32bit Operation. Total 128bits
      fprintf(stderr,"write_gpio failed!");
      exit(EXIT_FAILURE);
    }

    //EXE
    gpio_addr = 0xA0040000;
    //fprintf(stdout,"Server: Writing Execute @%lx\n",gpio_addr);
    if(write_gpio(gpio_addr, 1)==-1){//32bit Operation. Total 128bits
      fprintf(stderr,"write_gpio failed!");
      exit(EXIT_FAILURE);
    }

    int timeout_cntr  = 10000;
    //Wait for Rd Data to be Ready by polling for Register @ 0x2000004000 to be cleared
    poll_data = (uint64_t)0;
   
    for (int i = 0; i < len; i ++) {
     buff[i] = 0;
    }
    //fprintf(stdout,"Server: Wait for Execute to be cleared!\n");
    do {
      usleep(1);
      poll_data = read_gpio(0xA0040000);
      //fprintf(stdout,"Server: Reading @%lx poll_data=%lx\n",0xA0040000,poll_data);
      timeout_cntr--;
    } while(poll_data != 0 && timeout_cntr > 0);

    if(timeout_cntr== 0){
      fprintf(stderr,"Server: Poll Timedout Exec not cleared! %lx!\n",poll_data);
      exit(EXIT_FAILURE);
    }

    gpio_addr = 0xA0040020;
    rdata0 = read_gpio(gpio_addr); 
    //fprintf(stdout,"Server: Reading @%lx Data0=%lx\n",gpio_addr,rdata0);
    memcpy(p0,&rdata0,sizeof(rdata0));
    buff[6]  = p0[0];
    buff[7]  = p0[1];
    buff[8]  = p0[2];
    buff[9]  = p0[3];
    buff[10]  = p0[4];
    buff[11]  = p0[5];
    buff[12]  = p0[6];
    buff[13]  = p0[7];
    //for (int i = 0; i < len; i ++) {
    //  fprintf(stdout,"Server: Read buffer[%0d]: 0x%" PRIx8 "\n",i,buff[i]);
    //}
  }//*/
 
 //BRAM
  else if(cmd == BWRITE){
   uint64_t value;
   value = (
            ((uint64_t)buff[16] << 56) | 
            ((uint64_t)buff[15] << 48) | 
            ((uint64_t)buff[14] << 40) | 
            ((uint64_t)buff[13] << 32) |
            ((uint64_t)buff[12] << 24) |
            ((uint64_t)buff[11] << 16) | 
            ((uint64_t)buff[10] << 8)  |
            ((uint64_t)buff[9]) 
            );
   gpio_addr = (
                ((unsigned long)buff[1] << 32) |
                ((unsigned long)buff[2] << 24) |
                ((unsigned long)buff[3] << 16) |
                ((unsigned long)buff[4] << 8)  |
                ((unsigned long)buff[5] << 0)
               );
   if(write_gpio_bram(gpio_addr, value)==-1){//32bit Operation. Total 128bits
         fprintf(stderr,"write_gpio_bram failed!");
         exit(EXIT_FAILURE);
    }
 }
 else if(cmd == BREAD){
   uint64_t rdata0;
   uint8_t  p[sizeof(rdata0)];
   gpio_addr = (
                ((unsigned long)buff[1] << 32) |
                ((unsigned long)buff[2] << 24) |
                ((unsigned long)buff[3] << 16) |
                ((unsigned long)buff[4] << 8)  |
                ((unsigned long)buff[5] << 0)
               );
   rdata0 = read_gpio_bram(gpio_addr);
   memcpy(p,&rdata0,sizeof(rdata0));
   buff[6]  = p[0];//rdata0 &  0x00000000000000ff;
   buff[7]  = p[1];//rdata0 &  0x000000000000ff00;
   buff[8]  = p[2];//rdata0 &  0x0000000000ff0000;
   buff[9]  = p[3];//rdata0 &  0x00000000ff000000;
   buff[10] = p[4];//rdata0 & 0x000000ff00000000;
   buff[11] = p[5];//rdata0 & 0x0000ff0000000000;
   buff[12] = p[6];//rdata0 & 0x00ff000000000000;
   buff[13] = p[7];//rdata0 & 0xff00000000000000;
   fprintf(stdout,"Server: ReadData: 0x%" PRIx64 "\n",rdata0);
   for (int i = 0; i < len; i ++) {
     fprintf(stdout,"Server: Read buffer[%0d]: 0x%" PRIx8 "\n",i,buff[i]);
   }
 }
}

 int handleTcpClient(int *clientSock){
  int  rxMsgSize;
  int len = 16; //Bytes
  uint8_t *  buff = (uint8_t *) malloc (sizeof(uint8_t) * 100);

  //fprintf(stdout,"Server: Calling handleTcpClient()\n");
  if((rxMsgSize = recv(*clientSock,buff,len,0))<0){
    fprintf(stderr,"Server: Recv Failed!\n");
    exit(EXIT_FAILURE);
  }
  else if(rxMsgSize == 0){
    fprintf(stdout,"Server: Client Disconnected.\n");
    return 1;
  }
  else {
    //fprintf(stdout,"Server:  Received Msg from client!\n");
    //for(int i=0; i< len;i++){
    //  fprintf(stdout,"Server:  Received Buffer[%0d]: 0x%" PRIx8 "\n",i,buff[i]);
    //}
    procReqDataFrmCl(buff,PROJ_RST_MODE);
    //for(int i=0; i< len;i++){
    //  fprintf(stdout,"Server:  Sending Ack Buffer[%0d]: 0x%" PRIx8 "\n",i,buff[i]);
    //}
    //! Buffer Reset to send back ACK
    //Echo Back Ack to the client
    if(send(*clientSock,buff,len,0) != rxMsgSize){
      fprintf(stderr,"Send Failed!\n");
      exit(EXIT_FAILURE);
    }
    //fprintf(stdout,"\nServer: Sent Ack: 0x%" PRIx8 "\n",buff[0]);
  }
  free(buff);
  //sleep(1);
  return 0;
}

void acceptClientSock(int *serverSock,int *clientSock,struct sockaddr_in *clientAddr,unsigned int *clientLen){
  fprintf(stdout,"Calling acceptClientSock()\n");
  *clientSock = accept(*serverSock,(struct sockaddr *) &*clientAddr, &*clientLen);
  if(*clientSock<0){
    fprintf(stderr,"Accept Client Socket Failed!\n");
    exit(EXIT_FAILURE);
  }
  fprintf(stdout,"Handling Client %s\n",inet_ntoa(clientAddr->sin_addr));
}

void startListening(int *serverSock){
  if(listen(*serverSock, MAXPENDING)<0){
    fprintf(stderr,"Listening failed!\n");
    exit(EXIT_FAILURE);
  }
  fprintf(stdout,"startListening!\n");
}

void bindServerSock(int *serverSock,struct sockaddr_in *serverAddr){
  if(bind(*serverSock,(struct sockaddr *) &*serverAddr, sizeof(*serverAddr))<0){
    fprintf(stderr,"Server binding failed!\n");
    fprintf(stdout,"serverSock = %0d\n",*serverSock);
    fprintf(stdout,"sizeof(serverAddr) = %0ld\n",sizeof(*serverAddr));
    exit(EXIT_FAILURE);
  }
}

void createServerSock(int *serverSock){
  if((*serverSock = socket(PF_INET,SOCK_STREAM,IPPROTO_TCP)) < 0){
    fprintf(stderr,"Server socket creation failed!\n");
    exit(EXIT_FAILURE);
  }
  //fprintf(stdout,"createServerSock: *serverSock= %0d\n",*serverSock);
}

void configureServerAddr(struct sockaddr_in *serverAddr,unsigned int *clientLen,struct sockaddr_in *clientAddr,unsigned short *serverPort){
  memset(&*serverAddr, 0, sizeof(*serverAddr));
  serverAddr->sin_family = AF_INET;
  serverAddr->sin_addr.s_addr = htonl(INADDR_ANY);
  serverAddr->sin_port = htons(*serverPort);
  *clientLen = sizeof(clientAddr);
  fprintf(stdout,"configureServerAddr: *serverPort=%0d!\n",*serverPort);
}
#endif
