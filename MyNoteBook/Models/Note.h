//
//  Note.h
//  MyNoteBook
//
//  Created by TaoZeyu on 15/1/13.
//  Copyright (c) 2015年 TaoZeyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Group;

@interface Note : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSDate * createAt;
@property (nonatomic, retain) NSDate * lastEditAt;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) Group *group;

-(void)valuesInitWithTitle:(NSString *)title withContent:(NSString *)content withGroup:(Group *)group;

@end
