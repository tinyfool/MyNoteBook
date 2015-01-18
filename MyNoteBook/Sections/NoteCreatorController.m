//
//  NoteCreatorController.m
//  MyNoteBook
//
//  Created by TaoZeyu on 15/1/18.
//  Copyright (c) 2015年 TaoZeyu. All rights reserved.
//

#import "NoteCreatorController.h"

@interface NoteCreatorController()

@property BOOL cancelAndExitAfterCloseDialog;

@property (strong, nonatomic) NoteListController *parent;
@property (strong, nonatomic) Note *currentNote;
@property BOOL willCreateNew;

@property (strong, nonatomic) NSString *oldTitle;
@property (strong, nonatomic) NSString *oldContent;

@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextView *contentField;

@end

@implementation NoteCreatorController

-(void)valuesInitWithParent:(NoteListController *)parent withNote:(Note *)note isNew:(BOOL)isNew
{
    self.currentNote = note;
    self.parent = parent;
    self.willCreateNew = isNew;
}

-(void)viewDidLoad
{
    if(!self.willCreateNew)
    {
        self.titleField.text = self.currentNote.title;
        self.contentField.text = self.currentNote.content;
        
        self.oldTitle = self.currentNote.title;
        self.oldContent = self.currentNote.content;
        
        self.navigationItem.title = @"编辑";
        
    } else {
        self.navigationItem.title = @"新建";
        
        self.oldTitle = @"";
        self.oldContent = @"";
    }
}

- (IBAction)clickCancel:(id)sender
{
    if([self hasEditContent]) {
        UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:@"你所进行的修改将丢失，确定要返回吗？"
                                                         delegate:self
                                                cancelButtonTitle:@"取消"
                                           destructiveButtonTitle:@"确定"
                                                otherButtonTitles: nil];
        [sheet showInView:self.view];
        self.cancelAndExitAfterCloseDialog = YES;
        
    } else {
        [self cancelAndExit];
    }
}

-(BOOL)hasEditContent
{
    NSLog(@"- '%@' '%@'", self.titleField.text.description, self.oldTitle.description);
    return  ![self.titleField.text.description isEqualToString: self.oldTitle] ||
            ![self.contentField.text.description isEqualToString:self.oldContent];
}

-(void)cancelAndExit
{
    [self.parent reciveNote: self.currentNote wantsCreate:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickDone:(id)sender
{
    if([self checkAndExhibitErrorInfo]) {
        self.currentNote.title = self.titleField.text;
        self.currentNote.content = self.contentField.text;
        self.currentNote.lastEditAt = [NSDate date];
        
        [self.parent reciveNote: self.currentNote wantsCreate:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(BOOL)checkAndExhibitErrorInfo
{
    if([self checkContentCanSubmit]) {
        return YES;
    }
    UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:@"标题和内容都不能为空。"
                                                   delegate:self
                                          cancelButtonTitle:nil
                                     destructiveButtonTitle:@"知道了"
                                          otherButtonTitles: nil];
    [sheet showInView:self.view];
    self.cancelAndExitAfterCloseDialog = NO;
    
    return NO;
}

-(BOOL)checkContentCanSubmit
{
    return  ![self.titleField.text isEqualToString:@""] &&
            ![self.contentField.text isEqualToString:@""];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(self.cancelAndExitAfterCloseDialog && !buttonIndex) {
        [self cancelAndExit];
    }
}

@end
