# Audio & Video

## HTML5
http://www.quirksmode.org/html5/tests/video.html
https://developer.mozilla.org/en-US/docs/HTML/Supported_media_formats
[<audio>](http://www.w3schools.com/tags/tryit.asp?filename=tryhtml5_audio)

read!
http://docs.sublimevideo.net/encode-videos-for-the-web
http://docs.sublimevideo.net/write-proper-video-elements

## Paperclip Processors
  [Poster Image](http://docs.sublimevideo.net/create-poster-frame)
  [Image Geometry](http://www.imagemagick.org/script/command-line-processing.php#geometry)
  
  read!
  http://mdeering.com/posts/018-paperclip-processors-doing-so-much-more-with-your-attachment
  http://jimneath.org/2008/06/03/converting-videos-with-rails-converting-the-video.html
  
  [Conditional Processor](http://stackoverflow.com/questions/8590822/apply-processor-with-paperclip-if-condition-its-true)
  [Conditional Styles](http://stackoverflow.com/questions/9086011/conditionally-applying-styles-to-paperclip-attachments-in-rails-3-1)
  (basic takeaway... use lambda's and ``attachment.instance`` to dynamically pass options)
  
  [Chainable Processors](https://gist.github.com/emcmanus/2689440) - Though processors appear chained by default, this gives you more fine-grained control of the chain.
  
  S3 Permissions for a single
  ```
    :s3_permissions => {
      :original => :private
    }

    s3_headers: A hash of headers or a Proc. You may specify a hash such as => 1.year.from_now.httpdate. If you use a Proc, headers are determined at runtime. Paperclip will call that Proc with attachment as the only argument. Can be defined both globally and within a style-specific hash.
  ```

## AWS
  http://explainshell.com/
  
  it looks like uploads are auto streamed by the gem, but if you need more info.  You can also configure the 'large' threshold.
  http://stackoverflow.com/questions/9589664/stream-uploading-large-files-using-aws-sdk
  - Cloudfront should ONLY have access to the prod directory

## FFMPEG
  ``brew install ffmpeg --with-libvpx --with-libvorbis``
  [Sublime Recommendations](http://docs.sublimevideo.net/encode-videos-for-the-web)
  [ffmpeg wrapper gem](https://github.com/streamio/streamio-ffmpeg)

### Streaming (qt-faststart)
  [ffmpeg w/ faststart](http://ffmpeg.org/trac/ffmpeg/wiki/MacOSXCompilationGuide#CompileFFmpeg)
  [ffmpeg -flag](http://stackoverflow.com/questions/8061798/post-processing-in-ffmpeg-to-move-moov-atom-in-mp4-files-qt-faststart#answer-14706197)

## Audio
  http://stackoverflow.com/questions/5887311/ffmpeg-1-image-1-audio-file-1-video
  [Normalize Audio](https://github.com/zmillman/paperclip-normalize) [experimental]
  [What Bitrate](http://crave.cnet.co.uk/digitalmusic/which-mp3-bit-rate-should-i-use-49290353/)
    - 24k   agressive speech (mobile only - not recommended)
    - 48k   podcast
    - 64k   speech
    - 96k   happy medium?
    - 128k  radio
    - 160k  CD
  

## Convert
http://xkcd.com/927/

Video-to-Audio: ``ffmpeg -i Sample.avi -vn -ar 44100 -ac 2 -ab 128k -f mp3 Sample.mp3``  [explain](http://linuxpoison.blogspot.com/2010/04/how-to-extract-audio-from-video-file.html)
Audio-to-Video: ``ffmpeg -i Sample.jpg -i Sample.mp3 -vcodec libx264 result2.mp4``
Audio-Downsample ``ffmpeg -i long_sample.mp3 -ar 44100 -ac 2 -ab 64k -f mp3 long_sample_smaller.mp3``