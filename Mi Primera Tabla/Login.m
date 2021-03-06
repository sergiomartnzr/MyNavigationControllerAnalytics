//
//  Login.m
//  MyNavigationControllerAnalytics
//
//  Created by Sergio Martinez on 10/28/17.
//  Copyright © 2017 wgdomenzain. All rights reserved.
//

#import "Login.h"

@interface Login ()

@end

@implementation Login

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //Firebase login
    //[GIDSignIn sharedInstance].uiDelegate = self;
    //[[GIDSignIn sharedInstance] signIn];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSignInPressed:(id)sender {
    [FIRAnalytics logEventWithName:@"Signin_button"
                        parameters:@{
                                     @"name": @"Google",
                                     @"full_text": @"Gmail"
                                     }];
    
    [GIDSignIn sharedInstance].uiDelegate = self;
    [[GIDSignIn sharedInstance] signIn];
    
    //[self performSegueWithIdentifier:@"List Scene" sender:self];
}

- (IBAction)btnSignOutPressed:(id)sender {
    NSError *signOutError;
    BOOL status = [[FIRAuth auth] signOut:&signOutError];
    if (!status) {
        NSLog(@"Error signing out: %@", signOutError);
        return;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
