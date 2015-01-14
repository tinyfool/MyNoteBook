//
//  Group.m
//  MyNoteBook
//
//  Created by TaoZeyu on 15/1/13.
//  Copyright (c) 2015年 TaoZeyu. All rights reserved.
//
#import "Group.h"
#import "Note.h"

#import "AppMacro.h"

@implementation Group

@dynamic createAt;
@dynamic name;
@dynamic notes;

-(void) valuesInitWithName:(NSString *)name
{
    self.name = name;
    self.createAt = [NSDate date];
}

+(BOOL) insertDefaultGroupIfFirstLaunch:(AppDelegate *) appDelegate
{
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSError *error;
    NSUInteger count = [context countForFetchRequest:[self getFindDefaultGroupRequest] error: &error];
    
    if(count == NSNotFound) {
        Group *defualtGroup = [NSEntityDescription
                               insertNewObjectForEntityForName: @"Group"
                               inManagedObjectContext: context];
        
        [defualtGroup valuesInitWithName:DefaultGroupName];
        [appDelegate saveContext];
    }
    
    return YES;
}

+(Group *) getDefaultGroup:(NSManagedObjectContext *)context
{
    NSError *error;
    NSArray *results = [context executeFetchRequest:[self getFindDefaultGroupRequest] error:&error];
    
    if (results == nil) {
        NSLog(@"Default group not found:%@", [error localizedDescription]);
        return nil;
    }
    
    return [results firstObject];
}

+(NSFetchRequest *) getFindDefaultGroupRequest
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName: @"Group"];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat: @"(name = %s)", DefaultGroupName];
    [request setPredicate: pred];
    
    return request;
}

@end
