#ifndef _SOCKET_CLIENT_C
#define _SOCKET_CLIENT_C
#include "socket_client.h"

void sendWaitForAck(struct sockaddr_in *serverAddr, int *clientSock, uint8_t *dataToBeSent, int32_t *ack, int req_len) {
  size_t len;
  len = 16;
  //! Send Message
  //for(int i=0; i< len;i++){
  //  fprintf(stdout,"Client: Sending Buffer[%d]: 0x%" PRIx8 "\n",i,dataToBeSent[i]);
  //}
  if(send(*clientSock,dataToBeSent,req_len,0) != req_len){
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
    //fprintf(stdout,"Client: Got Ack From Server!\n");
    //for(int i=0; i< len;i++){
    //  fprintf(stdout,"Client: Recv Buffer[%0d]: 0x%" PRIx8 "\n",i,dataToBeSent[i]);
    //}
  }
}

//! API For Feservver Integration 
void send_pkt(uint8_t *buffer) {
  int                 rxMsgSize;
  int                 clientSock; //Client Socket Descriptor
  struct sockaddr_in  serverAddr; // Local Address
  unsigned short      serverPort; 
  uint64_t            ret_data = 0;
  size_t len;
  len = 16; //Bytes sizeof(buffer);
  serverPort = 8081;
  serverPort = 9900;
  serverPort = 8900;
  createClientSock(&clientSock);
  configureServerAddr(&serverAddr,&serverPort);
  connectClientSock(&clientSock,&serverAddr);
  //! Send Message
  //fprintf(stdout,"Client: Sending Buff: 0x%" PRIx8 "\n",buffer[0]);
  if(send(clientSock,buffer,len,0) != len){
      fprintf(stderr,"Send Failed!\n");
      exit(EXIT_FAILURE);
  }
  //for(int i=0; i< len;i++){
  //  fprintf(stdout,"Client: Sent Buffer[%0d]: 0x%" PRIx8 "\n",i,buffer[i]);
  //}
  //! Rd Data Received
  //memset(&buffer, '0', sizeof(buffer));
  for (int i = 0; i < len; i ++) {
    buffer[i] = 0;
  }
  if((rxMsgSize = recv(clientSock,buffer,len,0))<0){
    fprintf(stderr,"Rd Data Recv Failed! MsgSize: %d exp_length: %0d\n",rxMsgSize,len);
    exit(EXIT_FAILURE);
  }
  else {
    fprintf(stdout,"Client: Got Ack From Server!\n");
    for(int i=0; i< len;i++){
      fprintf(stdout,"Client: Recv Buffer[%0d]: 0x%" PRIx8 "\n",i,buffer[i]);
    }
  }
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
  //serverAddr->sin_addr.s_addr = inet_addr("192.168.0.100");
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
#endif

