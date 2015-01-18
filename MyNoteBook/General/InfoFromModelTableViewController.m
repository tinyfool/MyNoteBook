//
//  InfoFromModelTableViewController.m
//  MyNoteBook
//
//  Created by TaoZeyu on 15/1/18.
//  Copyright (c) 2015年 TaoZeyu. All rights reserved.
//

#import "InfoFromModelTableViewController.h"

#import "NoteListController.h"
#import "AppDelegate.h"

#import "Note.h"
#import "Group.h"

@interface InfoFromModelTableViewController()

@property (strong, nonatomic) NSArray *infoArray;

@end

@implementation InfoFromModelTableViewController

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    NSInteger index = indexPath.row;
//    if(index == 0) {
//        [self clickCreateLine];
//    } else {
//        [self clickLineWithIndex: index - 1];
//    }
//}

-(void)saveContext
{
    NSError *error;
    BOOL success = [self.getContext save:&error];
    if(!success) {
        NSLog(@"save context error: %@", error.description);
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.showCreateNewLine) {
        return [self.infoArray count] + 1;
    } else {
        return [self.infoArray count];
    }
}

-(void)resetInfoArray:(NSArray *)infoArray
{
    self.infoArray = infoArray;
    [self.tableView reloadData];
}

-(BOOL)showCreateNewLine
{
    return YES;
}

-(void)setInfoToCell:(UITableViewCell *)cell from:(id)info
{
    //To be override.
}

-(void)clickCreateLine
{
    //To be override.
}

-(void)clickLineWithIndex:(NSInteger)index
{
    //To be override.
}

-(void)longPressLineWithIndex:(NSInteger) index
{
    //To be override.
}

-(NSManagedObjectContext *) getContext
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    return [appDelegate managedObjectContext];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:SimpleTableIdentifier];
        
        [self registerEventsFromCell:cell indexPath:indexPath];
    }
    if(self.showCreateNewLine) {
        if(indexPath.row == 0) {
            [self setCreateToCell:cell];
        } else {
            [self setInfoToCell:cell from:self.infoArray[indexPath.row - 1]];
        }
    } else {
        [self setInfoToCell:cell from:self.infoArray[indexPath.row]];
    }
    
    return cell;
}

-(void)registerEventsFromCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleCellTapped:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    tapGestureRecognizer.numberOfTouchesRequired = 1;
    cell.tag = indexPath.row;
    [cell addGestureRecognizer:tapGestureRecognizer];
    
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 1.0;
    [cell addGestureRecognizer:lpgr];
}

-(void)handleCellTapped:(UITapGestureRecognizer *)tap
{
    NSInteger index = [self getCellIndexFromEvent:tap];
    
    if(self.showCreateNewLine) {
        if(index == 0) {
            [self clickCreateLine];
        } else {
            [self clickLineWithIndex: index - 1];
        }
    } else {
        [self clickLineWithIndex: index];
    }
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)longPress
{
    if(longPress.state != UIGestureRecognizerStateBegan) {
        return;
    }
    NSInteger index = [self getCellIndexFromEvent:longPress];
    
    if(self.showCreateNewLine) {
        if(index != 0) {
            [self longPressLineWithIndex: index - 1];
        }
    } else {
        [self longPressLineWithIndex: index];
    }
}

-(NSInteger)getCellIndexFromEvent:(UIGestureRecognizer *)tapEvent
{
    CGPoint touchPoint = [tapEvent locationInView:self.view];
    NSIndexPath* indexPath = [self.tableView indexPathForRowAtPoint:touchPoint];
    return indexPath.row;
}

-(void)setCreateToCell:(UITableViewCell *)cell
{
    cell.textLabel.text = @"（新建）";
    cell.detailTextLabel.text = @"";
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
}

@end
