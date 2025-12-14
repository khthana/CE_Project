vcom tb_arm2.vhd
vcom tb_cpu.vhd
vsim tb_cpu
wave -logic /reset
wave -logic /oscout
wave -logic /osc
wave -logic /cpu_unit/clk_q1
wave -logic /cpu_unit/clk_q2
wave -logic /cpu_unit/clk_q3
wave -logic /cpu_unit/clk_q4
wave -logic /psen_b
wave -logic /cpu_unit/cu_block/int_tmp
wave -logic /cpu_unit/increase_pc
wave -logic /cpu_unit/write_to_pc
wave -literal -hex /cpu_unit/pc
wave -literal -hex /cpu_unit/mar_out
wave -literal -hex /cpu_unit/mbr
wave -literal -hex /cpu_unit/ir
wave -logic /cpu_unit/cu_block/fsm_ctrl/skip
wave -logic /cpu_unit/cu_block/fsm_ctrl/int
wave -logic /cpu_unit/cu_block/fsm_ctrl/write_to_pc
wave -logic /cpu_unit/cu_block/fsm_ctrl/sel_des_ir_cu
wave -logic /cpu_unit/cu_block/fsm_ctrl/increase_pc
wave -logic /cpu_unit/cu_block/fsm_ctrl/clr_mbr_cu
wave -logic /cpu_unit/cu_block/fsm_ctrl/load_int_cu
wave -logic /cpu_unit/cu_block/fsm_ctrl/wr_pc_cu
wave -logic /cpu_unit/cu_block/fsm_ctrl/clr_int_cu
wave -logic /cpu_unit/cu_block/fsm_ctrl/current_state
wave -logic /cpu_unit/cu_block/fsm_ctrl/next_state
wave -logic /cpu_unit/write_to_pc
wave -literal -hex /cpu_unit/data_in_alu
wave -literal -hex /cpu_unit/sel_first_operand_alu
wave -literal -hex /cpu_unit/alu_block/first_operand
wave -literal -hex /cpu_unit/sel_second_operand_alu
wave -literal -hex /cpu_unit/alu_block/second_operand
wave -literal -hex /cpu_unit/execute_alu
wave -literal -hex /cpu_unit/check_status_alu
wave -logic /cpu_unit/write_to_w_alu
wave -literal -hex /cpu_unit/alu_block/w_out
wave -logic /cpu_unit/write_to_status_alu
wave -literal -hex /cpu_unit/status
wave -logic /cpu_unit/write_to_fsr_alu
wave -literal -hex /cpu_unit/fsr
wave -logic /cpu_unit/alu_zero_flag
wave -logic /cpu_unit/cu_block/decoder1/skip_if_clr
wave -logic /cpu_unit/cu_block/decoder1/skip_if_set
wave -logic /cpu_unit/alu_zero_flag
wave -literal -hex /cpu_unit/data_out_alu
wave -logic /cpu_unit/write_to_intcon_io
wave -logic /cpu_unit/io_block/set_rbif
wave -logic /cpu_unit/io_block/set_intf
wave -logic /cpu_unit/io_block/set_t0if
wave -logic /cpu_unit/io_block/clk_q4
wave -literal -hex /cpu_unit/intcon
wave -logic /cpu_unit/addr_mode_rf
wave -logic /cpu_unit/write_to_rf
wave -logic /cpu_unit/rf_block/we_in
wave -literal -hex /cpu_unit/rf_block/ram_in1
wave -literal -hex /cpu_unit/rf_block/ram_out1
wave -literal -hex /cpu_unit/rf_block/ram_in2
wave -literal -hex /cpu_unit/rf_block/ram_out2
wave -literal -hex /cpu_unit/rf
wave -literal -hex /cpu_unit/sel_part_pc
wave -logic /cpu_unit/write_to_pclath_pc
wave -literal -hex /cpu_unit/pclath
wave -logic /cpu_unit/sel_sadr_pc
wave -literal -hex /cpu_unit/update_sp_pc
wave -logic /cpu_unit/write_to_stack_pc
wave -logic /cpu_unit/write_to_tmr0_io
wave -literal -hex /cpu_unit/tmr0
wave -logic /cpu_unit/write_to_trisa_io
wave -literal -hex /cpu_unit/trisa
wave -logic /cpu_unit/write_to_porta_io
wave -literal -hex /porta
wave -literal -hex /dsp_seg/din
wave -logic /cpu_unit/write_to_trisb_io
wave -literal -hex /cpu_unit/trisb
wave -logic /cpu_unit/write_to_portb_io
wave -literal -hex /portb
wave -literal -hex /dsp_nibble/din
wave -logic /cpu_unit/set_gie_io
wave -logic /cpu_unit/clr_gie_io
wave -logic /cpu_unit/write_to_option_io
wave -literal -hex /cpu_unit/option
run 76500 ns

