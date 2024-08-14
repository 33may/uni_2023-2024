img = imread('/Users/keru/Desktop/svd image color.jpeg');

gray_img = im2gray(img);
gray_img_double = double(gray_img);

[U, S, V] = svd(gray_img_double, 'econ');

reconstructed_img = U * S * V';

mse = mean((gray_img_double(:) - reconstructed_img(:)).^2);
psnr_value = psnr(uint8(reconstructed_img), gray_img);
ssim_value = ssim(uint8(reconstructed_img), gray_img);

figure;

subplot(3, 2, 1); 
imshow(img);
title('Original Color Image', 'FontSize', 16, 'Position', [size(img, 2)/2, -80], 'VerticalAlignment', 'bottom');
text(size(img, 2)/2, size(img, 1) + 140, 'Tensor of Size $I^{2000 \times 3000 \times 3}$, where $I \in 0 \ldots 255$', 'FontSize', 16, 'HorizontalAlignment', 'center', 'Interpreter', 'latex');

subplot(3, 2, 2);
imshow(gray_img);
title('Grayscale Image', 'FontSize', 16, 'Position', [size(gray_img, 2)/2, -80], 'VerticalAlignment', 'bottom');
text(size(gray_img, 2)/2, size(gray_img, 1) + 140, 'Matrix of Size $I^{2000 \times 3000}$, where $I \in 0 \ldots 255$', 'FontSize', 16, 'HorizontalAlignment', 'center', 'Interpreter', 'latex');

subplot(3, 2, [3, 4]);
text(0.5, 0.5, ...
    ['$\textbf{Comparison of SVD Sizes}$' newline newline ...
    '$\textbf{Full SVD:}$' newline ...
    '$U: \,' num2str(size(U_full, 1)) '\times' num2str(size(U_full, 2)) '$' newline ...
    '$S: \,' num2str(size(S_full, 1)) '\times' num2str(size(S_full, 2)) '$' newline ...
    '$V: \,' num2str(size(V_full, 1)) '\times' num2str(size(V_full, 2)) '$' newline newline ...
    '$\textbf{Economy SVD:}$' newline ...
    '$U: \,' num2str(size(U, 1)) '\times' num2str(size(U, 2)) '$' newline ...
    '$S: \,' num2str(size(S, 1)) '\times' num2str(size(S, 2)) '$' newline ...
    '$V: \,' num2str(size(V, 1)) '\times' num2str(size(V, 2)) '$'], ...
    'FontSize', 16, 'HorizontalAlignment', 'center', 'Interpreter', 'latex');

axis off;

subplot(3, 2, 5);
imshow(uint8(reconstructed_img));
title('Reconstructed Grayscale Image', 'FontSize', 16, 'Position', [size(gray_img, 2)/2, -50], 'VerticalAlignment', 'bottom');
text(size(reconstructed_img, 2)/2, size(reconstructed_img, 1) + 140, 'Reconstructed from SVD', 'FontSize', 16, 'HorizontalAlignment', 'center', 'Interpreter', 'latex');

subplot(3, 2, 6);
text(0.5, 0.5, ...
    ['$\textbf{Comparison of Original and SVD Images}$' newline newline ...
    '$MSE: ' num2str(mse) '$' newline ...
    '$PSNR: ' num2str(psnr_value) '$' newline, ...
    '$SSIM: ' num2str(ssim_value) '$'], ...
    'FontSize', 16, 'HorizontalAlignment', 'center', 'Interpreter', 'latex');

axis off;

set(gcf, 'Position', [100, 100, 1200, 1200]);
