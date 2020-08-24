//
//  JZTRTCVideoViewController.m
//  Runner
//
//  Created by 徐慈 on 2020/8/7.
//

#import "JZTRTCVideoViewController.h"
#import "GenerateTestUserSig.h"
#import "TrtcJzFlutterPlugin.h"
#import <objc/runtime.h>

@implementation JZTRTCVideoViewController

- (id)initWithFrame:(CGRect)frame viewId:(int64_t)viewId args:(id)args binaryMessenger:(NSObject<FlutterBinaryMessenger> *)messenger {
    if (self = [super init]) {
        _viewId = viewId;
        
        _subView = [UIView new];
        _subView.backgroundColor = [UIColor lightGrayColor];
        if (CGSizeEqualToSize(frame.size, CGSizeZero)) {
            NSDictionary *dic = args;
            CGFloat x = [dic[@"x"] floatValue];
            CGFloat y = [dic[@"y"] floatValue];
            CGFloat width = [dic[@"width"] floatValue];
            CGFloat height = [dic[@"height"] floatValue];
            
            _subView.frame = CGRectMake(x, y, width, height);
        } else {
            _subView.frame = frame;
        }
        
        CGFloat width = [[UIScreen mainScreen] bounds].size.width;
        CGFloat height = [self getContentHeight:YES];
        CGFloat topBottom = 25;
        CGFloat leftRight = 15;
        CGFloat middle = 15;
        CGFloat contentWidth = (width - leftRight * 2) / 2;
        CGFloat contentHeight = (height - topBottom * 2 - middle) / 2;
        
        _localView = [[UIView alloc] initWithFrame:CGRectMake(leftRight, topBottom, contentWidth, contentHeight)];
        [_subView addSubview:_localView];
        [self setCornerWithView:_localView viewSize:_localView.bounds.size corners:(UIRectCornerAllCorners) radius:5 borderColor:[UIColor lightGrayColor]];
        _remoteView = [[UIView alloc] initWithFrame:CGRectMake(leftRight, topBottom + middle + contentHeight, contentWidth, contentHeight)];
        [_subView addSubview:_remoteView];
        [self setCornerWithView:_remoteView viewSize:_remoteView.bounds.size corners:(UIRectCornerAllCorners) radius:5 borderColor:[UIColor lightGrayColor]];
        
        [JZTRTCVideoViewController storeLocalVideoView:_localView];
        [JZTRTCVideoViewController storeRemoteVideoView:_remoteView];
        
        _channel = [FlutterMethodChannel methodChannelWithName:@"com.jz.TrtcJzFlutterView" binaryMessenger:messenger];
        __weak typeof(self) weakSelf = self;
        [_channel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
            [weakSelf onMethodCall:call result:result];
        }];
    }
    return self;
}

+ (void)storeLocalVideoView:(UIView *)localview {
    if (localview) {
        objc_setAssociatedObject(self, &kJZTRTCVideoViewControllerLocalVideoViewKey, localview, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    NSLog(@"localview 为空，保存失败!!!!!!!");
}

+ (void)storeRemoteVideoView:(UIView *)remoteview {
    if (remoteview) {
        objc_setAssociatedObject(self, &kJZTRTCVideoViewControllerRemoteVideoViewKey, remoteview, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    NSLog(@"remoteview 为空，保存失败!!!!!!!");
}

+ (UIView *)getLocalView {
    return objc_getAssociatedObject(self, &kJZTRTCVideoViewControllerLocalVideoViewKey);
}

+ (UIView *)getRemoteView {
    return objc_getAssociatedObject(self, &kJZTRTCVideoViewControllerRemoteVideoViewKey);
}

//view 方法交互
- (void)onMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result{
    result(FlutterMethodNotImplemented);
}

- (nonnull UIView *)view {
    return _subView;
}

- (CGFloat)getContentHeight:(BOOL)hasNavigationBar {
    CGFloat statusBarHeight =  [[UIApplication sharedApplication] statusBarFrame].size.height;
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    
    return hasNavigationBar ? screenHeight - statusBarHeight - 44 : screenHeight - statusBarHeight;
}

- (void)setCornerWithView:(UIView*)view
                 viewSize:(CGSize)viewSize
                  corners:(UIRectCorner)corners
                   radius:(CGFloat)radius
              borderColor:(UIColor*)borderColor{
    CGRect fr = CGRectZero;
    fr.size = viewSize;
    
    UIBezierPath *round = [UIBezierPath bezierPathWithRoundedRect:fr byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    
    CAShapeLayer *shape = [[CAShapeLayer alloc]init];
    
    [shape setPath:round.CGPath];
    shape.strokeColor = borderColor.CGColor;
    shape.fillColor = [UIColor clearColor].CGColor;
    [view.layer addSublayer:shape];
}

@end
