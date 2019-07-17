//
//  ContainerViewManager.m
//  VerIDDemo
//
//  Created by VARANASI, KRISHNA MANOJ (CORP) on 16/07/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "ContainerViewManager.h"
#import "RCTContainerView.h"

@implementation ContainerViewManager

RCT_EXPORT_MODULE(RCTContainerView)

- (UIView *)view {
  
  RCTContainerView *view = [[RCTContainerView alloc] init];
  
  return view;
}

@end
