vsim tb_alu
wave -logic /clk2
wave -logic /clk4
wave -literal -hex /data_in_alu
wave -literal -hex /ir_operand_in_alu
wave -literal -hex /ir_b_in_alu
wave -literal -hex /sel_first_operand_alu
wave -literal -hex /sel_second_operand_alu
wave -literal -hex/alu/first_operand
wave -literal -hex/alu/second_operand
wave -literal /command
wave -literal -hex /data_out_alu
wave -literal -hex /check_status_alu
wave -logic /write_to_status_alu
wave -literal -hex /status_out_alu
wave -logic /write_to_fsr_alu
wave -literal -hex /fsr_out_alu
wave -logic /write_to_w_alu
wave -literal -hex /alu/w_out
wave -logic /alu/alu_flag_out
wave -logic /alu/mux_flag_out
wave -logic /alu_zero_flag
wave -literal -hex /execute_alu
run 4000 ns
