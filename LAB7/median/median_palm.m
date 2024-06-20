clear;
palm_bin = imread('out_bin.ppm');
palm_bin = palm_bin(:,:,1);
palm_med = imread('out_med.ppm');
palm_med = palm_med(:,:,1);

filtr = medfilt2(palm_bin, [5, 5]);
filtr(1:2, :) = 0;
filtr(63:64, :) = 0;
filtr(:, 1:2) = 0;
filtr(:, 63:64) = 0;

diff = imabsdiff(palm_med, filtr);

figure(1)
subplot(1,3,1)
imshow(filtr)
title('MATLAB')

subplot(1,3,2)
imshow(palm_med)
title('FPGA')

subplot(1,3,3)
imshow(diff)
title('diff')

SE = strel('square',5);
open = imopen(palm_bin,SE);

palm_open = imread('out_open.ppm');
palm_open = palm_open(:,:,1);

diff = imabsdiff(palm_open, open); 

figure(2)
subplot(1,3,1)
imshow(open)
title('MATLAB')

subplot(1,3,2)
imshow(palm_open)
title('FPGA')

subplot(1,3,3)
imshow(diff)
title('diff')