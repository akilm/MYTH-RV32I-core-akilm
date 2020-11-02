# RISC-V Processor Design with TL-Verilog

This repository contains all the information needed to build your RISC-V pipelined core, which has support of base interger RV32I instruction format using TL-Verilog on makerchip platform.
The core was built during the MYTH (Microprocessor for you in thirty hours) Workshop conducted by Kunal Ghosh (VLSI System Design) and Steve Hoover (Redwood EDA) . The first two days was focussed on how an application written in higher level language (C, C++, JAVA, Python) communicates with the processor, details such as how a compiler / assembler works, interfaces between the Application layer --> OS and RTL, An introduction to RISC V ISA taught by Kunal Ghosh. Days 3-5 were all about Computer Architecture, RISCV ISA and Implementing a 3 stage pipelined RISCV Core on Makerchip IDE using TL-Verilog taught by Steve Hoover.

# RISC V ISA 

## Introduction

The RISC V is an open source specification of an Instruction Set Architecture (ISA). Unlike most other ISA designs, the RISC-V ISA is provided under open source licenses that do not require fees to use, which provides it a huge edge over other commercially available ISAs. It is a simple, stable, small standard base ISA with extensible ISA support, that has been redefining the flexibility, scalability, extensibility, and modularity of chip designs. 
<img src="https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Images/README%20images/riscv-logo-1.png" 
alt="alt text" >

## RISC-V International
The RISC-V Foundation was founded in 2015 to build an open, collaborative community of software and hardware innovators based on the RISC-V ISA. The Foundation, a non-profit corporation controlled by its members, directed the development to drive the initial adoption of the RISC-V ISA. For more information visit the site : www.riscv.org

## ISA Base and Extensions
The RISC V Architecture is defined as a base integer ISA, which must be present in any implementation, plus optional extensions to the base ISA. Each base integer instruction set is characterized by

1. Width of the integer registers (XLEN)
2. Corresponding size of the address space
3. Number of integer registers (32 in RISC-V)

The ISA base and its extensions are developed in a collective effort between industry, the research community and educational institutions.More details on RISC-V ISA can be obtained [here](https://riscv.org/technical/specifications/).

<br/>
<img src="https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Images/Base_extensions.PNG" 
alt="alt text" width="384" height="456">

# RISC-V Toolchain 
A generic RISC V toolchain involves a compiler to compile the source code to RISC-V target and a simulator for debugging the code. In this workshop, GCC cross compiler was used to compile the c-program and spike simulator to debug and verify the code.


## RISC-V GNU Compiler Toolchain  
A compiler is a special program that processes statements written in a particular programming language (C, C++, JAVA etc) and turns them into machine language (ASM) or "code" that a computer's processor uses. The GNU Compiler Collection (GCC) is a compiler system produced by the GNU Project supporting various programming languages.
To Install the complete tool chain in your locally on your linux machine, refer [here](https://github.com/riscv/riscv-gnu-toolchain)


## Spike Simulator
Spike is the golden reference functional RISC-V ISA C++ sofware simulator. It provides full system emulation or proxied emulation with HTIF/FESVR. It serves as a starting point for running software on a RISC-V target. The Debug feature provided by the spike simulator was used extensively in this workshop. To install the simulator locally on your linux machine , refer [here](https://github.com/riscv/riscv-isa-sim)


## Installation 
To avoid all the hassles of individually installing the compiler and the simulator, follow the steps below which makes it easier to install both the tools in your local machine.
<br/>
1. If git is installed in your local machine, use the following git command in your terminal to clone the repository at a desired location.Alternatively you can also go to https://github.com/kunalg123/riscv_workshop_collaterals to download the repository using the github gui as a zip file.<br/>
`$git clone https://github.com/kunalg123/riscv_workshop_collaterals.git`
<p align="center">
<img src="https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Images/README%20images/step1install.PNG" 
alt="alt text">
<p/>


2. Change the current working directory to the folder installed in the previous step. <br/>
`$cd riscv_workshop_collaterals`
<br/>
<p align="center">
<img src="https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Images/README%20images/install2.PNG" 
alt="alt text">
<p/>


3. For installation of the complete toolchain,make the shell file executable by using chmos and then  run the "run.sh" shell script. For this, type the following command:<br/>
`$chmod +x run.sh`<br/>
`$./run.sh`
<p align="center">
<img src="https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Images/README%20images/install3.PNG" 
alt="alt text">
<p/>
<p align="center">
<img src="https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Images/README%20images/install4.PNG" 
alt="alt text">
<p/>
<br/>
## Compiling a C Code to RISC V and simulations
Create a C-program using any text editor and save it as a .c file. In this case, we used a C-program that calculates the sum of numbers from 1-9. The code can be found [here](https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Codes/sum1ton.c). The program is then compiled using the gcc compiler.<br/> The steps involved :-

1. Open any text editor, write a program in C and save it as a .c file.<br/>
`$leafpad sum1ton.c`<br/>
![code](https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Images/README%20images/leafpad.PNG)
2. Compile the program using the GCC Compiler. <br/>
`$gcc sum1ton.c`
3. To run the compiled object file (Default file with name a.out will automatically be formed after compilation) use : <br/>
`$./a.out`

Comparing the Instruction sets x86 and RISC-V :-<br/>

1. To compile using the pre-existing x86 on your machine use:<br/>
`$gcc -o <object filename> <C-filename>`
2. To view the disassembly/assembly code - x86 :<br/>
`$objdump -d -M intel -s <object filename compiled using gcc>`
![x86 assembly code - Main Function](https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Images/README%20images/RISCV%20vs%20x86%201.PNG)
3. To compile with RISC-V GCC compiler:<br/>
`$riscv64-unknown-elf-gcc <compiler option -O1 ; Ofast> <ABI specifier -lp64; -lp32; -ilp32> <architecture specifier -RV64 ; RV32> -o <object filename> <C filename>` 
4. To view the disassembly/assembly code - RISC V :<br/>
`$riscv64-unknown-elf-objdump -d <object filename> | less` 
![RISC V assembly code - Main Function](https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Images/README%20images/RISCV%20vs%20x86.PNG)


Viewing the assembly files would give a clear picture of the number of instructions used for the same program in both the cases.
<br/>
Spike is a software simulator, the object files generated in the previous steps can be run using spike through the following commands. The debug option provides a valuable tool to analyse the code execution line by line and view the contents of the register file at any point in time.<br/>

1. To run the program using spike use :-<br/>
`$spike pk <Object Filename>`

2. To debug the assembly code line by line, the following command is used. This command instantiates the file in debug mode <br/>
`$spike -d pk <Object Filename>`

3. The following command is used to run the program until the pc attains a certain value specified by the Ending Address. Take a look at the assembly code to view the address of different instructions and routines. subsequently pressing enter once :- executes the next line of code.<br/>
`$until pc 0 <Ending Address>`<br/>

4. The following command is used to view the contents of any register after execution of certain number of lines in the program .<br/>
`$reg 0 <Register name>`

![Spike debug](https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Images/spikedebug.png)
The RISC V assembly code generated using the above steps is now executed by the core built in TL-Verilog, Maker Chip IDE.
<br/><br/>

# Application Binary Interface
Application Binary Interface is an interface that allows application programmers to access hardware resources. It forms the interface that links RISC-V specification has 32 registers whose width is defined by XLEN which can be 32/64 for RV32/RV64 respectively.The data can be loaded from memory to registers or directly sent, Application programmer can access each of these 32 registers through its ABI name seen below
![Application Binary Interface : RISC-V](https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Images/README%20images/ABI.png)
## Using ABI calls to sum numbers from 1 to 9
The main program is rewritten in terms of an ABI call from the main c program . The parameters are passed and the return value from the function is stored in a variable. 
![ABI call](https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Images/README%20images/callflow.PNG)
![Main C program](https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Images/README%20images/sum1tonc.PNG)
![ABI function](https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Images/README%20images/loads.PNG)

# TL-Verilog 

 Transaction-Level Verilog (TL-Verilog) is an emerging extension to SystemVerilog that supports a new design methodology, called transaction-level design. A transaction, in this methodology, is an entity that moves through structures like pipelines, arbiters, and queues, A transaction might be a machine instruction, a flit of a packet, or a memory read/write. Transaction logic, like packet header decode or instruction execution, that operates on the transaction can be placed anywhere along the transaction's flow. Tools produce the logic to carry signals through their flows to stitch the transaction logic. 
![TL-Verilog](https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Images/README%20images/TLVerilog.PNG)

## Maker Chip IDE
[Makerchip IDE](https://www.makerchip.com/sandbox/#) is a free online environment for developing high-quality integrated circuits. You can code, compile, simulate, and debug Verilog designs, all from your browser. Your code, block diagrams, and waveforms are tightly integrated.
<br/>
Makerchip IDE is kind enought to make-up random values for un-assigned signals and the waveforms can be viewed in the waveforms tab on the right. Waveforms are organized by TL-Verilog design hierarchy. Waveforms clearly show when signals are carrying meaningful data. designs are represented in logic diagrams. TL-Verilog design hierarchy, including pipelines and pipeline stages, provides organization to the logic diagrams.

![Maker chip IDE](https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Images/README%20images/MakerchipIDE.png)

## Combinational logic 
Signals in TL-Verilog do not need declarations and can directly be used in assignments statements.All the signals start with '$' in TL-Verilog. If a signal is used but never assigned, the ide takes care of assigning random values to those signals. 
This example describes a combinational logic calculator designed using TL-verilog. 
![Simple Combinational logic Calculator](https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Images/Calculator/Combinational_Calculator.png)
![Combinational logic Calculator Waveforms ](https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Images/Calculator/Combinational_Calculator_Waveforms.png)

## Sequential logic 
Signals can be preceded with a '>>n'  which will provide the value of that signal n cycles before .For example, >>1$num and >>2$num: the previous two values of $num. The use of >>1$num and >>2$num implies staging of $num through two flip-flops. 
This example describes a two cycle sequential logic calculator designed using TL-verilog. 
![Sequential logic Calculator](https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Images/Calculator/Sequential_Calculator.PNG)
![Sequential logic Waveforms](https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Images/Calculator/Sequential_Calculator_waveform.PNG)

## Pipelined Logic 
Timing abstract powerful feature of TL-Verilog which converts a code into pipeline stages easily. Whole code under |pipe scope with stages defined as @?. This example describes a pipelined calculator designed using TL-verilog. 
![Pipelined Calculator](https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Images/Calculator/Calculator_Counter_Pipeline.PNG)
![Pipelined Calculator Waveforms](https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Images/Calculator/Calculator_Counter_Pipeline_Waveform.PNG)

## Validity
Validity is TL-verilog means signal indicates validity of transaction and described as "when" scope else it will work as don't care. Denoted as ?$valid. Validity provides easier debug, cleaner design, better error checking, automated clock gating.
![Validity signal](https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Images/Calculator/2ccvalidity.PNG)
![Associated waveforms](https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Images/Calculator/2-Cycle-Calculator_waveform.PNG)

## Hierarchy 
Behavioral Hierarchy is a way to replicate logic in TL-Verilog.It provides named scope to related logic and can be used with indices to denote multiple instances of the same kind (Ex: an array). This is used to represent the memory elements which are basically an array of memory words
![Hierarchy Example: Pythagoras Theorem](https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Images/RISC-V/hierarchy.PNG)
## Other Design Constructs
TL-verilog also supports some other design constructs which can be read in the maker chip ide , under the tutorials tab.
![Maker Chip Tutorials](https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Images/README%20images/Tutorials.PNG)

## Integrating TL-Verilog with development flow
The maker-chip platform converts the code written in TL-verilog to system verilog. So any further front-end development flow can use the generated system verilog code and follow the usual flow.
![System Verilog code](https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Images/README%20images/System_Verilog.PNG)

# RV32I Core Implementation
The CPU is divided into different stages like Fetch, Decode and Execute. A single cycle processor is first designed. It is later pipelined by separating the instructions under different @ blocks.
![Overall Block Diagram](https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Images/README%20images/RISCV%20Block%20DIagram.PNG)
## Program Counter Logic
The PC (program counter) serves as the address bits for the instruction memory. The program counter needs to be incremented by 4 every cycle since RISC-V architecture follows byte addressing .
![PC Update](https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Images/RISC-V/PC_Update_b.PNG)
![PC Update](https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Images/RISC-V/PC_Update_w.PNG)
## Instruction Fetch 
Instruction memory contains all the instructions. The memory contains 32-bit words which can be read one word at a time. RISC-V follows the little-endian format of memory where the lower order bytes are stored first in the lower Addresses. 
![PC Update](https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Images/RISC-V/PC_Update_b.PNG)
![PC Update Waveforms](https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Images/RISC-V/PC_Update_w.PNG)
## Instruction Decode
The instruction fetched in the previous state is decoded to identify the type of the instruction.RISC V classifies instructions into n-basic types namely :- R (Register), I(Immediate), S(Store), B(Branch), U(Upper Immediates), J(Jump). The decoding stage allows the CPU to determine what instruction is to be performed so that the CPU can tell how many operands it needs to fetch in order to perform the instruction
![Instruction Decode](https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Images/RISC-V/decode_fields.PNG)
![Instruction Decode Waveforms](https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Images/RISC-V/decode_fields_w.PNG)
## Register File - Read and Write
The Register File contains 32 registers as specified by RISC-V ISA and each are named x0-x31.
Here the Register file supports 2 Read Operations and 1 Write operation Simultaneously (same clock cycle).
![Register File Read/Write](https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Images/RISC-V/rf_write.PNG)
![Register File Read/Write](https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Images/RISC-V/rg_write_w.PNG)

## ALU - Arithmetic and Logic Unit and CU - Control Unit 
The Arithmetic and Logic unit unit that carries out all the arithmetic and logic operations on the operands provided and stores the output of the operation in $Result[31:0] signal. During Decode Stage, branch target address is calculated and fed into PC mux. Before Execute Stage, once the operands are ready branch condition is checked.
![ALU and CU](https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Images/RISC-V/alu.PNG)
!![ALU and CU](https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Images/README%20images/ALUCU.PNG)
## Pipelining the CPU
The above single stage Core was enhanced to be staged across 3 stages in a pipeline, Final output where the core is computing Sum of 9 number. Converting non-pipelined CPU to pipelined CPU using timing abstract feature of TL-Verilog. This allows easy retiming wihtout any risk of funcational bugs. More details reagrding Timing Abstract in TL-Verilog can be found in IEEE Paper "Timing-Abstract Circuit Design in Transaction-Level Verilog" by Steven Hoover.
 ```
 |<pipe-name>
    @<pipe stage>
       Instructions present in this stage
       
    @<pipe_stage>
       Instructions present in this stage
```
![Pipelining the CPU](https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Images/README%20images/pipelined.PNG)

## Data Memory - Load and Store
Similar to branch, load will also have 3 cycle delay. The Data Memory is can perform a read and write operation simultaneously. Added test case to check fucntionality of load/store. Stored the summation of 1 to 9 on address 4 of Data Memory and loaded that value from Data Memory to r15.The number of stages in the pipeline becomes 5, to accomodate the load and store stages. Modified the definition of Data memory to support half-word and byte load/stores as well.Data memory was modified based on the behavioral hierarchy supported in TL-Verilog.
![Data Memory](https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Images/RISC-V/dmem.PNG)
![Data Memory](https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Images/RISC-V/half_word_and_byte.PNG)

## The complete RV32I core
Added Jumps and completed Instruction Decode and ALU for all instruction present in RV32I base integer instruction set. PC definition is updated to support jump operations as well. The code for the complete RV32I TL-Verilog implementation can be found in the file [RV32I Core](https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Codes/risc-v_solutions.tlv).

![RV32I Core Block diagram](https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Images/Final.PNG)

![RV32I Flow Diagram](https://github.com/RISCV-MYTH-WORKSHOP/MYTH-RV32I-core-akilm/blob/master/Images/README%20images/pipeline%20flow%20dia.PNG)

# Acknowledgements

* Steve Hoover, Founder, Redwood EDA.
* Kunal Ghosh, Co-founder, VSD Corp. Pvt. Ltd.
* Shivani Shah, Research Scholar at IIIT Bangalore.
* Shivam Potdar, GSoC 2020 @fossi-foundation.
* Vineet Jain, GSoC 2020 @fossi-foundation.


