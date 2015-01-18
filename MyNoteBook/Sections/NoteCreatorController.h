//
//  NoteCreatorController.h
//  MyNoteBook
//
//  Created by TaoZeyu on 15/1/18.
//  Copyright (c) 2015年 TaoZeyu. All rights reserved.
//

#import "InfoFromModelTableViewController.h"
#import "NoteListController.h"
#import "Note.h"

@interface NoteCreatorController : UIViewController <UIActionSheetDelegate>

@property (readwrite) SEL doneCallback;

-(void)valuesInitWithParent:(NoteListController *)parent withNote:(Note *)note isNew:(BOOL)isNew;

@end