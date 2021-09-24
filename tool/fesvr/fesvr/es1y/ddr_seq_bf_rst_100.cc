
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000304, 0x00000001); //no read/write are issued to SDRAM 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000030, 0x00000001); //self ref0x enable 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000000, 0x83080020); //device config MSTR register

 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000010, 0x00000030); 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000014, 0x00002131); //don't care, non-zero 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000020, 0x00000100); //derate 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000024, 0x01e53b2f); //non-zero
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000028, 0x00000000); //don't care if 0x0000[29]=0 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x0000002c, 0x00000000); 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000030, 0x00000000); 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000034, 0x00405e03); 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000038, 0x004a0001); 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000050, 0x00110000); //[2] per bank refresh
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000054, 0x00030003); 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000060, 0x00000000); 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000064, 0x80030007); //[9:0] t_rfc_min (>= tRFCpb, 140)
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000068, 0x003c0000); 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x000000c0, 0x00000000); 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x000000c4, 0x0c000000); 

 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x000000d0, 0x00010001); //[25:16]INIT5,post_cke. [11:0]INIT3,pre_cke=2ms 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x000000d4, 0x00010008); //[24:16]INIT1,reset=200us
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x000000dc, 0x00840000); //INIT3 mr(MR1 in lp4 SDRAM)  emr(MR2 in lp4 SDRAM)
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x000000e0, 0x00200000); //INIT4 emr2(MR3 in lp4 SDRAM) emr3(MR13 in lp4 SDRAM)
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x000000e8, 0x0000004d); //[31:16] mr11, [15:0] mr12
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x000000ec, 0x0000004d); //[31:16] mr22, [15:0] mr14
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x000000f0, 0x00000000); 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x000000f4, 0x00000888); //RANK Control 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x000000fc, 0x00000000); //RANK Control 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000100, 0x1719291a); //start of SDRAM Timing Register
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000104, 0x00050528); 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000108, 0x02030e11); //write latency, read latency, rd2wr, wr2rd 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x0000010c, 0x01010000); //t_MRW 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000110, 0x1004070c); //[11:8] tRRD=10 




 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000114, 0x03050e0e); 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000118, 0x010d0006); 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x0000011c, 0x00000a09); 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000120, 0x00000501); 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000130, 0x00020000); 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000134, 0x02100002); 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000138, 0x000000ad); //end of SDRAM Timing Register


 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000180, 0x03e8000f); //ZQ Control Register 0
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000184, 0x03200070); //ZQ Control Register 1
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000188, 0x00000000); //ZQ Control Register 2

 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000190, 0x02828200); //DFI Timing register
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000194, 0x00080101);
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000198, 0x07f0b130);

 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x000001b0, 0x00000000); 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x000001b4, 0x00000200); //DFI Timing register
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x000001c0, 0x00000001); 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x000001c4, 0x00000000);

 // SDRAM address mapper
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000200, 0x001f1f17);
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000204, 0x00080808); 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000208, 0x00000000); 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x0000020c, 0x00000000); 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000210, 0x00001f1f); 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000214, 0x07070707);
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000218, 0x07070707);
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x0000021c, 0x00001f0f); 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000220, 0x00003f3f);
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000224, 0x00000000); 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000228, 0x02080300); 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x0000022c, 0x003f3f00);

 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000240, 0x09160230); 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000244, 0x00000000); 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000250, 0x03631f05); 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000254, 0x000000f9); 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x0000025c, 0x210002a7); 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000264, 0x0f00ce4d); 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x0000026c, 0xb600718e); 

 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000300, 0x00000014); 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x0000030c, 0x00000000); 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x0000036c, 0x00000001); 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000400, 0x00000011); 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000404, 0x0001309d); 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000408, 0x0000631d); 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000490, 0x00000001); 
 this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + 4 * 0x00000494, 0x00110004); 

