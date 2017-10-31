//
//  Back.m
//  MyNavigationControllerAnalytics
//
//  Created by Sergio Martinez on 10/30/17.
//  Copyright © 2017 wgdomenzain. All rights reserved.
//

#import "Back.h"

@interface Back ()

@end

@implementation Back

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnBackPressed:(id)sender {
    
    //Firebase trigger event
    [FIRAnalytics logEventWithName: @"Buy_More_Button"
                        parameters:@{
                                     @"name": @"Buy_More_Button",
                                     @"full_text": @"The user will buy more products"
                                     }];
    
    NSLog(@"----------------GOING BACK TO THE PRODUCT LIST");
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
