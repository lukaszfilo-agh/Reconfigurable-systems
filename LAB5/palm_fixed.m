clear all; close all;

palm_RGB = imread('palm_64.jpg');
palm_RGB_fi = imread('palm_64.jpg');

palm_RGB_fi = fi(palm_RGB_fi, 0, 8, 0); % value, sign, word, fraction
R = palm_RGB_fi(:, :, 1);
G = palm_RGB_fi(:, :, 2);
B = palm_RGB_fi(:, :, 3);

M = [0.299 0.587 0.114; ...
         -0.168736 -0.331264 0.5; ...
         0.5 -0.418688 -0.081312];

sign = 1;
prec_i = 0;
prec_f = 17;
word = 1 + prec_i + prec_f;

for i = 1:3

    for j = 1:3
        FixedMat(i, j) = fi(M(i, j), sign, word, prec_f);
    end

end

ntBP = numerictype(1, 9, 0);

YCbCr(:, :, 1) = quantize(FixedMat(1, 1) * R, ntBP) + quantize(FixedMat(1, 2) * G, ntBP) + quantize(FixedMat(1, 3) * B, ntBP);
YCbCr(:, :, 2) = quantize(FixedMat(2, 1) * R, ntBP) + quantize(FixedMat(2, 2) * G, ntBP) + quantize(FixedMat(2, 3) * B, ntBP) + fi(128, 0, 8, 0);
YCbCr(:, :, 3) = quantize(FixedMat(3, 1) * R, ntBP) + quantize(FixedMat(3, 2) * G, ntBP) + quantize(FixedMat(3, 3) * B, ntBP) + fi(128, 0, 8, 0);

fotoYCB = uint8(YCbCr);

foto_sim_out = imread('out_00.ppm');
YCbCr = uint8(YCbCr);
diff = imabsdiff(foto_sim_out, YCbCr);

figure(1)
subplot(1, 3, 1)
imshow(YCbCr)
title('MATLAB')

subplot(1, 3, 2)
imshow(foto_sim_out)
title('SIM')

subplot(1, 3, 3)
imshow(diff);
title('DIFF')

