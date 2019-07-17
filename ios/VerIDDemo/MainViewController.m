//
//  MainViewController.m
//  VerIDDemo
//
//  Created by VARANASI, KRISHNA MANOJ (CORP) on 16/07/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  
  NSURL *jscodeLocation = [self getBundleURL];
  
  RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jscodeLocation moduleName:@"VerIDDemo" initialProperties:@{} launchOptions:nil];
  rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];
  
  UIView* launchScreenView = [[[NSBundle mainBundle] loadNibNamed:@"LaunchScreen" owner:self options:nil] objectAtIndex:0];
  launchScreenView.frame = appDelegate.window.bounds;
  rootView.loadingView = launchScreenView;
  
  self.view = rootView;
  
}

-(NSURL *)getBundleURL {
#if DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
#else
  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
}

@end
