#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets RGB_IBUF[0]]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets RGB_IBUF[1]]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets RGB_IBUF[2]]

set_property PACKAGE_PIN Y9 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

set_property PACKAGE_PIN N15 [get_ports {btn[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {btn[0]}]
set_property PACKAGE_PIN R18 [get_ports {btn[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {btn[1]}]

set_property PACKAGE_PIN Y19  [get_ports {vsync}];  # "VGA-VS"
set_property IOSTANDARD LVCMOS33 [get_ports vsync];

set_property PACKAGE_PIN AA19 [get_ports {hsync}];  # "VGA-HS"
set_property IOSTANDARD LVCMOS33 [get_ports hsync];


set_property PACKAGE_PIN Y21  [get_ports {blue[0]}];  # "VGA-B1"
set_property IOSTANDARD LVCMOS33 [get_ports {blue[0]}];

set_property PACKAGE_PIN Y20  [get_ports {blue[1]}];  # "VGA-B2"
set_property IOSTANDARD LVCMOS33 [get_ports {blue[1]}];

set_property PACKAGE_PIN AB20  [get_ports {blue[2]}];  # "VGA-B3"
set_property IOSTANDARD LVCMOS33 [get_ports {blue[2]}];

set_property PACKAGE_PIN AB19  [get_ports {blue[3]}];  # "VGA-B3"
set_property IOSTANDARD LVCMOS33 [get_ports {blue[3]}];

set_property PACKAGE_PIN AB22 [get_ports {green[0]}];  # "VGA-G1"
set_property IOSTANDARD LVCMOS33 [get_ports {green[0]}];

set_property PACKAGE_PIN AA22 [get_ports {green[1]}];  # "VGA-G2"
set_property IOSTANDARD LVCMOS33 [get_ports {green[1]}];

set_property PACKAGE_PIN AB21 [get_ports {green[2]}];  # "VGA-G3"
set_property IOSTANDARD LVCMOS33 [get_ports {green[2]}];

set_property PACKAGE_PIN AA21 [get_ports {green[3]}];  # "VGA-G3"
set_property IOSTANDARD LVCMOS33 [get_ports {green[3]}];

set_property PACKAGE_PIN V20  [get_ports {red[0]}];  # "VGA-R1"
set_property IOSTANDARD LVCMOS33 [get_ports {red[0]}];

set_property PACKAGE_PIN U20  [get_ports {red[1]}];  # "VGA-R2"
set_property IOSTANDARD LVCMOS33 [get_ports {red[1]}];

set_property PACKAGE_PIN V19  [get_ports {red[2]}];  # "VGA-R3"
set_property IOSTANDARD LVCMOS33 [get_ports {red[2]}];

set_property PACKAGE_PIN V18  [get_ports {red[3]}];  # "VGA-R3"
set_property IOSTANDARD LVCMOS33 [get_ports {red[3]}];

set_property PACKAGE_PIN F22 [get_ports {sw[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[0]}]
set_property PACKAGE_PIN G22 [get_ports {sw[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[1]}]

#set_property PACKAGE_PIN T22 [get_ports {hit_count_reg[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {hit_count_reg[0]}]
#set_property PACKAGE_PIN T21 [get_ports {hit_count_reg[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {hit_count_reg[1]}]
#set_property PACKAGE_PIN U22 [get_ports {hit_count_reg[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {hit_count_reg[2]}]
#set_property PACKAGE_PIN U21 [get_ports {hit_count_reg[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {hit_count_reg[3]}]

#set_property PACKAGE_PIN V22 [get_ports {refr_tick}]
#set_property IOSTANDARD LVCMOS33 [get_ports {refr_tick}]

#set_property PACKAGE_PIN V22 [get_ports {hit_count[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {hit_count[0]}]
#set_property PACKAGE_PIN W22 [get_ports {hit_count[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {hit_count[1]}]
#set_property PACKAGE_PIN U19 [get_ports {hit_count[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {hit_count[2]}]
#set_property PACKAGE_PIN U14 [get_ports {hit_count[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {hit_count[3]}]

#set_property PACKAGE_PIN U19 [get_ports {game_stop}]
#set_property IOSTANDARD LVCMOS33 [get_ports {game_stop}]

#set_property PACKAGE_PIN V22 [get_ports {sq_veloc[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {sq_veloc[0]}]
#set_property PACKAGE_PIN W22 [get_ports {sq_veloc[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {sq_veloc[1]}]
#set_property PACKAGE_PIN U19 [get_ports {sq_veloc[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {sq_veloc[2]}]
#set_property PACKAGE_PIN U14 [get_ports {sq_veloc[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {sq_veloc[3]}]

set_property PACKAGE_PIN T22 [get_ports {led_out[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[0]}]
set_property PACKAGE_PIN T21 [get_ports {led_out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[1]}]
set_property PACKAGE_PIN U22 [get_ports {led_out[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[2]}]
set_property PACKAGE_PIN U21 [get_ports {led_out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[3]}]
set_property PACKAGE_PIN V22 [get_ports {led_out[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[4]}]
set_property PACKAGE_PIN W22 [get_ports {led_out[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[5]}]
set_property PACKAGE_PIN U19 [get_ports {led_out[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[6]}]
set_property PACKAGE_PIN U14 [get_ports {led_out[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[7]}]

#set_property PACKAGE_PIN G22 [get_ports {RGB[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {RGB[0]}]
#set_property PACKAGE_PIN H22 [get_ports {RGB[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {RGB[1]}]
#set_property PACKAGE_PIN F21 [get_ports {RGB[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {RGB[2]}]

#set_property PACKAGE_PIN M15 [get_ports {obj_select[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {obj_select[0]}]
#set_property PACKAGE_PIN H17 [get_ports {obj_select[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {obj_select[1]}]
#set_property PACKAGE_PIN H18 [get_ports {obj_select[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {obj_select[2]}]

set_property PACKAGE_PIN T18 [get_ports {up_sw}]
set_property IOSTANDARD LVCMOS33 [get_ports {up_sw}]
set_property PACKAGE_PIN R16 [get_ports {down_sw}]
set_property IOSTANDARD LVCMOS33 [get_ports {down_sw}]

set_property PACKAGE_PIN M15 [get_ports {up_sw1}]
set_property IOSTANDARD LVCMOS33 [get_ports {up_sw1}]
set_property PACKAGE_PIN H17 [get_ports {down_sw1}]
set_property IOSTANDARD LVCMOS33 [get_ports {down_sw1}]