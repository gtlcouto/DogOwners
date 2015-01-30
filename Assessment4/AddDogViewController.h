//
//  AddDogViewController.h
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dog.h"
#import "Person.h"  

@interface AddDogViewController : UIViewController

@property NSManagedObjectContext * context;
@property Dog * selectedDog;
@property Person * selectedPerson;

@end
