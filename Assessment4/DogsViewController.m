//
//  DogsViewController.m
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "DogsViewController.h"
#import "AddDogViewController.h"
#import "Dog.h"

@interface DogsViewController () <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *dogsTableView;
@property NSMutableArray * dogsArray;
@property Person * selectedPerson;
@property NSIndexPath * deleteIndexPath;

@end

@implementation DogsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dogsArray = [NSMutableArray new];
    [self loadDogs];
    self.title = @"Dogs";
}

-(void)viewWillAppear:(BOOL)animated
{
    [self loadDogs];
    [self.dogsTableView reloadData];
}
#pragma mark - UIAlertView Delegate Methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
         //Delete object from coredata
        [self.context deleteObject:[self.dogsArray objectAtIndex:self.deleteIndexPath.row]];

        NSError *error = nil;
        if (![self.context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }

        // Remove dog from table view
        [self.dogsArray removeObjectAtIndex:self.deleteIndexPath.row];
        [self.dogsTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:self.deleteIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - UITableView Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dogsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"dogCell"];
    Dog * dog = self.dogsArray[indexPath.row];
    cell.textLabel.text = dog.name;
    cell.detailTextLabel.numberOfLines = 2;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ \n%@", dog.breed, dog.color];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertView *deleteAlert = [UIAlertView new];
        deleteAlert.delegate = self;
        deleteAlert.title = @"Are you sure you want to kill this poor puppy \ue413?";
        [deleteAlert addButtonWithTitle:@"NO!!! SAVE THE PUPPY \ue052"];
        [deleteAlert addButtonWithTitle:@"YES MUHAHAH \ue11a"];
        self.deleteIndexPath = indexPath;
        [deleteAlert show];
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"Kill the puppy!";
}

#pragma mark - Helper methods
- (void)loadDogs
{

    NSFetchRequest * request = [NSFetchRequest fetchRequestWithEntityName:[Person description]];
    NSArray * personArray =  [[self.context executeFetchRequest:request error:nil] mutableCopy];
    self.selectedPerson = personArray[self.selectedIndex];
    self.dogsArray = [[self.selectedPerson.dogs allObjects] mutableCopy];
    [self.dogsTableView reloadData];
}


#pragma mark - Segue Methods

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    AddDogViewController * vc = segue.destinationViewController;
    vc.context = self.context;

    if ([segue.identifier isEqualToString: @"AddDogSegue"])
    {
        vc.selectedPerson = self.selectedPerson;
    }
    else
    {
        //vc.selectedPerson = self.selectedPerson;
        vc.selectedDog = [self.dogsArray objectAtIndex:[self.dogsTableView indexPathForSelectedRow].row];
    }
}

@end
