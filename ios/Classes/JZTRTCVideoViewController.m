//
//  JZTRTCVideoViewController.m
//  Runner
//
//  Created by 徐慈 on 2020/8/7.
//

#import "JZTRTCVideoViewController.h"
#import "GenerateTestUserSig.h"

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

        _channel = [FlutterMethodChannel methodChannelWithName:@"com.jz.TrtcJzFlutterView" binaryMessenger:messenger];
        __weak __typeof__(self) weakSelf = self;
        [_channel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
            [weakSelf onMethodCall:call result:result];
        }];
    }
    return self;
}

- (void)onMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result{
    NSDictionary *arguments = [call arguments];
    if([@"initTrtcLocalUser" isEqualToString:call.method]) {
      [self initTrtcLocalUser:arguments[@"userId"] roomId:[arguments[@"roomId"] intValue]];
      result(nil);
    } else if([@"startLocalAudio" isEqualToString:call.method]) {
      [self startLocalAudio];
      result(nil);
    } else if([@"exitRoom" isEqualToString:call.method]) {
      [self exitRoom];
      result(nil);
    } else if([@"startLocalPreview" isEqualToString:call.method]) {
      [self startLocalPreview:[arguments[@"isFrontCamera"] boolValue]];
      result(nil);
    }
     else {
      result(FlutterMethodNotImplemented);
    }
}

- (nonnull UIView *)view {
    return _subView;
}

- (TRTCCloud *)trtcCloud {
    if (!_trtcCloud) {
        _trtcCloud = [TRTCCloud sharedInstance];
        _trtcCloud.delegate = self;
    }
    return _trtcCloud;
}

#pragma mark --TRTC Delegate
- (void)initTrtcLocalUser:(NSString *)userId roomId:(UInt32)roomId {
    NSLog(@">>>>>>>>>> 1111111");

    TRTCParams *param = [TRTCParams new];
    param.sdkAppId = 0;
    param.userId = userId;
    param.roomId = roomId;
    param.role = TRTCRoleAnchor;
    param.userSig = [GenerateTestUserSig genTestUserSig:param.userId];
    [self.trtcCloud enterRoom:param appScene:TRTCAppSceneVideoCall];

   TRTCVideoEncParam *videoEncParam = [TRTCVideoEncParam new];
   videoEncParam.videoResolution = TRTCVideoResolution_640_360;
   videoEncParam.videoBitrate = 550;
   videoEncParam.videoFps = 15;
   [self.trtcCloud setVideoEncoderParam:videoEncParam];

   TXBeautyManager *beautyManager = [self.trtcCloud getBeautyManager];
   [beautyManager setBeautyStyle:TXBeautyStyleNature];
   [beautyManager setBeautyLevel:5];
   [beautyManager setWhitenessLevel:1];

   [self.trtcCloud setDebugViewMargin:userId margin:UIEdgeInsetsMake(80, 0, 0, 0)];
}

- (void)startLocalAudio {
    NSLog(@">>>>>>>>>> 2222222");
    [self.trtcCloud startLocalAudio];
}

- (void)startLocalPreview:(BOOL)isFrontCamera {
    [self.trtcCloud startLocalPreview:isFrontCamera view:_subView];
}

- (void)exitRoom {
    [self.trtcCloud exitRoom];
}

- (void)dealloc {
    [TRTCCloud destroySharedIntance];
}

/// delegate
- (void)onUserVideoAvailable:(NSString *)userId available:(BOOL)available {
    
}

- (void)onRemoteUserEnterRoom:(NSString *)userId {
    
}

@end
