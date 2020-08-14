#import "TrtcJzFlutterPlugin.h"
#import "GenerateTestUserSig.h"
#import "JZTRTCVideoViewController.h"
#import "MyPlatformViewFactory.h"
#import <objc/runtime.h>

@interface TrtcJzFlutterPlugin() {
    FlutterMethodChannel *_methodChannel;
    NSObject <FlutterBinaryMessenger> *_messenger;
    id _registry;
}

@property (nonatomic, strong) NSMutableArray *remoteUserIds;
@property (nonatomic, strong) TRTCCloud *trtcCloud;
@property (nonatomic, strong) FlutterBasicMessageChannel *basicMessageChannel;

@end

@implementation TrtcJzFlutterPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel methodChannelWithName:@"trtc_jz_flutter" binaryMessenger:[registrar messenger]];
  [registrar addMethodCallDelegate:[[TrtcJzFlutterPlugin alloc] initWithChannel:channel registrar:registrar messenger:registrar.messenger] channel:channel];
  [registrar registerViewFactory:[[MyPlatformViewFactory alloc] initWithMessenger:registrar.messenger] withId:@"com.jz.TrtcJzFlutterView"];
}

- (instancetype)initWithChannel:(FlutterMethodChannel *)channel registrar:(NSObject<FlutterPluginRegistrar>*)registrar messenger:(NSObject<FlutterBinaryMessenger>*)messenger {
    if ([super init]) {
        _methodChannel = channel;
        _registry = registrar;
        _messenger = messenger;
        _basicMessageChannel = [FlutterBasicMessageChannel messageChannelWithName:@"com.jz.TrtcJzFlutterView.basicMessageChannel" binaryMessenger:registrar.messenger codec:[FlutterStringCodec sharedInstance]];

        [_basicMessageChannel setMessageHandler:^(id  _Nullable message, FlutterReply  _Nonnull callback) {
            callback(message);
        }];
    }
    
    return self;
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result{
    NSDictionary *arguments = [call arguments];
    if([@"initTrtcLocalUser" isEqualToString:call.method]) {
      [self initTrtcLocalUser:arguments[@"userid"] sdkappid:[arguments[@"sdkappid"] intValue] userSig:arguments[@"usersig"] roomId:[arguments[@"roomid"] intValue]];
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
    } else if ([@"startRemoteVideoView" isEqualToString:call.method]) {
        [self startRemoteVideoView];
        result(nil);
    } else {
      result(FlutterMethodNotImplemented);
    }
}

- (NSMutableArray *)remoteUserIds {
    if (!_remoteUserIds) {
        _remoteUserIds = [NSMutableArray array];
    }
    return _remoteUserIds;
}

- (TRTCCloud *)trtcCloud {
    if (!_trtcCloud) {
        _trtcCloud = [TRTCCloud sharedInstance];
        _trtcCloud.delegate = self;
    }
    return _trtcCloud;
}

#pragma mark --TRTC Delegate
- (void)initTrtcLocalUser:(NSString *)userId sdkappid:(UInt32)sdkappid userSig:(NSString *)userSig roomId:(UInt32)roomId {
    TRTCParams *param = [TRTCParams new];
    param.sdkAppId = sdkappid;
    param.userId = userId;
    param.roomId = roomId;
    param.role = TRTCRoleAnchor;
    param.userSig = userSig;
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
    [self.trtcCloud startLocalAudio];
}

- (void)startLocalPreview:(BOOL)isFrontCamera {
    UIView *localVideoView = objc_getAssociatedObject(self, &kJZTRTCVideoViewControllerLocalVideoViewKey);
    [self.trtcCloud startLocalPreview:isFrontCamera view:localVideoView];
}

- (void)startRemoteVideoView {
    if (self.remoteUserIds.count > 0) {
        UIView *remoteVideoView = objc_getAssociatedObject(self, &kJZTRTCVideoViewControllerRemoteVideoViewKey);
        [self.trtcCloud startRemoteView:self.remoteUserIds[0] view:remoteVideoView];
    }
}

- (void)exitRoom {
    [self.trtcCloud exitRoom];
}

- (void)dealloc {
    [TRTCCloud destroySharedIntance];
}

/// delegate
- (void)onUserVideoAvailable:(NSString *)userId available:(BOOL)available {
    [self.basicMessageChannel sendMessage:@"onUserVideoAvailable"];
    if (available) {
        [self.remoteUserIds addObject:userId];
    }
}

- (void)onRemoteUserEnterRoom:(NSString *)userId {
    [self.basicMessageChannel sendMessage:@"onRemoteUserEnterRoom"];
}


@end
