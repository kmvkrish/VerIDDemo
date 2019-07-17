//
//  AuthenticationViewController.h
//  VerIDDemo
//
//  Created by VARANASI, KRISHNA MANOJ (CORP) on 16/07/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <VerIDUI/VerIDUI.h>
#import <VerIDCore/VerIDCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface AuthenticationViewController : UIViewController<VerIDSessionDelegate>

@property VerID *verID;

@end

NS_ASSUME_NONNULL_END
