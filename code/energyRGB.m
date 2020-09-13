function res = energyRGB(I)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sum up the enery for each channel 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
grey = energyGrey(I);
res = grey(:,:,1)+grey(:,:,2)+grey(:,:,3);

end

function res = energyGrey(I)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% returns energy of all pixelels
% e = |dI/dx| + |dI/dy|
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dx = [-1 0 1]; % horizontal gradient filter 
dy = dx'; % vertical gradient filter
[~, ~, channel] = size(I);
Ix = zeros(size(I));
Iy = zeros(size(I));
for i=1:channel
    Ix(:,:,i) = conv2(double(I(:,:,i)),dx,'same');
    Iy(:,:,i) = conv2(double(I(:,:,i)),dy,'same');
end

res = abs(Ix)+abs(Iy);
end

