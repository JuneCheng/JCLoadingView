//
//  JCLoadingView.m
//  JCLoadingView
//
//  Created by JuneCheng on 2021/3/18.
//

#import "JCLoadingView.h"
#import <Masonry/Masonry.h>

#define HEXColor(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]

#define kSpace 20.f

@implementation JCLoadingView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUI];
    }
    return self;
}

- (BOOL)willDealloc {
    return NO;
}

- (void)setUI {

    /************* 创建 加载view *************/
    _view_net_load = [[UIView alloc] initWithFrame:self.frame];
    _view_net_load.backgroundColor = [UIColor clearColor];
    [self addSubview:_view_net_load];
    
    _lab_tint = [[UILabel alloc] init];
    _lab_tint.text = @"正在加载，请稍后";
    _lab_tint.textColor = [UIColor lightGrayColor];
    _lab_tint.font = [UIFont systemFontOfSize:16];
    _lab_tint.textAlignment = NSTextAlignmentCenter;
    [_view_net_load addSubview:_lab_tint];
    [_lab_tint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake([[UIScreen mainScreen] bounds].size.width, 20));
        make.centerX.mas_equalTo(self.view_net_load);
        make.centerY.mas_equalTo(self.view_net_load);
    }];
    
    _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [_indicator startAnimating];
    [_view_net_load addSubview:_indicator];
    [_indicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view_net_load);
        make.bottom.mas_equalTo(self.lab_tint.mas_top).offset(-kSpace);
    }];
    
    /************* 创建 加载失败view *************/
    _view_net_error = [[UIView alloc] initWithFrame:self.frame];
    _view_net_error.backgroundColor = [UIColor clearColor];
    [self addSubview:_view_net_error];
    
    _lab_error = [[UILabel alloc] init];
    _lab_error.text = @"未检测到网络连接，请检查网络设置";
    _lab_error.textColor = [UIColor lightGrayColor];
    _lab_error.font = [UIFont systemFontOfSize:16];
    _lab_error.textAlignment = NSTextAlignmentCenter;
    [_view_net_error addSubview:_lab_error];
    [_lab_error mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake([[UIScreen mainScreen] bounds].size.width, 20));
        make.centerX.mas_equalTo(self.view_net_error);
        make.centerY.mas_equalTo(self.view_net_error);
    }];
    
    _img_error = [[UIImageView alloc] init];
    _img_error.image = [UIImage imageNamed:@"ic_nodata"];
    [_view_net_error addSubview:_img_error];
    [_img_error mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.centerX.mas_equalTo(self.view_net_error);
        make.bottom.mas_equalTo(self.lab_error.mas_top).offset(-kSpace);
    }];
    
    _btn_reload = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btn_reload setBackgroundColor:HEXColor(0xff2c4a)];
    [_btn_reload setTitle:@"刷新重试" forState:UIControlStateNormal];
    _btn_reload.titleLabel.font = [UIFont systemFontOfSize:16];
    _btn_reload.layer.cornerRadius = 18;
    [_btn_reload addTarget:self action:@selector(reloadButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_view_net_error addSubview:_btn_reload];
    [_btn_reload mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 36));
        make.centerX.mas_equalTo(self.view_net_error);
        make.top.mas_equalTo(self.lab_error.mas_bottom).offset(kSpace);
    }];
    
    _view_net_error.hidden = YES;
    
//    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
//    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        if (status <= 0) {
//            _view_net_error.hidden = NO;
//        }
//    }];
}

- (void)reloadButtonClick:(id)sender {
    if (self.reloadBlock) {
        [self removeFromSuperview];
        self.reloadBlock(sender);
    }
}

#pragma mark block相关

- (void)setReloadBlock:(ReloadButtonBlock)reloadBlock {
    _reloadBlock = reloadBlock;
    if (reloadBlock) {
        _btn_reload.hidden = NO;
    } else {
        _btn_reload.hidden = YES;
    }
}

@end
