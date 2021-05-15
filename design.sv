/// desidgn for adder and substractor combinational circuit
// addition and sub for unsigned numbers

module add_sub_dut(in1,in2,add_sub,out);
	input [7:0] in1,in2;
	input add_sub;
	output [8:0] out;

  
    assign out=(add_sub==1)?(in1+in2):(in1-in2);
  
	/*	
	always@(*)
	begin 
		if(add_sub==1)
			begin
				out=in1+in2;
			end
		else 
			begin
				out=in1-in2;
			end

	end
	*/
endmodule
