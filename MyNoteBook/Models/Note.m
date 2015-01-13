//
//  Note.m
//  MyNoteBook
//
//  Created by TaoZeyu on 15/1/13.
//  Copyright (c) 2015年 TaoZeyu. All rights reserved.
//

#import "Note.h"
#import "Group.h"


@implementation Note

@dynamic content;
@dynamic createAt;
@dynamic lastEditAt;
@dynamic title;
@dynamic group;

-(instancetype)initWithTitle:(NSString *)title withContent:(NSString *)content withGroup:(Group *)group
{
    self = [super init];
    if(self) {
        self.title = title;
        self.content = content;
        self.group = group;
        [self setCreateAndEditTimeToCurrent];
    }
    return self;
}

-(void)setCreateAndEditTimeToCurrent
{
    self.createAt = [NSDate date];
    self.lastEditAt = [NSDate date];
}

@end
