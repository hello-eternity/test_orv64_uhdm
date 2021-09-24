#ifndef __HTIF_ES1Y_H
#define __HTIF_ES1Y_H
#include "htif_proj.h"
#include "station_orv32.h"
#include "station_vp.h"
#include "station_cache.h"
#include "station_ddr_top.h"
#include "station_pll.h"
#include "station_byp.h"
#include "station_usb_top.h"
#include "station_slow_io.h"
#include "station_sdio.h"
#include "station_dt.h"
#include "station_usb_top.h"
#include "station_dma.h"

//class htif_proj;

class es1y : public htif_proj {
  typedef void (es1y::*func_pointer)(std::string key);
  private:
    //helpers
    //std::vector<uint64_t> get_breakpoints(std::string breakpoints);
    void set_breakpoints(std::vector<uint64_t> station_en_addr, std::vector<uint64_t> station_addr, std::vector<uint64_t> breakpoints);
    // list of functions
    void io_test(std::string key);
    void program_pll(std::string key);
    void sram_ddr(std::string key);  
    void reset_ddr(std::string key);  
    // RUN
    void bg();
    void reset_usb(std::string key);  
    void reset_sdio(std::string key);  
    // SDIO
    void clear_nth_bit(int64_t addr, int position);
    void set_nth_bit(int64_t addr, int position);
    void set_n_bits(int64_t addr, int end_position, int start_position);
    void clear_n_bits(int64_t addr, int end_position, int start_position);
    bool nth_bit_set(int64_t addr, int position);
    bool n_bits_nonzero(int64_t addr, int end_position, int start_position);
    uint32_t get_n_bits(int64_t addr, int end_position, int start_position);
    bool card_insertion_chk(int64_t header);
    void card_detection(int64_t header);
    void host_controller_setup_sequence(int64_t header);
    void host_controller_clock_setup_sequence(int64_t header);
    void card_clock_supply_sequence(int64_t header);
    void card_clock_stop_sequence(int64_t header);
    void clock_frequency_change_sequence(int64_t header);
    void card_interface_detection(int64_t header);
    bool tuning_sequence(int64_t header) ;
    void mode1_retuning_flow_sequence(int64_t header) ;
    void auto_tuning_sequence(int64_t header) ;
    void software_tuning_sequence(int64_t header);
    void bus_timing_setting(int64_t header);
    void sdio_init(std::string key);  
    // SDIO ENDS
    void incr_test_io_freq(std::string key);
    void chip_config(std::string key);
    void config_l1(std::string key);
    void config_l2(std::string key);
    void release_bank0_reset(std::string key);
    void release_bank1_reset(std::string key);
    void release_bank2_reset(std::string key);
    void release_bank3_reset(std::string key);
    void release_reset_for_l2(std::string key);
    void test_l2(std::string key);
    void set_0_to_bank0_vldram(std::string key);
    void set_0_to_bank1_vldram(std::string key);
    void set_0_to_bank2_vldram(std::string key);
    void set_0_to_bank3_vldram(std::string key);
    void set_0_to_l2_vldram(std::string key);
    void release_orv32_early_reset(std::string key);
    void release_vp0_early_reset(std::string key);
    void release_vp1_early_reset(std::string key);
    void release_vp2_early_reset(std::string key);
    void release_vp3_early_reset(std::string key);
    void release_all_early_reset(std::string key);
    void test_l1(std::string key);
    void set_0_to_orv32_l1_tagram(std::string key);
    void set_0_to_vp0_l1_tagram(std::string key);
    void set_0_to_vp1_l1_tagram(std::string key);
    void set_0_to_vp2_l1_tagram(std::string key);
    void set_0_to_vp3_l1_tagram(std::string key);
    void set_0_to_l1_tagram(std::string key);
    void warmup_l1_cache(std::string key);
    void load_kernel(std::string key);
    void load_image(std::string key);
    void load_weight(std::string key);
    void alloc_stack(std::string key);
    void set_magic_mem_address(std::string key);
    void set_reset_pc(const char * target);
    void set_orv32_reset_pc(std::string key);
    void set_vp0_reset_pc(std::string key);
    void set_vp1_reset_pc(std::string key);
    void set_vp2_reset_pc(std::string key);
    void set_vp3_reset_pc(std::string key);
    void set_all_vp_reset_pc(std::string key);
    void load_rom(std::string key);
    void dump_l2_after_loading(std::string key);
    void release_vp0_reset(std::string key);
    void release_vp1_reset(std::string key);
    void release_vp2_reset(std::string key);
    void release_vp3_reset(std::string key);
    void release_all_vp_reset(std::string key);
    void mem_test(std::string key);
    void enable_dram_tester(std::string key);
    void release_orv32_reset(std::string key);
    void io_reg_test(std::string key);
    void enable_flash_fsm(std::string key);
    void enable_boot_fsm(std::string key);
    void read_from_flash(std::string key);
    void trigger_afterwards(std::string key);
    struct func_t {
      std::string key;
      es1y::func_pointer ptr;
   
    };
    std::vector<func_t> boot_sequence;
  public:
    es1y(htif_t * ht) : htif_proj("es1y", ht){
        boot_sequence.push_back((func_t){"incr_test_io_freq=", &es1y::incr_test_io_freq});
        boot_sequence.push_back((func_t){"chip_config=", &es1y::chip_config});
        boot_sequence.push_back((func_t){"io_test"  ,&es1y::io_test});
        boot_sequence.push_back((func_t){"program_pll="  ,&es1y::program_pll});
        boot_sequence.push_back((func_t){"sram_ddr"  ,&es1y::sram_ddr});
        boot_sequence.push_back((func_t){"reset_ddr"  ,&es1y::reset_ddr});
        boot_sequence.push_back((func_t){"enable_dram_tester", &es1y::enable_dram_tester});
        boot_sequence.push_back((func_t){"config_l1=", &es1y::config_l1});
        boot_sequence.push_back((func_t){"config_l2=", &es1y::config_l2});
        boot_sequence.push_back((func_t){"release_bank0_reset", &es1y::release_bank0_reset});
        boot_sequence.push_back((func_t){"release_bank1_reset", &es1y::release_bank1_reset});
        boot_sequence.push_back((func_t){"release_bank2_reset", &es1y::release_bank2_reset});
        boot_sequence.push_back((func_t){"release_bank3_reset", &es1y::release_bank3_reset});
        boot_sequence.push_back((func_t){"release_l2_reset", &es1y::release_reset_for_l2});
        boot_sequence.push_back((func_t){"reset_usb"  ,&es1y::reset_usb});
        boot_sequence.push_back((func_t){"reset_sdio"  ,&es1y::reset_sdio});
        boot_sequence.push_back((func_t){"sdio_init"  ,&es1y::sdio_init});
        boot_sequence.push_back((func_t){"io_reg_test"  ,&es1y::io_reg_test});
        boot_sequence.push_back((func_t){"enable_boot_fsm", &es1y::enable_boot_fsm});
        boot_sequence.push_back((func_t){"test_l2", &es1y::test_l2});
        boot_sequence.push_back((func_t){"set_0_to_bank0_vldram", &es1y::set_0_to_bank0_vldram});
        boot_sequence.push_back((func_t){"set_0_to_bank1_vldram", &es1y::set_0_to_bank1_vldram});
        boot_sequence.push_back((func_t){"set_0_to_bank2_vldram", &es1y::set_0_to_bank2_vldram});
        boot_sequence.push_back((func_t){"set_0_to_bank3_vldram", &es1y::set_0_to_bank3_vldram});
        boot_sequence.push_back((func_t){"set_0_to_l2_vldram", &es1y::set_0_to_l2_vldram});
        boot_sequence.push_back((func_t){"release_orv32_early_reset", &es1y::release_orv32_early_reset});
        boot_sequence.push_back((func_t){"release_vp0_early_reset", &es1y::release_vp0_early_reset});
        boot_sequence.push_back((func_t){"release_vp1_early_reset", &es1y::release_vp1_early_reset});
        boot_sequence.push_back((func_t){"release_vp2_early_reset", &es1y::release_vp2_early_reset});
        boot_sequence.push_back((func_t){"release_vp3_early_reset", &es1y::release_vp3_early_reset});
        boot_sequence.push_back((func_t){"release_all_early_reset", &es1y::release_all_early_reset});
        boot_sequence.push_back((func_t){"test_l1", &es1y::test_l1});
        boot_sequence.push_back((func_t){"set_0_to_orv32_l1_tagram", &es1y::set_0_to_orv32_l1_tagram});
        boot_sequence.push_back((func_t){"set_0_to_vp0_l1_tagram", &es1y::set_0_to_vp0_l1_tagram});
        boot_sequence.push_back((func_t){"set_0_to_vp1_l1_tagram", &es1y::set_0_to_vp1_l1_tagram});
        boot_sequence.push_back((func_t){"set_0_to_vp2_l1_tagram", &es1y::set_0_to_vp2_l1_tagram});
        boot_sequence.push_back((func_t){"set_0_to_vp3_l1_tagram", &es1y::set_0_to_vp3_l1_tagram});
        boot_sequence.push_back((func_t){"set_0_to_l1_tagram", &es1y::set_0_to_l1_tagram});
        boot_sequence.push_back((func_t){"l1_warmup", &es1y::warmup_l1_cache});
        boot_sequence.push_back((func_t){"load_pk", &es1y::load_kernel});
        boot_sequence.push_back((func_t){"load_image=", &es1y::load_image});
        boot_sequence.push_back((func_t){"load_weight=", &es1y::load_weight});
        boot_sequence.push_back((func_t){"alloc_sp=", &es1y::alloc_stack});
        boot_sequence.push_back((func_t){"set_magic_mem", &es1y::set_magic_mem_address});
        boot_sequence.push_back((func_t){"set_orv32_rst_pc=", &es1y::set_orv32_reset_pc});
        boot_sequence.push_back((func_t){"set_vp0_rst_pc=", &es1y::set_vp0_reset_pc});
        boot_sequence.push_back((func_t){"set_vp1_rst_pc=", &es1y::set_vp1_reset_pc});
        boot_sequence.push_back((func_t){"set_vp2_rst_pc=", &es1y::set_vp2_reset_pc});
        boot_sequence.push_back((func_t){"set_vp3_rst_pc=", &es1y::set_vp3_reset_pc});
        boot_sequence.push_back((func_t){"set_all_vp_rst_pc=", &es1y::set_all_vp_reset_pc});
        boot_sequence.push_back((func_t){"load_rom", &es1y::load_rom});
        boot_sequence.push_back((func_t){"dump_l2_after_loading=", &es1y::dump_l2_after_loading});
        boot_sequence.push_back((func_t){"mem_test=", &es1y::mem_test});
        boot_sequence.push_back((func_t){"release_vp0_reset", &es1y::release_vp0_reset});
        boot_sequence.push_back((func_t){"release_vp1_reset", &es1y::release_vp1_reset});
        boot_sequence.push_back((func_t){"release_vp2_reset", &es1y::release_vp2_reset});
        boot_sequence.push_back((func_t){"release_vp3_reset", &es1y::release_vp3_reset});
        boot_sequence.push_back((func_t){"release_all_vp_reset", &es1y::release_all_vp_reset});
        boot_sequence.push_back((func_t){"enable_flash_fsm", &es1y::enable_flash_fsm});
        boot_sequence.push_back((func_t){"release_orv32_reset", &es1y::release_orv32_reset});
        boot_sequence.push_back((func_t){"trigger_afterwards", &es1y::trigger_afterwards});
        boot_sequence.push_back((func_t){"read_from_flash", &es1y::read_from_flash});
        auto it = this->boot_sequence.begin();
        for(;it != this->boot_sequence.end(); ++it){
          this->ht->argmap.insert({it->key.c_str(), ""});
        }
        this->ht->argmap.insert({"use_avery", ""});
        this->ht->argmap.insert({"ddr_bypass", ""});
        this->ht->argmap.insert({"ddr_train_1d", ""});
        this->ht->argmap.insert({"freeze", ""});
        this->ht->argmap.insert({"test_bp=", ""});
        this->ht->argmap.insert({"bp_pc=", ""});
        this->ht->argmap.insert({"background_traffic", ""});
        this->ht->argmap.insert({"disable_pc_chk", ""});
        this->ht->argmap.insert({"usb_ss", ""});
        this->ht->argmap.insert({"usb_fs", ""});
        this->ht->argmap.insert({"usb_init", ""});
        this->ht->argmap.insert({"snapshot", ""});
        this->ht->argmap.insert({"plic_interrupt", ""});
        this->ht->argmap.insert({"log_step=", ""});
        this->ht->argmap.insert({"snap_period=", ""});
        this->ht->argmap.insert({"snap_initial=", ""});
        this->ht->argmap.insert({"linux_rom", ""});
        this->ht->argmap.insert({"simple_dt", ""});
        this->ht->argmap.insert({"isa=", ""});
        this->ht->argmap.insert({"test_instret=", ""});
        this->ht->argmap.insert({"instret=", ""});
        this->ht->argmap.insert({"test_scu", ""});
        this->ht->argmap.insert({"test_bg=", ""});
        this->ht->argmap.insert({"test_scan_f", ""});
        this->ht->argmap.insert({"set_0_to_ddr_sram", ""});
    } 
  void setup();
  ~es1y();
  
  friend class htif_t;
};

// COPY OF mem_t from ours-beak/devices needed for making the dts
class mem_t{
 public:
  mem_t(size_t size) : len(size) {
    if (!size)
      throw std::runtime_error("zero bytes of target memory requested");
    //data = (char*)calloc(1, size);
    //if (!data)
    //  throw std::runtime_error("couldn't allocate " + std::to_string(size) + " bytes of target memory");
  }
  mem_t(const mem_t& that) = delete;
  ~mem_t() {
  }
  char* contents() { return data; }
  size_t size() { return len; }

 private:
  char* data;
  size_t len;
};

#endif
