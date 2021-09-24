#include <stdio.h>
#include <stdlib.h>
#include <vector>
#include <string>
#include <string.h>

#include "debug_tick.h"
#include "socket_client.h"
#include "common-socket.h"
#include "common.h"
#include "pygmy_es1y_addr_translater.h"

int main (int argc, char const *argv[])
{
  std::string status;
  dtm_t*   dtm = NULL;

  unsigned char* debug_req_valid = (unsigned char*) malloc(sizeof(unsigned char));
  unsigned char  debug_req_ready;
  uint32_t*      debug_req_bits_addr = (uint32_t*) malloc(sizeof(uint32_t));
  uint32_t*      debug_req_bits_op = (uint32_t*) malloc(sizeof(uint32_t));
  uint32_t*      debug_req_bits_data = (uint32_t*) malloc(sizeof(uint32_t));
  uint64_t*      debug_tohost_addr = (uint64_t*) malloc(sizeof(uint64_t));
  uint64_t*      debug_fromhost_addr = (uint64_t*) malloc(sizeof(uint64_t));
  unsigned char  debug_resp_valid;
  unsigned char* debug_resp_ready = (unsigned char*) malloc(sizeof(unsigned char));
  int            debug_resp_bits_resp;
  int            debug_resp_bits_data;

  int            state = 0; //0: IDLE, 1: WR_ADDR, 2:WR_DATA 3:RD
  int            rcvd_addr = 0;
  int            rcvd_data = 0;
  uint64_t       data = 0;
  uint64_t       addr = 0;
  uint64_t       ret_data = 0;
  uint64_t       tmp_data = 0;

  int            dma_cmd_vld = 0;
  int            is_incremental = 0;
  uint64_t       burst_data[256];
  int            is_burst = 0;
  int            burst_idx = 0;

  unsigned short serverPort = 0;
  struct sockaddr_in serverAddr;
  int clientSock;
  for (int i = 1; i < argc; i++) {
    if (strncmp(argv[i], "serverPort=", 11) == 0) {
      serverPort = atoi(argv[i] + 11);
    }
  }
  if (serverPort == 0) {
    serverPort = 9900; // Default
    serverPort = 8900; // Default
  }
  printf ("serverPort = %0d\n", serverPort);
  setup(serverPort, &serverAddr, &clientSock);

  //do_status_check(&serverAddr, &clientSock);

  debug_req_ready = 1;
  debug_resp_valid = 0;
  debug_resp_bits_resp = 0;
  debug_resp_bits_data = 0;

  while (1) {
    //printf("=========================\n");
    //printf("Sending: req_ready      = %x\n", debug_req_ready);
    //printf("Sending: resp_valid     = %x\n", debug_resp_valid);
    //printf("Sending: resp_bits_resp = %x\n", debug_resp_bits_resp);
    //printf("Sending: resp_bits_data = %x\n", debug_resp_bits_data);
    dtm = debug_tick( debug_req_valid,
                      debug_req_ready,
                      debug_req_bits_addr,
                      debug_req_bits_op,
                      debug_req_bits_data,
                      debug_tohost_addr,
                      debug_fromhost_addr,

                      debug_resp_valid,
                      debug_resp_ready,
                      debug_resp_bits_resp,
                      debug_resp_bits_data,
                      argc,
                      argv,
                      dtm
                    );
    //printf("Receiving: req_valid      = %x\n", *debug_req_valid);
    //printf("Receiving: req_bits_addr  = %x\n", *debug_req_bits_addr);
    //printf("Receiving: req_bits_op    = %x\n", *debug_req_bits_op);
    //printf("Receiving: req_bits_data  = %x\n", *debug_req_bits_data);
    //printf("Receiving: resp_ready     = %x\n", *debug_resp_ready);
    //printf("Receiving: debug_tohost_addr     = %x\n", *debug_tohost_addr);
    //printf("Receiving: debug_fromhost_addr   = %x\n", *debug_fromhost_addr);
    //printf("state = %d, rcvd_addr = %d\n", state, rcvd_addr);
    if (*debug_req_valid == 0) {
      //do_status_check(&serverAddr, &clientSock);
      debug_resp_valid = 0;
    } else {
      ret_data = 0;
      if (state == 0) { // IDLE
        is_incremental = 0;
        is_burst = 0;
        burst_idx = 0;
        if (*debug_req_bits_op == 2) {
          state = 1; // WR_ADDR
          rcvd_addr ++;
          tmp_data = 0;
          tmp_data = *debug_req_bits_data;
          if ((*debug_req_bits_addr == 0x2) || (*debug_req_bits_addr == 0x6) || (*debug_req_bits_addr == 0xa) || (*debug_req_bits_addr == 0xc))
            data = (data & 0xffffffff00000000) | tmp_data;
          else
            data = (data & 0x00000000ffffffff) | (tmp_data << 32);
        } else if (*debug_req_bits_op == 1) {
          addr = *debug_req_bits_data;
          state = 3; // RD
        }
      } else if (state == 1) { // WR_ADDR
        is_incremental = 0;
        is_burst = 0;
        burst_idx = 0;
        if (*debug_req_bits_op == 2) {
          rcvd_addr ++;
          tmp_data = 0;
          tmp_data = *debug_req_bits_data;
          if ((*debug_req_bits_addr == 0x2) || (*debug_req_bits_addr == 0x6) || (*debug_req_bits_addr == 0xa) || (*debug_req_bits_addr == 0xc))
            data = (data & 0xffffffff00000000) | tmp_data;
          else
            data = (data & 0x00000000ffffffff) | (tmp_data << 32);
          if (rcvd_addr == 2) {
            addr = data;
            state = 2; // WR_DATA
            rcvd_addr = 0;
          }
        }
      } else if (state == 2) { // WR_DATA
        if (((*debug_req_bits_addr == 0x2) || (*debug_req_bits_addr == 0x3) || (*debug_req_bits_addr == 0x6) || (*debug_req_bits_addr == 0x7) || (*debug_req_bits_addr == 0xa) || (*debug_req_bits_addr == 0xb) || (*debug_req_bits_addr == 0xe) || (*debug_req_bits_addr == 0xf)) && (*debug_req_bits_op == 2)) {
          rcvd_addr ++;
          state = 1; // WR_ADDR
          tmp_data = 0;
          tmp_data = *debug_req_bits_data;
          if ((*debug_req_bits_addr == 0x2) || (*debug_req_bits_addr == 0x6) || (*debug_req_bits_addr == 0xa) || (*debug_req_bits_addr == 0xc))
            data = (data & 0xffffffff00000000) | tmp_data;
          else
            data = (data & 0x00000000ffffffff) | (tmp_data << 32);
        } else if (*debug_req_bits_op == 1) {
          addr = *debug_req_bits_data;
          state = 3; // RD
        } else if (((*debug_req_bits_addr == 0x0) || (*debug_req_bits_addr == 0x1) || (*debug_req_bits_addr == 0x4) || (*debug_req_bits_addr == 0x5) || (*debug_req_bits_addr == 0x8) || (*debug_req_bits_addr == 0x9) || (*debug_req_bits_addr == 0xc) || (*debug_req_bits_addr == 0xd)) && (*debug_req_bits_op == 2)) {
          rcvd_data ++;
          tmp_data = 0;
          tmp_data = *debug_req_bits_data;
          if ((*debug_req_bits_addr == 0x0) || (*debug_req_bits_addr == 0x4) || (*debug_req_bits_addr == 0x8) || (*debug_req_bits_addr == 0xc))
            data = (data & 0xffffffff00000000) | tmp_data;
          else
            data = (data & 0x00000000ffffffff) | (tmp_data << 32);
          if (rcvd_data % 2 == 0) {
            //fprintf(stderr, "Writing addr %llx, wdata %llx, *debug_req_bits_addr = %lld, *debug_tohost_addr = %llx, *debug_fromhost_addr = %llx\n", addr, data, *debug_req_bits_addr, *debug_tohost_addr, *debug_fromhost_addr);
            if (addr < 0x80000000) { // bit 31 is 0
              do_write(&serverAddr, &clientSock, addr, data);
            } else if ((addr == *debug_tohost_addr) || (addr == *debug_fromhost_addr)) { // tohost or fromhost
                do_write(&serverAddr, &clientSock, STATION_DMA_DMA_DEBUG_ADDR_ADDR, addr);
                do_write(&serverAddr, &clientSock, STATION_DMA_DMA_DEBUG_REQ_TYPE_ADDR, 2);
                do_write(&serverAddr, &clientSock, STATION_DMA_DMA_DEBUG_WR_DATA_ADDR, data);
            } else { // Memory Data
              if ((*debug_req_bits_addr == 0x0) || (*debug_req_bits_addr == 0x1)) { // DMA
                // fprintf (stderr, "inside DMA write\n");
                if (is_burst == 1) {
                  burst_data[burst_idx] = data;
                  burst_idx += 1;
                  do_write_burst(&serverAddr, &clientSock, addr, burst_data, burst_idx);
                } else {
                  if (is_incremental == 0) {
                    do_write(&serverAddr, &clientSock, STATION_DMA_DMA_DEBUG_ADDR_ADDR, addr);
                    do_write(&serverAddr, &clientSock, STATION_DMA_DMA_DEBUG_REQ_TYPE_ADDR, 2);
                    do_write(&serverAddr, &clientSock, STATION_DMA_DMA_DEBUG_WR_DATA_ADDR, data);
                  } else {
                    do_write(&serverAddr, &clientSock, STATION_DMA_DMA_DEBUG_WR_DATA_ADDR, data);
                  }
                }
                is_burst = 0;
                burst_idx = 0;
              } else if ((*debug_req_bits_addr == 0x4) || (*debug_req_bits_addr == 0x5)) { // L2
                //if (addr < 0x40000000) {
                  do_write(&serverAddr, &clientSock, addr2oraddr("l2_data", addr), data);
                  do_write(&serverAddr, &clientSock, addr2oraddr("l2_tag", addr), (addr >> 16));
                  do_write(&serverAddr, &clientSock, addr2oraddr("l2_vld", addr), 0xffffffffffffffff);
                //} else {
                //  do_write_backdoor(&serverAddr, &clientSock, addr, data);
                //}
              } else if ((*debug_req_bits_addr == 0x8) || (*debug_req_bits_addr == 0x9)) { // DDR
                do_write(&serverAddr, &clientSock, STATION_DT_DBG_ADDR_ADDR, addr);
                do_write(&serverAddr, &clientSock, STATION_DT_DBG_DATA_ADDR, data);
              } else if ((*debug_req_bits_addr == 0xc) || (*debug_req_bits_addr == 0xd)) { // DMA BURST
                is_burst = 1;
                burst_data[burst_idx] = data;
                burst_idx += 1;
              }
            }
            if (is_burst == 0)
              addr += 8;
            is_incremental = 1;
          }
        }
      } else if (state == 3) { // RD
        is_incremental = 0;
        is_burst = 0;
        burst_idx = 0;
        if (*debug_req_bits_op == 1) {
          state = 0;
          tmp_data = 0;
          tmp_data = *debug_req_bits_data;
          addr = (addr & 0x00000000ffffffff) | (tmp_data << 32);
          // TODO:
          //fprintf(stderr, "Reading addr %llx, *debug_tohost_addr = %llx, *debug_fromhost_addr = %llx\n", addr, *debug_tohost_addr, *debug_fromhost_addr);
          if (addr < 0x80000000) { // bit 31 is 0
            ret_data = do_read(&serverAddr, &clientSock, addr);
          } else if ((addr == *debug_tohost_addr) || (addr == *debug_fromhost_addr) || (addr == *debug_tohost_addr + 4) || (addr == *debug_fromhost_addr + 4)) { // tohost or fromhost
            do_write(&serverAddr, &clientSock, STATION_DMA_DMA_DEBUG_ADDR_ADDR, addr & 0xfffffff8);
            do_write(&serverAddr, &clientSock, STATION_DMA_DMA_DEBUG_REQ_TYPE_ADDR, 0);
            ret_data = do_read(&serverAddr, &clientSock, STATION_DMA_DMA_DEBUG_RD_DATA_ADDR);
          } else { // Memory Data
            if ((*debug_req_bits_addr == 0x2) || (*debug_req_bits_addr == 0x3)) { // DMA
              do_write(&serverAddr, &clientSock, STATION_DMA_DMA_DEBUG_ADDR_ADDR, addr & 0xfffffff8);
              do_write(&serverAddr, &clientSock, STATION_DMA_DMA_DEBUG_REQ_TYPE_ADDR, 0);
              ret_data = do_read(&serverAddr, &clientSock, STATION_DMA_DMA_DEBUG_RD_DATA_ADDR);
              //printf ("ret_data = %lx in memory\n", ret_data);
            } else if ((*debug_req_bits_addr == 0x6) || (*debug_req_bits_addr == 0x7)) { // L2
              //if (addr < 0x40000000)
                ret_data = do_read(&serverAddr, &clientSock, addr2oraddr("l2_data", addr));
              //else
              //  ret_data = do_read_backdoor(&serverAddr, &clientSock, addr);
            } else if ((*debug_req_bits_addr == 0xa) || (*debug_req_bits_addr == 0xb)) { // DDR
              do_write(&serverAddr, &clientSock, STATION_DT_DBG_ADDR_ADDR, addr);
              ret_data = do_read(&serverAddr, &clientSock, STATION_DT_DBG_DATA_ADDR);
            } else if ((*debug_req_bits_addr == 0xe) || (*debug_req_bits_addr == 0xf)) { // GPIO
            }
          }
        }
      }
      debug_resp_valid = 1;
      debug_resp_bits_resp = 0;
      if (((addr >> 32) == 0x8c) ||
          ((addr >> 32) == 0x8d) ||
          ((addr >> 32) == 0x8e) ||
          ((addr >> 32) == 0x8f))
        debug_resp_bits_data = ret_data & 0xffffffff;
      else
        debug_resp_bits_data = ((addr >> 2) & 0x1) ? ((ret_data >> 32) & 0xffffffff) : (ret_data & 0xffffffff);
    }
  }

  return 0;
}
