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
        
        _remoteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 200)];
        [_subView addSubview:_remoteView];
        
        [JZTRTCVideoViewController storeLocalVideoView:_subView];
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

@end
