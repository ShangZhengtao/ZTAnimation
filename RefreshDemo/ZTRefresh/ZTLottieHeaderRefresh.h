//
//  ZTLottieHeaderRefresh.h
//  RefreshDemo
//
//  Created by apple on 2017/9/26.
//  Copyright © 2017年 shang. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

@interface ZTLottieHeaderRefresh : MJRefreshHeader
/** lottie文件名不需要后缀json*/
@property (nonatomic, copy) NSString *lottieFilename;
@end
