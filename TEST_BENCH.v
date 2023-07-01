`include "control.v"
module tb;
reg clk;
instruction_fetch uut(.clk(clk));
initial begin
    clk=0;
    forever begin
        #10 clk=~clk;
    end
end 
initial begin
    #5000 $finish;
end


endmodule