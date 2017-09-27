//
//  ZTLottieHeaderRefresh.m
//  RefreshDemo
//
//  Created by apple on 2017/9/26.
//  Copyright © 2017年 shang. All rights reserved.
//

#import "ZTLottieHeaderRefresh.h"
#import <MJRefresh/MJRefresh.h>
#import <Lottie/Lottie.h>
@interface ZTLottieHeaderRefresh()
@property (nonatomic,strong) LOTAnimationView *lottieView;
@end


@implementation ZTLottieHeaderRefresh

- (LOTAnimationView *)lottelView{
    if (!_lottieView) {
        _lottieView = [LOTAnimationView animationNamed:self.lottieFilename];
        _lottieView.contentMode = UIViewContentModeScaleAspectFill;
        _lottieView.bounds = CGRectMake(0, 0, 100, 100);
        _lottieView.loopAnimation = YES;
    }
    return _lottieView;
}

#pragma mark - 重写父类的方法
- (void)prepare
{
    [super prepare];
    if (self.lottieFilename.length == 0) {
        self.lottieFilename = @"loader_4";
    }
    [self addSubview:self.lottelView];
   
}
- (void)setLottieFilename:(NSString *)lottieFilename {
    _lottieFilename = lottieFilename;
    [self.lottieView removeFromSuperview];
    self.lottieView = nil;
    [self prepare];
}

- (void)placeSubviews
{
    [super placeSubviews];
    self.lottelView.center = CGPointMake(self.mj_w*0.5, self.mj_h *0.5);
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    // 根据状态做事情
    [super setState:state];
    if (state == MJRefreshStateIdle) { //刷新完成
        [self stopAnimation];
    } else if (state == MJRefreshStatePulling) {
        self.lottelView.animationProgress = 1;
    } else if (state == MJRefreshStateRefreshing) {
        [self startAnimation];
    }
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
    if (!self.lottelView.isAnimationPlaying) {
        if (self.lottieView.animationProgress >= 0 && self.lottieView.animationProgress <=0.94) {
            self.lottelView.animationProgress = self.pullingPercent;
        }
    
    }
}

- (void)startAnimation{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.lottelView play];
    });
    
}

- (void)stopAnimation {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.lottelView stop];
    });
}
@end
