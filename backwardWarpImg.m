function [mask, result_img] = backwardWarpImg(src_img, resultToSrc_H,...
                                              dest_canvas_width_height)
    src_height = size(src_img, 1);
    src_width = size(src_img, 2);
    src_channels = size(src_img, 3);
    dest_width = dest_canvas_width_height(1);
    dest_height = dest_canvas_width_height(2);
    
    result_img = zeros(dest_height, dest_width, src_channels);
    mask = false(dest_height, dest_width);
    
    % this is the overall region covered by result_img
    [dest_X, dest_Y] = meshgrid(1:dest_width, 1:dest_height);
    
    % map result_img region to src_img coordinate system using the given
    % homography.
    src_pts = applyHomography(resultToSrc_H, [dest_X(:), dest_Y(:)]);
    src_X = reshape(round(src_pts(:,1)), dest_height, dest_width);
    src_Y = reshape(round(src_pts(:,2)), dest_height, dest_width);

    for i=1:dest_height
        for j=1:dest_width
            x = src_X(i,j);
            y = src_Y(i,j);
            if x >= 1 && y >=1 && ...
                x <= src_width &&  y <= src_height
                result_img(i,j,:) = src_img(y, x, :);
                mask(i,j)=1;
            else
                result_img(i,j,:) = [0 0 0];
            end
        end
    end
     
end