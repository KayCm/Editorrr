//
//  FFMpegCommand.h
//  Editor
//
//  Created by Kai on 2022/2/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FFMpegCommand : NSObject

//-(void)ffmpeg_command;

-(void)ffmpeg_command:(NSString *)commandStr completionBlock:(void(^)(int result))completionBlock;

-(NSString*)getCommand:(int)type withInPut:(NSString*)input withOutPut:(NSString*)output withOtherRes:(NSArray*)otherRes;

-(void)ffmpeg_commandArray:(NSArray*)cmdArr completionBlock:(void(^)(int result))completionBlock;

-(void)ffmpeg_commandWithCmdArray:(NSArray*)cmdArr
                     WithProgress:(void(^)(float result))progressBlock
              WithCompletionBlock:(void(^)(int result))completionBlock;



/// 视频裁剪
/// @param input 输入
/// @param output 输出
-(NSString*)ffmpeg_command_ScaleTargetWidthWithInPut:(NSString*)input
                                          WithOutPut:(NSString*)output;

/// 视频裁剪
/// @param input 输入
/// @param output 输出
-(NSString*)ffmpeg_command_ScaleTargetHeightWithInPut:(NSString*)input
                                          WithOutPut:(NSString*)output;

-(NSString*)ffmpeg_command_Scale1080WithInPut:(NSString*)input
                                   WithOutPut:(NSString*)output;

-(NSString*)ffmpeg_command_to16_9:(NSString *)input
                       WithOutPut:(NSString *)output;

/// 去除声音
/// @param input 输入
/// @param output 输出
-(NSString*)ffmpeg_command_DelVoiceWithInPut:(NSString*)input
                                  WithOutPut:(NSString*)output;

/// 视频模糊
/// @param input 输入
/// @param output 输出
-(NSString*)ffmpeg_command_blurWithInPut:(NSString*)input
                              WithOutPut:(NSString*)output;


/// 垂直翻转
/// @param input 输入
/// @param output 输出
-(NSString*)ffmpeg_command_flip_verticalWithInPut:(NSString*)input
                                       WithOutPut:(NSString*)output;

/// 水平翻转
/// @param input 输入
/// @param output 输出
-(NSString*)ffmpeg_command_flip_horizontalWithInPut:(NSString*)input
                                         WithOutPut:(NSString*)output;

-(NSString*)ffmpeg_command_SpeedPlusWithInPut:(NSString*)input
                                   WithOutPut:(NSString*)output;


-(NSString*)ffmpeg_command_SpeedMinsWithInPut:(NSString*)input
                                   WithOutPut:(NSString*)output;

-(NSString*)ffmpeg_command_DelEndLogoWithInPut:(NSString*)input
                                    WithOutPut:(NSString*)output
                                 WithTotalTime:(int)time;


/// 视频裁剪
/// @param input 输入
/// @param output 输出
/// @param height 高
/// @param width 宽
/// @param x x
/// @param y y
-(NSString*)ffmpeg_command_cropWithInPut:(NSString*)input
                              WithOutPut:(NSString*)output
                              WithHeight:(int)height
                               WithWidth:(int)width
                                   WithX:(int)x
                                   WithY:(int)y;

-(NSString*)ffmpeg_command_picInPicWithInPut:(NSString*)input
                                  WithOutPut:(NSString*)output
                                     withPic:(NSString*)pic;


-(NSString*)ffmpeg_command_SetLogoInPut:(NSString *)input WithOutPut:(NSString *)output withPic:(NSString *)pic;

-(NSString*)ffmpeg_command_SetPicBorderWithInPut:(NSString *)input
                                      WithOutPut:(NSString *)output
                                         withPic:(NSString *)pic;

-(NSString*)ffmpeg_command_SmartExportWithInPut:(NSString *)input WithOutPut:(NSString *)output;

-(NSString*)ffmpeg_command_ReverseWithInPut:(NSString *)input WithOutPut:(NSString *)output;

-(NSString*)ffmpeg_command_ScaleWithHeight:(int)height
                                 WithWidth:(int)width
                                 WithInPut:(NSString *)input
                                WithOutPut:(NSString *)output;

-(NSString*)ffmpeg_command_manyVideo:(NSString *)inputs WithOutPut:(NSString *)output;


@end

NS_ASSUME_NONNULL_END
