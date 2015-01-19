//
//  Group.m
//  MyNoteBook
//
//  Created by TaoZeyu on 15/1/16.
//  Copyright (c) 2015年 TaoZeyu. All rights reserved.
//

#import "Group.h"
#import "Note.h"

#import "AppMacro.h"


@implementation Group

@dynamic createAt;
@dynamic name;
@dynamic notes;

-(void)valuesInitWithName:(NSString *) name
{
    self.name = name;
    self.createAt = [NSDate date];
}

-(NSArray *)listNotes
{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"createAt" ascending:NO];
    return [self.notes sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
}

+(BOOL)isDefaultGroup:(Group *)group
{
    return [group.name isEqualToString:DefaultGroupName];
}

+(BOOL) insertDefaultGroupIfFirstLaunch:(AppDelegate *) appDelegate
{
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSError *error;
    NSUInteger count = [context countForFetchRequest:[self getFindDefaultGroupRequest] error: &error];
    
    if(count == 0) {
        Group *defaultGroup = [NSEntityDescription
                               insertNewObjectForEntityForName: @"Group"
                               inManagedObjectContext: context];
        
        [defaultGroup valuesInitWithName:DefaultGroupName];
        
        BOOL success = [context save: &error];
        
        if(!success) {
            NSLog(@"error: %@", error.localizedDescription);
            return NO;
        }
        return YES;
        
    } else {
        return NO;
    }
}

+(Group *) createGroupWithName:(NSString *)name inContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName: @"Group"];
    NSPredicate *pred = [NSPredicate predicateWithFormat: @"(name = %@)", name];
    
    NSError *error;
    [request setPredicate:pred];
    NSUInteger count = [context countForFetchRequest:request error: &error];
    
    if(count > 0) {
        NSLog(@"Error, Group '%@' count : %lu", name, count);
        return nil;
    }
    Group *group = [NSEntityDescription
                    insertNewObjectForEntityForName:@"Group"
                    inManagedObjectContext:context];
    [group valuesInitWithName:name];
    
    return group;
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
    
    NSPredicate *pred = [NSPredicate predicateWithFormat: @"(name = %@)", DefaultGroupName];
    [request setPredicate: pred];
    
    return request;
}

+(NSArray *)listAllGroups:(NSManagedObjectContext *)context
{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"createAt" ascending:NO];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName: @"Group"];
    
    [request setSortDescriptors:@[sortDescriptor]];
    
    NSError *error;
    NSArray *resultArray = [context executeFetchRequest:request error:&error];
    
    if(resultArray == nil)
    {
        NSLog(@"Group List Select Error:%@", [error localizedDescription]);
        return nil;
    }
    return resultArray;
}


@end
