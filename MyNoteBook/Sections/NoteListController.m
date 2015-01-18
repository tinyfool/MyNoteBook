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

#import "NoteCreatorController.h"

@interface NoteListController()

@property NSInteger longPressIndex;
@property (strong, nonatomic) Group* group;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationBar;

@end

@implementation NoteListController

-(void)viewDidLoad
{
    [super viewDidLoad];
    Group *defaultGroup = [Group getDefaultGroup:[self getContext]];
    [self setCurrentGroup:defaultGroup];
    
    [self registerLongPressEvents];
}


-(void) registerLongPressEvents
{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
                                               initWithTarget:self
                                               action:@selector(myHandleTableviewCellLongPressed:)];
    
    longPress.delegate = self;
    longPress.minimumPressDuration = 1.0;
    [self.tableView addGestureRecognizer:longPress];
}

- (void) myHandleTableviewCellLongPressed:(UILongPressGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        NSLog(@"UIGestureRecognizerStateBegan");
    }
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        NSLog(@"UIGestureRecognizerStateChanged");
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        NSLog(@"UIGestureRecognizerStateEnded");
    }
}


-(void)setInfoToCell:(UITableViewCell *)cell from:(id)info
{
    Note *note = (Note *)info;
    cell.textLabel.text = note.title;
    cell.detailTextLabel.text = note.content;
}

-(void)setCurrentGroup:(Group *)group
{
    self.navigationBar.title = group.name;
    [self resetInfoArray: [group listNotes]];
    self.group = group;
}

-(void)clickCreateLine
{
    Note *note = [NSEntityDescription
                  insertNewObjectForEntityForName: @"Note"
                  inManagedObjectContext: [self getContext]];
    
    [note valuesInitWithTitle:nil
                  withContent:nil
                    withGroup:self.group];
    
    NoteCreatorController *viewController=[self.storyboard instantiateViewControllerWithIdentifier:@"NoteCreatorController"];
    [viewController valuesInitWithParent:self
                                withNote:note
                                   isNew:YES];
    [self.navigationController pushViewController:viewController animated:YES];
    
}

-(void)clickLineWithIndex:(NSInteger)index
{
    Note *note = (Note *)self.infoArray[index];
    NoteCreatorController *viewController=[self.storyboard instantiateViewControllerWithIdentifier:@"NoteCreatorController"];
    [viewController valuesInitWithParent:self
                                withNote:note
                                   isNew:NO];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(void)longPressLineWithIndex:(NSInteger)index
{
    UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:@"确定要删除这条笔记吗？删除之后不能恢复。"
                                                     delegate:self
                                            cancelButtonTitle:@"取消"
                                       destructiveButtonTitle:@"确认删除"
                                            otherButtonTitles: nil];
    self.longPressIndex = index;
    [sheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(!buttonIndex && self.longPressIndex != -1) {
        Note *note = (Note *)self.infoArray[self.longPressIndex];
        [self.getContext deleteObject:note];
        [self saveContext];
        [self resetInfoArray:self.group.listNotes];
    }
}

-(void)cancelCreateNote:(Note *)note
{
    [self.getContext deleteObject:note];
    [self saveContext];
}

-(void)submitNoteEditOrCreate:(Note *)note
{
    [self saveContext];
    [self resetInfoArray:[self.group listNotes]];
}

@end
