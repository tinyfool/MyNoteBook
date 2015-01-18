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

@property (strong, nonatomic) Group* group;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationBar;

@end

@implementation NoteListController

-(void)viewDidLoad
{
    [super viewDidLoad];
    Group *defaultGroup = [Group getDefaultGroup:[self getContext]];
    [self setCurrentGroup:defaultGroup];
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
    NSLog(@"click create.");
    
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
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"%@", segue.identifier);
}

-(void)reciveNote:(Note *)note wantsCreate:(BOOL)wantsCreate
{
    if(!wantsCreate) {
        [self.getContext deleteObject:note];
    }
    [self saveContext];
    
    if(wantsCreate) {
        NSLog(@"%@", [self.group listNotes]);
        [self resetInfoArray:[self.group listNotes]];
    }
}

@end
