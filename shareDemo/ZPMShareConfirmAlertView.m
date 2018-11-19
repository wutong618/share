//
//  ZPMShareConfirmAlertView.m
//  zhaopin
//
//  Created by 吴桐 on 2018/10/12.
//  Copyright © 2018 zhaopin.com. All rights reserved.
//

#import "ZPMShareConfirmAlertView.h"
//#import "SDK/ShareSDK/Support/PlatformSDK/WeChatSDK/WXApi.h"

@interface ZPMShareConfirmAlertView()
@property(strong,nonatomic)UIView *backView;
@property(strong,nonatomic)UIView *shareBackView;
@property(strong,nonatomic)UILabel *titleLabel;
@property(strong,nonatomic)NSMutableArray *array;
@property(strong,nonatomic)UIButton *cancelBtn;

@end
@implementation ZPMShareConfirmAlertView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        [self setUI];
    }
    return self;
}

#pragma mark - 设置UI
- (void)setUI{
    [self addSubview:self.backView];
    [self.backView addSubview:self.shareBackView];
    [self.shareBackView addSubview:self.titleLabel];
    [self.shareBackView addSubview:self.cancelBtn];
    
    [self judgeIsInsert];
    for (int i = 0; i < self.array.count; i ++) {
        UIButton *btn = (UIButton *)self.array[i];
        if (![btn isKindOfClass:[UIButton class]]) {
            return;
        }
        btn.frame = CGRectMake( i*(32 + 64) + 32, 48, 64, 64);
        [self.shareBackView addSubview:btn];
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        self.shareBackView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 180, [UIScreen mainScreen].bounds.size.width, 180);
    }];
}

#pragma mark - 自定义方法
+ (void)showShareConfirm:(EventHandler) ch
          andShareHandle:(EventHandler) sh{
    ZPMShareConfirmAlertView *scaView = [[ZPMShareConfirmAlertView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    scaView.shareToPlatform = sh;
    scaView.closeHandle = sh;
    [[UIApplication sharedApplication].keyWindow addSubview:scaView];
}

- (void)judgeIsInsert{
    // 是否安装微信
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
        UIButton *wechatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [wechatBtn setImage:[UIImage imageNamed:@"icon_微信"] forState:UIControlStateNormal];
        [wechatBtn addTarget:self action:@selector(shareWechat) forControlEvents:UIControlEventTouchUpInside];
        [self.array addObject:wechatBtn];
    }
    // 是否安装QQ
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqqapi://"]]) {
        UIButton *qqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [qqBtn setImage:[UIImage imageNamed:@"icon_QQ"] forState:UIControlStateNormal];
        [qqBtn addTarget:self action:@selector(shareQQ) forControlEvents:UIControlEventTouchUpInside];
        [self.array addObject:qqBtn];
    }
    // 是否安装微博
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weibosdk://"]]) {
        UIButton *wbBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [wbBtn setImage:[UIImage imageNamed:@"icon_微博"] forState:UIControlStateNormal];
        [wbBtn addTarget:self action:@selector(shareWeibo) forControlEvents:UIControlEventTouchUpInside];
        [self.array addObject:wbBtn];
    }
    
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]
        &&![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqqapi://"]]
        &&![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weibosdk://"]]) {
        UILabel *Label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
        Label.text = @"该设备没有可分享的客户端";
        [Label sizeToFit];
        Label.center = CGPointMake(self.shareBackView.center.x, 80);
        Label.textColor = [UIColor blackColor];
        [self.shareBackView addSubview:Label];
    }
}

- (void)shareWechat{
    NSLog(@"分享微信");
    BlockCallWithOneArg(self.shareToPlatform, @"1");
}

- (void)shareQQ{
    NSLog(@"分享QQ");
    BlockCallWithOneArg(self.shareToPlatform, @"2");
}

- (void)shareWeibo{
    NSLog(@"分享微博");
    BlockCallWithOneArg(self.shareToPlatform, @"3");
}

- (void)closeView{
    [UIView animateWithDuration:0.2 animations:^{
        self.shareBackView.frame = CGRectMake(0,[UIScreen mainScreen].bounds.size.height , [UIScreen mainScreen].bounds.size.width, 180);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - 懒加载
- (NSMutableArray *)array{
    if (!_array) {
        _array = [[NSMutableArray alloc]init];
    }
    return _array;
}

- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    }
    return _backView;
}

- (UIView *)shareBackView{
    if (!_shareBackView) {
        _shareBackView = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 180)];
        _shareBackView.backgroundColor = [UIColor whiteColor];
    }
    return _shareBackView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 50)/2, 16, 50, 20)];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.text = @"分享";
    }
    return _titleLabel;
}

- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.backgroundColor = [UIColor whiteColor];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _cancelBtn.frame = CGRectMake(0, self.shareBackView.frame.size.height - 40, [UIScreen mainScreen].bounds.size.width, 40);
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (void)dealloc{
    NSLog(@"dealloc succ");
}
         
@end
