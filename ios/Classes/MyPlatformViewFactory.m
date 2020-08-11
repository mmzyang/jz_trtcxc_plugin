//
//  MyPlatformViewFactory.m
//  Runner
//
//  Created by 徐慈 on 2020/8/7.
//

#import "MyPlatformViewFactory.h"
#import "JZTRTCVideoViewController.h"

@implementation MyPlatformViewFactory {
    NSObject<FlutterBinaryMessenger>*_messenger;
    JZTRTCVideoViewController *viewController;
}

- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger> *)messager {
    self = [super init];
    if (self) {
        _messenger = messager;
    }
    return self;
}

- (NSObject<FlutterMessageCodec> *)createArgsCodec {
    return [FlutterStandardMessageCodec sharedInstance];
}

- (NSObject <FlutterPlatformView> *)createWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id _Nullable)args {
    viewController = [[JZTRTCVideoViewController alloc] initWithFrame:frame viewId:viewId args:args binaryMessenger:_messenger];
    return viewController;
}


@end
