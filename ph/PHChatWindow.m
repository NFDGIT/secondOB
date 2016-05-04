//
//  PHChatWindow.m
//  ph
//
//  Created by qingyun on 16/4/29.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "PHChatWindow.h"

@interface PHChatWindow ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITableView *chatView;
@property (strong, nonatomic) IBOutlet UITextField *chatField;

@end

@implementation PHChatWindow
static NSString * identifier=@"cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.navigationController.navigationBar.translucent=NO;

    self.chatView.delegate=self;
    self.chatView.dataSource=self;
    self.chatView.rowHeight=80;
    self.selfChats=[NSMutableArray array];
    
    
    self.chatField.delegate=self;
    

    [self.chatView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma  mark ---tableview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.selfChats.count>0) {
    return self.selfChats.count;
    }
    return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.textLabel.numberOfLines=0;
    cell.textLabel.text=self.selfChats[indexPath.row];
    
    return cell;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.chatField resignFirstResponder];
    self.view.transform=CGAffineTransformIdentity;
    
    
}
#pragma mark----textfield delegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    self.view.transform= CGAffineTransformMakeTranslation(0, -271);
    
    return YES;
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.text.length==0) {
        return YES;
    }
    [self.selfChats addObject:textField.text];
    textField.text=nil;
    
    [self.chatView reloadData];
    
    [textField resignFirstResponder];
    self.view.transform=CGAffineTransformIdentity;
    return YES;
}

@end
