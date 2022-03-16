//
//  VideoEditViewController.h
//  Editor
//
//  Created by Kai on 2022/2/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoEditViewController : UIViewController

@property(nonatomic,strong)NSString *url;
@property(nonatomic)BOOL videoHorizontal;
@property(nonatomic,strong)UIImage *videoCover;

@end

NS_ASSUME_NONNULL_END
