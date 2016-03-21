//
//  WeakWeatherToday.m
//
//  Created by   on 15/12/17
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "WeakWeatherToday.h"
#import "WeakWeatherIndex.h"


NSString *const kWeakWeatherTodayFengli = @"fengli";
NSString *const kWeakWeatherTodayIndex = @"index";
NSString *const kWeakWeatherTodayAqi = @"aqi";
NSString *const kWeakWeatherTodayWeek = @"week";
NSString *const kWeakWeatherTodayHightemp = @"hightemp";
NSString *const kWeakWeatherTodayLowtemp = @"lowtemp";
NSString *const kWeakWeatherTodayDate = @"date";
NSString *const kWeakWeatherTodayFengxiang = @"fengxiang";
NSString *const kWeakWeatherTodayType = @"type";
NSString *const kWeakWeatherTodayCurTemp = @"curTemp";


@interface WeakWeatherToday ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation WeakWeatherToday

@synthesize fengli = _fengli;
@synthesize index = _index;
@synthesize aqi = _aqi;
@synthesize week = _week;
@synthesize hightemp = _hightemp;
@synthesize lowtemp = _lowtemp;
@synthesize date = _date;
@synthesize fengxiang = _fengxiang;
@synthesize type = _type;
@synthesize curTemp = _curTemp;


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
            self.fengli = [self objectOrNilForKey:kWeakWeatherTodayFengli fromDictionary:dict];
    NSObject *receivedWeakWeatherIndex = [dict objectForKey:kWeakWeatherTodayIndex];
    NSMutableArray *parsedWeakWeatherIndex = [NSMutableArray array];
    if ([receivedWeakWeatherIndex isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedWeakWeatherIndex) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedWeakWeatherIndex addObject:[WeakWeatherIndex modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedWeakWeatherIndex isKindOfClass:[NSDictionary class]]) {
       [parsedWeakWeatherIndex addObject:[WeakWeatherIndex modelObjectWithDictionary:(NSDictionary *)receivedWeakWeatherIndex]];
    }

    self.index = [NSArray arrayWithArray:parsedWeakWeatherIndex];
            self.aqi = [self objectOrNilForKey:kWeakWeatherTodayAqi fromDictionary:dict];
            self.week = [self objectOrNilForKey:kWeakWeatherTodayWeek fromDictionary:dict];
            self.hightemp = [self objectOrNilForKey:kWeakWeatherTodayHightemp fromDictionary:dict];
            self.lowtemp = [self objectOrNilForKey:kWeakWeatherTodayLowtemp fromDictionary:dict];
            self.date = [self objectOrNilForKey:kWeakWeatherTodayDate fromDictionary:dict];
            self.fengxiang = [self objectOrNilForKey:kWeakWeatherTodayFengxiang fromDictionary:dict];
            self.type = [self objectOrNilForKey:kWeakWeatherTodayType fromDictionary:dict];
            self.curTemp = [self objectOrNilForKey:kWeakWeatherTodayCurTemp fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.fengli forKey:kWeakWeatherTodayFengli];
    NSMutableArray *tempArrayForIndex = [NSMutableArray array];
    for (NSObject *subArrayObject in self.index) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForIndex addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForIndex addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForIndex] forKey:kWeakWeatherTodayIndex];
    [mutableDict setValue:self.aqi forKey:kWeakWeatherTodayAqi];
    [mutableDict setValue:self.week forKey:kWeakWeatherTodayWeek];
    [mutableDict setValue:self.hightemp forKey:kWeakWeatherTodayHightemp];
    [mutableDict setValue:self.lowtemp forKey:kWeakWeatherTodayLowtemp];
    [mutableDict setValue:self.date forKey:kWeakWeatherTodayDate];
    [mutableDict setValue:self.fengxiang forKey:kWeakWeatherTodayFengxiang];
    [mutableDict setValue:self.type forKey:kWeakWeatherTodayType];
    [mutableDict setValue:self.curTemp forKey:kWeakWeatherTodayCurTemp];

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

    self.fengli = [aDecoder decodeObjectForKey:kWeakWeatherTodayFengli];
    self.index = [aDecoder decodeObjectForKey:kWeakWeatherTodayIndex];
    self.aqi = [aDecoder decodeObjectForKey:kWeakWeatherTodayAqi];
    self.week = [aDecoder decodeObjectForKey:kWeakWeatherTodayWeek];
    self.hightemp = [aDecoder decodeObjectForKey:kWeakWeatherTodayHightemp];
    self.lowtemp = [aDecoder decodeObjectForKey:kWeakWeatherTodayLowtemp];
    self.date = [aDecoder decodeObjectForKey:kWeakWeatherTodayDate];
    self.fengxiang = [aDecoder decodeObjectForKey:kWeakWeatherTodayFengxiang];
    self.type = [aDecoder decodeObjectForKey:kWeakWeatherTodayType];
    self.curTemp = [aDecoder decodeObjectForKey:kWeakWeatherTodayCurTemp];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_fengli forKey:kWeakWeatherTodayFengli];
    [aCoder encodeObject:_index forKey:kWeakWeatherTodayIndex];
    [aCoder encodeObject:_aqi forKey:kWeakWeatherTodayAqi];
    [aCoder encodeObject:_week forKey:kWeakWeatherTodayWeek];
    [aCoder encodeObject:_hightemp forKey:kWeakWeatherTodayHightemp];
    [aCoder encodeObject:_lowtemp forKey:kWeakWeatherTodayLowtemp];
    [aCoder encodeObject:_date forKey:kWeakWeatherTodayDate];
    [aCoder encodeObject:_fengxiang forKey:kWeakWeatherTodayFengxiang];
    [aCoder encodeObject:_type forKey:kWeakWeatherTodayType];
    [aCoder encodeObject:_curTemp forKey:kWeakWeatherTodayCurTemp];
}

- (id)copyWithZone:(NSZone *)zone
{
    WeakWeatherToday *copy = [[WeakWeatherToday alloc] init];
    
    if (copy) {

        copy.fengli = [self.fengli copyWithZone:zone];
        copy.index = [self.index copyWithZone:zone];
        copy.aqi = [self.aqi copyWithZone:zone];
        copy.week = [self.week copyWithZone:zone];
        copy.hightemp = [self.hightemp copyWithZone:zone];
        copy.lowtemp = [self.lowtemp copyWithZone:zone];
        copy.date = [self.date copyWithZone:zone];
        copy.fengxiang = [self.fengxiang copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
        copy.curTemp = [self.curTemp copyWithZone:zone];
    }
    
    return copy;
}


@end
