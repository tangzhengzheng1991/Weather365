//
//  WeakWeatherHistory.m
//
//  Created by   on 15/12/17
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "WeakWeatherHistory.h"


NSString *const kWeakWeatherHistoryFengli = @"fengli";
NSString *const kWeakWeatherHistoryAqi = @"aqi";
NSString *const kWeakWeatherHistoryWeek = @"week";
NSString *const kWeakWeatherHistoryLowtemp = @"lowtemp";
NSString *const kWeakWeatherHistoryHightemp = @"hightemp";
NSString *const kWeakWeatherHistoryDate = @"date";
NSString *const kWeakWeatherHistoryFengxiang = @"fengxiang";
NSString *const kWeakWeatherHistoryType = @"type";


@interface WeakWeatherHistory ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation WeakWeatherHistory

@synthesize fengli = _fengli;
@synthesize aqi = _aqi;
@synthesize week = _week;
@synthesize lowtemp = _lowtemp;
@synthesize hightemp = _hightemp;
@synthesize date = _date;
@synthesize fengxiang = _fengxiang;
@synthesize type = _type;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.fengli = [self objectOrNilForKey:kWeakWeatherHistoryFengli fromDictionary:dict];
            self.aqi = [self objectOrNilForKey:kWeakWeatherHistoryAqi fromDictionary:dict];
            self.week = [self objectOrNilForKey:kWeakWeatherHistoryWeek fromDictionary:dict];
            self.lowtemp = [self objectOrNilForKey:kWeakWeatherHistoryLowtemp fromDictionary:dict];
            self.hightemp = [self objectOrNilForKey:kWeakWeatherHistoryHightemp fromDictionary:dict];
            self.date = [self objectOrNilForKey:kWeakWeatherHistoryDate fromDictionary:dict];
            self.fengxiang = [self objectOrNilForKey:kWeakWeatherHistoryFengxiang fromDictionary:dict];
            self.type = [self objectOrNilForKey:kWeakWeatherHistoryType fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.fengli forKey:kWeakWeatherHistoryFengli];
    [mutableDict setValue:self.aqi forKey:kWeakWeatherHistoryAqi];
    [mutableDict setValue:self.week forKey:kWeakWeatherHistoryWeek];
    [mutableDict setValue:self.lowtemp forKey:kWeakWeatherHistoryLowtemp];
    [mutableDict setValue:self.hightemp forKey:kWeakWeatherHistoryHightemp];
    [mutableDict setValue:self.date forKey:kWeakWeatherHistoryDate];
    [mutableDict setValue:self.fengxiang forKey:kWeakWeatherHistoryFengxiang];
    [mutableDict setValue:self.type forKey:kWeakWeatherHistoryType];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.fengli = [aDecoder decodeObjectForKey:kWeakWeatherHistoryFengli];
    self.aqi = [aDecoder decodeObjectForKey:kWeakWeatherHistoryAqi];
    self.week = [aDecoder decodeObjectForKey:kWeakWeatherHistoryWeek];
    self.lowtemp = [aDecoder decodeObjectForKey:kWeakWeatherHistoryLowtemp];
    self.hightemp = [aDecoder decodeObjectForKey:kWeakWeatherHistoryHightemp];
    self.date = [aDecoder decodeObjectForKey:kWeakWeatherHistoryDate];
    self.fengxiang = [aDecoder decodeObjectForKey:kWeakWeatherHistoryFengxiang];
    self.type = [aDecoder decodeObjectForKey:kWeakWeatherHistoryType];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_fengli forKey:kWeakWeatherHistoryFengli];
    [aCoder encodeObject:_aqi forKey:kWeakWeatherHistoryAqi];
    [aCoder encodeObject:_week forKey:kWeakWeatherHistoryWeek];
    [aCoder encodeObject:_lowtemp forKey:kWeakWeatherHistoryLowtemp];
    [aCoder encodeObject:_hightemp forKey:kWeakWeatherHistoryHightemp];
    [aCoder encodeObject:_date forKey:kWeakWeatherHistoryDate];
    [aCoder encodeObject:_fengxiang forKey:kWeakWeatherHistoryFengxiang];
    [aCoder encodeObject:_type forKey:kWeakWeatherHistoryType];
}

- (id)copyWithZone:(NSZone *)zone
{
    WeakWeatherHistory *copy = [[WeakWeatherHistory alloc] init];
    
    if (copy) {

        copy.fengli = [self.fengli copyWithZone:zone];
        copy.aqi = [self.aqi copyWithZone:zone];
        copy.week = [self.week copyWithZone:zone];
        copy.lowtemp = [self.lowtemp copyWithZone:zone];
        copy.hightemp = [self.hightemp copyWithZone:zone];
        copy.date = [self.date copyWithZone:zone];
        copy.fengxiang = [self.fengxiang copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
    }
    
    return copy;
}


@end
