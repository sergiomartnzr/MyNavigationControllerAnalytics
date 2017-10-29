//
//  Login.h
//  MyNavigationControllerAnalytics
//
//  Created by Sergio Martinez on 10/28/17.
//  Copyright © 2017 wgdomenzain. All rights reserved.
//

#import <UIKit/UIKit.h>

@import Firebase;
@import GoogleSignIn;

@interface Login : UIViewController <GIDSignInUIDelegate>
@property (weak, nonatomic) IBOutlet GIDSignInButton *btnSignOutPressed;

//@property(weak, nonatomic) IBOutlet GIDSignInButton *btnSignOutPressed;

//- (IBAction)btnSignInPressed:(id)sender;
- (IBAction)btnSignOutPressed:(id)sender;

@end
