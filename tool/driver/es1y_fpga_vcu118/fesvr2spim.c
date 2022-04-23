#include <stdio.h>
#include <stdlib.h>
#include <vector>
#include <string>
#include <string.h>

#include "ftd2xx.h"
#include "libft4222.h"
#include "debug_tick.h"
#include "common.h"
#include "pygmy_es1_addr_translater.h"

int main (int argc, char const *argv[])
{
  std::string status;
  FT4222_SPIMode mode = SPI_IO_SINGLE;

  dtm_t*   dtm = NULL;

  unsigned char* debug_req_valid = (unsigned char*) malloc(sizeof(unsigned char));
  unsigned char  debug_req_ready;
  uint32*        debug_req_bits_addr = (uint32*) malloc(sizeof(uint32));
  uint32*        debug_req_bits_op = (uint32*) malloc(sizeof(uint32));
  uint32*        debug_req_bits_data = (uint32*) malloc(sizeof(uint32));
  uint64*        debug_tohost_addr = (uint64*) malloc(sizeof(uint64));
  uint64*        debug_fromhost_addr = (uint64*) malloc(sizeof(uint64));
  unsigned char  debug_resp_valid;
  unsigned char* debug_resp_ready = (unsigned char*) malloc(sizeof(unsigned char));
  int            debug_resp_bits_resp;
  int            debug_resp_bits_data;

  int            state = 0; //0: IDLE, 1: WR_ADDR, 2:WR_DATA 3:RD
  int            rcvd_addr = 0;
  int            rcvd_data = 0;
  uint64         data = 0;
  uint64         addr = 0;
  uint64         ret_data = 0;
  uint64         tmp_data = 0;

  FT_HANDLE ftHandle = setup(mode, CLK_DIV_128, CLK_IDLE_LOW, CLK_LEADING);
  if (ftHandle == NULL)
    return 0;

  do_status_check(mode, ftHandle);

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
      do_status_check(mode, ftHandle);
      debug_resp_valid = 0;
    } else {
      ret_data = 0;
      if (state == 0) { // IDLE
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
            // TODO:
            if (strcmp(argv[1], "+drop_addr_bit_31") == 0) {
              addr = addr & 0xffffffff7fffffff;
            }
            if ((addr >> 39) & 0x1 == 1) { // bit 39 is 1
              do_write(mode, ftHandle, addr, data);
            } else if ((addr == *debug_tohost_addr) || (addr == *debug_fromhost_addr)) { // tohost or fromhost
              do_write(mode, ftHandle, addr2obaddr("mmem", addr), data); // TODO: MMEM
              //do_write(mode, ftHandle, addr2obaddr("l2_data", addr), data); // TODO: MMEM
            } else { // Memory Data
              if ((*debug_req_bits_addr == 0x0) || (*debug_req_bits_addr == 0x1)) { // DMA
                do_write(mode, ftHandle, addr2obaddr("dma", addr), data);
              } else if ((*debug_req_bits_addr == 0x4) || (*debug_req_bits_addr == 0x5)) { // L2
                // VLD
                do_write(mode, ftHandle, addr2obaddr("l2_vld", addr), 0xffffffffffffffff);
                // TAG
                do_write(mode, ftHandle, addr2obaddr("l2_tag", addr), (addr >> 17));
                // DATA
                do_write(mode, ftHandle, addr2obaddr("l2_data", addr), data);
              } else if ((*debug_req_bits_addr == 0x8) || (*debug_req_bits_addr == 0x9)) { // DDR
                do_write(mode, ftHandle, addr2obaddr("dt", addr), data);
              } else if ((*debug_req_bits_addr == 0xc) || (*debug_req_bits_addr == 0xd)) { // GPIO
              }
            }
            addr += 8;
          }
        }
      } else if (state == 3) { // RD
        if (*debug_req_bits_op == 1) {
          state = 0;
          tmp_data = 0;
          tmp_data = *debug_req_bits_data;
          addr = (addr & 0x00000000ffffffff) | (tmp_data << 32);
          // TODO:
          if (strcmp(argv[1], "+drop_addr_bit_31") == 0) {
            addr = addr & 0xffffffff7fffffff;
          }
          //fprintf(stderr, "Reading addr %x, *debug_tohost_addr = %x, *debug_fromhost_addr = %x\n", addr, *debug_tohost_addr, *debug_fromhost_addr);
          if ((addr >> 39) & 0x1 == 1) { // bit 39 is 1
            ret_data = do_read(mode, ftHandle, addr);
          } else if ((addr == *debug_tohost_addr) || (addr == *debug_fromhost_addr) || (addr == *debug_tohost_addr + 4) || (addr == *debug_fromhost_addr + 4)) { // tohost or fromhost
            ret_data = do_read(mode, ftHandle, addr2obaddr("mmem", addr)); // TODO: MMEM
            //ret_data = do_read(mode, ftHandle, addr2obaddr("l2_data", addr)); // TODO: MMEM
          } else { // Memory Data
            if ((*debug_req_bits_addr == 0x2) || (*debug_req_bits_addr == 0x3)) { // DMA
              ret_data = do_read(mode, ftHandle, addr2obaddr("dma", addr));
            } else if ((*debug_req_bits_addr == 0x6) || (*debug_req_bits_addr == 0x7)) { // L2
              ret_data = do_read(mode, ftHandle, addr2obaddr("l2_data", addr));
            } else if ((*debug_req_bits_addr == 0xa) || (*debug_req_bits_addr == 0xb)) { // DDR
              ret_data = do_read(mode, ftHandle, addr2obaddr("dt", addr));
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

  FT4222_UnInitialize(ftHandle);
  FT_Close(ftHandle);
  return 0;
}
