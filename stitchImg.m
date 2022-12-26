function stitched_img = stitchImg(varargin)

    % Images should be all grayscale or all colour
    assert(max(cellfun(@(x) size(x, 3), varargin)== min(cellfun(@(x) size(x, 3), varargin))));
    H_stitched = sum(cellfun(@(x) size(x, 1), varargin));
    W_stitched = sum(cellfun(@(x) size(x, 2), varargin));
    C_stitched = size(varargin{1}, 3);

    stitched_img = zeros(H_stitched, W_stitched, C_stitched);
    num_imgs = numel(varargin);
    middle_idx = round((num_imgs + 1) / 2);
    ref_idx = middle_idx;

    % paste the reference image into the output canvas.
    ref_img = varargin{ref_idx};
    H_ref = size(ref_img, 1);
    W_ref = size(ref_img, 2);

    ref_start_x = 1 + floor((W_stitched - W_ref) / 2);
    ref_start_y = 1 + floor((H_stitched - H_ref) / 2);
    stitched_img(ref_start_y : ref_start_y + H_ref - 1, ref_start_x : ref_start_x + W_ref - 1,:) = ref_img;
    stitch_mask = false(H_stitched, W_stitched);
    stitch_mask(ref_start_y : ref_start_y + H_ref - 1,ref_start_x : ref_start_x + W_ref - 1) = true;

    for n = 1:num_imgs
        if n == ref_idx
            continue
        end
        img_n = varargin{n};
        [kp_stitched, kp_n] = genSIFTMatches(stitched_img, img_n);
        [inliers_id, H_3x3] = runRANSAC(kp_n ,kp_stitched , 300, 1);
        [mask, dest_img] = backwardWarpImg(img_n, inv(H_3x3), [W_stitched, H_stitched]);
        stitched_img = blendImagePair(dest_img, mask,stitched_img, stitch_mask, 'blend');
        stitch_mask = or(stitch_mask, mask);
    end
    stitched_img = bbox_crop(stitched_img);
end