vsim tb_io
wave -logic /reset
wave -logic /clk1
wave -logic /clk2
wave -logic /clk4
wave -literal /command
wave -literal -hex /data_in_io
wave -logic /write_to_tmr0_io
wave -logic/io_block/inc_timer
wave -literal -hex /tmr0_out_io
wave -logic /write_to_option_io
wave -literal -hex /option_out_io
wave -logic /write_to_intcon_io
wave -literal -hex /intcon_out_io
wave -logic /write_to_trisa_io
wave -literal -hex /trisa_out_io
wave -logic /write_to_porta_io
wave -literal -hex /porta_out_io
wave -logic /write_to_trisb_io
wave -literal -hex /trisb_out_io
wave -logic /write_to_portb_io
wave -literal -hex /portb_out_io
wave -literal -hex /porta_pinout_io
wave -literal -hex /portb_pinout_io
run 7200
