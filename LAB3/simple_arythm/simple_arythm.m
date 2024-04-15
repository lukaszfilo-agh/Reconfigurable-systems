clear all; close all;
format long
sign=1; %0-unsigned value, 1-signed value % sign
prec_i=1; %number of integer part bits (Nc) % one bit
prec_f=10; %number of fractional part bits (Nu) % eight bits
word = 1 + prec_i + prec_f; % whole word

val_a = 0.32345;
val_b = -0.78743;
val_c = 0.56532;

A = fi(val_a,sign,word,prec_f);
B = fi(val_b,sign,word,prec_f);
C = fi(val_c,sign,word,prec_f);
A_Bin = bin(A);
B_Bin = bin(B);
C_Bin = bin(C);
out = (A+B)*C
out_prec = (val_a+val_b)*val_c
%%
res = zeros(1,17);
for prec_f = 0:16
    A = fi(val_a,sign,word,prec_f);
    B = fi(val_b,sign,word,prec_f);
    C = fi(val_c,sign,word,prec_f);
    out = (A+B)*C;
    o_dub = double(out);
    res(prec_f+1) = abs(o_dub-out_prec);
end

plot(res)