`timescale 1ns / 1ps

module Brent_Kung #(parameter bits = 64)(
    input [bits-1:0] A,B,
    input Cin,
    output [bits-1:0] SUM ,
    output Cout 
    );
wire [bits-1:0] g_internal [0 : 2*$clog2(bits)-2] ;
wire [bits-1:0] p_internal [0 : 2*$clog2(bits)-2] ;
// generate and propagate logic
wire [bits-1:0] g,p;
GP_Logic # (.bits(bits)) GP_block(.X(A) ,.Y(B) ,.g(g) ,.p(p));

//carry network using Brent and kung
Carry_Determination CD_Cin (.g({g[0],Cin}),.p({p[0],1'b1}),.G(g_internal[0][0]),.P(p_internal[0][0]));
Carry_Determination CD_C0 (.g({g[1],g_internal[0][0]}),.p({p[1],p_internal[0][0]}),.G(g_internal[0][1]),.P(p_internal[0][1]));
genvar i , n , m , z;
generate
    // make the first row (cin , first row first group)
    for(i=2;i<bits;i=i+2)
    begin : first
        Carry_Determination CD_1(.g({g[i+1],g[i]}),.p({p[i+1],p[i]}),.G(g_internal[0][i+1]),.P(p_internal[0][i+1]));
        assign g_internal[0][i] = g[i];
        assign p_internal[0][i] = p[i];
    end
    // make second group 
    for (n=4;n<=bits;n=n<<1)
    begin : second 
        for(m=n;m<=bits;m=m+n)
        begin : second_1
            if (m==n)
                Carry_Determination_Gonly  CD_2(.g({g_internal[$clog2(n) -2][m-1],g_internal[$clog2(n) -2][m-n/2-1]}),.p(p_internal[$clog2(n) -2][m-1]),.G(g_internal[$clog2(n)-1][m-1]));            
            else
                Carry_Determination  CD_2(.g({g_internal[$clog2(n) -2][m-1],g_internal[$clog2(n) -2][m-n/2-1]}),.p({p_internal[$clog2(n) -2][m-1],p_internal[$clog2(n) -2][m-n/2-1]}),.G(g_internal[$clog2(n)-1][m-1]),.P(p_internal[$clog2(n)-1][m-1]));
  
            for (z=(m-n);z<m-1;z=z+1)
            begin
                assign g_internal[$clog2(n)-1][z] = g_internal[$clog2(n) -2][z];
                assign p_internal[$clog2(n)-1][z] = p_internal[$clog2(n) -2][z];
            end
        end
    end

   for (n=4;n<=bits;n=n<<1)
   begin : third
     for (z=0;z<bits;z=z+1)
           begin
           if ((z%(2*(bits/n))!=((bits/n)-1))|(z<((bits/n)*3-1))|(z>((bits/n)*(n-1)-1)))begin
               assign g_internal[$clog2(bits)+$clog2(n)-2][z] = g_internal[$clog2(bits)+$clog2(n)-3][z];
               assign p_internal[$clog2(bits)+$clog2(n)-2][z] = p_internal[$clog2(bits)+$clog2(n)-3][z];
           end
           else
                Carry_Determination_Gonly  CD_3(.g({g_internal[$clog2(bits)+$clog2(n)-3][z],g_internal[$clog2(bits)+$clog2(n)-3][z-(bits/n)]}),.p(p_internal[$clog2(bits)+$clog2(n)-3][z]),.G(g_internal[$clog2(bits)+$clog2(n)-2][z]));
           end
   end
endgenerate
SUM_logic #(.bits(bits)) SUM_block(.C({g_internal[2*$clog2(bits)-2][bits-2:0],Cin}) , .p(p) ,.SUM(SUM));
assign Cout = g_internal[2*$clog2(bits)-2][bits-1];
endmodule
