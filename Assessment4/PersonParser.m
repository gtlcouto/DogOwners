//
//  PersonParser.m
//  Assessment4
//
//  Created by Gustavo Couto on 2015-01-30.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "PersonParser.h"
#import "AppDelegate.h"

@implementation PersonParser


+ (void)loadJsonData
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"people" ofType:@"json"];
    NSManagedObjectContext * context = [AppDelegate appDelegate].managedObjectContext;
    NSData * myDataFromJson = [NSData dataWithContentsOfFile:filePath];
    NSArray * arrayJson = [NSJSONSerialization JSONObjectWithData:myDataFromJson options:0 error:nil];
    
   for (NSString * string in arrayJson)
   {
       Person * person = [NSEntityDescription insertNewObjectForEntityForName:[Person description] inManagedObjectContext:context];
       person.name = string;
       NSError *error = nil;
       if (![context save:&error]) {
           NSLog(@"Can't Save Person in PersonParser! %@ %@", error, [error localizedDescription]);
           return;
    }

   }
}

@end
