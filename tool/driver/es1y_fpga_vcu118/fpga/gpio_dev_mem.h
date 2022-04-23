#ifndef _GPIO_DEV_MEM_H
#define _GPIO_DEV_MEM_H
#define debug 0
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <inttypes.h>
int write_gpio(uint64_t gpio_addr, uint64_t value);
unsigned long read_gpio(uint64_t gpio_addr);
int write_gpio_bram(unsigned long gpio_addr, uint64_t value);
uint64_t read_gpio_bram(unsigned long gpio_addr);
void open_fd();
void close_fd();

#endif
