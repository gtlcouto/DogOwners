//
//  ViewController.m
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "PersonParser.h"
#import "AppDelegate.h"
#import "DogsViewController.h"

#define kColorKey @"myColor"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property UIAlertView *addAlert;
@property UIAlertView *colorAlert;
@property NSMutableArray * peopleArray;
@property NSManagedObjectContext * context;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.peopleArray = [NSMutableArray new];
    self.context = [AppDelegate appDelegate].managedObjectContext;
    [self loadPeople];
    self.title = @"Dog Owners";

    NSData *colorData = [[NSUserDefaults standardUserDefaults] objectForKey:@"myColor"];
    UIColor *color = [NSKeyedUnarchiver unarchiveObjectWithData:colorData];

    self.navigationController.navigationBar.tintColor = color;

}

#pragma mark - UITableView Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.peopleArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"myCell"];
    Person * thisPerson = self.peopleArray[indexPath.row];
    cell.textLabel.text = thisPerson.name;
    return cell;
}

#pragma mark - UIAlertView Methods

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIColor * color = [UIColor new];
    if (buttonIndex == 0)
    {
        color = [UIColor purpleColor];
        self.navigationController.navigationBar.tintColor = color;
        NSData *colorData = [NSKeyedArchiver archivedDataWithRootObject:color];
        [[NSUserDefaults standardUserDefaults] setObject:colorData forKey:kColorKey];
    }
    else if (buttonIndex == 1)
    {
        color = [UIColor blueColor];
        self.navigationController.navigationBar.tintColor = color;
        NSData *colorData = [NSKeyedArchiver archivedDataWithRootObject:color];
        [[NSUserDefaults standardUserDefaults] setObject:colorData forKey:kColorKey];
    }
    else if (buttonIndex == 2)
    {
        color = [UIColor orangeColor];
        self.navigationController.navigationBar.tintColor = color;
        NSData *colorData = [NSKeyedArchiver archivedDataWithRootObject:color];
        [[NSUserDefaults standardUserDefaults] setObject:colorData forKey:kColorKey];
    }
    else if (buttonIndex == 3)
    {
        color = [UIColor greenColor];
        self.navigationController.navigationBar.tintColor = color;
        NSData *colorData = [NSKeyedArchiver archivedDataWithRootObject:color];
        [[NSUserDefaults standardUserDefaults] setObject:colorData forKey:kColorKey];
    }

}

#pragma mark - IBActions Methods

//METHOD FOR PRESENTING USER'S COLOR PREFERENCE
- (IBAction)onColorButtonTapped:(UIBarButtonItem *)sender
{
    self.colorAlert = [[UIAlertView alloc] initWithTitle:@"Choose a default color!"
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"Purple", @"Blue", @"Orange", @"Green", nil];
    self.colorAlert.tag = 1;
    [self.colorAlert show];
}

#pragma mark - Helper methods
- (void)loadPeople
{

    NSFetchRequest * request = [NSFetchRequest fetchRequestWithEntityName:[Person description]];
    self.peopleArray =  [[self.context executeFetchRequest:request error:nil] mutableCopy];
    [self.tableView reloadData];

    if ( self.peopleArray.count == 0)
    {
        [PersonParser loadJsonData];
    }
    
}

#pragma mark - Segue methods
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DogsViewController * vc = segue.destinationViewController;
    vc.context = self.context;
    vc.selectedIndex = [self.tableView indexPathForSelectedRow].row;
}

@end
