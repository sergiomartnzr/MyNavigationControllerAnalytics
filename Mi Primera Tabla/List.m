//
//  ViewController.m
//  Mi Primera Tabla
//
//  Created by Walter Gonzalez Domenzain on 20/09/17.
//  Copyright © 2017 wgdomenzain. All rights reserved.
//

#import "List.h"
#import "cellMainTable.h"
#import "Details.h"

@interface List ()
@property NSMutableArray *userNames;
@property NSMutableArray *userAges;
@property NSMutableArray *userDescriptions;
@property NSMutableArray *userImages;
@property (strong, nonatomic) IBOutlet UIImageView *tmpImage;
@property NSMutableArray *dataToSend;
@end

@implementation List
/**********************************************************************************************/
#pragma mark - Initialization methods
/**********************************************************************************************/
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initController];
}
//-------------------------------------------------------------------------------
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-------------------------------------------------------------------------------
- (void)initController {
    self.userNames  = [[NSMutableArray alloc] initWithObjects: @"Hugo Boss Green", @"Hugo Boss Gray", @"Hugo Boss Black", @"Hugo Boss Blue", @"Hugo Boss Orange", nil];
    
        self.userDescriptions  = [[NSMutableArray alloc] initWithObjects: @"Sophisticated green sneakers", @"Awsome gray shoes", @"Elegant black shoes", @"Casual blue tennis", @"Amazing sport shoes", nil];
    
    self.userAges  = [[NSMutableArray alloc] initWithObjects: @"$4500.00", @"$5400.00", @"$7300.00", @"$3600.00", @"7900.00", nil];

    self.userImages = [[NSMutableArray alloc] initWithObjects: [UIImage imageNamed:@"green.jpg"], [UIImage imageNamed:@"gray.jpg"], [UIImage imageNamed:@"black.jpg"], [UIImage imageNamed:@"blue.jpg"], [UIImage imageNamed:@"brown.jpg"], nil];
}

/**********************************************************************************************/
#pragma mark - Table source and delegate methods
/**********************************************************************************************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
//-------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.userNames.count;
}
//-------------------------------------------------------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}
//-------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Initialize cells
    cellMainTable *cell = (cellMainTable *)[tableView dequeueReusableCellWithIdentifier:@"cellMainTable"];
    
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"cellMainTable" bundle:nil] forCellReuseIdentifier:@"cellMainTable"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellMainTable"];
    }
    //Fill cell with info from arrays
    cell.lblName.text       = self.userNames[indexPath.row];
    cell.lblAge.text        = self.userAges[indexPath.row];
    cell.imgUser.image      = self.userImages[indexPath.row];
    
    return cell;
}
//-------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Firebase event trigger (the name is Choose_button_$SHOE_NAME)
    
    NSString *eventSuffix = self.userNames[indexPath.row];
    
    eventSuffix = [eventSuffix stringByReplacingOccurrencesOfString:@" "
                                         withString:@"_"];
    
    [FIRAnalytics logEventWithName:[NSString stringWithFormat: @"%@_%@", @"Choose_button", eventSuffix]
                        parameters:@{
                                     @"name": self.userNames[indexPath.row],
                                     @"full_text": self.userDescriptions[indexPath.row]
                                     }];
    
    NSLog(@"----------------ELEMENT SELECTED");
    
    //Send details to the Details view
    self.dataToSend = [[NSMutableArray alloc]init];
    [self.dataToSend addObject:@{
                        @"name" :  self.userNames[indexPath.row],
                        @"age" : self.userAges[indexPath.row],
                        @"image" :  self.userImages[indexPath.row],
                        @"description": self.userDescriptions[indexPath.row]
                        }];
    
    NSDictionary *objectToSend = self.dataToSend[0];
    [self performSegueWithIdentifier:@"secondView" sender:objectToSend];
    NSLog(@"Item selected");
}
/**********************************************************************************************/
#pragma mark - Action methods
/**********************************************************************************************/
- (IBAction)btnAddPressed:(id)sender {
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"Add new item"
                                                                              message: @"Input Name Age and Image"
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"name";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"age";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSArray * textfields = alertController.textFields;
        UITextField * namefield = textfields[0];
        UITextField * agefield = textfields[1];
        
        [self.userNames addObject:namefield.text];
        [self.userAges addObject:agefield.text];
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
        
        
        NSLog(@"%@:%@",namefield.text,agefield.text);
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    // output image
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    //self.tmpImage.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:nil];

    [self.userImages addObject:chosenImage];
    [self.tblMain reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"secondView"])
    {
        Details *controller = [segue destinationViewController];
        controller.data = sender;
        NSLog(@"Segueado!!!!!");

    }
}

@end
