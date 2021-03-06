//
//  RCTContainerView.m
//  VerIDDemo
//
//  Created by VARANASI, KRISHNA MANOJ (CORP) on 16/07/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "RCTContainerView.h"

@interface RCTContainerView()

@property VerIDSession *session;
@property VerID *verid;
@property UIViewController *viewController;

@end

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
    [self setTag:9999];
    [self setViewController:[[UIViewController alloc] init]];
    [self.viewController setView:self];
  }
  return self;
}

- (void)startSession {
  if (self.session != nil) {
    [self.session cancel];
    [self setSession:nil];
  }
  for (UIView *subview in self.subviews) {
    [subview removeFromSuperview];
  }
  if (self.verid == nil) {
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] init];
    [activityIndicator setFrame:self.bounds];
    [self addSubview:activityIndicator];
    [activityIndicator startAnimating];
    VerIDFactory *veridFactory = [[VerIDFactory alloc] init];
    [veridFactory setDelegate:self];
    [veridFactory createVerID];
  } else {
    VerIDLivenessDetectionSessionSettings *settings = [[VerIDLivenessDetectionSessionSettings alloc] init];
    [self setSession:[[VerIDSession alloc] initWithEnvironment:self.verid settings:settings]];
    [self.session setViewDelegate:self];
    [self.session setDelegate:self];
    [self.session start];
  }
}

- (void)stopSession {
  if (self.session != nil) {
    [self.session setDelegate:nil];
    [self.session cancel];
    for (UIView *subview in self.subviews) {
      [subview removeFromSuperview];
    }
    [self setSession:nil];
  }
}

- (void)veridFactory:(VerIDFactory *)factory didCreateVerID:(VerID *)instance {
  [self setVerid:instance];
  if (self.window != nil) {
    [self startSession];
  }
}

- (void)veridFactory:(VerIDFactory *)factory didFailWithError:(NSError *)error {
  
}

- (void)didMoveToWindow {
  if (self.window != nil) {
    [self startSession];
  } else {
    [self stopSession];
  }
}

- (void)closeViewsWithCallback:(void (^ _Nonnull)(void))callback {
  for (UIView *subview in self.subviews) {
    [subview removeFromSuperview];
  }
  callback();
}

- (void)removeViewControllers {
  for (UIViewController *child in [self.viewController childViewControllers]) {
    [child willMoveToParentViewController:nil];
    [child.view removeFromSuperview];
    [child removeFromParentViewController];
  }
}

- (void)addViewController:(UIViewController * _Nonnull)viewController {
  [self removeViewControllers];
  [viewController willMoveToParentViewController:self.viewController];
  [self.viewController addChildViewController:viewController];
  [viewController.view setTranslatesAutoresizingMaskIntoConstraints:NO];
  [self addSubview:viewController.view];
  [NSLayoutConstraint activateConstraints:@[
                                            [viewController.view.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:0],
                                            [viewController.view.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:0],
                                            [viewController.view.topAnchor constraintEqualToAnchor:self.topAnchor constant:0],
                                            [viewController.view.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0]
                                            ]];
  [viewController didMoveToParentViewController:self.viewController];
  if ([viewController canBecomeFirstResponder]) {
    [viewController becomeFirstResponder];
  }
}

- (void)presentResultViewController:(UIViewController<ResultViewControllerProtocol> * _Nonnull)viewController {
  [self addViewController:viewController];
}

- (void)presentTipsViewController:(UIViewController<TipsViewControllerProtocol> * _Nonnull)viewController {
  [self addViewController:viewController];
}

- (void)presentVerIDViewController:(UIViewController<VerIDViewControllerProtocol> * _Nonnull)viewController {
  [self addViewController:viewController];
}

- (void)session:(VerIDSession *)session didFinishWithResult:(VerIDSessionResult *)result {
  if (self.superview != nil) {
    self.onSessionFinished(nil);
  }
}

- (void)sessionWasCanceled:(VerIDSession *)session {
  if (self.superview != nil) {
    self.onSessionCanceled(nil);
  }
}

@end
