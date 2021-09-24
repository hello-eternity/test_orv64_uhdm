/*
 * This test application is to read/write data directly from/to the device 
 * from userspace. 
 * 
 */
#include "gpio_dev_mem.h"
int fd;
struct stat sb;
void *ptr;
void *ptr2;
uint64_t page_addr;
uint64_t page_addr2;
uint64_t page_size;
unsigned long page_addr_bram;
void *ptr_bram;
/* open dev mem and return fd */
void open_fd() {
  unsigned long rst_spi_addr_base     = 0xA0000000;
  unsigned long test_addr_base        = 0x4000000000;
  unsigned long bram_addr_base        = 0x10000000;
	page_size=sysconf(_SC_PAGESIZE);
  page_size = page_size * 128;
	printf("GPIO access through /dev/mem. page size %u pagesz: %lx\n",page_size ,getpagesize());
	fd = open ("/dev/mem", O_RDWR|O_CREAT);
	if (fd < 1) {
		perror("open /dev/mem fail");
    exit(EXIT_FAILURE);
	}
  fstat(fd,&sb);
  //--------------------------
  page_addr = (rst_spi_addr_base  & (~(page_size-1)));
  if (rst_spi_addr_base != page_addr ) {
      printf("rst_spi_addr_base %lx != page addr %lx\n", rst_spi_addr_base, page_addr);
      perror("rst_spi_addr_base != page addr\n");
      exit(EXIT_FAILURE);
  }
  else {
    printf("rst_spi_addr_base %lx page addr %lx\n", rst_spi_addr_base, page_addr);
  }
	ptr = mmap(NULL, page_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, page_addr);
  if(ptr == MAP_FAILED){
    close(fd);
    perror("gpio_dev_mem: Error Mapping PTR to the file");
    exit(EXIT_FAILURE);
  } 
  //--------------------------
 page_addr_bram = (bram_addr_base  & (~(page_size-1)));
 if (bram_addr_base != page_addr_bram ) {
     printf("bram_addr_base %lx != page addr %lx\n", bram_addr_base, page_addr_bram);
     perror("bram_addr_base != page addr\n");
     exit(EXIT_FAILURE);
 }
 else {
   printf("bram_addr_base %lx page addr %lx\n", bram_addr_base, page_addr_bram);
 }
 ptr_bram = mmap(NULL, page_size*sizeof(uint64_t), PROT_READ|PROT_WRITE, MAP_SHARED, fd, page_addr_bram);
 printf("ptr_bram: %x\n",ptr_bram);
 if(ptr_bram == MAP_FAILED){
   close(fd);
   perror("gpio_dev_mem: Error Mapping ptr_bram to the file");
   exit(EXIT_FAILURE);
 } 
  //--------------------------
  page_addr2 = (test_addr_base  & (~(page_size-1)));
  if (test_addr_base != page_addr2 ) {
      printf("test_addr_base %lx != page addr2 %lx\n", test_addr_base, page_addr2);
      perror("test_addr_base != page addr2\n");
      exit(EXIT_FAILURE);
  }
  else {
    printf("test_addr_base %lx page addr2 %lx\n", test_addr_base, page_addr2);
  }
	ptr2 = mmap(NULL, page_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, page_addr2);
  if(ptr2 == MAP_FAILED){
    close(fd);
    perror("gpio_dev_mem: Error Mapping PTR to the file");
    exit(EXIT_FAILURE);
  } 
 
}

void close_fd(){
	munmap(ptr, page_size);
	munmap(ptr_bram, page_size);
  close(fd);
}

/* write gpio */
int write_gpio(uint64_t gpio_addr, uint64_t value)
{
	if (gpio_addr == 0) {
		printf("[MAIN] GPIO physical address is required.\n");
		return -1;
	}

	uint64_t page_offset;
	uint64_t page_offset2;
	page_offset = gpio_addr - page_addr;
	page_offset2 = gpio_addr - page_addr2;

    if(debug>=4){
        printf("[MAIN] gpio write. addr %08" PRIx32 ", value %016" PRIx64 "\n", gpio_addr, value);
    }

    if (gpio_addr >= 0x4000000000)
      *((uint64_t*)(ptr2 + page_offset2)) = value;
    else
      *((uint64_t*)(ptr + page_offset)) = value;

	return 0;
}

unsigned long read_gpio(uint64_t gpio_addr)
{
	uint64_t value;
	uint64_t page_offset;

	page_offset = gpio_addr - page_addr;

	/* Read value from the device register */
    value = *((uint64_t*)(ptr + page_offset));

    if(debug>=4){
        printf("[MAIN] read gpio64. addr %08" PRIx32 ", value %016" PRIx64 "\n", gpio_addr, value);
    }

	return value;
}

int write_gpio_bram(unsigned long gpio_addr, uint64_t value)
{
 	uint64_t page_offset;
	if (gpio_addr == 0) {
		fprintf(stderr,"GPIO physical address is required.\n");
		return -1;
	}
	  page_offset = gpio_addr - page_addr_bram;
    fprintf(stdout,"write_gpio_bram: Before gpio_addr %lx, page_addr_bram %lx, page_offset 0x%" PRIx64 ", value: 0x%" PRIx64 "\n", gpio_addr,page_addr_bram,page_offset,value);
    *((unsigned long long*)(ptr_bram + page_offset)) = value;
    fprintf(stdout,"write_gpio_bram: After gpio_addr %lx, page_addr_bram %lx, page_offset 0x%" PRIx64 ", value: 0x%" PRIx64 "\n", gpio_addr,page_addr_bram,page_offset,value);
	return 0;
}
uint64_t read_gpio_bram(unsigned long gpio_addr)
{
	uint64_t value = 0;
	
	uint64_t page_offset;
	page_offset = gpio_addr - page_addr_bram;
  fprintf(stdout,"read_gpio_bram: Before gpio_addr %lx, page_addr_bram %lx, page_offset 0x%" PRIx64 ", value: 0x%" PRIx64 "\n", gpio_addr,page_addr_bram,page_offset,value);
  value = *((unsigned long long*)(ptr_bram + page_offset));
  fprintf(stdout,"read_gpio_bram: After gpio_addr %lx, page_addr_bram %lx, page_offset 0x%" PRIx64 ", value: 0x%" PRIx64 "\n", gpio_addr,page_addr_bram,page_offset,value);
	return value;
}

