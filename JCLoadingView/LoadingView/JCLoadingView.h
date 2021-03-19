//
//  JCLoadingView.h
//  JCLoadingView
//
//  Created by JuneCheng on 2021/3/18.
//

#import <UIKit/UIKit.h>

typedef void (^ReloadButtonBlock)(id _Nullable sender);

NS_ASSUME_NONNULL_BEGIN

@interface JCLoadingView : UIView

@property (nonatomic, strong) UIView *view_net_load;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;
@property (nonatomic, strong) UILabel *lab_tint;

@property (nonatomic, strong) UIView *view_net_error;
@property (nonatomic, strong) UIImageView *img_error;
@property (nonatomic, strong) UILabel *lab_error;
@property (nonatomic, strong) UIButton *btn_reload;

@property (nonatomic, copy) ReloadButtonBlock reloadBlock;

@end

NS_ASSUME_NONNULL_END
