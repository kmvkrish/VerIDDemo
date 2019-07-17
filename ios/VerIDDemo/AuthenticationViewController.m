//
//  AuthenticationViewController.m
//  VerIDDemo
//
//  Created by VARANASI, KRISHNA MANOJ (CORP) on 16/07/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "AuthenticationViewController.h"
#import "AppDelegate.h"

@interface AuthenticationViewController ()

@end

@implementation AuthenticationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
  self.verID = appDelegate.verID;
  
  VerIDLivenessDetectionSessionSettings *settings = [[VerIDLivenessDetectionSessionSettings alloc] init];
  settings.numberOfResultsToCollect = 3;
  
  self.verID.faceRecognition.authenticationScoreThreshold = [[NSNumber alloc] initWithDouble:4.5];
  
  VerIDSession *session = [[VerIDSession alloc] initWithEnvironment:self.verID settings:settings];
  session.delegate = self;
  //[session start];
}

- (void)session:(VerIDSession *)session didFinishWithResult:(VerIDSessionResult *)result {
  NSLog(@"Verification sesison was finished");
}

- (void)sessionWasCanceled:(VerIDSession *)session {
  NSLog(@"Verification session was cancelled");
}


@end
