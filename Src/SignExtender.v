module SignExtender(BusImm, Imm26, Ctrl); 
   output [63:0] BusImm; 
   input [25:0]  Imm26; 
   input [2:0]	 Ctrl; 
   
	reg [63:0] result;
	always @(*) begin
		case(Ctrl)
		3'b000: begin //B type
		 result = {{36{Imm26[25]}}, Imm26}; 
		end
		3'b001: begin //CB type
		 result = {{43{Imm26[23]}}, Imm26[23:5]};
		end
		3'b010: begin //I type
			result = {52'b0, Imm26[21:10]}; 
		end
		3'b011: begin //D type
			result = {{55{Imm26[20]}}, Imm26[20:12]}; 
		end
		3'b100: begin //IW type
			result = {48'b0, Imm26[20:5]} << (Imm26[22:21] * 16); 
			
			
		end
		default: begin	// invalid type
			result = 64'b0;
		end
		
		endcase
   end 
   
   assign BusImm = result;
endmodule
// module SignExtender(BusImm, Imm26, Ctrl); 
//    output [63:0] BusImm; 
//    input [25:0]  Imm26; 
//    input [1:0] Ctrl; 

//    assign BusImm = 
//       (Ctrl == 3'b10) ? {52'b0, Imm26[21: 10]}: //I
//       (Ctrl == 3'b11) ? {{53{Imm26[20]}}, Imm26[20: 12]}: //D: 64-11=53
//       (Ctrl == 3'b00) ? {{36{Imm26[25]}}, Imm26[25: 0], 2'b0}: // B: 64-26-2= 36
//       (Ctrl == 3'b01) ? {{43{Imm26[23]}}, Imm26[23: 5], 2'b0}: //CB: 64-19-2=43
         
//       0;   
// endmodule