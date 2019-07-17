/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "AppDelegate.h"
#import "ContainerViewController.h"

#import <React/RCTBridge.h>
#import <React/RCTBundleURLProvider.h>


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  //RCTBridge *bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:launchOptions];


  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  
  UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
  
  ContainerViewController *rootViewController = (ContainerViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ContainerViewController"];
  
  self.window.rootViewController = rootViewController;
  [self.window makeKeyAndVisible];
  
  VerIDFactory *factory = [[VerIDFactory alloc] init];
  [factory setDelegate:self];
  [factory createVerID];
  
  return YES;
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
#if DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
#else
  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
}

/*
 *  VerIDFactoryDelegate methods
 */
- (void)veridFactory:(VerIDFactory *)factory didCreateVerID:(VerID *)instance {
  NSLog(@"Created Ver-ID instance: %@", instance);
  self.verID = instance;
}

- (void)veridFactory:(VerIDFactory *)factory didFailWithError:(NSError *)error {
  NSLog(@"Failed to create Ver-ID instance: %@", error.description);
}

@end
