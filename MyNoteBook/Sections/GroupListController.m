//
//  GroupListController.m
//  MyNoteBook
//
//  Created by TaoZeyu on 15/1/18.
//  Copyright (c) 2015年 TaoZeyu. All rights reserved.
//

#import "GroupListController.h"
#import "Group.h"

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
    NSLog(@"Entered: %lu %@", buttonIndex, [[alertView textFieldAtIndex:0] text]);
    
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
    [sheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //notify error dialog closed.
    
}

-(void)setInfoToCell:(UITableViewCell *)cell from:(id)info
{
    Group *group = (Group *)info;
    cell.textLabel.text = group.name;
}

@end
