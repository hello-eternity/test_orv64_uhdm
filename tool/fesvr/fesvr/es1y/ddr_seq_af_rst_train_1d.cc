this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000304, 0x00000000); //read write are issued to SDRAM 
this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000060, 0x00000001); //dis_auto_refresh=1
this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000030, 0x00000020); //selfrf_sw=1,powerdown_en=0, selfref_en=0
this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000320, 0x00000000); //sw_done=0,quasi programming starts 
this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x000001b0, 0x00000000); //dfi_init_complete_en=0
this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000320, 0x00000001); //sw_done=1, quasi programming done

// Polling ack after setting sw_done to 1
rdata = 0x0;
while ((rdata & 0x1) != 1) {
  //fprintf(stderr, "Line 679\n");
  this->ht->OURSBUS_READ_4B  (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000324, rdata); // SW done ack (status) bit 0
}

#include "train_1d.cc"

this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000320, 0x00000000); //quasi programming starts 
this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x000001b0, 0x00000020); //DFI init start=1
this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000320, 0x00000001); //sw_done=1, quasi programming done

// Polling ack after setting sw_done to 1
rdata = 0x0;
while ((rdata & 0x1) != 1) {
  //fprintf(stderr, "Line 679\n");
  this->ht->OURSBUS_READ_4B  (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000324, rdata); // SW done ack (status) bit 0
}

// Polling for dfi_init_complete=1
rdata = 0x0;
while ((rdata & 0x1) != 1) {
  fprintf(stderr, "Line 668\n");
  this->ht->OURSBUS_READ_4B  (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x000001bc, rdata); //DFI init complete (status)
}

this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000320, 0x00000000); //quasi programming starts 
this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x000001b0, 0x00000000); //DFI init start=0
this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x000001b0, 0x00000001); //DFI init complete en
this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000030, 0x00000000); //selfrf_sw=0
this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000320, 0x00000001); //sw_done=1, quasi programming done

// Polling ack after setting sw_done to 1
rdata = 0x0;
while ((rdata & 0x1) != 1) {
  //fprintf(stderr, "Line 679\n");
  this->ht->OURSBUS_READ_4B  (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000324, rdata); // SW done ack (status) bit 0
}

rdata = 0x0;
while ((rdata & 0x7) != 0x1) {
  fprintf(stderr, "Line 685\n");
  this->ht->OURSBUS_READ_4B  (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000004, rdata); //Wait for normal mode (status)
}

//mode registers write: kee0xe same as programmed in uMctl
this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000014, 0x000001c4);//MR1
this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000010, 0x80000038);
rdata = 0x1;
while ((rdata & 0x1) != 0) {
  this->ht->OURSBUS_READ_4B (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000018, rdata); 
}

this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000014, 0x00000224);//MR2
this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000010, 0x80000038);
rdata = 0x1;
while ((rdata & 0x1) != 0) {
  this->ht->OURSBUS_READ_4B (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000018, rdata); 
}

this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000014, 0x00000320);//MR3
this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000010, 0x80000038);
rdata = 0x1;
while ((rdata & 0x1) != 0) {
  this->ht->OURSBUS_READ_4B (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000018, rdata); 
}

this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000060, 0x00000000); //dis_auto_refresh=0
this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000490, 0x00000001); //enable AXI port
