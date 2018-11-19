//
//  ZPMShareManager.m
//  shareDemo
//
//  Created by 吴桐 on 2018/11/19.
//  Copyright © 2018年 cowlevel. All rights reserved.
//

#import "ZPMShareManager.h"
#import "ZPMShareConfirmAlertView.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDK/NSMutableDictionary+SSDKShare.h>
#import <ShareSDKUI/ShareSDKUI.h>

@implementation ZPMShareManager

- (void)showShareConfirm{
    [ZPMShareConfirmAlertView showShareConfirm:^(id  _Nonnull sender) {
       
    } andShareHandle:^(id  _Nonnull sender) {
        NSString *platform = (NSString *)sender;
        if ([platform isEqualToString:@"1"]) {
            [self share:SSDKPlatformSubTypeWechatSession];
        }
        else if ([platform isEqualToString:@"2"]) {
            [self share:SSDKPlatformSubTypeQQFriend];
        }
        else if ([platform isEqualToString:@"3"]) {
            [self share:SSDKPlatformTypeSinaWeibo];
        }
    }];
}

- (void)share:(SSDKPlatformType)platformType{
    //进行分享
    [ShareSDK share:platformType
         parameters:self.shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         switch (state) {
             case SSDKResponseStateSuccess:
             {
                 NSLog(@"分享成功");
                 break;
             }
             case SSDKResponseStateFail:
             {
                 NSLog(@"分享失败");
                 break;
             }
             case SSDKResponseStateCancel:
             {
                 NSLog(@"分享取消");
                 break;
             }
             default:
                 break;
         }
     }];
}

- (void)showOriginSDKConfirm{
    
    NSArray *items = nil;
    items = @[
              @(SSDKPlatformTypeWechat),
              @(SSDKPlatformTypeQQ),
              @(SSDKPlatformTypeSinaWeibo)
              ];
    SSUIShareSheetConfiguration *config = [[SSUIShareSheetConfiguration alloc] init];
    //    config.style = SSUIActionSheetStyleSimple;
    //    config.menuBackgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    [ShareSDK showShareActionSheet:[UIApplication sharedApplication].keyWindow
                       customItems:items
                       shareParams:self.shareParams
                sheetConfiguration:config
                    onStateChanged:^(SSDKResponseState state,
                                     SSDKPlatformType platformType,
                                     NSDictionary *userData,
                                     SSDKContentEntity *contentEntity,
                                     NSError *error,
                                     BOOL end)
     {
         
         switch (state) {
                 
             case SSDKResponseStateBegin:
             {
                 //设置UI等操作
                 break;
             }
             case SSDKResponseStateSuccess:
             {
                 
                 break;
             }
             case SSDKResponseStateFail:
             {
                 
                 break;
             }
             case SSDKResponseStateCancel:
             {
                 
                 break;
             }
             default:
                 break;
         }
     }];
}

- (NSMutableDictionary *)shareParams{
    if (!_shareParams) {
        _shareParams = [[NSMutableDictionary alloc]init];
        [_shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:@[[UIImage imageNamed:@"分享的图片"]]
                                            url:[NSURL URLWithString:@"https://www.mob.com"]
                                          title:@"分享标题"
                                           type:SSDKContentTypeAuto];
    }
    return _shareParams;
}
@end
