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

@interface JZTRTCVideoViewController : NSObject <FlutterPlatformView, FlutterStreamHandler, TRTCCloudDelegate>
{
    int64_t _viewId;
    FlutterMethodChannel *_channel;
    FlutterEventSink _eventSink;
    UIView *_subView;
}

@property(nonatomic, strong) TRTCCloud *trtcCloud;

- (id)initWithFrame:(CGRect)frame viewId:(int64_t)viewId args:(id)args binaryMessenger:(NSObject<FlutterBinaryMessenger> *)messenger;

@end

NS_ASSUME_NONNULL_END
