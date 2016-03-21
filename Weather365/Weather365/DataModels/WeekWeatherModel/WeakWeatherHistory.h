//
//  WeakWeatherHistory.h
//
//  Created by   on 15/12/17
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface WeakWeatherHistory : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *fengli;
@property (nonatomic, strong) NSString *aqi;
@property (nonatomic, strong) NSString *week;
@property (nonatomic, strong) NSString *lowtemp;
@property (nonatomic, strong) NSString *hightemp;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *fengxiang;
@property (nonatomic, strong) NSString *type;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
