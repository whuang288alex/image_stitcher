function [inliers_id, best_H] = runRANSAC(Xs, Xd, ransac_n, eps)
    
    num_pts = size(Xs, 1);
    pts_id = 1 : num_pts;
    inliers_id = [];
    max_M = 0;

    for iter = 1 : ransac_n
        inds = randperm(num_pts, 4);
        H = computeHomography(Xs(inds,:), Xd(inds,:));
        A = H * transpose([Xs,ones(num_pts,1)]);
        temp = transpose(A);
        temp = [temp(:,1)./temp(:,3), temp(:,2)./temp(:,3)];
        dist = sqrt(sum((temp - Xd).^2,2));
        i = dist < eps;
        if sum(i) > max_M
            max_M = sum(i);
            best_H = H;
            inliers_id = pts_id(i);
        end
    end 
end