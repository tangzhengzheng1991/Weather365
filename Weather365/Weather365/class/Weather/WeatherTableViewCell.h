//
//  WeatherTableViewCell.h
//  HowFarToGo
//
//  Created by tangzhengzheng on 15/12/27.
//  Copyright © 2015年 TianDiHuaYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherTableViewCell : UITableViewCell

@property (nonatomic,strong)NSString *cityName;

@property (weak, nonatomic) IBOutlet UIButton *currentCityButton;

//@property (weak, nonatomic) IBOutlet UILabel *currentCity;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

//- (IBAction)refreshData:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *TodayWeatherIcon;
@property (weak, nonatomic) IBOutlet UILabel *TodayDate;
@property (weak, nonatomic) IBOutlet UILabel *TodayWeather;
@property (weak, nonatomic) IBOutlet UILabel *TodayWeek;

@property (weak, nonatomic) IBOutlet UILabel *TodayTemperature;
@property (weak, nonatomic) IBOutlet UILabel *currentTemperature;
@property (weak, nonatomic) IBOutlet UILabel *currentWindDirection;
@property (weak, nonatomic) IBOutlet UILabel *currentWindPower;

@property (weak, nonatomic) IBOutlet UILabel *sunriseTime;

@property (weak, nonatomic) IBOutlet UILabel *sunsetTime;
@property (weak, nonatomic) IBOutlet UIImageView *sunriseAndSunsetImage;




@property (weak, nonatomic) IBOutlet UILabel *secondDateWeak;
@property (weak, nonatomic) IBOutlet UIImageView *secondWeatherIcon;
@property (weak, nonatomic) IBOutlet UILabel *secondWeather;
@property (weak, nonatomic) IBOutlet UILabel *secondTemperature;


@property (weak, nonatomic) IBOutlet UILabel *thirdDateWeak;
@property (weak, nonatomic) IBOutlet UIImageView *thirdWeatherIcon;
@property (weak, nonatomic) IBOutlet UILabel *thirdWeather;
@property (weak, nonatomic) IBOutlet UILabel *thirdTemperature;

@property (weak, nonatomic) IBOutlet UILabel *fourthDateWeak;
@property (weak, nonatomic) IBOutlet UIImageView *fourthWeatherIcon;
@property (weak, nonatomic) IBOutlet UILabel *fourthWeather;
@property (weak, nonatomic) IBOutlet UILabel *fourthTemperature;


@property (weak, nonatomic) IBOutlet UILabel *fifthDateWeak;
@property (weak, nonatomic) IBOutlet UIImageView *fifthWeatherIcon;
@property (weak, nonatomic) IBOutlet UILabel *fifthWeather;
@property (weak, nonatomic) IBOutlet UILabel *fifthTemperature;
@end
