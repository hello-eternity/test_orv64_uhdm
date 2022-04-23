
module chip_idle_gen
  #(
    parameter int CPU_IDLE_N_CPU = 5,
    parameter int CPU_IDLE_N_BANK = 4
  ) (
    input logic [CPU_IDLE_N_CPU-1:0]  cpu_wfi,
    input logic [CPU_IDLE_N_CPU-1:0]  cpu_wfe,
    input logic [CPU_IDLE_N_CPU-1:0]  cpu_rstn,
    input logic [CPU_IDLE_N_BANK-1:0] bank_idle,
    input logic [CPU_IDLE_N_BANK-1:0] bank_rstn,
    output logic                      chip_is_idle
    );

  always_comb begin
    chip_is_idle = 1'b1;
    for (int i = 0; i < CPU_IDLE_N_CPU; i++) begin
      if ((cpu_wfi[i] == 1'b0) & (cpu_wfe[i] == 1'b0) & (cpu_rstn[i] == 1'b1)) begin
        chip_is_idle = 1'b0;
        break;
      end
    end
    for (int i = 0; i < CPU_IDLE_N_BANK; i++) begin
      if ((bank_idle[i] == 1'b0) & (bank_rstn[i] == 1'b1)) begin
        chip_is_idle = 1'b0;
        break;
      end
    end
  end

endmodule
