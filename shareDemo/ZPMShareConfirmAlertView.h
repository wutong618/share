//
//  ZPMShareConfirmAlertView.h
//  zhaopin
//
//  Created by 吴桐 on 2018/10/12.
//  Copyright © 2018 zhaopin.com. All rights reserved.
//
#define BlockCallWithOneArg(block,arg)  if(block){block(arg);}

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^EventHandler)(id sender);

@interface ZPMShareConfirmAlertView : UIView
@property(strong,nonatomic)EventHandler closeHandle;
@property(strong,nonatomic)EventHandler shareToPlatform;

+ (void)showShareConfirm:(EventHandler) ch
          andShareHandle:(EventHandler) sh;
@end

NS_ASSUME_NONNULL_END
