/*
 * @Descripttion: 
 * @Author: xuci
 * @Date: 2020-08-06 16:42:19
 */
#import <Flutter/Flutter.h>
#import <TXLiteAVSDK_TRTC/TXLiteAVSDK.h>

@interface TrtcJzFlutterPlugin : NSObject <FlutterPlugin, TRTCCloudDelegate>

@property (nonatomic, strong) TRTCCloud *trtcCloud;

@end
