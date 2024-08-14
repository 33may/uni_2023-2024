img = imread('/Users/keru/Desktop/svd image color.jpeg');

R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

k_values = [10, 50, 100];

U_red_tsvd = cell(1, length(k_values));
S_red_tsvd = cell(1, length(k_values));
V_red_tsvd = cell(1, length(k_values));

U_green_tsvd = cell(1, length(k_values));
S_green_tsvd = cell(1, length(k_values));
V_green_tsvd = cell(1, length(k_values));

U_blue_tsvd = cell(1, length(k_values));
S_blue_tsvd = cell(1, length(k_values));
V_blue_tsvd = cell(1, length(k_values));

reconstructed_imgs = cell(1, length(k_values));
psnr_values = zeros(1, length(k_values));
ssim_values = zeros(1, length(k_values));

for i = 1:length(k_values)
    k = k_values(i);
    
    [U_red, S_red, V_red] = svd(double(R), 'econ');
    U_red_tsvd{i} = U_red(:, 1:k);
    S_red_tsvd{i} = S_red(1:k, 1:k);
    V_red_tsvd{i} = V_red(:, 1:k);
    R_reconstructed = U_red_tsvd{i} * S_red_tsvd{i} * V_red_tsvd{i}';
    
    [U_green, S_green, V_green] = svd(double(G), 'econ');
    U_green_tsvd{i} = U_green(:, 1:k);
    S_green_tsvd{i} = S_green(1:k, 1:k);
    V_green_tsvd{i} = V_green(:, 1:k);
    G_reconstructed = U_green_tsvd{i} * S_green_tsvd{i} * V_green_tsvd{i}';

    [U_blue, S_blue, V_blue] = svd(double(B), 'econ');
    U_blue_tsvd{i} = U_blue(:, 1:k);
    S_blue_tsvd{i} = S_blue(1:k, 1:k);
    V_blue_tsvd{i} = V_blue(:, 1:k);
    B_reconstructed = U_blue_tsvd{i} * S_blue_tsvd{i} * V_blue_tsvd{i}';
    

    reconstructed_img = cat(3, uint8(R_reconstructed), uint8(G_reconstructed), uint8(B_reconstructed));
    reconstructed_imgs{i} = reconstructed_img;

    psnr_values(i) = psnr(reconstructed_img, img);
    ssim_values(i) = ssim(reconstructed_img, img);
end


figure;

tiledlayout(2, 3, 'TileSpacing', 'tight', 'Padding', 'compact');

nexttile([1, 3]);
imshow(img);
title('Original Color Image', 'FontSize', 16);

nexttile;
imshow(cat(3, R, zeros(size(R)), zeros(size(R))));
title('Red Channel', 'FontSize', 16);


nexttile;
imshow(cat(3, zeros(size(G)), G, zeros(size(G))));
title('Green Channel', 'FontSize', 16);

nexttile;
imshow(cat(3, zeros(size(B)), zeros(size(B)), B));
title('Blue Channel', 'FontSize', 16);


set(gcf, 'Position', [100, 100, 1400, 800]);

figure;

for i = 1:length(k_values)
    subplot(1, 3, i);
    imshow(reconstructed_imgs{i});
    title(['Reconstructed with k = ', num2str(k_values(i))], 'FontSize', 16);
    text(size(reconstructed_imgs{i}, 2)/2, size(reconstructed_imgs{i}, 1) + 200, ...
        ['PSNR: ', num2str(psnr_values(i)), ' dB' newline ...
        'SSIM: ', num2str(ssim_values(i))], ...
        'FontSize', 12, 'HorizontalAlignment', 'center', 'Interpreter', 'latex');
end

set(gcf, 'Position', [100, 100, 1200, 600]);


set(gca, 'LooseInset', get(gca, 'TightInset'));
