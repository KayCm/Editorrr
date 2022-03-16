//
//  GetVideoViewController.h
//  Editor
//
//  Created by Kai on 2022/3/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GetVideoViewController : UIViewController

typedef void (^BlockDict)(NSDictionary *value);

@property (copy, nonatomic) BlockDict valueBlock;

@end

NS_ASSUME_NONNULL_END
