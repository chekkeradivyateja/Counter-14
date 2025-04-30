module counter(clk, rstn, load, up_down, data_in[3:0], count[3:0]);
	input clk, rstn, load, up_down;
	input [3:0]data_in;
	output reg [3:0]count;

always@(posedge clk)
begin
		if(!rstn)
			count <= 4'b0;
	        else if(load)
			count <= data_in;
		else if(up_down)
		begin
			if(count == 4'd13)
				count <= 4'd0;
			else
				count <= count+1;
		end
		else
			begin
			if(count == 4'd0)
				count <= 4'd13;
			else
				count <= count-1;
			end
		end
endmodule			

