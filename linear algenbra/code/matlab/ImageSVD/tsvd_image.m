img = imread('/Users/keru/Desktop/svd image color.jpeg');

gray_img = im2gray(img);
gray_img_double = double(gray_img);

k_values = [10, 50, 100];

U_tsvd = cell(1, length(k_values));
S_tsvd = cell(1, length(k_values));
V_tsvd = cell(1, length(k_values));
reconstructed_imgs = cell(1, length(k_values));
psnr_values = zeros(1, length(k_values));
ssim_values = zeros(1, length(k_values));

compressed_sizes_bytes = zeros(1, length(k_values));
compressed_sizes_mb = zeros(1, length(k_values));

in_memory_size_bytes = numel(gray_img) * 1;
in_memory_size_mb = in_memory_size_bytes / (1024 * 1024);

[U, S, V] = svd(gray_img_double, 'econ');
for i = 1:length(k_values)
    k = k_values(i);
    U_tsvd{i} = U(:, 1:k);
    S_tsvd{i} = S(1:k, 1:k);
    V_tsvd{i} = V(:, 1:k);
    reconstructed_imgs{i} = U_tsvd{i} * S_tsvd{i} * V_tsvd{i}';
    psnr_values(i) = psnr(uint8(reconstructed_imgs{i}), gray_img);
    ssim_values(i) = ssim(uint8(reconstructed_imgs{i}), gray_img);
    
    compressed_size_bytes = (numel(U_tsvd{i}) + numel(S_tsvd{i}) + numel(V_tsvd{i})) * 8;
    compressed_size_mb = compressed_size_bytes / (1024 * 1024);
    
    compressed_sizes_bytes(i) = compressed_size_bytes;
    compressed_sizes_mb(i) = compressed_size_mb;
end

figure;
subplot(1, 1, 1);
imshow(img);
title('Original Color Image', 'FontSize', 16, 'Position', [size(img, 2)/2, -80], 'VerticalAlignment', 'bottom');
text(size(img, 2)/2, size(img, 1) + 80, ...
    ['In-Memory Size: ', num2str(in_memory_size_bytes), ' bytes (', num2str(in_memory_size_mb, '%.2f'), ' MB)'], ...
    'FontSize', 16, 'HorizontalAlignment', 'center', 'Interpreter', 'latex');

figure;
for i = 1:length(k_values)
    subplot(1, 3, i);
    imshow(uint8(reconstructed_imgs{i}));
    title(['Reconstructed with k = ', num2str(k_values(i))], 'FontSize', 16);
    text(size(img, 2)/2, size(img, 1) + 500, ...
    ['PSNR: ' num2str(psnr_values(i)) ' dB' newline ' SSIM: ' num2str(ssim_values(i)) newline ...
    'Compressed Size: ' num2str(compressed_sizes_bytes(i)) ' bytes (' num2str(compressed_sizes_mb(i), '%.2f') ' MB)' newline ...
    'Take: ' num2str(100 * compressed_sizes_mb(i) / in_memory_size_mb, '%.1f') ' \% initial memory'], ...
    'FontSize', 16, 'HorizontalAlignment', 'center', 'Interpreter', 'latex');
end

set(gcf, 'Position', [100, 100, 1200, 1200]);

set(gca, 'LooseInset', get(gca, 'TightInset'));
