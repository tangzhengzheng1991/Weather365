//
//  todayDetailsRetData.m
//
//  Created by   on 15/12/27
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "todayDetailsRetData.h"


NSString *const ktodayDetailsRetDataPostCode = @"postCode";
NSString *const ktodayDetailsRetDataHTmp = @"h_tmp";
NSString *const ktodayDetailsRetDataTemp = @"temp";
NSString *const ktodayDetailsRetDataLTmp = @"l_tmp";
NSString *const ktodayDetailsRetDataTime = @"time";
NSString *const ktodayDetailsRetDataLongitude = @"longitude";
NSString *const ktodayDetailsRetDataLatitude = @"latitude";
NSString *const ktodayDetailsRetDataWD = @"WD";
NSString *const ktodayDetailsRetDataPinyin = @"pinyin";
NSString *const ktodayDetailsRetDataDate = @"date";
NSString *const ktodayDetailsRetDataWeather = @"weather";
NSString *const ktodayDetailsRetDataCity = @"city";
NSString *const ktodayDetailsRetDataCitycode = @"citycode";
NSString *const ktodayDetailsRetDataWS = @"WS";
NSString *const ktodayDetailsRetDataSunrise = @"sunrise";
NSString *const ktodayDetailsRetDataAltitude = @"altitude";
NSString *const ktodayDetailsRetDataSunset = @"sunset";


@interface todayDetailsRetData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation todayDetailsRetData

@synthesize postCode = _postCode;
@synthesize hTmp = _hTmp;
@synthesize temp = _temp;
@synthesize lTmp = _lTmp;
@synthesize time = _time;
@synthesize longitude = _longitude;
@synthesize latitude = _latitude;
@synthesize wD = _wD;
@synthesize pinyin = _pinyin;
@synthesize date = _date;
@synthesize weather = _weather;
@synthesize city = _city;
@synthesize citycode = _citycode;
@synthesize wS = _wS;
@synthesize sunrise = _sunrise;
@synthesize altitude = _altitude;
@synthesize sunset = _sunset;


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
            self.postCode = [self objectOrNilForKey:ktodayDetailsRetDataPostCode fromDictionary:dict];
            self.hTmp = [self objectOrNilForKey:ktodayDetailsRetDataHTmp fromDictionary:dict];
            self.temp = [self objectOrNilForKey:ktodayDetailsRetDataTemp fromDictionary:dict];
            self.lTmp = [self objectOrNilForKey:ktodayDetailsRetDataLTmp fromDictionary:dict];
            self.time = [self objectOrNilForKey:ktodayDetailsRetDataTime fromDictionary:dict];
            self.longitude = [[self objectOrNilForKey:ktodayDetailsRetDataLongitude fromDictionary:dict] doubleValue];
            self.latitude = [[self objectOrNilForKey:ktodayDetailsRetDataLatitude fromDictionary:dict] doubleValue];
            self.wD = [self objectOrNilForKey:ktodayDetailsRetDataWD fromDictionary:dict];
            self.pinyin = [self objectOrNilForKey:ktodayDetailsRetDataPinyin fromDictionary:dict];
            self.date = [self objectOrNilForKey:ktodayDetailsRetDataDate fromDictionary:dict];
            self.weather = [self objectOrNilForKey:ktodayDetailsRetDataWeather fromDictionary:dict];
            self.city = [self objectOrNilForKey:ktodayDetailsRetDataCity fromDictionary:dict];
            self.citycode = [self objectOrNilForKey:ktodayDetailsRetDataCitycode fromDictionary:dict];
            self.wS = [self objectOrNilForKey:ktodayDetailsRetDataWS fromDictionary:dict];
            self.sunrise = [self objectOrNilForKey:ktodayDetailsRetDataSunrise fromDictionary:dict];
            self.altitude = [self objectOrNilForKey:ktodayDetailsRetDataAltitude fromDictionary:dict];
            self.sunset = [self objectOrNilForKey:ktodayDetailsRetDataSunset fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.postCode forKey:ktodayDetailsRetDataPostCode];
    [mutableDict setValue:self.hTmp forKey:ktodayDetailsRetDataHTmp];
    [mutableDict setValue:self.temp forKey:ktodayDetailsRetDataTemp];
    [mutableDict setValue:self.lTmp forKey:ktodayDetailsRetDataLTmp];
    [mutableDict setValue:self.time forKey:ktodayDetailsRetDataTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.longitude] forKey:ktodayDetailsRetDataLongitude];
    [mutableDict setValue:[NSNumber numberWithDouble:self.latitude] forKey:ktodayDetailsRetDataLatitude];
    [mutableDict setValue:self.wD forKey:ktodayDetailsRetDataWD];
    [mutableDict setValue:self.pinyin forKey:ktodayDetailsRetDataPinyin];
    [mutableDict setValue:self.date forKey:ktodayDetailsRetDataDate];
    [mutableDict setValue:self.weather forKey:ktodayDetailsRetDataWeather];
    [mutableDict setValue:self.city forKey:ktodayDetailsRetDataCity];
    [mutableDict setValue:self.citycode forKey:ktodayDetailsRetDataCitycode];
    [mutableDict setValue:self.wS forKey:ktodayDetailsRetDataWS];
    [mutableDict setValue:self.sunrise forKey:ktodayDetailsRetDataSunrise];
    [mutableDict setValue:self.altitude forKey:ktodayDetailsRetDataAltitude];
    [mutableDict setValue:self.sunset forKey:ktodayDetailsRetDataSunset];

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

    self.postCode = [aDecoder decodeObjectForKey:ktodayDetailsRetDataPostCode];
    self.hTmp = [aDecoder decodeObjectForKey:ktodayDetailsRetDataHTmp];
    self.temp = [aDecoder decodeObjectForKey:ktodayDetailsRetDataTemp];
    self.lTmp = [aDecoder decodeObjectForKey:ktodayDetailsRetDataLTmp];
    self.time = [aDecoder decodeObjectForKey:ktodayDetailsRetDataTime];
    self.longitude = [aDecoder decodeDoubleForKey:ktodayDetailsRetDataLongitude];
    self.latitude = [aDecoder decodeDoubleForKey:ktodayDetailsRetDataLatitude];
    self.wD = [aDecoder decodeObjectForKey:ktodayDetailsRetDataWD];
    self.pinyin = [aDecoder decodeObjectForKey:ktodayDetailsRetDataPinyin];
    self.date = [aDecoder decodeObjectForKey:ktodayDetailsRetDataDate];
    self.weather = [aDecoder decodeObjectForKey:ktodayDetailsRetDataWeather];
    self.city = [aDecoder decodeObjectForKey:ktodayDetailsRetDataCity];
    self.citycode = [aDecoder decodeObjectForKey:ktodayDetailsRetDataCitycode];
    self.wS = [aDecoder decodeObjectForKey:ktodayDetailsRetDataWS];
    self.sunrise = [aDecoder decodeObjectForKey:ktodayDetailsRetDataSunrise];
    self.altitude = [aDecoder decodeObjectForKey:ktodayDetailsRetDataAltitude];
    self.sunset = [aDecoder decodeObjectForKey:ktodayDetailsRetDataSunset];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_postCode forKey:ktodayDetailsRetDataPostCode];
    [aCoder encodeObject:_hTmp forKey:ktodayDetailsRetDataHTmp];
    [aCoder encodeObject:_temp forKey:ktodayDetailsRetDataTemp];
    [aCoder encodeObject:_lTmp forKey:ktodayDetailsRetDataLTmp];
    [aCoder encodeObject:_time forKey:ktodayDetailsRetDataTime];
    [aCoder encodeDouble:_longitude forKey:ktodayDetailsRetDataLongitude];
    [aCoder encodeDouble:_latitude forKey:ktodayDetailsRetDataLatitude];
    [aCoder encodeObject:_wD forKey:ktodayDetailsRetDataWD];
    [aCoder encodeObject:_pinyin forKey:ktodayDetailsRetDataPinyin];
    [aCoder encodeObject:_date forKey:ktodayDetailsRetDataDate];
    [aCoder encodeObject:_weather forKey:ktodayDetailsRetDataWeather];
    [aCoder encodeObject:_city forKey:ktodayDetailsRetDataCity];
    [aCoder encodeObject:_citycode forKey:ktodayDetailsRetDataCitycode];
    [aCoder encodeObject:_wS forKey:ktodayDetailsRetDataWS];
    [aCoder encodeObject:_sunrise forKey:ktodayDetailsRetDataSunrise];
    [aCoder encodeObject:_altitude forKey:ktodayDetailsRetDataAltitude];
    [aCoder encodeObject:_sunset forKey:ktodayDetailsRetDataSunset];
}

- (id)copyWithZone:(NSZone *)zone
{
    todayDetailsRetData *copy = [[todayDetailsRetData alloc] init];
    
    if (copy) {

        copy.postCode = [self.postCode copyWithZone:zone];
        copy.hTmp = [self.hTmp copyWithZone:zone];
        copy.temp = [self.temp copyWithZone:zone];
        copy.lTmp = [self.lTmp copyWithZone:zone];
        copy.time = [self.time copyWithZone:zone];
        copy.longitude = self.longitude;
        copy.latitude = self.latitude;
        copy.wD = [self.wD copyWithZone:zone];
        copy.pinyin = [self.pinyin copyWithZone:zone];
        copy.date = [self.date copyWithZone:zone];
        copy.weather = [self.weather copyWithZone:zone];
        copy.city = [self.city copyWithZone:zone];
        copy.citycode = [self.citycode copyWithZone:zone];
        copy.wS = [self.wS copyWithZone:zone];
        copy.sunrise = [self.sunrise copyWithZone:zone];
        copy.altitude = [self.altitude copyWithZone:zone];
        copy.sunset = [self.sunset copyWithZone:zone];
    }
    
    return copy;
}


@end
