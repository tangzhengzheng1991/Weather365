//
//  DefineAlertView.h
//  CustomerAlertView
//
//  Created by qgy on 15/4/6.
//  Copyright (c) 2015年 qgy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DefineAlertView : UIView
@property (nonatomic,unsafe_unretained) id delegate;
@property (nonatomic,strong) UIView     *titleView;
@property (nonatomic,strong) UILabel    *titleLabel;
-(id)initWithTitle:(NSString *)title andChooseButtonTitles:(NSMutableArray *)titles;
-(void)show;
-(void)dismiss;
@end

@protocol DefineAlertView <NSObject>

-(void)clickButton:(NSInteger) buttonTag andChooseView:(DefineAlertView *)view;

@end
