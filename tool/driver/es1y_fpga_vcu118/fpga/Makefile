EXP = /work/tools/scripts/
CC = aarch64-linux-gnu-gcc
CFLAGS = -Wall -O3 -lm -pthread
PROJ_HOME = /work/users/etchen/git

all: fpga

fpga: fpga_cmds.h fpga_cmds_base.h socket_server.c socket_server.h
	mkdir -p fpga
	cd fpga && $(CC) $(CFLAGS) ../gpio_dev_mem.c ../socket_server.c -o socket_server

load_mem:
	mkdir -p fpga
	cd fpga && $(CC) $(CFLAGS) -I$(PROJ_ROOT)/rtl/gen/ ../gpio_dev_mem.c ../load_mem.c -o load_mem

rey: all
	$(EXP)/run_ssh.exp $@ '~/sd_card/bin/stop_server.sh'
	$(EXP)/run_scp.exp $@ fpga/kiwi-server '/home/root/sd_card/bin'
	$(EXP)/run_ssh.exp $@ '~/sd_card/bin/start_server.sh'
	$(EXP)/run_scp.exp $@ fpga_cmds.sh '/home/root/sd_card/bin/'
	$(EXP)/run_scp.exp $@ fpga/smart_pop '/home/root/sd_card/bin'

source:
	@echo source /work/tools/Xilinx/petalinux/2017.4/settings.sh
	@echo source /work/tools/Xilinx/petalinux/2017.4/components/yocto/source/aarch64/environment-setup-aarch64-xilinx-linux
	@echo source /work/tools/Xilinx/petalinux/2017.4/components/yocto/source/aarch64/layers/core/oe-init-build-env

clean:
	rm -rf *.o socket_server fpga build

.PHONY:
