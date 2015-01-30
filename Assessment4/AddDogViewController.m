//
//  AddDogViewController.m
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "AddDogViewController.h"

@interface AddDogViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *breedTextField;
@property (weak, nonatomic) IBOutlet UITextField *colorTextField;

@end

@implementation AddDogViewController

//TODO: UPDATE CODE ACCORIDNGLY

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadUI];
    self.title = @"Add Dog";
}

-(void)loadUI
{
    if (self.selectedDog) {
        self.nameTextField.text = self.selectedDog.name;
        self.breedTextField.text = self.selectedDog.breed;
        self.colorTextField.text = self.selectedDog.color;
    }
}

-(void)setDog
{
    self.selectedDog.name = self.nameTextField.text;
    self.selectedDog.breed = self.breedTextField.text;
    self.selectedDog.color = self.colorTextField.text;
}

- (IBAction)onPressedUpdateDog:(UIButton *)sender
{
    if (self.selectedDog) {
        [self setDog];
    } else{
        self.selectedDog = [NSEntityDescription insertNewObjectForEntityForName:[Dog description] inManagedObjectContext:self.context];
        [self setDog];
        [self.selectedPerson addDogsObject:self.selectedDog];
    }
    if ((self.nameTextField.text && self.nameTextField.text.length > 0) &&
        (self.breedTextField.text && self.breedTextField.text.length > 0) &&
        (self.colorTextField.text && self.colorTextField.text.length > 0)) {
            NSError *error = nil;
            if (![self.context save:&error]) {
                NSLog(@"Can't Save Dog in AddDogViewController! %@ %@", error, [error localizedDescription]);
                return;
            }
            [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        UIAlertView * alertView = [UIAlertView new];
        alertView.title = @"Error!";
        alertView.message =@"Please complete all of the fields";
        [alertView addButtonWithTitle:@"Okay"];
        [alertView show];
    }
}

@end
