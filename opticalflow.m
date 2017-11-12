fr1 = imread('frame1.png');
fr2 = imread('frame2.png');
windowSize=10;
im1 = im2double(rgb2gray(fr1));
im2 = im2double(rgb2gray(fr2));
 
u = zeros(size(im1));
v = zeros(size(im2));
 
[H, V]=gradient(im1);
fx = H;
fy = V;
ft = im2-im1; % partial on t
 tic
 
halfWindow = floor(windowSize/2);
for i = halfWindow+1:size(fx,1)-halfWindow
   for j = halfWindow+1:size(fx,2)-halfWindow
      curFx = fx(i-halfWindow:i+halfWindow, j-halfWindow:j+halfWindow);
      curFy = fy(i-halfWindow:i+halfWindow, j-halfWindow:j+halfWindow);
      curFt = ft(i-halfWindow:i+halfWindow, j-halfWindow:j+halfWindow);
      
      curFx = curFx';
      curFy = curFy';
      curFt = curFt';
 
      curFx = curFx(:);
      curFy = curFy(:);
      curFt = -curFt(:);
      
      A = [curFx curFy];
      
      U = pinv(A'*A)*A'*curFt;
      
      u(i,j)=U(1);
      v(i,j)=U(2);
   end
end
% downsize u and v
u_deci = u(1:15:end, 1:15:end);
v_deci = v(1:15:end, 1:15:end);
% get coordinate for u and v in the original frame
[m, n] = size(im1);
[X,Y] = meshgrid(1:n, 1:m);
X_deci = X(1:15:end, 1:15:end);
Y_deci = Y(1:15:end, 1:15:end);
 
figure();
 
imshow(fr1);
hold on;
quiver(X_deci, Y_deci, u_deci,v_deci,3,'y');
figure ;
quiver(X_deci, Y_deci, u_deci,v_deci,3,'y');
toc
