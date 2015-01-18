//
//  Group.h
//  MyNoteBook
//
//  Created by TaoZeyu on 15/1/16.
//  Copyright (c) 2015年 TaoZeyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "AppDelegate.h"

@class Note;

@interface Group : NSManagedObject

@property (nonatomic, retain) NSDate * createAt;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *notes;
@end

@interface Group (CoreDataGeneratedAccessors)

-(void)valuesInitWithName:(NSString *)name;
-(NSArray *)listNotes;

- (void)addNotesObject:(Note *)value;
- (void)removeNotesObject:(Note *)value;
- (void)addNotes:(NSSet *)values;
- (void)removeNotes:(NSSet *)values;
-(BOOL)isDefaultGroup;

+(BOOL) insertDefaultGroupIfFirstLaunch:(AppDelegate *) appDelegate;
+(Group *) createGroupWithName:(NSString *)name inContext:(NSManagedObjectContext *)context;
+(Group *) getDefaultGroup:(NSManagedObjectContext *)context;
+(NSArray *)listAllGroups:(NSManagedObjectContext *)context;

@end
