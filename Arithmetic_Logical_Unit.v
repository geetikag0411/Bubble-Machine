module alu(inp1, inp2, opc, out);
input wire [31:0] inp1,inp2;
input wire [4:0] opc;
output reg [31:0] out;
reg i1,i2,ou1;
// adder add(.inp1(inp1),.inp2(inp2),.out(out));
always@(inp1,inp2,opc) begin
    case (opc)
    5'd0: begin
        out=inp1+inp2;
    end
    5'd1: begin
        out=inp1-inp2;
    end
    5'd2: begin
        out=inp1+inp2;
    end 
    5'd3: begin
        out=inp1-inp2;
    end
    5'd4: begin
        out=inp1&inp2;
    end
    5'd5: begin
        out=inp1|inp2;
    end
    5'd6: begin
        out=inp1*(2**inp2);
    end
    5'd7: begin
        out=inp1/(2**inp2);
    end
    5'd8: begin
      //jump
    end
    5'd9: begin
       if (inp1<inp2) out=1'd1;
       else out=1'd0;
    end
    5'd10: begin
        out=inp1+inp2;
    end
    5'd11: begin
        out=inp1+inp2;
    end
    5'd12: begin
        out=inp1&inp2;
    end
    5'd13: begin
       if (inp1<inp2) out=1'd1;
       else out=1'd0;
    end

    endcase
end

endmodule