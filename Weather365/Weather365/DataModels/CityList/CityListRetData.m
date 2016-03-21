//
//  CityListRetData.m
//
//  Created by   on 15/12/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "CityListRetData.h"


NSString *const kCityListRetDataNameCn = @"name_cn";
NSString *const kCityListRetDataNameEn = @"name_en";
NSString *const kCityListRetDataProvinceCn = @"province_cn";
NSString *const kCityListRetDataDistrictCn = @"district_cn";
NSString *const kCityListRetDataAreaId = @"area_id";


@interface CityListRetData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CityListRetData

@synthesize nameCn = _nameCn;
@synthesize nameEn = _nameEn;
@synthesize provinceCn = _provinceCn;
@synthesize districtCn = _districtCn;
@synthesize areaId = _areaId;


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
            self.nameCn = [self objectOrNilForKey:kCityListRetDataNameCn fromDictionary:dict];
            self.nameEn = [self objectOrNilForKey:kCityListRetDataNameEn fromDictionary:dict];
            self.provinceCn = [self objectOrNilForKey:kCityListRetDataProvinceCn fromDictionary:dict];
            self.districtCn = [self objectOrNilForKey:kCityListRetDataDistrictCn fromDictionary:dict];
            self.areaId = [self objectOrNilForKey:kCityListRetDataAreaId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.nameCn forKey:kCityListRetDataNameCn];
    [mutableDict setValue:self.nameEn forKey:kCityListRetDataNameEn];
    [mutableDict setValue:self.provinceCn forKey:kCityListRetDataProvinceCn];
    [mutableDict setValue:self.districtCn forKey:kCityListRetDataDistrictCn];
    [mutableDict setValue:self.areaId forKey:kCityListRetDataAreaId];

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

    self.nameCn = [aDecoder decodeObjectForKey:kCityListRetDataNameCn];
    self.nameEn = [aDecoder decodeObjectForKey:kCityListRetDataNameEn];
    self.provinceCn = [aDecoder decodeObjectForKey:kCityListRetDataProvinceCn];
    self.districtCn = [aDecoder decodeObjectForKey:kCityListRetDataDistrictCn];
    self.areaId = [aDecoder decodeObjectForKey:kCityListRetDataAreaId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_nameCn forKey:kCityListRetDataNameCn];
    [aCoder encodeObject:_nameEn forKey:kCityListRetDataNameEn];
    [aCoder encodeObject:_provinceCn forKey:kCityListRetDataProvinceCn];
    [aCoder encodeObject:_districtCn forKey:kCityListRetDataDistrictCn];
    [aCoder encodeObject:_areaId forKey:kCityListRetDataAreaId];
}

- (id)copyWithZone:(NSZone *)zone
{
    CityListRetData *copy = [[CityListRetData alloc] init];
    
    if (copy) {

        copy.nameCn = [self.nameCn copyWithZone:zone];
        copy.nameEn = [self.nameEn copyWithZone:zone];
        copy.provinceCn = [self.provinceCn copyWithZone:zone];
        copy.districtCn = [self.districtCn copyWithZone:zone];
        copy.areaId = [self.areaId copyWithZone:zone];
    }
    
    return copy;
}


@end
