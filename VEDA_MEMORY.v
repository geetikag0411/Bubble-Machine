module veda (
    clk,reset,writeEnable,addressa,datain,dataout,addressb
);
parameter W =5;
input clk,reset,writeEnable;
input [31:0] datain;
input [W-1:0]addressa;
input [W-1:0]addressb;
output reg [31:0]dataout;
reg [2**W-1:0]memory[31:0];
integer i;
always @(posedge clk or addressa or datain ) begin
    if (reset==1) begin
        for(i=0;i<2**W;i=i+1)
        begin
            memory[i]=0;
        end
    end

   else if(writeEnable==1)
    begin
        for(i=0;i<2**W;i=i+1)
        begin
            memory[i]=memory[i];
        end
        memory[addressa]=datain;
    end
    else 
    begin
    for(i=0;i<2**W;i=i+1)
        begin
            memory[i]=memory[i];
        end
    end
end
always @(posedge clk or addressb) begin
    dataout=memory[addressb];
end
endmodule