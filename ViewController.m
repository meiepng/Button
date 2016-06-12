//
//  ViewController.m
//  Button
//3
//  Created by mac on 16/5/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#define NightSkinIsDown @"nightSkinIsDown"
#define kSpace 20

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btn;

- (IBAction)top:(id)sender;
- (IBAction)down:(id)sender;
- (IBAction)left:(id)sender;
- (IBAction)right:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *xuanzhuan;
- (IBAction)rocation:(id)sender;

@property (nonatomic,assign) BOOL nightSkinIsdown;
@property (nonatomic,weak) NSTimer *timer;
@property (nonatomic,assign) int count;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _nightSkinIsdown = [[NSUserDefaults standardUserDefaults] objectForKey:NightSkinIsDown];
    [_xuanzhuan setImage:[UIImage imageNamed:_nightSkinIsdown ? @"sidebar_nightmode_on" : @"sidebar_nightmode_off" ] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)top:(id)sender {
    CGFloat img_w=_btn.imageView.frame.size.width;
    CGFloat img_h=_btn.imageView.frame.size.height;
    CGFloat tit_w=_btn.titleLabel.frame.size.width;
    CGFloat tit_h=_btn.titleLabel.frame.size.height;
    _btn.titleEdgeInsets=UIEdgeInsetsMake((img_h/2+kSpace/2), -img_w/2, -(img_h/2+kSpace/2), img_w/2);
    _btn.imageEdgeInsets=UIEdgeInsetsMake(-(tit_h/2+kSpace/2), tit_w/2, (tit_h/2+kSpace/2), -tit_w/2);
}

- (IBAction)down:(id)sender {
    CGFloat img_w=_btn.imageView.frame.size.width;
    CGFloat img_h=_btn.imageView.frame.size.height;
    CGFloat tit_w=_btn.titleLabel.frame.size.width;
    CGFloat tit_h=_btn.titleLabel.frame.size.height;
    _btn.titleEdgeInsets=UIEdgeInsetsMake(-(img_h/2+kSpace/2), -img_w/2, (img_h/2+kSpace/2), img_w/2);
    _btn.imageEdgeInsets=UIEdgeInsetsMake((tit_h/2+kSpace/2), tit_w/2, -(tit_h/2+kSpace/2), -tit_w/2);
}

- (IBAction)left:(id)sender {
    _btn.titleEdgeInsets=UIEdgeInsetsMake(0, (0+kSpace/2), 0, (0-kSpace/2));
    _btn.imageEdgeInsets=UIEdgeInsetsMake(0, (0-kSpace/2), 0, (0+kSpace/2));
}

- (IBAction)right:(id)sender {
    CGFloat img_w=_btn.imageView.frame.size.width;
    CGFloat tit_w=_btn.titleLabel.frame.size.width;
    _btn.titleEdgeInsets=UIEdgeInsetsMake(0, -(img_w+kSpace/2), 0, (img_w+kSpace/2));
    _btn.imageEdgeInsets=UIEdgeInsetsMake(0, (tit_w+kSpace/2), 0, -(tit_w+kSpace/2));
    
}
- (IBAction)rocation:(id)sender {
    //判断皮肤是否下载
    if(_nightSkinIsdown){
        _xuanzhuan.selected = !_xuanzhuan.selected;
        [_xuanzhuan setImage:[UIImage imageNamed:_xuanzhuan.selected ? @"sidebar_nightmode_on" : @"sidebar_nightmode_off"] forState:UIControlStateNormal];
        return;
    }
    //开始旋转
    [_xuanzhuan setImage:[UIImage imageNamed:@"sidebar_nightmode_loading"] forState:UIControlStateNormal];
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 7;  //转7次
    rotationAnimation.delegate = self;
    [_xuanzhuan.imageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.07 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
    _timer = timer;
}

-(void)timerFired
{
    _count++;
    if (_count == 101) {
        [_timer invalidate];
        [_xuanzhuan setImage:[UIImage imageNamed:@"sidebar_nightmode_on"] forState:UIControlStateNormal];
        //存储皮肤下载记录
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:NightSkinIsDown];
        [[NSUserDefaults standardUserDefaults] synchronize];
        _nightSkinIsdown = YES;
        return;
    }
    
    NSString *str = @"%";
    NSString *count = [NSString stringWithFormat:@"%d",_count];
    [_xuanzhuan setTitle:[str stringByAppendingString:count] forState:UIControlStateNormal];
}
@end
