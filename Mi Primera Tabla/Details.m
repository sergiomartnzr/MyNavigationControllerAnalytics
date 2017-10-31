//
//  secondViewViewController.m
//  Mi Primera Tabla
//
//  Created by Vic on 9/27/17.
//  Copyright © 2017 wgdomenzain. All rights reserved.
//

#import "Details.h"

@interface Details ()

@end

@implementation Details

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.data != nil) {
        self.name.text= self.data[@"name"];
        self.age.text= self.data[@"age"];
        self.image.image = self.data[@"image"];
        if (self.data.description != nil) {
            self.textdesc.text = self.data[@"description"];
        }
    }
}
- (IBAction)btnBuyPressed:(id)sender {
    
        //Firebase trigger event (the event name is Buy_button_$SHOE_NAME)
    
        NSString *eventSuffix = self.data[@"name"];
    
        eventSuffix = [eventSuffix stringByReplacingOccurrencesOfString:@" "
                                                             withString:@"_"];
    
        [FIRAnalytics logEventWithName: [NSString stringWithFormat: @"%@_%@", @"Buy_button", eventSuffix]
                        parameters:@{
                                 @"name": self.data[@"name"],
                                 @"full_text": self.data[@"description"]
                                 }];

        NSLog(@"----------------ELEMENT BOUGHT");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
