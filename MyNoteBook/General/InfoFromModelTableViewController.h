//
//  InfoFromModelTableViewController.h
//  MyNoteBook
//
//  Created by TaoZeyu on 15/1/18.
//  Copyright (c) 2015年 TaoZeyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoFromModelTableViewController : UITableViewController

@property (readonly) NSArray *infoArray;

-(NSManagedObjectContext *) getContext;
-(void)saveContext;
-(void)resetInfoArray:(NSArray *)infoArray;
-(void)setInfoToCell:(UITableViewCell *)cell from:(id)info;
-(void)clickCreateLine;
-(void)clickLineWithIndex:(NSInteger)index;
-(void)longPressLineWithIndex:(NSInteger) index;

@end
