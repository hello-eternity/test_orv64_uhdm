# ORV64

## Overview

ORV64 is a 64-bit RISC-V Core designed for embedded applications. 
It has a 5 stage in-order pipeline and multi-level cache system including 
L1 I/Dcache and L2 I/D cache. ORV64 supports RV64IMAC instruction sets, 
Sv39 Virtual Address format, legal combinations of privilege modes and 
Physcial Memory Protection (PMP). It is capable of running a 
full-featured operating system like Linux. The core is compatible with 
all applicable RISC‑V standards.

## Documentation
The ORV64 user manual can be accessed online at [ReadTheDocs](https://picorio-doc.readthedocs.io/en/latest/index.html). It is also contained in the [doc](https://gitlab.com/picorio/picorio-doc) folder of this repository.

Table of Contents
=================
* [ORV64 RISC-V CPU Overview](#overview)
* [Documentation](#documentation)
* [Table of Contents](#table-of-contents)
    * [Prerequisites](#prerequisites)
    * [Compile & Run simulation](#compile-&-run-simulation)
        * [With VCS](#with-vcs)
        * [With Verilator](#with-verilator)
    * [Build & Run Benchmarks](#build-&-run-benchmark)
        * [Build Dhrystone](#build-dhrystone)
        * [Build Embench-iot](#build-embench-iot)
        * [Build Coremark](#build-coremark)
    * [CI Testsuites](#ci-testsuites)
* [Contributing](#contributing)

## Prerequisites
### 1. [Verilator: SystemVerilog Translator and simulator](https://www.veripool.org/projects/verilator/wiki/Installing)

   The project is developed under the Verilator with version 4.100, git commit SHA `0a9ae154`.
	
### 2. [Gtkwave: Wave viewer](http://gtkwave.sourceforge.net/)

### 3. [RISC-V GNU Compiler Toolchain](https://github.com/riscv/riscv-gnu-toolchain).
   
 * Choose Newlib for installation.
 * The configuration can be: ```./configure --prefix=/opt/riscv --with-arch=rv64ima --with-abi=lp64 --with-cmodel=medany```

4.Set ORV64 PATH ```ORV64```

 * If you place the project at, say, ```/opt/ORV64```

        $ vim ~/.bashrc
      append ```export ORV64=/opt/ORV64``` into .bashrc, then save & exit
        $ source ~/.bashrc


## Compile
### With VCS
To compile ORV64 with VCS:

    $ cd orv64/tb
    $ make vcs 

## Build and Run Test Cases

### Build Test Cases
To build Test Cases (ISA-Test, coremark, dhrystone ...)

    $ cd orv64/tb
    $ make benchmarks

And then you will find the bin file in orv64/tb/test_program/isa and orv64/tb/test_program/benchmarks

## Run
After successfully compling and building, you can Run a single case:

    $ cd orv64/tb
    $ ./rrvtest -e <path to elf file>

-e means run a single elf file in silent mode, only the test results will be output. If you want to see all of the output, you can use -E option

To run all of the ISA-Test:

    $ cd orv64/tb
    $ ./rrvtest -r

-r means run a single elf file in silent mode, only the test results will be output. If you want to see all of the output, you can use -R option

by default, spike cosim would involve in. You can disable cosim by using option -n. 


## CI Testsuites
We provide GitLab continuous integration configuration file that runs the RISC-V unit-tests and the RISCV benchmarks. 
Once everything is set up and installed, you can run the tests suites as follows: 
* With Verilator:
        
        $ make -C ./tb verilator_run_test
        $ make -C ./tb verilator_run
* With VCS

        $ make -C ./tb vcs
        $ make -C ./tb vcs_run_test
# Contributing
Check out the [contribution guide](CONTRIBUTING.md).

