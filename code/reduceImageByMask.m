function imageReduced = reduceImageByMask( image, seamMask, isVertical )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Removes pixels by input mask
% Removes vertical line if isVertical == 1, otherwise horizontal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if (isVertical)
        imageReduced = reduceImageByMaskVertical(image, seamMask);
    else
        imageReduced = reduceImageByMaskHorizontal(image, seamMask');
    end;
end

function imageReduced = reduceImageByMaskVertical(image, seamMask)
    % Note that the type of the mask is logical and you 
    % can make use of this.
    
    %%%%%%%%%%%%%%%%%%
    % YOUR CODE HERE:
    %%%%%%%%%%%%%%%%%%
    [height,width,channel] = size(image);
    imageReduced = zeros(height,width-1,channel,'uint8');
    for i=1:height
        for j=1:width-1
            if seamMask(i,j)==false 
                break;
            else
                imageReduced(i,j,:) = image(i,j,:);
            end
        end
        imageReduced(i,j:end,:) = image(i,j+1:end,:);
    end      
            
    %%%%%%%%%%%%%%%%%%
    % END OF YOUR CODE
    %%%%%%%%%%%%%%%%%%
end

function imageReduced = reduceImageByMaskHorizontal(image, seamMask)
    %%%%%%%%%%%%%%%%%%
    % YOUR CODE HERE:
    %%%%%%%%%%%%%%%%%%
    [height,width,channel] = size(image);
    imageReduced = zeros(height-1,width,channel,'uint8');
    for j=1:width
        for i=1:height-1
            if seamMask(i,j)==false
                break;
            else
                imageReduced(i,j,:) = image(i,j,:);
            end
        end
        imageReduced(i:end,j,:) = image(i+1:end,j,:);
    end 
    %%%%%%%%%%%%%%%%%%
    % END OF YOUR CODE
    %%%%%%%%%%%%%%%%%%
end
