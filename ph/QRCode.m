//
//  CodeVC.m
//  ph
//
//  Created by qingyun on 16/4/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QRCode.h"
#import <AVFoundation/AVFoundation.h>



@interface QRCode ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic,strong)AVCaptureDevice *device;
@property (nonatomic,strong)AVCaptureDeviceInput *input;
@property (nonatomic,strong)AVCaptureSession *session;
@property (nonatomic,strong)AVCaptureMetadataOutput * output;
@property (nonatomic,strong)UIImageView *inamationView;
@property (nonatomic,strong)NSTimer *timer;

@end

@implementation QRCode

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setImageView{
    UIImage *image=[UIImage imageNamed:@""];
    
    
}
-(void)changeImage{

    
}

-(void)reading{
    //初始化采集的环境
//    1.确定设备
    self.device=[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //2.构建intput
    NSError *error;
    
    
    self.input=[AVCaptureDeviceInput deviceInputWithDevice:self.device error:&error];
    

    
    self.output=[[AVCaptureMetadataOutput alloc]init];
    
    self.session=[[AVCaptureSession alloc]init];
    
    [self.session addInput:self.input];
    [self.session addOutput:self.output];
    
    //5.配置output
    dispatch_queue_t queue=dispatch_queue_create("myQueue", NULL);
    
    
    [self.output setMetadataObjectsDelegate:self queue:queue];
    
    
    [self.output setMetadataObjectTypes:self.output.availableMetadataObjectTypes];
    
    //6.设置预览效果
    AVCaptureVideoPreviewLayer *layer=[[AVCaptureVideoPreviewLayer alloc]initWithSession:self.session];
    [layer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    
    [self.session startRunning];
    
    
}

-(void)stopRead{
    [self.session stopRunning];
}


-(void)result:(NSString *)urlstring{
    
    
}



#pragma  mark --matedate
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count==0) {
        return;
    }
    id object=metadataObjects[0];
    if ([object isKindOfClass:[AVMetadataMachineReadableCodeObject class]]) {
        AVMetadataMachineReadableCodeObject *obj=(AVMetadataMachineReadableCodeObject *)object;
        [self performSelectorOnMainThread:@selector(result:) withObject:obj.stringValue waitUntilDone:NO];
    }
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
