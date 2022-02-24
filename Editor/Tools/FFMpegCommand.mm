//
//  FFMpegCommand.m
//  Editor
//
//  Created by Kai on 2022/2/25.
//

#import "FFMpegCommand.h"

extern "C" {
    #include "libavformat/avformat.h"
    #include "libavutil/opt.h"
    #include "libavcodec/avcodec.h"
    #include "libswscale/swscale.h"
    #include "ffmpeg.h"
}


#define DocumentDir [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define BundlePath(res) [[NSBundle mainBundle] pathForResource:res ofType:nil]
#define DocumentPath(res) [DocumentDir stringByAppendingPathComponent:res]


@implementation FFMpegCommand

-(void)ffmpeg_command{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
           char *movie = (char *)[BundlePath(@"2022.mp4") UTF8String];
           char *outPic = (char *)[DocumentPath(@"8888.mp4") UTF8String];

        char* a[] = {
            "ffmpeg",
            "-i",
            movie,
            "-s",
            "640x480",
            outPic
        };
           int result = ffmpeg_main(sizeof(a)/sizeof(*a), a);

        NSLog(@"~~~~~~~~~~~~~~~~~~~~~~~~~%d",result);
        
       });
}

@end
