//
//  WeakWeatherRetData.h
//
//  Created by   on 15/12/17
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WeakWeatherToday;

@interface WeakWeatherRetData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *history;
@property (nonatomic, strong) NSArray *forecast;
@property (nonatomic, strong) WeakWeatherToday *today;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *cityid;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
