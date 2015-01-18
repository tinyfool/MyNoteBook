//
//  NoteListController.h
//  MyNoteBook
//
//  Created by TaoZeyu on 15/1/13.
//  Copyright (c) 2015年 TaoZeyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoFromModelTableViewController.h"
#import "Note.h"

@interface NoteListController : InfoFromModelTableViewController<UIGestureRecognizerDelegate, UIActionSheetDelegate>

-(void)cancelCreateNote:(Note *)note;
-(void)submitNoteEditOrCreate:(Note *)note;
-(void)setCurrentGroup:(Group *)group;

@end
