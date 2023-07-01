// Now design and implement an instruction fetch phase where the instruction next to be executed
// will be stored in the instruction register.
`include "veda.v"
`include "alu.v"
module instruction_fetch (
input clk
);
reg reset1,reset2,writeEnable1,writeEnable2;
reg [7:0]addressa1,pc,temp;
reg [4:0]addressa2,addressb2;
reg [31:0]datain1,datain2;
wire [31:0]dataout1,dataout2;
reg [31:0]instruction;
//reg [31:0] zero,s0,s1,s2,s3,s4,s5,s6,s7,t0,t1,t2,t3,t4,t5,t6,t7,t8,t9,a0,a1,a2,a3,v0,v1,sp,ra;
reg [31:0]registers[31:0];
reg [31:0]inp1,inp2;
reg [4:0]opc;
wire[31:0]out;
reg [2:0]reset_state=2'b00;
reg [2:0]fetch_state=2'b01;
reg [2:0]Decode_Execute=2'b10;
reg [2:0]curr_s=2'b00;
veda #(.W(8))InstructionMemory(.clk(clk),.reset(1'b0),.writeEnable(writeEnable1),.addressa(addressa1),.datain(datain1),.dataout(dataout1),.addressb(pc));
veda #(.W(5))DataMemory(.clk(clk),.reset(reset2),.writeEnable(writeEnable2),.addressa(addressa2),.datain(datain2),.dataout(dataout2),.addressb(addressb2));
alu ALU(.inp1(inp1),.inp2(inp2),.out(out),.opc(opc));

initial begin

    //pc=8'b0;
  pc=8'b0;

 writeEnable2=1;#1
  //arr 
   addressa2=8'b0;
  datain2=32'd5;#1

  addressb2=8'b0;#1
  //$display("check2 %d",dataout2);

 addressa2=8'd4;
  datain2=32'd4;#1
  // addressb2=8'd4;#1
  // //$display(dataout2);
   addressa2=8'd8;
  datain2=32'd2;#1
 addressa2=8'd12;
  datain2=32'd1;#1
addressa2=8'd16;
  datain2=32'd3;#1
//   len
addressa2=8'd20;
  datain2=32'd5;#1

registers[10]=5;
registers[2]=0;
registers[0]=0;
   writeEnable1=1;#1
   
    addressa1=8'b1;//add
   datain1={6'd0,5'd19,5'd0,5'd0,11'd32};#1
    registers[11]=-1;//li
    registers[3]=1;//li
 addressa1=8'd2;//sub
   datain1={6'd0,5'd12,5'd10,5'd3,11'd34};#1

       addressa1=8'd3;// to jump outer
    datain1={6'd2,26'd4};#1
    
         addressa1=8'd4;//outer
    datain1={6'd8,5'd11,5'd11,16'd1};#1//addi
   addressa1=8'd5;//outer
    datain1={6'd4,5'd11,5'd12,16'd35};#1 //beq
 addressa1=8'd6;//outer
    datain1={6'd0,5'd13,5'd12,5'd11,11'd34};#1 //sub    
   addressa1=8'd7;//add
   datain1={6'd0,5'd14,5'd0,5'd0,11'd32};#1//add

       addressa1=8'd8;// to jump inner
    datain1={6'd2,26'd9};#1

 addressa1=8'd9;
  datain1={6'd4,5'd14,5'd13,16'd3};#1 //beq

 
 addressa1=8'd10;
  datain1={6'd0,5'd15,5'd14,5'd0,5'd2,6'd0};#1 //sll

   addressa1=8'd11;
    datain1={6'd8,5'd16,5'd15,16'd4};#1//addi

   addressa1=8'd12;//add
   datain1={6'd0,5'd15,5'd15,5'd2,11'd32};#1//add
    addressa1=8'd13;//add
   datain1={6'd0,5'd16,5'd16,5'd2,11'd32};#1//add 

  addressa1=8'd14;//lw
   datain1={6'd35,5'd17,5'd15,16'd0};#1
   addressa1=8'd15;//lw
   datain1={6'd35,5'd18,5'd16,16'd0};#1
   
  addressa1=8'd16;//bgt
   datain1={6'd23,5'd17,5'd18,16'd19};#1

  addressa1=8'd17;//addi
   datain1={6'd8,5'd14,5'd14,16'd1};#1//addi
  addressa1=8'd18;// to jump inner
    datain1={6'd2,26'd9};#1
//swap
addressa1=8'd19;//sw
   datain1={6'd41,5'd18,5'd15,16'd0};#1   
 addressa1=8'd20;//sw
   datain1={6'd41,5'd17,5'd16,16'd0};#1
    datain1={6'd8,5'd14,5'd14,16'd1};#1//addi 
    addressa1=8'd21;// to jump inner
    datain1={6'd2,26'd9};


    #4945
    //$display("j");
addressa2=8'b0;
  datain2=32'd1;#1
addressa2=8'd4;
  datain2=32'd2;#1
     addressa2=8'd8;
  datain2=32'd3;#1
 addressa2=8'd12;
  datain2=32'd4;#1
addressa2=8'd16;
  datain2=32'd5;#1
  addressa1=8'd20;
addressa1=8'd19;//sw
   datain1={6'd41,5'd18,5'd15,16'd0};#1   
 addressa1=8'd20;//sw
   datain1={6'd41,5'd17,5'd16,16'd0};#1
    datain1={6'd8,5'd14,5'd14,16'd1};#1//addi 
    addressa1=8'd21;// to jump inner
    datain1={6'd2,26'd9};

$display("EXIT2");//printing data after sorting
  addressb2=8'd0;#1
  $display(dataout2);
   addressb2=8'd4;#1
  $display(dataout2);
   addressb2=8'd8;#1
  $display(dataout2);
   addressb2=8'd12;#1
  $display(dataout2);
  addressb2=8'd16;#1
  $display(dataout2);
end
always@(posedge clk)
begin
  // addressb2=8'b0;#1
  // //$display("check1 %d",dataout2);
    case(curr_s)
    2'b00:
    begin ////$display("reset");
        pc=0;
        curr_s=2'b01;
    end
     2'b01:// fetch
    begin ////$display("fetch");
    instruction=dataout1;
    if(pc>=30)
    begin
      //$display("EXIT1\n");
      addressb2=8'd0;#1
  //$display(dataout2);
   addressb2=8'd4;#1
  //$display(dataout2);
  addressb2=8'd8;#1
  //$display(dataout2);
   addressb2=8'd12;#1
  //$display(dataout2);
  addressb2=8'd16;
  //$display(dataout2);
    end
   // //$display("%b",instruction);
    pc=pc+1;
            curr_s=2'b10;
             ////$display(pc);
    end


    2'b10://decode_exe
    begin
        // //$display("decode");
    case(instruction[31:26])
    6'd0:
    begin
    case(instruction[5:0])
    6'd32:
     begin
          //$display("add");
          opc=5'd0;
          // addressb2=registers[instruction[20:16]];#1
          // inp1=dataout2;
          inp1=registers[instruction[20:16]];
          //$display(inp1);
         // addressb2=registers[instruction[15:11]];#1
         inp2=registers[instruction[15:11]];
         //$display(inp2); #1
         
   //$display(out);
  // addressa2=registers[instruction[25:21]];
  //   datain2=out;
    registers[instruction[25:21]]=out;
    // #1
    //  datain2=out;
  //  addressb2=registers[instruction[26:21]];#1
    end
    6'd34:
   begin
     //$display("sub");
      opc=5'd1;
         inp1=registers[instruction[20:16]];
          //$display(inp1);
          inp2=registers[instruction[15:11]];
         //$display(inp2); #1
         
    // addressa2=registers[instruction[25:21]];
    // datain2=out;
    #1
     registers[instruction[25:21]]=out;
    // addressa2=registers[instruction[26:21]];
    // datain2=out;
    // #1
    end
    6'd33:
     begin //$display("addu");
     opc=5'd2;
    addressb2=registers[instruction[20:16]];#1
    inp1=dataout2;
    //$display(inp1);
    addressb2=registers[instruction[15:11]];#1
    inp2=dataout2;
    //$display(inp2); #1
    
    //$display(out);
    addressa2=registers[instruction[25:21]];
    datain2=out;
     addressa2=registers[instruction[25:21]];
    datain2=out;
    #1
     datain2=out;
    end
    6'd35:
     begin
            //$display("subu");
            opc=5'd3;
addressb2=registers[instruction[20:16]];#1
          inp1=dataout2;
          //$display(inp1);
          addressb2=registers[instruction[15:11]];#1
         inp2=dataout2;
         //$display(inp2); #1
         
    //$display(out);
 addressa2=registers[instruction[25:21]];
    datain2=out;
    #1
     datain2=out;
    end
    6'd36:
     begin
          //$display("and");
           opc=5'd4;
addressb2=registers[instruction[20:16]];#1
          inp1=dataout2;
          //$display(inp1);
          addressb2=registers[instruction[15:11]];#1
         inp2=dataout2;
         //$display(inp2); #1
         
    //$display(out);
 addressa2=registers[instruction[25:21]];
    datain2=out;
    #1
     datain2=out;
    end
    6'd37:
     begin     //$display("or");
  opc=5'd5;
addressb2=registers[instruction[20:16]];#1
          inp1=dataout2;
          //$display(inp1);
          addressb2=registers[instruction[15:11]];#1
         inp2=dataout2;
         //$display(inp2); #1
         
    //$display(out);
 addressa2=registers[instruction[25:21]];
    datain2=out;
    #1
     datain2=out;
    end
    6'd0:
     begin     //$display("sll");
     opc=5'd6;
inp1=registers[instruction[20:16]];#1
          //$display(inp1);
        inp2=instruction[10:6];

         //$display(inp2); #1
         
    //$display(out);
//  addressa2=registers[instruction[25:21]];
//     datain2=out;
    registers[instruction[25:21]]=out;

    end
    6'd2:
     begin  //$display("srl");
     opc=5'd7;
addressb2=registers[instruction[20:16]];#1
          inp1=dataout2;
          //$display(inp1);
        inp2=instruction[10:6];
         
         //$display(inp2); #1
         
    //$display(out);
 addressa2=registers[instruction[25:21]];
    datain2=out;
    #1
     datain2=out;
    end



    6'd8:
     begin     //$display("jr");
opc=5'd8;
addressb2=registers[instruction[25:21]];#1
    inp1=dataout2;
pc=pc+inp1;
    end


    6'd24:
     begin    
       //$display("slt");
 opc=5'd9;
addressb2=registers[instruction[20:16]];#1
          inp1=dataout2;
          //$display(inp1);
          addressb2=registers[instruction[15:11]];#1
         inp2=dataout2;
         //$display(inp2); #1
         
    //$display(out);
 addressa2=registers[instruction[25:21]];
    datain2=out;
    #1
     datain2=out;
    end
    endcase 

    end


    6'd8:
    begin     //$display("addi"); 
opc=5'd10;
          inp1=registers[instruction[20:16]];
          //$display(inp1);
          inp2=instruction[15:0];#1
         //$display(inp2); #1
         
    //$display(out);

    // addressa2=registers[instruction[25:21]];
    // datain2=out;
    registers[instruction[25:21]]=out;
    end
    6'd9:
    begin     
      //$display("addiu"); 
opc=5'd11;
addressb2=registers[instruction[20:16]];#1
          inp1=dataout2;
          //$display(inp1);
          inp2=instruction[15:0];#1
         //$display(inp2); #1
         
    //$display(out);
 addressa2=registers[instruction[25:21]];
    datain2=out;
    #1
     datain2=out;
    end
    6'd12:
    begin     //$display("andi"); 
opc=5'd12;
addressb2=registers[instruction[20:16]];#1
          inp1=dataout2;
          //$display(inp1);
                   inp2=instruction[15:0];#1

         //$display(inp2); #1
         
    //$display(out);
 addressa2=registers[instruction[25:21]];
    datain2=out;
    #1
     datain2=out;
    end
    6'd13:
        begin
    //$display("ori"); 
        opc=5'd13;
addressb2=registers[instruction[20:16]];#1
          inp1=dataout2;
          //$display(inp1);
                   inp2=instruction[15:0];#1

         //$display(inp2); #1
         
    //$display(out);
 addressa2=registers[instruction[25:21]];
    datain2=out;
    #1
     datain2=out;
    end
    6'd10:
    begin     //$display("slti ");
     opc=5'd14;
addressb2=registers[instruction[20:16]];#1
          inp1=dataout2;
          //$display(inp1);
                   inp2=instruction[15:0];#1

         //$display(inp2); #1
         
    //$display(out);
 addressa2=registers[instruction[25:21]];
    datain2=out;
    #1
     datain2=out;
    end


    6'd35:
    begin     //$display("lw");
    ////$display("%d %d\n",instruction[20:16],instruction[25:21]);
     //$display(registers[instruction[20:16]]); 
    addressb2=registers[instruction[20:16]];#2
    //$display(dataout2);#1
    registers[instruction[25:21]]=dataout2;
   // //$display(registers[instruction[25:21]]);
    end

    6'd41:
    begin    //$display("sw"); 
    addressa2=registers[instruction[20:16]];
    datain2=registers[instruction[25:21]];#2

    addressb2=registers[instruction[20:16]];
    //$display(dataout2);
    end


    6'd4: 
    begin  //$display("beq");
     inp1=registers[instruction[25:21]];#1
          // //$display(inp1);
          inp2=registers[instruction[20:16]];#1
         //$display(pc); #1
         if(inp1==inp2)
         pc=instruction[15:0];
         else pc=pc;
        //$display(pc); 

    end

    6'd5:
    begin     //$display("bne");
addressb2=registers[instruction[25:21]];#1
          inp1=dataout2;
          //$display(inp1);
          addressb2=registers[instruction[20:16]];#1
         inp2=dataout2;
           //$display(inp2); #1
           
         if(inp1!=inp2)
         pc=instruction[15:0];
         else pc=pc;
    end

    6'd23:
    begin     //$display("bgt"); 
    inp1=registers[instruction[25:21]];#1
          //$display(inp1);
          inp2=registers[instruction[20:16]];#1
           //$display(inp2); #1
          //  //$display(instruction[15:0]);
         if(inp1>inp2)
         begin
         pc=instruction[15:0];
         //$display(pc);
         end
         else pc=pc;
    end

    6'd29:
    begin     //$display("bgte"); 
addressb2=registers[instruction[25:21]];#1
          inp1=dataout2;
          //$display(inp1);
          addressb2=registers[instruction[20:16]];#1
         inp2=dataout2;
           //$display(inp2); #1
           
         if(inp1>=inp2)
         pc=instruction[15:0];
         else pc=pc;
    end

    6'd41:
    begin     //$display("ble"); 
addressb2=registers[instruction[25:21]];#1
          inp1=dataout2;
          //$display(inp1);
          addressb2=registers[instruction[20:16]];#1
         inp2=dataout2;
           //$display(inp2); #1
           
         if(inp1<inp2)
         pc=instruction[15:0];
         else pc=pc;
    end

    6'd43:
    begin     //$display("bleq ");
addressb2=registers[instruction[25:21]];#1
          inp1=dataout2;
          //$display(inp1);
          addressb2=registers[instruction[20:16]];#1
         inp2=dataout2;
           //$display(inp2); #1
           
         if(inp1<=inp2)
         pc=instruction[15:0];
         else pc=pc;
    end
    6'd2:
    begin     //$display("j ");
pc=instruction[25:0];
//$display(pc);
    end

//     6'd3:
//     begin     //$display("jal ");
// registers[24]=pc+1;
// pc=instruction[25:0]-1;
//     end
    endcase
            curr_s=2'b01;
    end


    endcase
end

    
endmodule