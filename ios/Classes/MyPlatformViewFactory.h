//
//  MyPlatformViewFactory.h
//  Runner
//
//  Created by 徐慈 on 2020/8/7.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyPlatformViewFactory : NSObject<FlutterPlatformViewFactory>

- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messager;

@end

NS_ASSUME_NONNULL_END
