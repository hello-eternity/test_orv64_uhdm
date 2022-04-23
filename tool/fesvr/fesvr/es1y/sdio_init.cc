#include "dtm.h"
#include "memif.h"
#include "debug_defines.h"
#include "encoding.h"
#include "es1y.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <assert.h>
#include <pthread.h>

static time_t ltime;

#define BYTE 8
#define _NO_OF_BITS sizeof(unsigned) * BYTE
#define MASK(n, m)  (((unsigned)~0u >> (_NO_OF_BITS - n - 1)) & \
                    (~0u << (_NO_OF_BITS - m)))

void es1y::clear_nth_bit(int64_t addr, int position) {
  uint64_t data = 0;
  this->ht->OURSBUS_READ_4B(addr,data);
  data = data & (~(0x00000001 << position));
  this->ht->OURSBUS_WRITE(addr, data);
}

void es1y::set_nth_bit(int64_t addr, int position){
  uint64_t data = 0;
  this->ht->OURSBUS_READ_4B(addr, data);
  data = data | ( 0x00000001 << position);
  this->ht->OURSBUS_WRITE(addr, data);
}

void es1y::set_n_bits(int64_t addr, int end_position, int start_position) {
  uint64_t data = 0;
  this->ht->OURSBUS_READ_4B(addr, data);
  data = data | MASK(end_position, start_position);
  this->ht->OURSBUS_WRITE(addr, data);
}

void es1y::clear_n_bits(int64_t addr, int end_position, int start_position) {
  uint64_t data = 0;
  this->ht->OURSBUS_READ_4B(addr, data);
  data = data & ~(MASK(end_position, start_position));
  this->ht->OURSBUS_WRITE(addr, data);
}

bool es1y::nth_bit_set(int64_t addr, int position){
  uint64_t data = 0;
  this->ht->OURSBUS_READ_4B(addr, data); 
  uint32_t mask = (0x00000001 << position);
  data &=  mask;
  if  (data == mask){
    return true;
  }
  return false;
}

bool es1y::n_bits_nonzero(int64_t addr, int end_position, int start_position) {
  uint64_t data = 0;
  this->ht->OURSBUS_READ_4B(addr, data); 
  data &= MASK(end_position, start_position);
  if (data != 0x00000000){
    return true;
  }
  return false;
}

uint32_t es1y::get_n_bits(int64_t addr, int end_position, int start_position){
  uint64_t data = 0;
  this->ht->OURSBUS_READ_4B(addr, data); 
  data &= MASK(end_position, start_position);
  data = data >> start_position;
  return data;
}

// Check if card inserted
bool es1y::card_insertion_chk(int64_t header) {
  uint64_t pstate_reg_addr = header + 0x24;
  if (nth_bit_set(pstate_reg_addr, 16)){
    fprintf(stderr, "Card is inserted\n");
    return 1;
  }
  else{
    fprintf(stderr, "Card is removed\n");
    return 0;
  }
}

// Card detection
void es1y::card_detection(int64_t header) {
  fprintf(stderr, "Entering Card Detection\n");
  uint64_t normal_int_stat_en_r_addr = header + 0x34;
  uint64_t normal_int_signal_en_r_addr = header +  0x38;

  // set NORMAL_INT_STAT_EN_R.CARD_INSERTION_STAT_EN to 1 [6]
  set_nth_bit(normal_int_stat_en_r_addr, 6);
  
  // set NORMAL_INT_SIGNAL_EN_R.CARD_INSERTION_STAT_EN to 1 [6]
  set_nth_bit(normal_int_signal_en_r_addr, 6);
         
  // set NORMAL_INT_STAT_EN_R.CARD_REMOVAL_STAT_EN to 1 [7]
  set_nth_bit(normal_int_stat_en_r_addr, 7);

  // set NORMAL_INT_SIGNAL_EN_R.CARD_REMOVAL_STAT_EN to 1 [7]
  set_nth_bit(normal_int_signal_en_r_addr, 7);

  // card detect interrupt
  uint64_t normal_int_stat_r_addr = header + 0x30;

  // check and clear interrupt (W1C)
  if (nth_bit_set(normal_int_stat_r_addr, 6)){
    set_nth_bit(normal_int_stat_r_addr, 6);
    fprintf(stderr, "Detect CARD_INSERSTION Interrupt\n");
  }
  else if (nth_bit_set(normal_int_stat_r_addr, 7)){
    set_nth_bit(normal_int_stat_r_addr, 7);
    fprintf(stderr, "Detect CARD_REMOVAL Interrupt\n");
  }  

  card_insertion_chk(header);
} 

//TODO: set common parameters for all version
void es1y::host_controller_setup_sequence(int64_t header) {
  uint64_t pwr_ctrl_r_addr = header + 0x29;
  uint64_t tout_ctrl_r_addr = header + 0x2e;
  uint64_t host_cntrl_vers_r = header + 0xfe;
  uint64_t clk_crtl_r = header + 0x2c;
  uint64_t capabilities2_r_addr = header + 0x44;
  uint64_t capabilities1_r_addr = header + 0x40;
  uint64_t host_ctrl2_r_addr = header + 0x3e;
  uint64_t uhs_ii_timer_cntrl_r_addr = header + 0xc2;

  uint32_t data0 = 0;
  uint32_t data1 = 0;
  // Set common parameters for all version: PWR_CTRL_R.SD_BUS_VOL_VDD1, TOUT_CNT
  // PWR_CTRL_R.SD_BUS_VOL_VDD1 (bit[3:1] = 0x7)
  // PWR_CTRL_R.SD_BUS_PWR_VDD1 (bit[0] = 0x1)
  set_n_bits(pwr_ctrl_r_addr, 3, 0);

  // TOUT_CTRL_R.TOUT_CNT (bit[3:0] = 0xa)
  set_nth_bit(tout_ctrl_r_addr, 3);
  set_nth_bit(tout_ctrl_r_addr, 1);
 
  // Read HOST_CNTRL_VERS_R.SPEC_VERSION_NUM[7:0]
  data0 = get_n_bits(host_cntrl_vers_r, 7,0);

  if (data0 < 3) {
    // TODO: set version 1 and 2 parameter. CLK_CRTL_R (8-bit divided clock)
  }

  else {
    // TODO:set version 3 parameter. CLK_CTRL_R (10-bit divided mode or  programmable clock mode)
    
    // Check if Preset value is used
    if (nth_bit_set(host_ctrl2_r_addr, 15)){
      // TODO:if prset value used
      // set preset registers
      // set HOST_CTRL2_R.PRESET_VAL_ENABLE[15] = 1
      set_nth_bit(host_ctrl2_r_addr, 15);
    }
    else {
      // TODO: check host driver version
      // if version <4
      // return with error
    }
  }
  // Set host_ctrl2_r.host_ver4_enable[12] = 1 
  set_nth_bit(host_ctrl2_r_addr, 1);

  // read CAPABILITIES1_R.SYS_ADDR_64_v4[27]
  if (nth_bit_set(capabilities1_r_addr, 27)){
    // set HOST_CTRL2_r.addressing [13] = 1
    set_nth_bit(host_ctrl2_r_addr, 13);
  } 

  // check capabilities2_r.uhs2_support[3] and vdd2_18v_suppot[28] is 1
  if(nth_bit_set(capabilities2_r_addr, 3) && nth_bit_set(capabilities2_r_addr, 28)) {
    // PWR_CTRL_R.SD_BUS_VOL_VDD2[7:5] to 1
    set_n_bits(pwr_ctrl_r_addr, 7, 5);
  }
  
  // set PRESET_UHS2_R: preset_val_enable = 1, uhs2_if_enable = 1, signaling en = 1 , uhs_mode_sel = 111
  // set HOST_CTRL2_R.PRESET_VAL_ENABLE[15] = 1
  set_nth_bit(host_ctrl2_r_addr, 15);
  
  // Set HOST_CTRL2_R.UHS2_IF_ENABLE[8] to 1 and UHS_MODE_SEL[2:0] to 111
  set_nth_bit(host_ctrl2_r_addr, 8);
  set_n_bits(host_ctrl2_r_addr, 2, 0);

  // set HOST_CTRL2_R.SIGNALING_EN[3] = 1
  set_nth_bit(host_ctrl2_r_addr, 3);
   
  // TODO:set UHS_II_TIMER_CNTRL_R.TIMEOUT_CNT_CMD_RES [3:0] 
  // TODO:set UHS_II_TIMER_CNTRL_R.TIMER_CNT_DEADLOCK[7:4] based on:
  // capabilities_1_r.tout_clk_freq, capabilities_1_r.tout_clik_unit
   
  // Read capabilities_1_r.tout_clock_freq [5:0]
  data0 = get_n_bits(capabilities1_r_addr, 5, 0);
  // Read capabilities_1_r.tout_clock_unit [7]
  
  data1 = get_n_bits(capabilities1_r_addr, 7, 7);
  // write to UHS_II_TIMER_CNTRL.TIMER_CNT_DEADLOCK[7:4]
 
  // check capabilities1_r.async_int_support[29]
  if (nth_bit_set(capabilities1_r_addr, 29)){
    // set host_ctrl2_r.async_int_enable 14
    set_nth_bit(host_ctrl2_r_addr, 14);
  }
}

//TODO: Implement how to exit
void es1y::host_controller_clock_setup_sequence(int64_t header) {
  struct timeval timeout; 

  bool programmable_clock_mode = true;
  uint64_t capabilities1_r_addr = header + 0x40;
  uint64_t capabilities2_r_addr = header + 0x44;

  // check if CAPABILITES2_R.CLK_MUL is non-zero[23:16]
  if (n_bits_nonzero(capabilities2_r_addr, 23, 16)){
    // check if CAPABILITES1_R.BASE_CLK_FREQ is 0[15:8]
    if (!n_bits_nonzero(capabilities1_r_addr, 15, 8)){
      programmable_clock_mode = false;
    }
  }
  uint64_t clk_ctrl_r_addr = header + 0x2c;
  if (programmable_clock_mode){
    // Set CLK_CTRL_R.FREQ_SEL[15:8] and GEN_SELECT [5]
    // this data write needs to be different [15:8] 
    set_n_bits(clk_ctrl_r_addr, 15, 8);
    set_nth_bit(clk_ctrl_r_addr, 5);
  } 
  else {
    // Set CLK_CTRL_R.FREQ_SEL[15:8] and GEN_SELECT [5]
    // this data write needs to be different [15:8] 
    set_n_bits(clk_ctrl_r_addr, 15, 8);
    clear_nth_bit(clk_ctrl_r_addr, 5);
  }
  // Set CLK_CTRL_R.INTERNAL_CLK_EN [0]
  set_nth_bit(clk_ctrl_r_addr, 0);

  // TODO
  //long start = 0;
  //long end = 0;
  //gettimeofday(&timeout, NULL);
  //start = (timeout.tv_sec*1000) + (timeoutv.tv_usec/1000);
  //while (1){
  //  if(end - start >=150){
  //    break;
  //    //fail
  //  }
  //  //  check CLK_CTRL_R.INTERNAL_CLK_STABLE[1]
  //  if (nth_bit_set(clk_ctrl_r_addr, 1)){
  //    break;
  //  }

  //  gettimeofday(&timeout, NULL);
  //  end = (timeout.tv_sec*1000) + (timeoutv.tv_usec/1000);
  //}
  // set CLK_CTRL_R.PLL_ENABLE[3]
  //set_nth_bit(clk_ctrl_r_addr, 3);
  //gettimeofday(&timeout, NULL);
  //start = (timeout.tv_sec*1000) + (timeoutv.tv_usec/1000);
  //// TODO: time  
  //while(1){
  //  // if time = 150ms break
  //  if(end - start >=150){
  //    break;
  //    //fail
  //  }
  //  //  check CLK_CTRL_R.INTERNAL_CLK_STABLE [1]
  //  if (nth_bit_set(clk_ctrl_r_addr, 1)){
  //    break;
  //  }
  //  gettimeofday(&timeout, NULL);
  //  end = (timeout.tv_sec*1000) + (timeoutv.tv_usec/1000);
  //}
}

void es1y::card_clock_supply_sequence(int64_t header){
  uint64_t clk_ctrl_r_addr = header + 0x2c;
  // set CLK_CTRL_R.SD_CLK_EN to 1 [2]
  set_nth_bit(clk_ctrl_r_addr, 2); 
}

void es1y::card_clock_stop_sequence(int64_t header){
  uint64_t clk_ctrl_r_addr = header + 0x2c;
  // set CLK_CTRL_R.SD_CLK_EN to 0 [2]
  clear_nth_bit(clk_ctrl_r_addr, 2); 
}

//TODO: implement how to exti
void es1y::clock_frequency_change_sequence(int64_t header){
  card_clock_stop_sequence(header);
  uint64_t clk_ctrl_r_addr = header + 0x2c;
  bool programmable_clock_mode = true;
  uint64_t capabilities2_r_addr = header + 0x44;
  uint64_t capabilities1_r_addr = header + 0x40;

  struct timeval timeout; 
  // set CLK_CTRL_R.PLL_ENABLE to 0 [3]
  clear_nth_bit(clk_ctrl_r_addr, 3); 
 
  //Check HOST_CTRL2.PRESET_VAL_ENABLE[15]
  uint64_t host_ctrl2_r_addr = header + 0x3e;
  if (nth_bit_set(host_ctrl2_r_addr, 15)){
     // Set bus speed mode in HOST_CTRL2_R.UHS_MODE_SEL[2:0]
     set_n_bits(host_ctrl2_r_addr, 2, 0);
  }
  else {
    // check if CAPABILITES2_R.CLK_MUL is non-zero[23:16]
    if (n_bits_nonzero(capabilities2_r_addr, 23, 16)){
      // check if CAPABILITES1_R.BASE_CLK_FREQ is 0[15:8]
      if (!n_bits_nonzero(capabilities1_r_addr, 15, 18)){
        programmable_clock_mode = false;
      }
    }
    if (programmable_clock_mode){
      // Set CLK_CTRL_R.FREQ_SEL[15:8] and GEN_SELECT [5]
      // this data write needs to be different [15:8] 
      set_n_bits(clk_ctrl_r_addr, 15, 8);
      set_nth_bit(clk_ctrl_r_addr, 5);
    } 
    else {
      // Set CLK_CTRL_R.FREQ_SEL[15:8] and GEN_SELECT [5]
      // this data write needs to be different [15:8] 
      set_n_bits(clk_ctrl_r_addr, 15, 8);
      clear_nth_bit(clk_ctrl_r_addr, 5);
    }
  }
  // SET CLK_CTRL_R.PLL_ENABLE to 1 [3]
  set_nth_bit(clk_ctrl_r_addr, 3);
  long start = 0;
  long end = 0;
  //gettimeofday(&timeout, NULL);
  //start = (timeout.tv_sec*1000) + (timeout.tv_usec/1000);

  //// timeout after 150ms
  //while (1){
  //  // if time = 150ms break
  //  if (end - start >=150){
  //    break;
  //    //fail
  //  }
  //  //  check CLK_CTRL_R.INTERNAL_CLK_STABLE [1]
  //  if (nth_bit_set(clk_ctrl_r_addr, 1)){
  //    break;
  //  }
  //  card_clock_supply_sequence(header);

  //  gettimeofday(&timeout, NULL);
  //  end = (timeout.tv_sec*1000) + (timeout.tv_usec/1000);
  //}
}

//TODO: Do UHS2 part, sd initizlization and identification, sd changing bus mode
void es1y::card_interface_detection(int64_t header){
  uint64_t capabilites2_r_addr = header + 0x44;
  uint64_t host_ctrl2_r_addr = header + 0x3e;
  uint64_t pwr_ctrl_r_addr = header + 0x29;
  uint64_t capabilities2_r_addr = header + 0x44;

  // Check CAPABILITIES2_R.UHS2_SUPPORT [3]
  if (nth_bit_set(capabilities2_r_addr, 3)) {
    // we don't have this yet ha ha
  } 
  else {
    // Set HOST_CTRL2_R.UHS2_IF_ENABLE[8] and UHS_MODE_SEL[2:0] to 0
    clear_nth_bit(host_ctrl2_r_addr, 8);
    clear_n_bits(host_ctrl2_r_addr, 2, 0);
   
    // Set PWR_CTRL_R.SD_BUS_PWR_VDD1[0] to 1
    set_nth_bit(pwr_ctrl_r_addr, 0);
    // TODO: sd clock frequency change
    // TODO: wait power ramp up
    
    card_clock_supply_sequence(header);
    // TODO: proive at least 74 clocks before isusing sd command
    // TODO: sd4-bit mode initizlization
  }
}

//TODO: Tuning error recovery, issue tuning command,
bool es1y::tuning_sequence(int64_t header) {
  // Tuning error recovery
  uint64_t host_ctrl2_r_addr = header + 0x3e;
  // Set HOST_CTRL2_R.EXECTUNING to 1 [6]
  set_nth_bit(host_ctrl2_r_addr, 6);
  uint64_t normal_int_stat_r_addr = header + 0x30;
  while(1) {
    //issue tuning command
    // Check if NORMAL_INT_STAT_R.BUF_RD_READY [5] is 1
    if (nth_bit_set(normal_int_stat_r_addr, 5)) {
      continue;
    }
    else {
      // Clear NORMAL_INT_STAT_R.BUF_RD_READY [5]
      clear_nth_bit(normal_int_stat_r_addr, 5);
    }
    // check if HOST_CTRL2_R.EXEC_TUNING [6] is 1
    if (nth_bit_set(host_ctrl2_r_addr, 6)){
      continue;
    }
    else {
      break;
    }
  }
  
  // check if HOST_CTRL2_R.SAMPLE_CLK_SEL[7] is 1
  if (nth_bit_set(host_ctrl2_r_addr, 7)){
    return true;
  }
  else {
    return false;
  }
}

// TODO: software retuning expires, reload and start software retuning timer
void es1y::mode1_retuning_flow_sequence(int64_t header) {
  // Software retuning timer expires
  
  uint64_t host_ctrl2_r_addr = header + 0x3e;
  // Check HOST_CTRL2_R.SAMPLE_CLK_SEL[7] is 1
  while(nth_bit_set(host_ctrl2_r_addr, 7)) {
    bool tuning_passed = tuning_sequence(header);
    if (tuning_passed)
      break;
  }

  // reload and start software retuning timer
}

//TODO: change at default settings, read next data transfer
//      reset sfotware tuning timer, tuning error, error recovery sequence
//      reset tuning circuit, wait for transfer to complete
void es1y::auto_tuning_sequence(int64_t header) {
  // if change at dfault settings...
  
  while (1){
    bool tuning_successful = tuning_sequence(header);
    if (!tuning_successful){
      return;
    }
  
  // Start next read data transfer
  // reset software's tuning timer
  // if tuning error
  // error recovery seqquence (pg 164) (4.12)
  // reset tuning circuit
 
  // if no tuning error
  // break;
  }
  // wait for transfer to complete
  //

}

//TODO: CMD19, rest of while loop
void es1y::software_tuning_sequence(int64_t header){
  uint64_t data;
  uint64_t clk_ctrl_r_addr = header + 0x2c;
  uint64_t host_ctrl2_r_addr = header + 0x3e;
  uint64_t at_ctrl_r_addr = header + 0x40; //+ P_VENDOR_SPECIFIC_AREA[11:0] ;
  uint64_t at_stat_r_addr = header + 0x44; //+ P_VENDOR_SPECIFIC_AREA[11:0] ;

  // Set CLK_CTRL_R.SD_CLK_EN to 0 [2]
  clear_nth_bit(clk_ctrl_r_addr, 2);

  // Set HOST_CTRL2_R.SAMPPLE_CLK_SEL[7] to 0
  clear_nth_bit(host_ctrl2_r_addr, 7);
  // CMD19 register setup, block_size_r, block_count_r, xfer_mode_r 

  // SET AT_CTRL_R.SW_TUNE_EN[4] to 1  
  set_nth_bit(at_ctrl_r_addr, 4);

  // AT_STAT_R.CENTERPH_CODE[7:0] =0
  clear_n_bits(at_stat_r_addr, 7, 0);
 
  // set CLK_CTRL_R.SD_CLK_EN to 1 [2]
  set_nth_bit(clk_ctrl_r_addr, data); 
  while(1){
    // send cmd19 to device
        
  }
}

//TODO: Calculate what to pout in tout_cnt
void es1y::bus_timing_setting(int64_t header){
  uint64_t capabilities1_r_addr = header + 0x40;
  uint64_t tout_ctrl_r_addr = header + 0x2e;
  uint32_t data0 = 0;
  uint32_t data1 = 0;
  uint64_t data2 = 0;
  uint8_t  reg[8] = {0};
  // READ CAPABILITES1_R.TOUT_CLK_FREQ[5:0]
  data0 = get_n_bits(capabilities1_r_addr, 5, 0);
  // read CAPABILITIES1_R.TOU_CLK_UNIT[7]  
  data1 = get_n_bits(capabilities1_r_addr, 7, 7);
  
  // Set TOUT_CTRL_R.TOUT_CNT[3:0]
  this->ht->OURSBUS_READ_4B(tout_ctrl_r_addr, data2);
  // data2 &= (0xf<calculated_value>)
  this->ht->OURSBUS_WRITE(tout_ctrl_r_addr, data2);
}

// SDIO
void es1y::sdio_init(std::string key) {
  uint64_t rd_data;
  uint64_t header = STATION_SDIO_MSHC_CTRL_ADDR;

  ltime = time(NULL);
  fprintf(stderr, "Start SDIO Initialization @ %s\n", asctime(localtime(&ltime)));

  // Step1: provide hclk and hresetn to DWC_mshc, required by card detection logic
  // Step2: Check if the card is already inserted (required by removable card)
  if (!card_insertion_chk(header)) {

    // Step3: If card is not inserted, do card detection (required by removable card)
    card_detection(header);
  }

  // Step4: Setup basic settings for DWC_mshc as described in Host Controller Setup Sequence
  host_controller_setup_sequence(header);

  // Step5: Enable input clocks (other than hclk) that are available in DWC_mshc
  host_controller_clock_setup_sequence(header);

  // Step6: Identify the type of card
  card_interface_detection(header);

  // Step7: Sequence after powering up, Table 4-1

  ltime = time(NULL);
  fprintf(stderr, "Done SDIO Initialization @ %s\n", asctime(localtime(&ltime)));

}


