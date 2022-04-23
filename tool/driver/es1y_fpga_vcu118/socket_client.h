#ifndef _SOCKET_CLIENT_H
#define _SOCKET_CLIENT_H
#include<unistd.h>
#include<stdio.h>
#include<stdlib.h>
#include<sys/socket.h>
#include<arpa/inet.h>
#include<netinet/in.h>
#include<string.h>
#include<inttypes.h>
#include "fpga/fpga_cmds_base.h"
#include "fpga/fpga_cmds.h"

#define RXBUFFERSIZE 1024
void createClientSock(int *clientSock);
void configureServerAddr(struct sockaddr_in *serverAddr,unsigned short *serverPort);
void connectClientSock(int *clientSock,struct sockaddr_in *serverAddr);
void sendWaitForAck(struct sockaddr_in *serverAddr, int *clientSock, uint8_t *dataToBeSent, int32_t *ack, int req_len = 16);
void send_pkt(uint8_t *buffer);
#endif
