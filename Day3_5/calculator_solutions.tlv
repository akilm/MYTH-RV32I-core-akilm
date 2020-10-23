\m4_TLV_version 1d: tl-x.org
\SV

   m4_makerchip_module   // (Expanded in Nav-TLV pane.)
\TLV
   $reset = *reset;
   
   |calc // Calculator 
      @1
         $valid_or_reset = $valid || $reset;
      ?$valid_or_reset
         @1
            $val1[31:0] = >>2$out;
            $val2[31:0] = $rand2[3:0];
            $sum[31:0] = $val1 + $val2;
            $diff[31:0] = $val1 - $val2;
            $prod[31:0] = $val1 * $val2;
            $quot[31:0] = $val1 / $val2;

            $valid = $reset ? 1'b0 : (>>1$valid + 1);
         @2   
            $out[31:0] = ($reset)?( 32'b0 ): ($op[1] ? ($op[0] ? $quot[31:0]:$prod[31:0]):($op[0] ? $diff[31:0]:$sum[31:0]));
         
         // Counter
         
   
   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule
