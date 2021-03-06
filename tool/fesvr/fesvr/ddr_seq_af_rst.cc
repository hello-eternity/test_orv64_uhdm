 this->ht->OURSBUS_WRITE (0x8C00000304, 0x00000000); //read write are issued to SDRAM 
 this->ht->OURSBUS_WRITE (0x8C00000030, 0x00000080); 
 this->ht->OURSBUS_WRITE (0x8C00000030, 0x00000080); 
 this->ht->OURSBUS_WRITE (0x8C00000320, 0x00000000);//quasi programming starts 
 this->ht->OURSBUS_WRITE (0x8C000001b0, 0x00000000); 
 this->ht->OURSBUS_WRITE (0x8C000001b0, 0x00000000); 

#include "ddr_skiptrain.cc"
//#include "train_1d.cc"

this->ht->OURSBUS_WRITE (0x8C000001b0, 0x00000020); //DFI init start
rdata = 0x0;
while ((rdata & 0x1) != 1) {
  //fprintf(stderr, "Line 668\n");
  this->ht->OURSBUS_READ_4B  (0x8C000001bc, rdata); //DFI init complete (status)
}

this->ht->OURSBUS_WRITE (0x8C000001b0, 0x00000000); //PHY DBI mode
this->ht->OURSBUS_WRITE (0x8C000001b0, 0x00000001); //DFI init complete en
this->ht->OURSBUS_WRITE (0x8C000001b0, 0x00000001); //DFI init complete en
this->ht->OURSBUS_WRITE (0x8C00000320, 0x00000001); //Quasi SW programming done

rdata = 0x0;
while ((rdata & 0x1) != 1) {
  //fprintf(stderr, "Line 679\n");
  this->ht->OURSBUS_READ_4B  (0x8C00000324, rdata); // SW done ack (status) bit 0
}

rdata = 0x0;
while ((rdata & 0x1) != 1) {
  //fprintf(stderr, "Line 685\n");
  this->ht->OURSBUS_READ_4B  (0x8C00000004, rdata); //Wait for normal mode (status)
}

//mode registers write: kee0xe same as programmed in uMctl
 this->ht->OURSBUS_WRITE (0x8C00000010, 0x00000038);
  
 this->ht->OURSBUS_WRITE (0x8C00000014, 0x00000d00);//MR13
 this->ht->OURSBUS_WRITE (0x8C00000010, 0x80000038);
 rdata = 0x1;
 while ((rdata & 0x1) != 0) {
   //fprintf(stderr, "Line 696\n");
   this->ht->OURSBUS_READ_4B  (0x8C00000018, rdata); 
 }

 this->ht->OURSBUS_WRITE (0x8C00000014, 0x00000184);//MR1
 this->ht->OURSBUS_WRITE (0x8C00000010, 0x80000038);
 rdata = 0x1;
 while ((rdata & 0x1) != 0) {
   //fprintf(stderr, "Line 704\n");
   this->ht->OURSBUS_READ_4B  (0x8C00000018, rdata); 
 }

 this->ht->OURSBUS_WRITE (0x8C00000014, 0x00000200);//MR2
 this->ht->OURSBUS_WRITE (0x8C00000010, 0x80000038);
 rdata = 0x1;
 while ((rdata & 0x1) != 0) {
   //fprintf(stderr, "Line 712\n");
   this->ht->OURSBUS_READ_4B  (0x8C00000018, rdata); 
 }

 this->ht->OURSBUS_WRITE (0x8C00000014, 0x00000308);//MR3
 this->ht->OURSBUS_WRITE (0x8C00000010, 0x80000038);
 rdata = 0x1;
 while ((rdata & 0x1) != 0) {
   //fprintf(stderr, "Line 720\n");
   this->ht->OURSBUS_READ_4B  (0x8C00000018, rdata); 
 }

 this->ht->OURSBUS_WRITE (0x8C00000010, 0x00000030);
 
 //Mode Register Programming Done  

 this->ht->OURSBUS_WRITE (0x8C00000030, 0x00000080); //power control
 this->ht->OURSBUS_WRITE (0x8C00000030, 0x00000080); //power control
 this->ht->OURSBUS_WRITE (0x8C00000490, 0x00000001); //enable AXI port

 this->ht->OURSBUS_WRITE (0x8C00000030, 0x00000001); //entering self refresh
 this->ht->OURSBUS_WRITE (0x8C00000030, 0x00000000); //exit self refresh


