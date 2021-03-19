# JCLoadingView
进程加载，根据请求结果进行不同处理（显示加载数据/显示无数据视图/显示失败视图）

# 效果图
<img src="https://user-images.githubusercontent.com/36223198/111728492-eeaa8280-88a7-11eb-80c1-b468cdd99c76.png" width="250" />  <img src="https://user-images.githubusercontent.com/36223198/111728497-f0744600-88a7-11eb-8dd4-999712e9e173.png" width="250" />  <img src="https://user-images.githubusercontent.com/36223198/111728499-f23e0980-88a7-11eb-8a2a-b001bff7755e.png" width="250" />

# 使用方法
```
// 1.加载数据，加载成功后隐藏Loading
[self.view showLoadingView:@"正在加载..."];
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    // 1.如果没有数据，显示
    [self.view noData:nil];
    // 2.如果有数据
//  [self.view hideLoadingView];
    // 3.如果网络出错
//  __weak typeof(self) weakSelf = self;
//  [self.view loadError:@"网络出错啦" reloadBlock:^(id  _Nonnull sender) {
//       [weakSelf getNetData];
//  }];
});
```
