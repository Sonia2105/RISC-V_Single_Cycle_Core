module Sign_Extend(Imm_Ext,In);
input [31:0] In;
output [31:0] Imm_Ext;

assign Imm_Ext = (In[31]) ? {{20{1'b1}},In[31:20]} : {{20{1'b0}},In[31:20]};

endmodule