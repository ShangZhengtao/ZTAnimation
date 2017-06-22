//
//  EmitterViewController.m
//  RefreshDemo
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 shang. All rights reserved.
//

#import "EmitterViewController.h"

@interface EmitterViewController ()
@property (weak, nonatomic) IBOutlet UIView *emitterView;
@property (nonatomic, strong) CAEmitterLayer *emitterlayer;
@end

@implementation EmitterViewController


- (CAEmitterLayer *)emitterlayer {
    if (!_emitterlayer) {
        _emitterlayer = [CAEmitterLayer layer];
        _emitterlayer.renderMode = kCAEmitterLayerAdditive; //混合模式
        _emitterlayer.emitterMode = kCAEmitterLayerSurface;
        _emitterlayer.emitterShape = kCAEmitterLayerRectangle; //发射器形状
//        _emitterlayer.masksToBounds = YES;
        _emitterlayer.emitterCells = @[[self getEmitterCell]];;
    }
    return _emitterlayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.emitterView.layer addSublayer:self.emitterlayer];
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.emitterlayer.frame = self.emitterView.bounds;
    self.emitterlayer.emitterSize = self.emitterView.bounds.size;
    _emitterlayer.emitterPosition = CGPointMake(self.emitterView.bounds.size.width * 0.5, self.emitterView.bounds.size.height - 10);
    
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
    cell.yAcceleration   = - 20.f;
    cell.emissionRange   = M_PI;
    cell.contents =  (__bridge id )([UIImage imageNamed:@"bubble"].CGImage);
    cell.enabled = YES;
    cell.lifetime        = 15;
    cell.lifetimeRange   = 20;
    cell.scale           = 0.1;
    cell.scaleRange      = 0.3;
    return cell;
}


- (UIImage *)imageWithsize:(CGSize)size {
    if ( size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, rect, [UIImage imageNamed:@"bubble"].CGImage);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
