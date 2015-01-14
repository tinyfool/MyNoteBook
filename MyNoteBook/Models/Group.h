//
//  Group.h
//  MyNoteBook
//
//  Created by TaoZeyu on 15/1/13.
//  Copyright (c) 2015年 TaoZeyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "AppDelegate.h"

@class Note;

@interface Group : NSManagedObject

@property (nonatomic, retain) NSDate * createAt;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Note *notes;

-(void) valuesInitWithName:(NSString *)name;
+(BOOL) insertDefaultGroupIfFirstLaunch:(AppDelegate *) appDelegate;
+(Group *) getDefaultGroup:(NSManagedObjectContext *)context;

@end
