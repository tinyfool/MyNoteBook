//
//  NoteListController.m
//  MyNoteBook
//
//  Created by TaoZeyu on 15/1/13.
//  Copyright (c) 2015年 TaoZeyu. All rights reserved.
//

#import "NoteListController.h"
#import "AppDelegate.h"

#import "Group.h"

@implementation NoteListController

-(void)viewDidLoad
{
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    [self showNotesInDefaultGroup];
    return [super numberOfSectionsInTableView:tableView];
}

-(NSManagedObjectContext *) getContext
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    return [appDelegate managedObjectContext];
}

-(void) showNotesInDefaultGroup
{
    NSManagedObjectContext *context = [self getContext];
    [self showNotesInGroup: [Group getDefaultGroup:context]];
}

-(void) showNotesInGroup:(Group *) group
{
}

@end
