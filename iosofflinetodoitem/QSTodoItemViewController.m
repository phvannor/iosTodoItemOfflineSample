//
//  QSTodoItemViewController.m
//  iosofflinetodoitem
//
//  Created by Carlos Figueira on 5/27/14.
//  Copyright (c) 2014 MobileServices. All rights reserved.
//

#import "QSTodoItemViewController.h"

@interface QSTodoItemViewController ()

@property (nonatomic, strong) IBOutlet UITextField *itemText;
@property (nonatomic, strong) IBOutlet UILabel *itemCreatedAt;
@property (nonatomic, strong) IBOutlet UISegmentedControl *itemComplete;

@end

@implementation QSTodoItemViewController

@synthesize item, itemText, itemComplete, itemCreatedAt;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UINavigationItem *nav = [self navigationItem];
    [nav setTitle:@"Todo Item"];

    NSDictionary *theItem = [self item];
    [itemText setText:[theItem objectForKey:@"text"]];

    BOOL isComplete = [[theItem objectForKey:@"complete"] boolValue];
    [itemComplete setSelectedSegmentIndex:(isComplete ? 0 : 1)];
    NSDate *created = [theItem objectForKey:@"__createdAt"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    if (created) {
        [itemCreatedAt setText:[dateFormatter stringFromDate:created]];
    }

    [itemComplete addTarget:self
                     action:@selector(completedValueChanged:)
           forControlEvents:UIControlEventValueChanged];
}

- (void)completedValueChanged:(id)sender {
    [[self view] endEditing:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    NSMutableDictionary *theItem = [self item];
    [theItem setValue:[itemText text] forKey:@"text"];
    [theItem setValue:[NSNumber numberWithBool:itemComplete.selectedSegmentIndex == 0] forKey:@"complete"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end