//
//  ZPMShareManager.h
//  shareDemo
//
//  Created by 吴桐 on 2018/11/19.
//  Copyright © 2018年 cowlevel. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZPMShareManager : NSObject
@property(strong,nonatomic)NSMutableDictionary *shareParams;
- (void)showShareConfirm;

- (void)showOriginSDKConfirm;
@end

NS_ASSUME_NONNULL_END
