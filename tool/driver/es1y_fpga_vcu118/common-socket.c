#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <vector>
#include <string>
#include <string.h>
#include <inttypes.h>
#include "socket_client.h"
#include <fcntl.h>

void setup(unsigned short serverPort, struct sockaddr_in * serverAddr_p, int * clientSock_p) {
  createClientSock(clientSock_p);

  configureServerAddr(serverAddr_p, &serverPort);
  connectClientSock(clientSock_p, serverAddr_p);
  //int flags = fcntl(*clientSock_p, F_GETFL, 0);
  //flags = flags | O_NONBLOCK;
  //fcntl(*clientSock_p, F_SETFL, flags);
}

void set_reset(struct sockaddr_in * serverAddr_p, int * clientSock_p) {
  int32_t ack;
  uint8_t dataToBeSent[100];

  dataToBeSent[ 0] = 0xb0;
  dataToBeSent[ 1] = 0x00;
  dataToBeSent[ 2] = 0x01;
  dataToBeSent[ 3] = 0x00;
  dataToBeSent[ 4] = 0x00;
  dataToBeSent[ 5] = 0x00;
  dataToBeSent[ 6] = 0x00;
  dataToBeSent[ 7] = 0x00;
  dataToBeSent[ 8] = 0x00;
  dataToBeSent[ 9] = 0x00;
  dataToBeSent[10] = 0x00;
  dataToBeSent[11] = 0x00;
  dataToBeSent[12] = 0x00;
  dataToBeSent[13] = 0x00;
  dataToBeSent[14] = 0x00;
  dataToBeSent[15] = 0x00;

  sendWaitForAck(serverAddr_p, clientSock_p, dataToBeSent, &ack);

}

void release_reset(struct sockaddr_in * serverAddr_p, int * clientSock_p) {
  int32_t ack;
  uint8_t dataToBeSent[100];

  dataToBeSent[ 0] = 0xb0;
  dataToBeSent[ 1] = 0x00;
  dataToBeSent[ 2] = 0x00;
  dataToBeSent[ 3] = 0x00;
  dataToBeSent[ 4] = 0x00;
  dataToBeSent[ 5] = 0x00;
  dataToBeSent[ 6] = 0x00;
  dataToBeSent[ 7] = 0x00;
  dataToBeSent[ 8] = 0x00;
  dataToBeSent[ 9] = 0x00;
  dataToBeSent[10] = 0x00;
  dataToBeSent[11] = 0x00;
  dataToBeSent[12] = 0x00;
  dataToBeSent[13] = 0x00;
  dataToBeSent[14] = 0x00;
  dataToBeSent[15] = 0x00;

  sendWaitForAck(serverAddr_p, clientSock_p, dataToBeSent, &ack);

}

void do_status_check(struct sockaddr_in * serverAddr_p, int * clientSock_p) {
  int32_t ack;
  uint8_t dataToBeSent[100];

  dataToBeSent[ 0] = 0xaa;
  dataToBeSent[ 1] = 0xaa;
  dataToBeSent[ 2] = 0xaa;
  dataToBeSent[ 3] = 0xaa;
  dataToBeSent[ 4] = 0xaa;
  dataToBeSent[ 5] = 0xaa;
  dataToBeSent[ 6] = 0xaa;
  dataToBeSent[ 7] = 0xaa;
  dataToBeSent[ 8] = 0xaa;
  dataToBeSent[ 9] = 0xaa;
  dataToBeSent[10] = 0xaa;
  dataToBeSent[11] = 0xaa;
  dataToBeSent[12] = 0xaa;
  dataToBeSent[13] = 0xaa;
  dataToBeSent[14] = 0xaa;
  dataToBeSent[15] = 0xaa;

  sendWaitForAck(serverAddr_p, clientSock_p, dataToBeSent, &ack);

  if (dataToBeSent[6] != 0x57) {
      printf("do_status_check failed! Status is not 0x57! Status = 0x%x\n", dataToBeSent[6]);
      abort();
  } else {
  }
}

uint64_t do_read(struct sockaddr_in * serverAddr_p, int * clientSock_p, uint64_t addr) {
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
  sendWaitForAck(serverAddr_p, clientSock_p, dataToBeSent, &ack);

  rdata = dataToBeSent[6];
  //rdata = (rdata << 8) + dataToBeSent[12];
  //rdata = (rdata << 8) + dataToBeSent[11];
  //rdata = (rdata << 8) + dataToBeSent[10];
  //rdata = (rdata << 8) + dataToBeSent[ 9];
  //rdata = (rdata << 8) + dataToBeSent[ 8];
  //rdata = (rdata << 8) + dataToBeSent[ 7];
  //rdata = (rdata << 8) + dataToBeSent[ 6];

  rdata = (rdata << 8) + dataToBeSent[ 7];
  rdata = (rdata << 8) + dataToBeSent[ 8];
  rdata = (rdata << 8) + dataToBeSent[ 9];
  rdata = (rdata << 8) + dataToBeSent[ 10];
  rdata = (rdata << 8) + dataToBeSent[11];
  rdata = (rdata << 8) + dataToBeSent[12];
  rdata = (rdata << 8) + dataToBeSent[13];

  //fprintf(stderr, "do_read after: addr = 0x%lx, rdata = 0x%lx\n", addr, rdata);

  return rdata;
}

void do_write(struct sockaddr_in * serverAddr_p, int * clientSock_p, uint64_t addr, uint64_t data) {
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

  //fprintf(stderr, "do_write before: addr = 0x%lx, data = 0x%lx\n", addr, data);
  sendWaitForAck(serverAddr_p, clientSock_p, dataToBeSent, &ack);
  //fprintf(stderr, "do_write after: addr = 0x%lx, data = 0x%lx\n", addr, data);
}

void do_write_burst(struct sockaddr_in * serverAddr_p, int * clientSock_p, uint64_t addr, uint64_t* data, int len) {
  int32_t ack;
  uint8_t dataToBeSent[2048];

  // do_status_check(serverAddr_p, clientSock_p);
  dataToBeSent[ 0] = 0x06;
  dataToBeSent[ 1] = (addr >> 32) & 0xff;
  dataToBeSent[ 2] = (addr >> 24) & 0xff;
  dataToBeSent[ 3] = (addr >> 16) & 0xff;
  dataToBeSent[ 4] = (addr >>  8) & 0xff;
  dataToBeSent[ 5] = (addr >>  0) & 0xff;
  dataToBeSent[ 6] = (len >> 8) & 0xff;
  dataToBeSent[ 7] = (len >> 0) & 0xff;
  dataToBeSent[ 8] = 0x0;
  dataToBeSent[ 9] = 0x0;
  dataToBeSent[10] = 0x0;
  dataToBeSent[11] = 0x0;
  dataToBeSent[12] = 0x0;
  dataToBeSent[13] = 0x0;
  dataToBeSent[14] = 0x0;
  dataToBeSent[15] = 0x0;

  //fprintf(stderr, "do_write before: addr = 0x%lx, data = 0x%lx, len = %d\n", addr, data[0], len);
  sendWaitForAck(serverAddr_p, clientSock_p, dataToBeSent, &ack);
  //fprintf(stderr, "do_write before 1: addr = 0x%lx, data = 0x%lx, len = %d\n", addr, data[0], len);

  for (int i = 0; i < len; i ++) {
    dataToBeSent[i * 8 + 0] = (data[len - 1 - i] >> 56) & 0xff;
    dataToBeSent[i * 8 + 1] = (data[len - 1 - i] >> 48) & 0xff;
    dataToBeSent[i * 8 + 2] = (data[len - 1 - i] >> 40) & 0xff;
    dataToBeSent[i * 8 + 3] = (data[len - 1 - i] >> 32) & 0xff;
    dataToBeSent[i * 8 + 4] = (data[len - 1 - i] >> 24) & 0xff;
    dataToBeSent[i * 8 + 5] = (data[len - 1 - i] >> 16) & 0xff;
    dataToBeSent[i * 8 + 6] = (data[len - 1 - i] >>  8) & 0xff;
    dataToBeSent[i * 8 + 7] = (data[len - 1 - i] >>  0) & 0xff;
  }

  sendWaitForAck(serverAddr_p, clientSock_p, dataToBeSent, &ack, len * 8);

  //fprintf(stderr, "do_write after: addr = 0x%lx, data = 0x%lx, len = %d\n", addr, data[0], len);
}

uint64_t do_read_backdoor(struct sockaddr_in * serverAddr_p, int * clientSock_p, uint64_t addr) {
  int32_t ack;
  uint8_t dataToBeSent[100];
  uint64_t rdata;
  uint64_t _addr = addr;

  dataToBeSent[ 0] = 0x16;
  dataToBeSent[ 1] = (_addr >> 32) & 0xff;
  dataToBeSent[ 2] = (_addr >> 24) & 0xff;
  dataToBeSent[ 3] = (_addr >> 16) & 0xff;
  dataToBeSent[ 4] = (_addr >>  8) & 0xff;
  dataToBeSent[ 5] = (_addr >>  0) & 0xff;
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

  //for (int i = 0; i < 16; i++)
  //  fprintf(stderr, "dataToBeSent[ %0d ] = 0x%x\n", i, dataToBeSent[i]);
  sendWaitForAck(serverAddr_p, clientSock_p, dataToBeSent, &ack);

  rdata = dataToBeSent[13];
  rdata = (rdata << 8) + dataToBeSent[12];
  rdata = (rdata << 8) + dataToBeSent[11];
  rdata = (rdata << 8) + dataToBeSent[10];
  rdata = (rdata << 8) + dataToBeSent[ 9];
  rdata = (rdata << 8) + dataToBeSent[ 8];
  rdata = (rdata << 8) + dataToBeSent[ 7];
  rdata = (rdata << 8) + dataToBeSent[ 6];
  //for (int i = 0; i < 16; i++)
  //  fprintf(stderr, "dataToBeSent[%d] = 0x%x\n", i, dataToBeSent[i]);
  //fprintf(stderr, "rdata = 0x%x", rdata);
  return rdata;
}

void do_write_backdoor(struct sockaddr_in * serverAddr_p, int * clientSock_p, uint64_t addr, uint64_t data) {
  int32_t ack;
  uint8_t dataToBeSent[100];
  uint64_t _addr = addr;

  dataToBeSent[ 0] = 0x26;
  dataToBeSent[ 1] = (_addr >> 32) & 0xff;
  dataToBeSent[ 2] = (_addr >> 24) & 0xff;
  dataToBeSent[ 3] = (_addr >> 16) & 0xff;
  dataToBeSent[ 4] = (_addr >>  8) & 0xff;
  dataToBeSent[ 5] = (_addr >>  0) & 0xff;
  dataToBeSent[ 6] = (data >>  0) & 0xff;
  dataToBeSent[ 7] = (data >>  8) & 0xff;
  dataToBeSent[ 8] = (data >> 16) & 0xff;
  dataToBeSent[ 9] = (data >> 24) & 0xff;
  dataToBeSent[10] = (data >> 32) & 0xff;
  dataToBeSent[11] = (data >> 40) & 0xff;
  dataToBeSent[12] = (data >> 48) & 0xff;
  dataToBeSent[13] = (data >> 56) & 0xff;
  dataToBeSent[14] = 0x0;
  dataToBeSent[15] = 0x0;

  for (int i = 0; i < 16; i++)
    fprintf(stderr, "dataToBeSent[ %0d ] = 0x%x\n", i, dataToBeSent[i]);
  sendWaitForAck(serverAddr_p, clientSock_p, dataToBeSent, &ack);
}

