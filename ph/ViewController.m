//
//  ViewController.m
//  ph
//
//  Created by qingyun on 16/4/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDKUI.h>
#import <objc/message.h>
#import "PHChatWindow.h"



@interface ViewController ()
@property (nonatomic,strong)NSString *s1;
@property (nonatomic,strong)NSString *s2;
@property (nonatomic,assign)NSInteger c1;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    unsigned int count;
    
    Method *methods=class_copyMethodList([self class], &count);
    
    Ivar *ivars=class_copyIvarList([self class], &count);
    
    
    
#if 0
for (int i; i<count+1; i++) {
        Ivar ivar=ivars[i];
        const char *name=ivar_getName(ivar);
        NSLog(@"%s",name);
        
    }
#else
    for (int i; i<count; i++) {
        Method method=methods[i];
        const char *name=method_getName(method);
        NSLog(@"%s",name);
  
    }
    
#endif
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)chat:(UIBarButtonItem *)sender {
    PHChatWindow *chatwindow=[[PHChatWindow alloc]initWithNibName:NSStringFromClass([PHChatWindow class]) bundle:nil];
    
    [self.navigationController pushViewController:chatwindow animated:YES];

}

- (IBAction)shareBtn:(UIButton *)sender {

    NSArray* imageArray = @[[UIImage imageNamed:@"333.png"]];
    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://mob.com"]
                                          title:@"分享标题"
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        
        
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];}
    
    
    
    
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
