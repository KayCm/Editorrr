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


@implementation FFMpegCommand

-(void)ffmpeg_commandArray:(NSArray*)cmdArr completionBlock:(void(^)(int result))completionBlock{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        for (NSString* commandStr in cmdArr) {
            
            // 根据 " " 将指令分割为指令数组
            NSArray *argv_array = [commandStr componentsSeparatedByString:(@" ")];
            // 将OC对象转换为对应的C对象
            int argc = (int)argv_array.count;
            char** argv = (char**)malloc(sizeof(char*)*argc);
            for(int i=0; i < argc; i++) {
                argv[i] = (char*)malloc(sizeof(char)*1024);
                strcpy(argv[i],[[argv_array objectAtIndex:i] UTF8String]);
            }
            
            // 传入指令数及指令数组,result==0表示成功
            int result = ffmpeg_main(argc,argv);
            NSLog(@"执行FFmpeg命令：%@，result = %d",commandStr,result);
            
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(0);
        });
        
    });
    
    
    
    
}

-(void)ffmpeg_commandWithCmdArray:(NSArray *)cmdArr WithProgress:(void (^)(float))progressBlock WithCompletionBlock:(void (^)(int))completionBlock{
    
    float i = 1;
    
    
    [cmdArr count];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        
        
        for (NSString* commandStr in cmdArr) {
            
            // 根据 " " 将指令分割为指令数组
            NSArray *argv_array = [commandStr componentsSeparatedByString:(@" ")];
            // 将OC对象转换为对应的C对象
            int argc = (int)argv_array.count;
            char** argv = (char**)malloc(sizeof(char*)*argc);
            for(int i=0; i < argc; i++) {
                argv[i] = (char*)malloc(sizeof(char)*1024);
                strcpy(argv[i],[[argv_array objectAtIndex:i] UTF8String]);
            }
            
            // 传入指令数及指令数组,result==0表示成功
            int result = ffmpeg_main(argc,argv);
            NSLog(@"执行FFmpeg命令：%@，result = %d",commandStr,result);
            
            if (result == 0) {
                progressBlock(i/[cmdArr count]);
            }
            
//            NSLog(@"WithProgress::::%lu",[i/[cmdArr count] floatValue]);
//
//            i++;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(0);
        });
        
    });
    
}

-(void)ffmpeg_command:(NSString *)commandStr completionBlock:(void(^)(int result))completionBlock {
    

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 根据 " " 将指令分割为指令数组
        NSArray *argv_array = [commandStr componentsSeparatedByString:(@" ")];
        // 将OC对象转换为对应的C对象
        int argc = (int)argv_array.count;
        char** argv = (char**)malloc(sizeof(char*)*argc);
        for(int i=0; i < argc; i++) {
            argv[i] = (char*)malloc(sizeof(char)*1024);
            strcpy(argv[i],[[argv_array objectAtIndex:i] UTF8String]);
        }
        
        // 传入指令数及指令数组,result==0表示成功
        int result = ffmpeg_main(argc,argv);
        NSLog(@"执行FFmpeg命令：%@，result = %d",commandStr,result);
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(result);
        });
        
    });
    
}

-(NSString*)getCommand:(int)type withInPut:(NSString*)input withOutPut:(NSString*)output withOtherRes:(NSArray*)otherRes{
    
    NSString *commandStr;
    
    switch (type) {
        case 0:
            //
            commandStr = [NSString stringWithFormat:@"ffmpeg -i %@ -s 1920x1080 -vf setpts=4*PTS %@",
                          input,
                          output];
            break;
        case 1:
            //音视频加速
            commandStr = [NSString stringWithFormat:
                             @"ffmpeg -i %@ -filter_complex [0:v]setpts=0.5*PTS[v];[0:a]atempo=2.0[a] -map [v] -map [a] %@",
                             input,
                             output];
            break;
        case 2:
            //水平反转
            commandStr = [NSString stringWithFormat:@"ffmpeg -i %@ -vf hflip -y %@",input,
                                                   output];
            break;
        case 3:
            //模糊滤镜
            commandStr = [NSString stringWithFormat:@"ffmpeg -i %@ -vf boxblur=20:1:cr=0:ar=0 %@",
                             input,
                             output];
            
            break;
        case 4:
            //视频水印
            commandStr = [NSString stringWithFormat:@"ffmpeg -i %@ -i %@ -filter_complex overlay=0:0 -max_muxing_queue_size 1024 %@",input,otherRes[0],output];
            
            break;
        case 5:
            
            //ffmpeg  -i  intput.avi  -vf  crop=iw/2:ih/2  output.avi
            // crop  crop=w:h:x:y
            commandStr = [NSString stringWithFormat:@"ffmpeg -i %@ -vf crop=iw:iw:0:ih/2-iw/2 %@",input,output];
            
            break;
            
        default:
            break;
    }
    
    
    
    
    return commandStr;
}

//vertical

//blur  //

-(NSString*)ffmpeg_command_ScaleTargetWidthWithInPut:(NSString*)input
                               WithOutPut:(NSString*)output{
    return [NSString stringWithFormat:@"ffmpeg -i %@ -vf crop=iw:iw,scale=iw:iw %@",
            input,
            output];
}

-(NSString*)ffmpeg_command_ScaleTargetHeightWithInPut:(NSString*)input
                               WithOutPut:(NSString*)output{
    return [NSString stringWithFormat:@"ffmpeg -i %@ -vf crop=ih:ih,scale=ih:ih %@",
            input,
            output];
}


-(NSString*)ffmpeg_command_Scale1080WithInPut:(NSString*)input
                               WithOutPut:(NSString*)output{
    return [NSString stringWithFormat:@"ffmpeg -i %@ -vf crop=iw:iw,scale=1080:1080 %@",
            input,
            output];
}

-(NSString*)ffmpeg_command_to16_9:(NSString *)input WithOutPut:(NSString *)output{
    //0.5625
    return [NSString stringWithFormat:@"ffmpeg -i %@ -vf boxblur=20:1:cr=0:ar=0,crop=iw:iw*0.5625,scale=1920:1080 %@",
            input,
            output];
}

-(NSString*)ffmpeg_command_DelVoiceWithInPut:(NSString *)input
                                  WithOutPut:(NSString *)output{
    return [NSString stringWithFormat:@"ffmpeg -i %@ -c copy -an %@",
            input,
            output];
}

-(NSString*)ffmpeg_command_blurWithInPut:(NSString*)input
                              WithOutPut:(NSString*)output{
    return [NSString stringWithFormat:@"ffmpeg -i %@ -vf boxblur=20:1:cr=0:ar=0 %@",
            input,
            output];;
}


-(NSString*)ffmpeg_command_flip_verticalWithInPut:(NSString*)input
                                       WithOutPut:(NSString*)output{
    return [NSString stringWithFormat:@"ffmpeg -i %@ -vf vflip -y %@",input,output];
}


-(NSString*)ffmpeg_command_flip_horizontalWithInPut:(NSString*)input
                                         WithOutPut:(NSString*)output{
    return [NSString stringWithFormat:@"ffmpeg -i %@ -vf hflip -y %@",input,output];
}


-(NSString*)ffmpeg_command_SpeedPlusWithInPut:(NSString *)input WithOutPut:(NSString *)output{
    
    return [NSString stringWithFormat:@"ffmpeg -i %@ -filter_complex [0:v]setpts=0.75*PTS[v];[0:a]atempo=1.25[a] -map [v] -map [a] %@",input,output];
    
}


-(NSString*)ffmpeg_command_SpeedMinsWithInPut:(NSString *)input WithOutPut:(NSString *)output{
    return [NSString stringWithFormat:@"ffmpeg -i %@ -filter_complex [0:v]setpts=1.25*PTS[v];[0:a]atempo=0.8[a] -map [v] -map [a] %@",input,output];;
}

-(NSString*)ffmpeg_command_DelEndLogoWithInPut:(NSString*)input
                                    WithOutPut:(NSString*)output WithTotalTime:(int)time{
    return [NSString stringWithFormat:@"ffmpeg -ss 0 -t %d -accurate_seek -i %@ -codec copy -avoid_negative_ts 1 %@",time,input,output];;
}


-(NSString*)ffmpeg_command_cropWithInPut:(NSString*)input
                              WithOutPut:(NSString*)output
                              WithHeight:(int)height
                               WithWidth:(int)width
                                   WithX:(int)x
                                   WithY:(int)y{
    
    return  [NSString stringWithFormat:@"ffmpeg -i %@ -vf crop=%d:%d:%d:%d %@",input,width,height,x,y,output];;
    
}

-(NSString*)ffmpeg_command_picInPicWithInPut:(NSString *)input WithOutPut:(NSString *)output withPic:(NSString *)pic{
    
    return [NSString stringWithFormat:@"ffmpeg -i %@ -i %@ -filter_complex overlay=W/2-w/2:0 -max_muxing_queue_size 1024 %@",pic,input,output];;
}

-(NSString*)ffmpeg_command_SetLogoInPut:(NSString *)input WithOutPut:(NSString *)output withPic:(NSString *)pic{
    
//    return [NSString stringWithFormat:@"ffmpeg -i %@ -i %@ -filter_complex overlay=W-w-10:H-h-10 -max_muxing_queue_size 1024 %@",input,pic,output];;
    
    return [NSString stringWithFormat:@"ffmpeg -i %@ -i %@ -filter_complex overlay=10:10 -max_muxing_queue_size 1024 %@",input,pic,output];;
}


-(NSString*)ffmpeg_command_SetPicBorderWithInPut:(NSString *)input WithOutPut:(NSString *)output withPic:(NSString *)pic{
    
    return [NSString stringWithFormat:@"ffmpeg -i %@ -i %@ -filter_complex overlay=W/2-w/2:H/2-h/2 -max_muxing_queue_size 1024 %@",pic,input,output];;
    
}


-(NSString*)ffmpeg_command_ReverseWithInPut:(NSString *)input WithOutPut:(NSString *)output{
    return [NSString stringWithFormat:@"ffmpeg -i %@ -vf reverse %@",input,output];
}

-(NSString*)ffmpeg_command_SmartExportWithInPut:(NSString *)input WithOutPut:(NSString *)output{
    return [NSString stringWithFormat:@"ffmpeg -i %@ -filter_complex [0:v]setpts=0.75*PTS[v];[0:a]atempo=1.25[a] -map [v] -map [a] -r 60 %@",input,output];
}

-(NSString*)ffmpeg_command_ScaleWithHeight:(int)height WithWidth:(int)width WithInPut:(NSString *)input WithOutPut:(NSString *)output{
    
    return [NSString stringWithFormat:@"ffmpeg -i %@ -vf scale=%d:%d,setdar=16:9 %@ -hide_banner",input,width,height,output];
    
}

-(NSString*)ffmpeg_command_manyVideo:(NSString *)inputs WithOutPut:(NSString *)output{
    
    // ffmpeg -f concat -i filelist.txt -c copy output.mkv
    
    
    
    
    
    
    return [NSString stringWithFormat:@"ffmpeg -f concat -safe 0 -i %@ -c copy %@",inputs,output];
    
}

//-(void)ffmpeg_command{
//
//    //ffmpeg -i mmm -s 640x480 000
//
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//           char *movie = (char *)[BundlePath(@"2022.mp4") UTF8String];
//           char *outPic = (char *)[DocumentPath(@"9999.mp4") UTF8String];
//
//        char* a[] = {
//            "ffmpeg",
//            "-i",
//            movie,
//            "-s",
//            "640x480",
//            outPic
//        };
//           int result = ffmpeg_main(sizeof(a)/sizeof(*a), a);
//
//        NSLog(@"~~~~~~~~~~~~~~~~~~~~~~~~~%d",result);
//
//       });
//}

@end
