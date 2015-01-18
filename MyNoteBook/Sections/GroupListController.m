//
//  GroupListController.m
//  MyNoteBook
//
//  Created by TaoZeyu on 15/1/18.
//  Copyright (c) 2015年 TaoZeyu. All rights reserved.
//

#import "GroupListController.h"
#import "Group.h"

@interface GroupListController()

@property NSInteger deleteIndex;

@end

@implementation GroupListController

-(BOOL)showCreateNewLine
{
    return NO;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self resetInfoArray: [Group listAllGroups: [self getContext]]];
}

- (IBAction)clickAddGroup:(id)sender
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"分组名称"
                                                     message:@"新建"
                                                    delegate:self
                                           cancelButtonTitle:@"取消"
                                           otherButtonTitles:@"确定", nil];
    
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    //input dialog closed.
    
    if(buttonIndex) {
        NSString *name = [[alertView textFieldAtIndex:0] text];
        if([name isEqualToString: @""]) {
            [self showErrorNotifyMessage:@"分组名称不能为空！"];
        } else {
            Group *group = [Group createGroupWithName:name inContext:[self getContext]];
            
            if(group == nil) {
                [self showErrorNotifyMessage:@"该分组名称已存在，请换一个名称。"];
            } else {
                [self saveContext];
                [self resetInfoArray:[Group listAllGroups:[self getContext]]];
            }
        }
    }
}

-(void)showErrorNotifyMessage:(NSString *)message
{
    UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:message
                                                     delegate:self
                                            cancelButtonTitle:nil
                                       destructiveButtonTitle:@"知道了"
                                            otherButtonTitles: nil];
    self.deleteIndex = -1;
    [sheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //notify error dialog closed.
    
    if(self.deleteIndex != -1 && !buttonIndex) {
        NSLog(@"start to delete '%@' of index %lu.", [(Group *) self.infoArray[self.deleteIndex] name], self.deleteIndex);
        [[self getContext] deleteObject:(Group *) self.infoArray[self.deleteIndex]];
        [self saveContext];
        
        [self resetInfoArray:[Group listAllGroups:[self getContext]]];
    }
}

-(void)longPressLineWithIndex:(NSInteger) index
{
    Group *group = (Group *) self.infoArray[index];
    if(group.isDefaultGroup) {
        [self showErrorNotifyMessage:@"不可以删除默认分组！"];
    } else {
        UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:@"你确定要删除这个分组吗？\n删除之后，该分组及分组里的所有笔记将不复存在。该操作也无法撤销。"
                                                         delegate:self
                                                cancelButtonTitle:@"取消"
                                           destructiveButtonTitle:@"确认删除"
                                                otherButtonTitles: nil];
        self.deleteIndex = index;
        [sheet showInView:self.view];
    }
}

-(void)setInfoToCell:(UITableViewCell *)cell from:(id)info
{
    Group *group = (Group *)info;
    cell.textLabel.text = group.name;
}

@end
