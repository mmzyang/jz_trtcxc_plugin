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

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
     result(FlutterMethodNotImplemented);
}

@end
