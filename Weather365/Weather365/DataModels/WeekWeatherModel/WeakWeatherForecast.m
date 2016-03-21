//
//  WeakWeatherForecast.m
//
//  Created by   on 15/12/17
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "WeakWeatherForecast.h"


NSString *const kWeakWeatherForecastFengli = @"fengli";
NSString *const kWeakWeatherForecastHightemp = @"hightemp";
NSString *const kWeakWeatherForecastWeek = @"week";
NSString *const kWeakWeatherForecastLowtemp = @"lowtemp";
NSString *const kWeakWeatherForecastDate = @"date";
NSString *const kWeakWeatherForecastType = @"type";
NSString *const kWeakWeatherForecastFengxiang = @"fengxiang";


@interface WeakWeatherForecast ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation WeakWeatherForecast

@synthesize fengli = _fengli;
@synthesize hightemp = _hightemp;
@synthesize week = _week;
@synthesize lowtemp = _lowtemp;
@synthesize date = _date;
@synthesize type = _type;
@synthesize fengxiang = _fengxiang;


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
            self.fengli = [self objectOrNilForKey:kWeakWeatherForecastFengli fromDictionary:dict];
            self.hightemp = [self objectOrNilForKey:kWeakWeatherForecastHightemp fromDictionary:dict];
            self.week = [self objectOrNilForKey:kWeakWeatherForecastWeek fromDictionary:dict];
            self.lowtemp = [self objectOrNilForKey:kWeakWeatherForecastLowtemp fromDictionary:dict];
            self.date = [self objectOrNilForKey:kWeakWeatherForecastDate fromDictionary:dict];
            self.type = [self objectOrNilForKey:kWeakWeatherForecastType fromDictionary:dict];
            self.fengxiang = [self objectOrNilForKey:kWeakWeatherForecastFengxiang fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.fengli forKey:kWeakWeatherForecastFengli];
    [mutableDict setValue:self.hightemp forKey:kWeakWeatherForecastHightemp];
    [mutableDict setValue:self.week forKey:kWeakWeatherForecastWeek];
    [mutableDict setValue:self.lowtemp forKey:kWeakWeatherForecastLowtemp];
    [mutableDict setValue:self.date forKey:kWeakWeatherForecastDate];
    [mutableDict setValue:self.type forKey:kWeakWeatherForecastType];
    [mutableDict setValue:self.fengxiang forKey:kWeakWeatherForecastFengxiang];

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

    self.fengli = [aDecoder decodeObjectForKey:kWeakWeatherForecastFengli];
    self.hightemp = [aDecoder decodeObjectForKey:kWeakWeatherForecastHightemp];
    self.week = [aDecoder decodeObjectForKey:kWeakWeatherForecastWeek];
    self.lowtemp = [aDecoder decodeObjectForKey:kWeakWeatherForecastLowtemp];
    self.date = [aDecoder decodeObjectForKey:kWeakWeatherForecastDate];
    self.type = [aDecoder decodeObjectForKey:kWeakWeatherForecastType];
    self.fengxiang = [aDecoder decodeObjectForKey:kWeakWeatherForecastFengxiang];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_fengli forKey:kWeakWeatherForecastFengli];
    [aCoder encodeObject:_hightemp forKey:kWeakWeatherForecastHightemp];
    [aCoder encodeObject:_week forKey:kWeakWeatherForecastWeek];
    [aCoder encodeObject:_lowtemp forKey:kWeakWeatherForecastLowtemp];
    [aCoder encodeObject:_date forKey:kWeakWeatherForecastDate];
    [aCoder encodeObject:_type forKey:kWeakWeatherForecastType];
    [aCoder encodeObject:_fengxiang forKey:kWeakWeatherForecastFengxiang];
}

- (id)copyWithZone:(NSZone *)zone
{
    WeakWeatherForecast *copy = [[WeakWeatherForecast alloc] init];
    
    if (copy) {

        copy.fengli = [self.fengli copyWithZone:zone];
        copy.hightemp = [self.hightemp copyWithZone:zone];
        copy.week = [self.week copyWithZone:zone];
        copy.lowtemp = [self.lowtemp copyWithZone:zone];
        copy.date = [self.date copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
        copy.fengxiang = [self.fengxiang copyWithZone:zone];
    }
    
    return copy;
}


@end
