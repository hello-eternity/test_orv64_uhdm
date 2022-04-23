#include<unistd.h>
#include<stdio.h>
#include<stdlib.h>
#include<sys/socket.h>
#include<arpa/inet.h>
#include<netinet/in.h>
#include<string.h>
#include<inttypes.h>

void sendWaitForAck(int *clientSock, uint8_t *dataToBeSent, int32_t *ack);
void do_write(int * clientSock_p, uint64_t addr, uint64_t data);
uint64_t do_read(int * clientSock_p, uint64_t addr);
void setup(unsigned short serverPort, struct sockaddr_in * serverAddr_p, int * clientSock_p);
void createClientSock(int *clientSock);
void configureServerAddr(struct sockaddr_in *serverAddr,unsigned short *serverPort);
void connectClientSock(int *clientSock,struct sockaddr_in *serverAddr);

int main() {
  //uint64_t addr = 0x0123456789;
  uint64_t addr = 0x100000;
  uint64_t addr2 = 0x10;
  uint64_t data  = 0x0123456789abcdef;
  uint64_t data2 = 0xfedcab9876543210;
  
  unsigned short serverPort = 9900;
  struct sockaddr_in serverAddr;
  int clientSock;
  setup(serverPort, &serverAddr, &clientSock);

  /* while (1) { */
  /*   do_write(&clientSock, addr, data); */
  /*   printf("finished write\n"); */
  /*   uint64_t read_data = do_read(&clientSock, addr); */
  /*   printf("finished read: %016x\n", read_data); */
  /*   addr++; */
  /*   data++; */
  /*   sleep(1); */
  /* } */

  do_write(&clientSock, addr, data);
  printf("Finished write of data: %" PRIx64 "\n", data);
  uint64_t read_data = do_read(&clientSock, addr);
  printf("Finished read of data: %" PRIx64 "\n", read_data);

  do_write(&clientSock, addr2, data2);
  printf("Finished write of data2: %" PRIx64 "\n", data2);
  uint64_t read_data2 = do_read(&clientSock, addr2);
  printf("Finished read of data2: %" PRIx64 "\n", read_data2);
}

void createClientSock(int *clientSock){
  if((*clientSock = socket(PF_INET,SOCK_STREAM,IPPROTO_TCP)) < 0){
    fprintf(stderr,"Server socket creation failed!\n");
    exit(EXIT_FAILURE);
  }
  //fprintf(stdout,"createClientSock: *clientSock= %0d\n",*clientSock);
}
void configureServerAddr(struct sockaddr_in *serverAddr,unsigned short *serverPort){
  memset(&*serverAddr, 0, sizeof(*serverAddr));
  serverAddr->sin_family = AF_INET;
  //Using server_port
  serverAddr->sin_port = htons(*serverPort);
  //Using IP address for FPGA
  //Comment out if testing locally
  serverAddr->sin_addr.s_addr = inet_addr("127.0.0.1");
  //serverAddr->sin_addr.s_addr = inet_addr("192.168.0.236");
  //fprintf(stdout,"configureServerAddr: *serverPort=%0d!\n",*serverPort);
  //fprintf(stdout,"configureServerAddr: s_addr=%0d!\n",serverAddr->sin_addr.s_addr);
}
void connectClientSock(int *clientSock,struct sockaddr_in *serverAddr){
  if(connect(*clientSock,(struct sockaddr *)&*serverAddr,sizeof(*serverAddr))<0){
    fprintf(stderr,"Connect failed\n");
    exit(EXIT_FAILURE);
  }
  //fprintf(stdout,"connectClientSock successful!\n");
}


void setup(unsigned short serverPort, struct sockaddr_in * serverAddr_p, int * clientSock_p) {
  createClientSock(clientSock_p);

  configureServerAddr(serverAddr_p, &serverPort);
  connectClientSock(clientSock_p, serverAddr_p);
  //int flags = fcntl(*clientSock_p, F_GETFL, 0);
  //flags = flags | O_NONBLOCK;
  //fcntl(*clientSock_p, F_SETFL, flags);
}


void sendWaitForAck(int *clientSock, uint8_t *dataToBeSent, int32_t *ack) {
  size_t len;
  len = 16;//In Bytes//sizeof(&*dataToBeSent);
  //! Send Message
  //for(int i=0; i< len;i++){
  //  fprintf(stdout,"Client: Sending Buffer[%d]: 0x%" PRIx8 "\n",i,dataToBeSent[i]);
  //}
  if(send(*clientSock,dataToBeSent,len,0) != len){
      fprintf(stderr,"Send Failed!\n");
      exit(EXIT_FAILURE);
  }
  // for(int i=0; i< len;i++){
  //   fprintf(stdout,"Client: Sent Buffer[%d]: 0x%" PRIx8 "\n",i,dataToBeSent[i]);
  // }
  //! ACK Received
  for (int i = 0; i < len; i ++) {
    dataToBeSent[i] = 0;
  }
  //memset(&dataToBeSent, '0', sizeof(dataToBeSent));
  //sleep(1);
  if(recv(*clientSock,dataToBeSent,len,0)<0){
    fprintf(stderr,"Client: Rd Data Recv Failed!\n");
    exit(EXIT_FAILURE);
  }
  else {
    fprintf(stdout,"Client: Got Ack From Server!\n");
    for(int i=0; i< len;i++){
      fprintf(stdout,"Client: Recv Buffer[%0d]: 0x%" PRIx8 "\n",i,dataToBeSent[i]);
    }
  }
}

void do_write(int * clientSock_p, uint64_t addr, uint64_t data) {
  int32_t ack;
  uint8_t dataToBeSent[100];

  // do_status_check(serverAddr_p, clientSock_p);
  dataToBeSent[ 0] = 0x04;
  dataToBeSent[ 1] = (addr >> 32) & 0xff;
  dataToBeSent[ 2] = (addr >> 24) & 0xff;
  dataToBeSent[ 3] = (addr >> 16) & 0xff;
  dataToBeSent[ 4] = (addr >>  8) & 0xff;
  dataToBeSent[ 5] = (addr >>  0) & 0xff;
  dataToBeSent[ 6] = (data >> 56) & 0xff;
  dataToBeSent[ 7] = (data >> 48) & 0xff;
  dataToBeSent[ 8] = (data >> 40) & 0xff;
  dataToBeSent[ 9] = (data >> 32) & 0xff;
  dataToBeSent[10] = (data >> 24) & 0xff;
  dataToBeSent[11] = (data >> 16) & 0xff;
  dataToBeSent[12] = (data >>  8) & 0xff;
  dataToBeSent[13] = (data >>  0) & 0xff;
  dataToBeSent[14] = 0x0;
  dataToBeSent[15] = 0x0;

  //for (int i = 0; i <= 15; i++) {
  //  printf("%02x\n", dataToBeSent[i]);
  //}

  //fprintf(stderr, "do_write before: addr = 0x%lx, data = 0x%lx\n", addr, data);
  sendWaitForAck(clientSock_p, dataToBeSent, &ack);
  //fprintf(stderr, "do_write after: addr = 0x%lx, data = 0x%lx\n", addr, data);
}

uint64_t do_read(int * clientSock_p, uint64_t addr) {
  int32_t ack;
  uint8_t dataToBeSent[100];
  uint64_t rdata;

  // do_status_check(serverAddr_p, clientSock_p);
  dataToBeSent[ 0] = 0x05;
  dataToBeSent[ 1] = (addr >> 32) & 0xff;
  dataToBeSent[ 2] = (addr >> 24) & 0xff;
  dataToBeSent[ 3] = (addr >> 16) & 0xff;
  dataToBeSent[ 4] = (addr >>  8) & 0xff;
  dataToBeSent[ 5] = (addr >>  0) & 0xff;
  dataToBeSent[ 6] = 0xa5; // Turn around byte: 1010 0101
  dataToBeSent[ 7] = 0x0;
  dataToBeSent[ 8] = 0x0;
  dataToBeSent[ 9] = 0x0;
  dataToBeSent[10] = 0x0;
  dataToBeSent[11] = 0x0;
  dataToBeSent[12] = 0x0;
  dataToBeSent[13] = 0x0;
  dataToBeSent[14] = 0x0;
  dataToBeSent[15] = 0x0;

  //fprintf(stderr, "do_read before: addr = 0x%lx, rdata = 0x%lx\n", addr, rdata);
  sendWaitForAck(clientSock_p, dataToBeSent, &ack);

  rdata = dataToBeSent[13];
  rdata = (rdata << 8) + dataToBeSent[12];
  rdata = (rdata << 8) + dataToBeSent[11];
  rdata = (rdata << 8) + dataToBeSent[10];
  rdata = (rdata << 8) + dataToBeSent[ 9];
  rdata = (rdata << 8) + dataToBeSent[ 8];
  rdata = (rdata << 8) + dataToBeSent[ 7];
  rdata = (rdata << 8) + dataToBeSent[ 6];

  //fprintf(stderr, "do_read after: addr = 0x%lx, rdata = 0x%lx\n", addr, rdata);

  return rdata;
}
