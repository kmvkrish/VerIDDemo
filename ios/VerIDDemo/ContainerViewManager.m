//
//  ContainerViewManager.m
//  VerIDDemo
//
//  Created by VARANASI, KRISHNA MANOJ (CORP) on 16/07/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMedia/CoreMedia.h>
#import "ContainerViewManager.h"
#import "RCTContainerView.h"
#import <VerIDCore/VerIDCore-Swift.h>
#import <VerIDUI/VerIDUI-Swift.h>

@interface ContainerViewManager()

@property VerIDSession *session;

@end

@implementation ContainerViewManager

RCT_EXPORT_MODULE(RCTSessionView)
RCT_EXPORT_VIEW_PROPERTY(onSessionFinished, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onSessionCanceled, RCTBubblingEventBlock)

+ (BOOL)requiresMainQueueSetup {
  return YES;
}

- (UIView *)view {  
  RCTContainerView *view = [[RCTContainerView alloc] init];
  return view;
}

@end
