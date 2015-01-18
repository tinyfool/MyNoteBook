//
//  GroupListController.h
//  MyNoteBook
//
//  Created by TaoZeyu on 15/1/18.
//  Copyright (c) 2015年 TaoZeyu. All rights reserved.
//

#import "InfoFromModelTableViewController.h"
#import "NoteListController.h"

@interface GroupListController : InfoFromModelTableViewController<UIAlertViewDelegate, UIActionSheetDelegate>

-(void)valuesInitWith:(NoteListController *)parent;

@end
