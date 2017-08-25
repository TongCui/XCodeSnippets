# How to create vedios from images
[How](http://hamelot.io/visualization/using-ffmpeg-to-convert-a-set-of-images-into-a-video/)

ffmpeg -r 15 -f image2 -s 1920x1080 -start_number 185 -i  G0033%03d.JPG -vframes 1000 -vcodec libx264 -crf 25 -pix_fmt yuv420p test.mp4

-r is the framerate (fps)
-crf is the quality, lower means better quality, 15-25 is usually good
-s is the resolution
-pix_fmt yuv420p specifies the pixel format, change this as needed


ffmpeg -r 36 -s 1920x1080 -pattern_type glob -i '*.JPG' -c:v libx264  -pix_fmt yuv420p out4.mp4
