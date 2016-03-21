//
//  WeakWeatherForecast.h
//
//  Created by   on 15/12/17
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface WeakWeatherForecast : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *fengli;
@property (nonatomic, strong) NSString *hightemp;
@property (nonatomic, strong) NSString *week;
@property (nonatomic, strong) NSString *lowtemp;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *fengxiang;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
