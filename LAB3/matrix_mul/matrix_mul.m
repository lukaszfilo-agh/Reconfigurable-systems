close all;
clear all;

m11 = -0.11;
m12 = 2.3;
m21 = 3.14;
m22 = -11.25;

A = 5.3;
B = -2.5;

prec_Z = 8;
prec_C = 4;

fm11 = fi(m11, 1, prec_Z + prec_C + 1, prec_C)
fm12 = fi(m12, 1, prec_Z + prec_C + 1, prec_C)
fm21 = fi(m21, 1, prec_Z + prec_C + 1, prec_C)
fm22 = fi(m22, 1, prec_Z + prec_C + 1, prec_C)

fA = fi(A, 1, prec_Z + prec_C + 1, prec_C)
fB = fi(A, 1, prec_Z + prec_C + 1, prec_C)

bm11 = bin(fm11)
bm12 = bin(fm12)
bm21 = bin(fm21)
bm22 = bin(fm22)

bA = bin(fA)
bB = bin(fB)

Y = fm11 * fA + fm12 * fB
Z = fm21 * fA + fm22 * fB