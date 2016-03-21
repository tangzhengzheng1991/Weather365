//
//  WeakWeatherRetData.m
//
//  Created by   on 15/12/17
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "WeakWeatherRetData.h"
#import "WeakWeatherHistory.h"
#import "WeakWeatherForecast.h"
#import "WeakWeatherToday.h"


NSString *const kWeakWeatherRetDataHistory = @"history";
NSString *const kWeakWeatherRetDataForecast = @"forecast";
NSString *const kWeakWeatherRetDataToday = @"today";
NSString *const kWeakWeatherRetDataCity = @"city";
NSString *const kWeakWeatherRetDataCityid = @"cityid";


@interface WeakWeatherRetData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation WeakWeatherRetData

@synthesize history = _history;
@synthesize forecast = _forecast;
@synthesize today = _today;
@synthesize city = _city;
@synthesize cityid = _cityid;


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
    NSObject *receivedWeakWeatherHistory = [dict objectForKey:kWeakWeatherRetDataHistory];
    NSMutableArray *parsedWeakWeatherHistory = [NSMutableArray array];
    if ([receivedWeakWeatherHistory isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedWeakWeatherHistory) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedWeakWeatherHistory addObject:[WeakWeatherHistory modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedWeakWeatherHistory isKindOfClass:[NSDictionary class]]) {
       [parsedWeakWeatherHistory addObject:[WeakWeatherHistory modelObjectWithDictionary:(NSDictionary *)receivedWeakWeatherHistory]];
    }

    self.history = [NSArray arrayWithArray:parsedWeakWeatherHistory];
    NSObject *receivedWeakWeatherForecast = [dict objectForKey:kWeakWeatherRetDataForecast];
    NSMutableArray *parsedWeakWeatherForecast = [NSMutableArray array];
    if ([receivedWeakWeatherForecast isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedWeakWeatherForecast) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedWeakWeatherForecast addObject:[WeakWeatherForecast modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedWeakWeatherForecast isKindOfClass:[NSDictionary class]]) {
       [parsedWeakWeatherForecast addObject:[WeakWeatherForecast modelObjectWithDictionary:(NSDictionary *)receivedWeakWeatherForecast]];
    }

    self.forecast = [NSArray arrayWithArray:parsedWeakWeatherForecast];
            self.today = [WeakWeatherToday modelObjectWithDictionary:[dict objectForKey:kWeakWeatherRetDataToday]];
            self.city = [self objectOrNilForKey:kWeakWeatherRetDataCity fromDictionary:dict];
            self.cityid = [self objectOrNilForKey:kWeakWeatherRetDataCityid fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForHistory = [NSMutableArray array];
    for (NSObject *subArrayObject in self.history) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForHistory addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForHistory addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForHistory] forKey:kWeakWeatherRetDataHistory];
    NSMutableArray *tempArrayForForecast = [NSMutableArray array];
    for (NSObject *subArrayObject in self.forecast) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForForecast addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForForecast addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForForecast] forKey:kWeakWeatherRetDataForecast];
    [mutableDict setValue:[self.today dictionaryRepresentation] forKey:kWeakWeatherRetDataToday];
    [mutableDict setValue:self.city forKey:kWeakWeatherRetDataCity];
    [mutableDict setValue:self.cityid forKey:kWeakWeatherRetDataCityid];

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

    self.history = [aDecoder decodeObjectForKey:kWeakWeatherRetDataHistory];
    self.forecast = [aDecoder decodeObjectForKey:kWeakWeatherRetDataForecast];
    self.today = [aDecoder decodeObjectForKey:kWeakWeatherRetDataToday];
    self.city = [aDecoder decodeObjectForKey:kWeakWeatherRetDataCity];
    self.cityid = [aDecoder decodeObjectForKey:kWeakWeatherRetDataCityid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_history forKey:kWeakWeatherRetDataHistory];
    [aCoder encodeObject:_forecast forKey:kWeakWeatherRetDataForecast];
    [aCoder encodeObject:_today forKey:kWeakWeatherRetDataToday];
    [aCoder encodeObject:_city forKey:kWeakWeatherRetDataCity];
    [aCoder encodeObject:_cityid forKey:kWeakWeatherRetDataCityid];
}

- (id)copyWithZone:(NSZone *)zone
{
    WeakWeatherRetData *copy = [[WeakWeatherRetData alloc] init];
    
    if (copy) {

        copy.history = [self.history copyWithZone:zone];
        copy.forecast = [self.forecast copyWithZone:zone];
        copy.today = [self.today copyWithZone:zone];
        copy.city = [self.city copyWithZone:zone];
        copy.cityid = [self.cityid copyWithZone:zone];
    }
    
    return copy;
}


@end
