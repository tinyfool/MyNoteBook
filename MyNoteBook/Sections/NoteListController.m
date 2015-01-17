//
//  NoteListController.m
//  MyNoteBook
//
//  Created by TaoZeyu on 15/1/13.
//  Copyright (c) 2015年 TaoZeyu. All rights reserved.
//

#import "NoteListController.h"
#import "AppDelegate.h"

#import "Note.h"
#import "Group.h"

@interface NoteListController ()

@property NSArray *notes;

@end

@implementation NoteListController

-(void)viewDidLoad
{
    [self showNotesInDefaultGroup];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
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
    [self reloadInputViews];
}

-(void) showNotesInGroup:(Group *) group
{
    self.notes = [group listNotes];
}

-(NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.notes count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:SimpleTableIdentifier];
    }
    cell.textLabel.text = [(Note *)self.notes[indexPath.row] title];
    
    return cell;
}
@end
