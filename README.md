# image_stitcher

This is an app that stitches a collection of photos into one. Below are some example results.


<img src="https://user-images.githubusercontent.com/91099638/209487185-0a8a00f5-5383-4369-8d37-af67733e2a1f.jpg" width=30% height=50%><img src="https://user-images.githubusercontent.com/91099638/209487188-1f0c55e6-5268-4298-837d-0093df6dad37.jpg" width=30% height=50%><img src="https://user-images.githubusercontent.com/91099638/209487187-761e4cc1-0b79-4d2c-afc3-f234ed016ddb.jpg" width=30% height=50%>

<img src="https://user-images.githubusercontent.com/91099638/209487402-52b92297-49c6-447f-b2db-1ff9c349d4ed.png" width=90% height=50%>


We accomplish ths by first getting some matching interest points using the Scale-invariant feature transform (SIFT) algorithm.

![before_ransac](https://user-images.githubusercontent.com/91099638/209487120-efca8aa6-e3c9-4686-b52a-e97dd55cfe86.png)
 
In order to make the matching more robust, we use RANdom Sampling And Consensus (RANSAC) to get rid of the outliers.

![after_ransac](https://user-images.githubusercontent.com/91099638/209487085-63aeac3d-c9ef-4725-886b-9882f3f79df2.png)

We then calculate the homogrphy between the images based on those SIFT matches, and use backward warping to stitch the images together. 
Note that in order to make the stiched image more natural, we use the MATLAB function "bwdist" to blend the images.

![mountain_panorama](https://user-images.githubusercontent.com/91099638/209487099-2941a440-2084-4cf2-8ed9-54b320d33bb5.png)


