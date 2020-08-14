#import "TrtcJzFlutterPlugin.h"
#import "GenerateTestUserSig.h"
#import "JZTRTCVideoViewController.h"
#import "MyPlatformViewFactory.h"

@implementation TrtcJzFlutterPlugin {
    FlutterMethodChannel *_methodChannel;
    NSObject<FlutterBinaryMessenger>* _messenger;
    id _registry;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel methodChannelWithName:@"trtc_jz_flutter" binaryMessenger:[registrar messenger]];
  [registrar addMethodCallDelegate:[[TrtcJzFlutterPlugin alloc] initWithChannel:channel registrar:registrar messenger:registrar.messenger] channel:channel];
  [registrar registerViewFactory:[[MyPlatformViewFactory alloc] initWithMessenger:registrar.messenger] withId:@"com.jz.TrtcJzFlutterView"];
//    [self registrarEvent:registrar];
}

- (instancetype)initWithChannel:(FlutterMethodChannel *)channel registrar:(NSObject<FlutterPluginRegistrar>*)registrar messenger:(NSObject<FlutterBinaryMessenger>*)messenger {
    if ([super init]) {
        _methodChannel = channel;
        _registry = registrar;
        _messenger = messenger;
    }
    
    return self;
}

//+ (void)registrarEvent:(NSObject<FlutterPluginRegistrar>*)registrar {
//    FlutterEventChannel *eventChannel = [FlutterEventChannel eventChannelWithName:@"com.jz.TrtcJzFlutterViewEvent" binaryMessenger:registrar.messenger];
//    [eventChannel setStreamHandler:^NSObject<FlutterStreamHandler> *(id arguments) {
//        return [JZTRTCVideoViewController new];
//    }];
//    
//}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  NSDictionary *arguments = [call arguments];
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else if([@"initTrtcLocalUser" isEqualToString:call.method]) {
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

- (TRTCCloud *)trtcCloud {
    if (!_trtcCloud) {
        _trtcCloud = [TRTCCloud sharedInstance];
        _trtcCloud.delegate = self;
    }
    return _trtcCloud;
}

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
    NSLog(@">>>>>>>>>> 3333333");

//    JZTRTCVideoViewController *viewController = //registrar.messenger;
//    NSLog(@">>>>>>>>>> %@", _localViewController.view);
//    _localViewController.view.backgroundColor = [UIColor redColor];
//    [self.trtcCloud startLocalPreview:isFrontCamera view:_localViewController.view];
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
