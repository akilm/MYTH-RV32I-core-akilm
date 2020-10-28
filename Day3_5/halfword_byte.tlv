\m4_TLV_version 1d: tl-x.org
\SV

   // =========================================
   // Welcome!  Try the tutorials via the menu.
   // =========================================

   // Default Makerchip TL-Verilog Code Template
   
   // Macro providing required top-level module definition, random
   // stimulus support, and Verilator config.
   m4_makerchip_module   // (Expanded in Nav-TLV pane.)
\TLV
   $reset = *reset;
   |cpu
      @0
         $reset = *reset;
         $dmem_wr_en = 1'b1;
         $dmem_addr[3:0] = 4'b0001;
         $dmem_wr_data[31:0] = 32'hffeeddcc;

         //Defined constants
         $dmem_index[1:0] = 2'b00;    // for half word it can take 2'b00 and 2'b10
                                      // for byte access it can take 2'b00, 2'b01, 2'b10 and 2'b11

         $size[1:0] = 2'b01;  // byte:00 ; half-word :- 01 ; word: 11
         $dmem_rd_en = 1'b1;
         $sign = 1'b1;   // unsigned :- 0 , signed :- 1
      @1
         /dmem[15:0]
            $wr = |cpu$dmem_wr_en && (|cpu$dmem_addr == #dmem);
            $rd = |cpu$dmem_rd_en;
            /data[3:0]
               $value[7:0] = |cpu$reset ? 8'b0:
                             (|cpu$size == 2'b11&& #data== 0 && /dmem[#dmem]$wr) ? |cpu$dmem_wr_data[7: 0] : 
                             (|cpu$size == 2'b11&& #data== 1 && /dmem[#dmem]$wr)? |cpu$dmem_wr_data[15:8] :
                             (|cpu$size == 2'b11&& #data== 2 && /dmem[#dmem]$wr)? |cpu$dmem_wr_data[23:16]: 
                             (|cpu$size == 2'b11&& #data== 3 && /dmem[#dmem]$wr)? |cpu$dmem_wr_data[31:24] :
                             (|cpu$size == 2'b00&& #data== |cpu$dmem_index && /dmem[#dmem]$wr) ? |cpu$dmem_wr_data[7:0] : 
                             (|cpu$size == 2'b01 && #data== |cpu$dmem_index && /dmem[#dmem]$wr) ? |cpu$dmem_wr_data[7:0] : 
                             (|cpu$size == 2'b01 && #data== |cpu$dmem_index+1 && /dmem[#dmem]$wr) ? |cpu$dmem_wr_data[15:8] : $RETAIN ; 
            
         ?$dmem_rd_en
            $dmem_rd_data[31:0] =  {/dmem[$dmem_addr]>>1/data[3]$value,/dmem[$dmem_addr]>>1/data[2]$value,/dmem[$dmem_addr]>>1/data[1]$value,/dmem[$dmem_addr]>>1/data[0]$value} ;

      @2{21{$instr[31]}}
         $temp[31:0] = $dmem_rd_data[31:0];
         $ld_data[31:0] = ($size == 2'b11)? $temp[31:0] :
                          ($size == 2'b01 && $dmem_index == 2'b00) ? ($sign ?{{16{$temp[15]}},$temp[15:0]}: {16'b0,$temp[15:0]}) :
                          ($size == 2'b01 && $dmem_index == 2'b10) ? ($sign ?{{16{$temp[31]}},$temp[31:16]}: {16'b0,$temp[31:16]}):
                          ($size == 2'b00&& $dmem_index == 2'b00) ? ($sign ?{{24{$temp[7]}},$temp[7:0]}: {24'b0,$temp[7:0]}):
                          ($size == 2'b00&& $dmem_index == 2'b01) ? ($sign ?{{24{$temp[15]}},$temp[15:8]} : {24'b0,$temp[15:8]}):
                          ($size == 2'b00&& $dmem_index == 2'b10) ? ($sign ?{{24{$temp[23]}},$temp[23:16]} : {24'b0,$temp[23:16]}):
                          ($size == 2'b00&& $dmem_index == 2'b11) ? ($sign ?{{24{$temp[31]}},$temp[31:24]} : {24'b0,$temp[31:24]}): $RETAIN;
   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule
//{/dmem[$dmem_addr]>>1/data[3]$value,/dmem[$dmem_addr]>>1/data[2]$value,/dmem[$dmem_addr]>>1/data[1]$value,/dmem[$dmem_addr]>>1/data[0]$value}