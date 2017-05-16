# How to create vedios from images
[How](http://hamelot.io/visualization/using-ffmpeg-to-convert-a-set-of-images-into-a-video/)

ffmpeg -r 15 -f image2 -s 1920x1080 -start_number 185 -i  G0033%03d.JPG -vframes 1000 -vcodec libx264 -crf 25 -pix_fmt yuv420p test.mp4
