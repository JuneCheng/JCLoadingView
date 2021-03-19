//
//  ViewController.m
//  JCLoadingView
//
//  Created by JuneCheng on 2021/3/18.
//

#import "ViewController.h"
#import "UIView+LoadingView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    self.navigationItem.title = @"JCLoadingView";
    
    [self getNetData];
}

/** 获取网络数据 */
- (void)getNetData {
    // 1.加载数据，加载成功后隐藏Loading
    [self.view showLoadingView:@"正在加载..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 1.如果没有数据，显示
        [self.view noData:nil];
        // 2.如果有数据
//        [self.view hideLoadingView];
        // 3.如果网络出错
//        __weak typeof(self) weakSelf = self;
//        [self.view loadError:@"网络出错啦" reloadBlock:^(id  _Nonnull sender) {
//            [weakSelf getNetData];
//        }];
    });
}

- (void)dealloc {
    NSLog(@"----------");
}

@end
