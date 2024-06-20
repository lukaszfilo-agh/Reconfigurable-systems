close all; clear all;

%potrzebne zdjecie reki 64x64 piksele w formacie jpg
palm_RGB_d = imread('palm_64.jpg');
palm_RGB = imread('palm_64.jpg');
imwrite(palm_RGB_d, 'palm_64.ppm');

palm_RGB_d = double(palm_RGB_d);
[height, width, ch] = size(palm_RGB_d);

R = palm_RGB_d(:, :, 1);
G = palm_RGB_d(:, :, 2);
B = palm_RGB_d(:, :, 3);

M = [0.299 0.587 0.114; ...
         -0.168736 -0.331264 0.5; ...
         0.5 -0.418688 -0.081312];

T = [0; 128; 128];

Ta = 30;
Tb = 140;
Tc = 146;
Td = 200;

for i = 1:height

    for j = 1:width
        pixel_rgb = [R(i, j); G(i, j); B(i, j)];
        pixel_YCbCr = (M * pixel_rgb) + T;
        Y(i, j) = uint8(pixel_YCbCr(1));
        Cb(i, j) = uint8(pixel_YCbCr(2));
        Cr(i, j) = uint8(pixel_YCbCr(3));

        if (Ta < Cb(i, j) && Cb(i, j) < Tb && Tc < Cr(i, j) && Cr(i, j) < Td)
            palm_binary(i, j) = 1;
        else
            palm_binary(i, j) = 0;
        end

    end

end

YCbCr(:, :, 1) = Y;
YCbCr(:, :, 2) = Cb;
YCbCr(:, :, 3) = Cr;

filtr = medfilt2(palm_binary, [5, 5]);
filtr(1:2, :) = 0;
filtr(63:64, :) = 0;
filtr(:, 1:2) = 0;
filtr(:, 63:64) = 0;

m00 = 0;
m10 = 0;
m01 = 0;

for i = 1:height

    for j = 1:width
        m00 = m00 + filtr(j, i);
        m10 = m10 + ((j - 1) * filtr(j, i));
        m01 = m01 + ((i - 1) * filtr(j, i));
    end

end

x = round(m10 / m00);
y = round(m01 / m00);

figure(1)
subplot(3, 2, 1);
imshow(palm_RGB)
title('RGB');

subplot(3, 2, 2);
imshow(YCbCr);
title('YCbCr');

subplot(3, 2, 3);
imshow(palm_binary);
title('Binary mask');

subplot(3, 2, 4);
imshow(filtr);
title('Median filter');

subplot(3, 2, 5)
hold on
imshow(palm_binary);
xline(y, 'color', 'r', 'LineWidth', 2);
yline(x, 'color', 'r', 'LineWidth', 2);
title('Center');
