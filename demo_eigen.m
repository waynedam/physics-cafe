%% 0. INITIALIZE
clear all; close all; clc; format short e; format compact; warning off

%% 1. LOAD IMAGE AND DISPLAY
img_name = 'images/pattern2.jpg';

img = load_image(img_name);

figure(1)
imshow(img), title('\color{red}ORIGINAL IMAGE')

%% 2. CALCULATE IMAGE'S EIGENDECOMPOSITION.
% Perform eigendecomposition.
[U, D] = eig(img); 

% Get the eigenvalues as a vector.
d = diag(D); 

% Sort them by absolute value and get indices.
[da, idx] = sort(abs(d),'descend'); 

% Sort the eigenvector columns and eigenvalues by decreasing absolute value.
U = U(:, idx);
ds = d(idx);
D = diag( ds );

% Plot the absolute eigenvalues, first linear scale then log.
figure(2)
plot(da,'-o'), grid on, title('\color{red}EIGENVALUES - LINEAR SCALE')
pause
semilogy(da,'-o'), grid on, title('\color{red}EIGENVALUES - LOG SCALE')

%% 3. DISPLAY THE FULLY RECONSTRUCTED IMAGE.
img_rec = U*D*U';
figure(3)
imshow( img_rec ), title('\color{red}RECONSTRUCTED IMAGE - FULL RANK')

% Calculate reconstruction error.
img_err = abs( img_rec - img );
rec_err = sum(img_err(:));

display(['Reconstruction error = ', num2str(rec_err)]);

%% 4. ERROR IN INCREMENTAL REDUCED RANK RECONSTRUCTION.
for k=1:size(img,1)
    img_rec = U(:,1:k)*diag(ds(1:k))*U(:,1:k)';
    img_err = abs( img_rec - img );
    tot_err(k) = sum(img_err(:));
    comp_ratio(k) = k/800;
end
tot_err = tot_err/tot_err(1);

figure(4), clf
yyaxis left
semilogy(tot_err,'b-o')
xlabel('Rank'); ylabel('Reconstruction Error [Normalized]');
% yyaxis right
% semilogy(comp_ratio, 'r-x')
% ylabel('Compression Ratio')
% grid on, title('\color{blue}RECONSTRUCTION ERROR \color{black} AND \color{red} COMPRESSION RATIO \color{black}VERSUS RANK')
grid on, title('\color{red}RECONSTRUCTION ERROR VERSUS RANK')

%% 5. DISPLAY OF INCREMENTAL REDUCED RANK RECONSTRUCTION.
% Set the reconstruction rank, k.
k = 100

UU = U(:,1:k);
dd = ds(1:k);
DD = diag(dd);

img_rec = UU*DD*UU';

% Calculate the compression ratio.
comp_ratio = get_comp_ratio( U, ds, UU, dd );

cr_string = num2str(comp_ratio*100);

disp(['Compression ratio = ', cr_string,'%']) 

figure(12)
imshow(img_rec), title(strcat('\color{red}RANK -', int2str(k), '- RECONSTRUCTION', ...
    ', Compression Ratio = ', cr_string,'%'));

%% 6. EXAMPLE OF DE-NOISING
% Set eigenvalue 50 to 100 times its actual value. 
% This could be an example of jamming or interference in an antenna array
% of 800 elements and our matrix represents the correlation matrix of
% signals from the array elements.

dj = ds;
dj(5) = 100*ds(5);
Dj = diag(dj);

% Generate the "jammed" image. 
img_jam = U*Dj*U';

figure(6)
imshow(img_jam), title('\color{red}JAMMED IMAGE');

pause

figure(7)
plot(dj(1:100),'-o'), grid on, title('\color{red}Jammed Eigenvalues');

% Now set dj(50) = 0.
dr = dj;
dr(5) = 0;
Dr = diag(dr);

% Reconstruct the image.
img_rec = U*Dr*U';

figure(8)
imshow(img_rec), title('\color{red}DE-NOISED IMAGE');