//
//  RCTContainerView.h
//  VerIDDemo
//
//  Created by VARANASI, KRISHNA MANOJ (CORP) on 16/07/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <React/RCTComponent.h>
#import <VerIDUI/VerIDUI-Swift.h>
#import <VerIDCore/VerIDCore-Swift.h>

NS_ASSUME_NONNULL_BEGIN

@interface RCTContainerView : UIView <VerIDFactoryDelegate, VerIDSessionDelegate, VerIDSessionViewDelegate>

@property (nonatomic, copy) RCTBubblingEventBlock onSessionFinished;

@property (nonatomic, copy) RCTBubblingEventBlock onSessionCanceled;

- (void)startSession;

- (void)stopSession;

@end

NS_ASSUME_NONNULL_END
