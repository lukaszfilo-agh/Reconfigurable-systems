clear all; close all;

palm_RGB = imread('palm_64.ppm');
palm_RGB = double(palm_RGB);

R = palm_RGB(:,:,1)/255;
G = palm_RGB(:,:,2)/255;
B = palm_RGB(:,:,3)/255;

[height, width, ch] = size(palm_RGB);

sign = 1;
prec_i = 1;
prec_f = 8;
word = 1 + prec_i + prec_f;

R_fi = fi(R,sign,word,prec_f,'RoundingMethod','Floor'); % value, sign, word, fraction
G_fi = fi(G,sign,word,prec_f,'RoundingMethod','Floor');
B_fi = fi(B,sign,word,prec_f,'RoundingMethod','Floor');

RGB_fi(:,:,1) = R_fi;
RGB_fi(:,:,2) = G_fi;
RGB_fi(:,:,3) = B_fi;

MAX_FIX = max(R_fi, max(G_fi, B_fi));
MIN_FIX = min(R_fi, min(G_fi, B_fi));

C_FIX = MAX_FIX - MIN_FIX;

G_min_B = G_fi - B_fi;
B_min_R = B_fi - R_fi;
R_min_G = R_fi - G_fi;

V = MAX_FIX;

S = double(C_FIX)./double(V); %jebana kropka
S = fi(S,sign,word,prec_f,'RoundingMethod','Floor');

for i=1:height
    for j=1:width
        if C_FIX(i,j) == 0
            H(i,j) = 0;
        elseif MAX_FIX(i,j) == R_fi(i,j)
            t = double(G_min_B(i,j))/double(C_FIX(i,j));
            t = fi(t,sign,word,prec_f,'RoundingMethod','Floor');
            H(i,j) = fi(60,1,8,0)*t;
        elseif MAX_FIX(i,j) == G_fi(i,j)
            t = double(B_min_R(i,j))/double(C_FIX(i,j)) ;
            t = fi(t,sign,word,prec_f,'RoundingMethod','Floor');
            H(i,j) = fi(60,1,8,0)*t;
            H(i,j) = H(i,j) + fi(120,1,9,0);
        elseif MAX_FIX(i,j) == B_fi(i,j)
            t = double(R_min_G(i,j))/double(C_FIX(i,j));
            t = fi(t,sign,word,prec_f,'RoundingMethod','Floor');
            H(i,j) = fi(60,1,8,0)*t;
            H(i,j) = H(i,j) + fi(240,1,10,0);
        end
        
        if H(i,j) < 0
            H(i,j) = H(i,j) + fi(360,1,10,0);
        end
        H(i,j) = fi((double(H(i,j))/360),1,24,7);
    end
end

sign = 1;
prec_i = 8;
prec_f = 0;
word = 1 + prec_i + prec_f;

H_255 = floor(double(H)*255);
V_255 = floor(double(MAX_FIX)*255);
S_255 = floor(double(S)*255);

H_255_fi = fi(H_255,sign,word,prec_f,'RoundingMethod','Floor');
S_255_fi = fi(S_255,sign,word,prec_f,'RoundingMethod','Floor');
V_255_fi = fi(V_255,sign,word,prec_f,'RoundingMethod','Floor');

RGB = imread('palm_64.ppm');

HSV_imag(:,:,1) = double(H);
HSV_imag(:,:,2) = double(S);
HSV_imag(:,:,3) = double(V);

HSV_imag_255(:,:,1) = double(H_255);
HSV_imag_255(:,:,2) = double(S_255);
HSV_imag_255(:,:,3) = double(V_255);

HSV_matlab = rgb2hsv(RGB);
HSV_matlab_255 = HSV_matlab*255;

HSV_FPGA = imread('out_00.ppm');

diff_fpga = imabsdiff(HSV_imag_255, double(HSV_FPGA));
max(max(diff_fpga))

figure(1);
subplot(1,5,1)
imshow(RGB);
title('RGB')

subplot(1,5,2)
imshow(HSV_imag)
title('Fixed-Point')

subplot(1,5,3)
imshow(HSV_matlab)
title('Matlab-Fcn')

subplot(1,5,4)
imshow(HSV_FPGA)
title('FPGA')

subplot(1,5,5)
imshow(diff_fpga)
title('DIFF')

figure(2)
subplot(2,3,1)
imshow(HSV_matlab(:,:,1))
subplot(2,3,2)
imshow(HSV_matlab(:,:,2))
subplot(2,3,3)
imshow(HSV_matlab(:,:,3))

subplot(2,3,4)
imshow(HSV_FPGA(:,:,1))
subplot(2,3,5)
imshow(HSV_FPGA(:,:,2))
subplot(2,3,6)
imshow(HSV_FPGA(:,:,3))

