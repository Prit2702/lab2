clc;
clear;
close all;

img = round(100 + (100 - 50) * rand(8));
flat_img = img(:)';
sorted_img = sort(flat_img);
[u_vals, ~, idx] = unique(sorted_img);
freq = accumarray(idx, 1);
cdf = cumsum(freq);
num_px = numel(img);
cdf_min = min(cdf(cdf > 0));
L = 256;
eq_vals = round(((cdf - cdf_min) / (num_px - cdf_min)) * (L - 1));
eq_img = zeros(size(img));
for i = 1:length(u_vals)
    eq_img(img == u_vals(i)) = eq_vals(i);
end
eq_img = uint8(eq_img);
img = uint8(img);

figure(1);
subplot(2, 1, 1);
bar(u_vals, freq, 'FaceColor', 'b');
title('Original Histogram');
xlabel('Intensity Values');
ylabel('Frequency');

subplot(2, 1, 2);
bar(0:L-1, histcounts(eq_img(:), 0:L), 'FaceColor', 'r');
title('Equalized Histogram');
xlabel('Intensity Values');
ylabel('Frequency');

figure(2)
subplot(1, 2, 1)
imshow(img)
title("Original Image");

subplot(1, 2, 2)
imshow(eq_img)
title("Equalised Image");
