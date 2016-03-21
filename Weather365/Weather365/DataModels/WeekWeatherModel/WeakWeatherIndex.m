//
//  WeakWeatherIndex.m
//
//  Created by   on 15/12/17
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "WeakWeatherIndex.h"


NSString *const kWeakWeatherIndexCode = @"code";
NSString *const kWeakWeatherIndexDetails = @"details";
NSString *const kWeakWeatherIndexName = @"name";
NSString *const kWeakWeatherIndexOtherName = @"otherName";
NSString *const kWeakWeatherIndexIndex = @"index";


@interface WeakWeatherIndex ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation WeakWeatherIndex

@synthesize code = _code;
@synthesize details = _details;
@synthesize name = _name;
@synthesize otherName = _otherName;
@synthesize index = _index;


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
            self.code = [self objectOrNilForKey:kWeakWeatherIndexCode fromDictionary:dict];
            self.details = [self objectOrNilForKey:kWeakWeatherIndexDetails fromDictionary:dict];
            self.name = [self objectOrNilForKey:kWeakWeatherIndexName fromDictionary:dict];
            self.otherName = [self objectOrNilForKey:kWeakWeatherIndexOtherName fromDictionary:dict];
            self.index = [self objectOrNilForKey:kWeakWeatherIndexIndex fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.code forKey:kWeakWeatherIndexCode];
    [mutableDict setValue:self.details forKey:kWeakWeatherIndexDetails];
    [mutableDict setValue:self.name forKey:kWeakWeatherIndexName];
    [mutableDict setValue:self.otherName forKey:kWeakWeatherIndexOtherName];
    [mutableDict setValue:self.index forKey:kWeakWeatherIndexIndex];

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

    self.code = [aDecoder decodeObjectForKey:kWeakWeatherIndexCode];
    self.details = [aDecoder decodeObjectForKey:kWeakWeatherIndexDetails];
    self.name = [aDecoder decodeObjectForKey:kWeakWeatherIndexName];
    self.otherName = [aDecoder decodeObjectForKey:kWeakWeatherIndexOtherName];
    self.index = [aDecoder decodeObjectForKey:kWeakWeatherIndexIndex];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_code forKey:kWeakWeatherIndexCode];
    [aCoder encodeObject:_details forKey:kWeakWeatherIndexDetails];
    [aCoder encodeObject:_name forKey:kWeakWeatherIndexName];
    [aCoder encodeObject:_otherName forKey:kWeakWeatherIndexOtherName];
    [aCoder encodeObject:_index forKey:kWeakWeatherIndexIndex];
}

- (id)copyWithZone:(NSZone *)zone
{
    WeakWeatherIndex *copy = [[WeakWeatherIndex alloc] init];
    
    if (copy) {

        copy.code = [self.code copyWithZone:zone];
        copy.details = [self.details copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.otherName = [self.otherName copyWithZone:zone];
        copy.index = [self.index copyWithZone:zone];
    }
    
    return copy;
}


@end
