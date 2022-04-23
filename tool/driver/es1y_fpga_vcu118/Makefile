fesvr2socket:
	g++ socket_client.c common-socket.c debug_tick.c pygmy_es1y_addr_translater.c fesvr2socket.c -std=c++11 -I$(PROJ_ROOT)/hardware/soc/subproj/es1y/rtl_gen/ -Wl,-rpath,$(RISCV)/lib/ $(RISCV)/lib/libfesvr.so -o fesvr2socket.o -fpermissive

debug:
	g++ socket_client.c common-socket.c pygmy_es1y_addr_translater.c debug-socket.c -std=c++11 -I$(PROJ_ROOT)/hardware/soc/subproj/es1y/rtl_gen/ -o debug-socket.o -fpermissive

connect:
	vivado -mode tcl -source script/server.tcl
