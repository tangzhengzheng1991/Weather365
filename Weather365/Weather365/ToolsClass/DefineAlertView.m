//
//  DefineAlertView.m
//  CustomerAlertView
//
//  Created by qgy on 15/4/6.
//  Copyright (c) 2015年 qgy. All rights reserved.
//

#import "DefineAlertView.h"

@implementation DefineAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithTitle:(NSString *)title andChooseButtonTitles:(NSMutableArray *)titles;
{
    if (self) {
        self = [super init];
        if([self checkDevice:@"iPhone"])
        {
            self.frame=CGRectMake(0,0 , 200, 40+(30+10)*titles.count);
            NSLog(@"isIphone");
        }
        if ([self checkDevice:@"iPad"]) {
            NSLog(@"=====");
            self.frame=CGRectMake(0, 0, 300, 220);
        }
        if ([self checkDevice:@"iPod"]) {
            NSLog(@"-----");
            self.frame=CGRectMake(0,0 , 200, 120);
        }
        self.backgroundColor = [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:0.8];
        _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 39)];
        _titleView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_titleView];
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 39)];
        _titleLabel.textColor = DDCOLOR;
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
        _titleLabel.text = title;
        [self addSubview:_titleLabel];
        for (int i =0; i<titles.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, 40+(30+10)*i, 200, 39);
            btn.tag = i;
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitle:[NSString stringWithFormat:@"%@",titles[i]] forState:UIControlStateNormal];
            btn.titleLabel.font = DD_BIG_FONT;
            btn.titleLabel.textAlignment = NSTextAlignmentLeft;
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [btn addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitleColor:[UIColor colorWithRed:103.0/255 green:105.0/255 blue:110.0/255 alpha:1] forState:UIControlStateNormal];
            [self addSubview:btn];
        }
       
        

        
    }
    return self;
}
-(void)selectBtn:(UIButton *)button
{
    [self.delegate clickButton:button.tag andChooseView:self];
}


-(void)show;
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    //    [topView addSubview:self];
    self.center=window.center;
    
    [window addSubview:self];
    [self showAnimation];
}
-(void)showAnimation
{
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.layer addAnimation:popAnimation forKey:nil];
}
-(void)dismiss
{
    [self hideAnimation];
}
-(void)hideAnimation
{
    [UIView animateWithDuration:0.4 animations:^{
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
-(void)clickButton:(NSInteger)buttonTag
{
    NSLog(@"dianjile ");
}
#pragma mark---------检查设备
-(bool)checkDevice:(NSString*)name
{
    NSString* deviceType = [UIDevice currentDevice].model;
    NSRange range = [deviceType rangeOfString:name];
    return range.location != NSNotFound;
}

@end
