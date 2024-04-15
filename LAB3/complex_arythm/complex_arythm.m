close all;
clear all;
A = -100.34;
B = 7.367;
C = -4.92;
D = 9.111;
E = -99.99;
F = 134.56;

precA = 8;
precB = 3;
precC = 7;
precD = 2;
precE = 5;
precF = 9;

fA = fi(A, 1, precA + 9 + 1, precA)
fB = fi(B, 1, precB + 4 + 1, precB);
fC = fi(C, 1, precC + 4 + 1, precC);
fD = fi(D, 1, precD + 5 + 1, precD);
fE = fi(E, 1, precE + 8 + 1, precE);
fF = fi(F, 1, precF + 9 + 1, precF);

bA = bin(fA);
bB = bin(fB);
bC = bin(fC);
bD = bin(fD);
bE = bin(fE);
bF = bin(fF);

out = (A + B) * C + ((D + E) * (E + F))

AsumB = fA + fB
DsumE = fD + fE
EsumF = fE + fF
ABtimesC = AsumB * fC
EDtimesEF = DsumE * EsumF

out_prec = (fA + fB) * fC + ((fD + fE) * (fE + fF))
