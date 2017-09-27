//
//  ZTHeaderRefresh.m
//  RefreshDemo
//
//  Created by apple on 2017/6/7.
//  Copyright © 2017年 shang. All rights reserved.
//

#import "ZTHeaderRefresh.h"

@interface ZTHeaderRefresh ()

@property (nonatomic, strong) UIView *animatedView;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) CAEmitterLayer *refreshingLayer;

@end

@implementation ZTHeaderRefresh
#pragma mark - 懒加载子控件
- (UIView *)animatedView {
    if (!_animatedView) {
        _animatedView = [[UIView alloc]init];
        _animatedView.backgroundColor = [UIColor clearColor];
    }
    return _animatedView;
}

- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;
        _shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        _shapeLayer.lineWidth = 2.5;
        _shapeLayer.lineCap = kCALineCapRound;
    }
    return _shapeLayer;
}

- (CAEmitterLayer *)refreshingLayer {
    if (!_refreshingLayer) {
        _refreshingLayer = [CAEmitterLayer layer];
        _refreshingLayer.renderMode = kCAEmitterLayerAdditive;
        _refreshingLayer.emitterShape = kCAEmitterLayerRectangle;
        _refreshingLayer.emitterCells = @[[self getEmitterCell]];
    }
    return _refreshingLayer;
}
//cell
- (CAEmitterCell *)getEmitterCell
{
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    CGFloat colorChangeValue  = 1;
    cell.blueRange = colorChangeValue;
    cell.redRange =  colorChangeValue;
    cell.greenRange =  colorChangeValue;
    
    cell.birthRate       = 5;
    cell.speed           = 5.f;
    cell.velocity        = -20.f;
    cell.velocityRange   = -40.f;
    cell.yAcceleration   = -20.f;
    cell.emissionRange   = M_PI;
    cell.contents =  (__bridge id )([UIImage imageNamed:@"bubble"].CGImage);
    cell.lifetime        = 15;
    cell.lifetimeRange   = 20;
    cell.scale           = 0.1;
    cell.scaleRange      = 0.3;
    return cell;
}

#pragma mark - 公共方法
- (void)setTintColor:(UIColor *)tintColor {
    _tintColor = tintColor;
    self.shapeLayer.strokeColor = tintColor.CGColor;
}

#pragma mark - 重写父类的方法
- (void)prepare
{
    [super prepare];
    self.clipsToBounds = YES;
    if (self.tintColor == nil) {
        self.tintColor = [UIColor orangeColor];
    }
}

- (void)placeSubviews
{
    [super placeSubviews];
    self.animatedView.bounds = CGRectMake(0, 0, 50, 50);
    self.animatedView.center = CGPointMake(self.mj_w*0.5, self.mj_h *0.5);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.animatedView.bounds];
    if (self.path != nil && !self.path.isEmpty) {
        path = self.path;
    }else { //画笑脸
        [path moveToPoint:CGPointMake(15, 20)];
        [path addArcWithCenter:CGPointMake(15, 20) radius:2 startAngle:0 endAngle:2 * M_PI clockwise:YES];
        [path moveToPoint:CGPointMake(35, 20)];
        [path addArcWithCenter:CGPointMake(35, 20) radius:2 startAngle:0 endAngle:2 * M_PI clockwise:YES];
        [path moveToPoint:CGPointMake(15, 30)];
        [path addQuadCurveToPoint:CGPointMake(35, 30) controlPoint:CGPointMake(25, 40)];
    }
    self.shapeLayer.path = path.CGPath;
    
    self.refreshingLayer.frame = CGRectMake(0, self.mj_h, self.mj_w, self.mj_h);
    self.refreshingLayer.emitterPosition = CGPointMake(self.animatedView.bounds.size.width *0.5, 0);
    _refreshingLayer.emitterSize = CGSizeMake(self.mj_w, self.animatedView.bounds.size.height);
    [self addSubview:self.animatedView];
    [self.animatedView.layer addSublayer:self.shapeLayer];
    [self.animatedView.layer addSublayer:self.refreshingLayer];
    
    
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    // 根据状态做事情
    [super setState:state];
    if (state == MJRefreshStateIdle) { //刷新完成
        [self stopAnimation];
    } else if (state == MJRefreshStatePulling) {
        self.shapeLayer.strokeEnd = 1;
    } else if (state == MJRefreshStateRefreshing) {
        [self startAnimation];
    }
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
    self.shapeLayer.strokeEnd = self.pullingPercent;;
}

- (void)startAnimation{
//    self.scrollView.scrollEnabled = NO;
    self.refreshingLayer.hidden = NO;
    self.shapeLayer.hidden = YES;
}

- (void)stopAnimation {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.scrollView.scrollEnabled = YES;
        self.refreshingLayer.hidden = YES;
        self.shapeLayer.hidden = NO;
    });
}

@end


