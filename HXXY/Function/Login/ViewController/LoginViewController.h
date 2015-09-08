//
//  LoginViewController.h
//  HXXY
//
//  Created by Apple on 9/8/15.
//  Copyright (c) 2015 广东华讯网络投资有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChangeStoryboardDelegate.h"
#import "GlobalResource.h"
@interface LoginViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *phoneNumber;
@property (strong, nonatomic) IBOutlet UITextField *password;
- (IBAction)loginButton:(id)sender;


@end
