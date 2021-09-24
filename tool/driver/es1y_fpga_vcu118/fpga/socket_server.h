#ifndef _SOCKET_SERVER_H
#define _SOCKET_SERVER_H
#include<unistd.h>
#include<stdio.h>
#include<stdlib.h>
#include<sys/socket.h>
#include<arpa/inet.h>
#include<netinet/in.h>
#include<string.h>
#include<inttypes.h>
#include "gpio_dev_mem.h"
#include "fpga_cmds_base.h"
#include "fpga_cmds.h"
#define MAXPENDING 5  //Max outstanding requests
#define RXBUFFERSIZE 1024
#define PROJ_RST_MODE ACTIVE_HIGH
void configureServerAddr(struct sockaddr_in *serverAddr,unsigned int *clientLen,struct sockaddr_in *clientAddr,unsigned short *serverPort);
void createServerSock(int *serverSock);
void bindServerSock(int *serverSock,struct sockaddr_in *serverAddr);
void startListening(int *serverSock);
void acceptClientSock(int *serverSock,int *clientSock,struct sockaddr_in *clientAddr,unsigned int *clientLen);
int handleTcpClient(int *clientSock);
enum cmd_t {BWRITE,BREAD,WRITE,READ,RST,STATUS,ERR};
enum rst_mode_t {ACTIVE_HIGH,ACITVE_LOW};
enum rst_ctrl_t {SET,REL};
enum drvr_type_t {SPI,ETH};
static inline const char *str_drvr_type(enum drvr_type_t drvr) {
  static const char *strings[]= {"SPI","ETH"};
  return strings[drvr];
}
void procReqDataFrmCl(uint8_t *buff, enum rst_mode_t rst_mode);
#endif
