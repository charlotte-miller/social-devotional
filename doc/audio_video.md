# Audio & Video

## HTML5
http://www.quirksmode.org/html5/tests/video.html
https://developer.mozilla.org/en-US/docs/HTML/Supported_media_formats

read!
http://docs.sublimevideo.net/encode-videos-for-the-web
http://docs.sublimevideo.net/write-proper-video-elements

## Paperclip Processors
  [Poster Image](http://docs.sublimevideo.net/create-poster-frame)
  [Image Geometry](http://www.imagemagick.org/script/command-line-processing.php#geometry)
  
  read!
  http://mdeering.com/posts/018-paperclip-processors-doing-so-much-more-with-your-attachment
  http://jimneath.org/2008/06/03/converting-videos-with-rails-converting-the-video.html
  
  
  S3 Permissions and reduced redundancy in paperclip config
  ```
    s3_storage_class: :reduced_redundancy

    :s3_permissions => :public_read

    Or something more specific like:

    :s3_permissions => {
      :original => :private
    }

    s3_headers: A hash of headers or a Proc. You may specify a hash such as => 1.year.from_now.httpdate. If you use a Proc, headers are determined at runtime. Paperclip will call that Proc with attachment as the only argument. Can be defined both globally and within a style-specific hash.
  ```

## AWS
  it looks like uploads are auto streamed by the gem, but if you need more info.  You can also configure the 'large' threshold.
  http://stackoverflow.com/questions/9589664/stream-uploading-large-files-using-aws-sdk

## FFMPEG
  ``brew install ffmpeg --with-libvpx --with-libvorbis``
  Temporarily missing: ``brew install libvpx``
  [ffmpeg wrapper gem](https://github.com/streamio/streamio-ffmpeg)

## Audio
  http://stackoverflow.com/questions/5887311/ffmpeg-1-image-1-audio-file-1-video
  [Normalize Audio](https://github.com/zmillman/paperclip-normalize) [experimental]