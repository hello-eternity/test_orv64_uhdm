#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <vector>
#include <string>
#include <string.h>
#include <inttypes.h>

void setup(unsigned short serverPort, struct sockaddr_in * serverAddr_p, int * clientSock_p);

void set_reset(struct sockaddr_in * serverAddr_p, int * clientSock_p);
void release_reset(struct sockaddr_in * serverAddr_p, int * clientSock_p);

void do_status_check(struct sockaddr_in * serverAddr_p, int * clientSock_p);

uint64_t do_read(struct sockaddr_in * serverAddr_p, int * clientSock_p, uint64_t addr);

void do_write(struct sockaddr_in * serverAddr_p, int * clientSock_p, uint64_t addr, uint64_t data);
void do_write_burst(struct sockaddr_in * serverAddr_p, int * clientSock_p, uint64_t addr, uint64_t* data, int len);

uint64_t do_read_backdoor(struct sockaddr_in * serverAddr_p, int * clientSock_p, uint64_t addr);

void do_write_backdoor(struct sockaddr_in * serverAddr_p, int * clientSock_p, uint64_t addr, uint64_t data);
