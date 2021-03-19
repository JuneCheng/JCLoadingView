//
//  UIView+LoadingView.m
//  JCLoadingView
//
//  Created by JuneCheng on 2021/3/18.
//

#import "UIView+LoadingView.h"
#import <objc/runtime.h>

static char LoadingViewKey;

@implementation UIView (LoadingView)

- (void)setLoadingView:(JCLoadingView *)blankPageView {
    [self willChangeValueForKey:@"LoadingViewKey"];
    objc_setAssociatedObject(self, &LoadingViewKey,
                             blankPageView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"LoadingViewKey"];
}

- (JCLoadingView *)loadingView {
    return objc_getAssociatedObject(self, &LoadingViewKey);
}





- (void)showLoadingView {
    [self showLoadingView:nil];
}

- (void)showLoadingView:(NSString * _Nullable)msg {
    self.loadingView = [[JCLoadingView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    
    if (msg.length > 0) {
        self.loadingView.lab_tint.text = msg;
    }
    [self addSubview:self.loadingView];
}

- (void)hideLoadingView {
    if (self.loadingView) {
        self.loadingView.hidden = YES;
        [self.loadingView removeFromSuperview];
    }
}

- (void)loadError:(void (^)(id sender))block {
    self.loadingView.view_net_load.hidden = YES;
    self.loadingView.view_net_error.hidden = NO;
    [self.loadingView setReloadBlock:block];
}

- (void)loadError:(NSString *)errorMsg reloadBlock:(void (^)(id sender))block {
    self.loadingView.lab_error.text = errorMsg;
    self.loadingView.view_net_load.hidden = YES;
    self.loadingView.view_net_error.hidden = NO;
    [self.loadingView setReloadBlock:block];
}

- (void)noData:(void (^ _Nullable)(id sender))block {
    [self loadError:@"当前没有数据" reloadBlock:block];
}




#pragma mark 添加空白视图

- (void)addEmptyView:(NSString *)errorMsg image:(UIImage * _Nullable)image reloadBlock:(void (^ _Nullable)(id sender) )block {
    if (block) {
        [self initLoadingView:block];
    }
    if (image) {
        self.loadingView.img_error.image = image;
    }
    self.loadingView.lab_error.text = errorMsg;
}

- (void)addEmptyView:(void (^ _Nullable)(id sender))block {
    [self addEmptyView:@"当前没有数据" image:nil reloadBlock:block];
}

- (void)addEmptyView {
    [self addEmptyView:@"当前没有数据" image:nil reloadBlock:nil];
}

- (void)removeEmptyView {
    [self hideLoadingView];
}

- (void)initLoadingView:(void (^)(id sender))block {
    [self hideLoadingView];// 先移除，避免出现多个
    [self showLoadingView];
    
    self.loadingView.view_net_load.hidden = YES;
    self.loadingView.view_net_error.hidden = NO;
    [self.loadingView setReloadBlock:block];
}

@end
