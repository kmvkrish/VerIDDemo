//
//  RCTContainerView.m
//  VerIDDemo
//
//  Created by VARANASI, KRISHNA MANOJ (CORP) on 16/07/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "RCTContainerView.h"

@implementation RCTContainerView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  return self;
}

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.backgroundColor = UIColor.darkGrayColor;
    [self setTag:9999];
  }
  return self;
}

- (void)dealloc
{
  
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

@end
