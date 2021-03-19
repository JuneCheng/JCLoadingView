//
//  UIView+LoadingView.h
//  JCLoadingView
//
//  Created by JuneCheng on 2021/3/18.
//

#import <UIKit/UIKit.h>
#import "JCLoadingView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LoadingView)

@property (strong, nonatomic) JCLoadingView *loadingView;

- (void)showLoadingView;
- (void)showLoadingView:(NSString * _Nullable)msg;
- (void)hideLoadingView;
- (void)loadError:(NSString *)errorMsg reloadBlock:(void (^)(id sender))block;
- (void)noData:(void (^ _Nullable)(id sender))block;


/** ********************上下两块方法最好不要混用******************** */

/**
 * 如果没有加载进程，可直接通过以下方法给任意view覆盖一层空页面
 *
 * 不建议在viewDidLoad中调用，此时view的frame不是最终的尺寸
 * 或请使用以下方式，延时一会再调用
 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), main_queue, ^{
 [self.tableview addEmptyView];
 });
 */

- (void)addEmptyView:(NSString *)errorMsg image:(UIImage * _Nullable)image reloadBlock:(void (^ _Nullable)(id sender))block;
- (void)addEmptyView:(void (^ _Nullable)(id sender))block;
- (void)addEmptyView;

- (void)removeEmptyView;

@end

NS_ASSUME_NONNULL_END
