/*
 * @Descripttion: 
 * @Author: xuci
 * @Date: 2020-08-07 15:08:00
 */
//
//  JZTRTCVideoViewController.h
//  Runner
//
//  Created by 徐慈 on 2020/8/7.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import <TXLiteAVSDK_TRTC/TXLiteAVSDK.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *kJZTRTCVideoViewControllerLocalVideoViewKey = @"kJZTRTCVideoViewControllerLocalVideoViewKey";   //存放 localvideoview
static NSString *kJZTRTCVideoViewControllerRemoteVideoViewKey = @"kJZTRTCVideoViewControllerRemoteVideoViewKey"; //存放 remotevideoview

static const NSString *kStoreKey = @"kStoreKey";

@interface JZTRTCVideoViewController : NSObject <FlutterPlatformView, TRTCCloudDelegate>
{
    int64_t _viewId;
    FlutterMethodChannel *_channel;
    FlutterEventChannel *_eventChannel;
    UIView *_subView;
    UIView *_remoteView;
    UIView *_localView;
}

- (id)initWithFrame:(CGRect)frame viewId:(int64_t)viewId args:(id)args binaryMessenger:(NSObject<FlutterBinaryMessenger> *)messenger;

+ (void)storeRemoteVideoView:(UIView *)remoteview;
+ (void)storeLocalVideoView:(UIView *)localview;
+ (UIView *)getRemoteView;
+ (UIView *)getLocalView;

@end

NS_ASSUME_NONNULL_END
