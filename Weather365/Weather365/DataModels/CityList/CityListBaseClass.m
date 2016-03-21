//
//  CityListBaseClass.m
//
//  Created by   on 15/12/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "CityListBaseClass.h"
#import "CityListRetData.h"


NSString *const kCityListBaseClassErrMsg = @"errMsg";
NSString *const kCityListBaseClassErrNum = @"errNum";
NSString *const kCityListBaseClassRetData = @"retData";


@interface CityListBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CityListBaseClass

@synthesize errMsg = _errMsg;
@synthesize errNum = _errNum;
@synthesize retData = _retData;


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
            self.errMsg = [self objectOrNilForKey:kCityListBaseClassErrMsg fromDictionary:dict];
            self.errNum = [[self objectOrNilForKey:kCityListBaseClassErrNum fromDictionary:dict] doubleValue];
    NSObject *receivedCityListRetData = [dict objectForKey:kCityListBaseClassRetData];
    NSMutableArray *parsedCityListRetData = [NSMutableArray array];
    if ([receivedCityListRetData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedCityListRetData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedCityListRetData addObject:[CityListRetData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedCityListRetData isKindOfClass:[NSDictionary class]]) {
       [parsedCityListRetData addObject:[CityListRetData modelObjectWithDictionary:(NSDictionary *)receivedCityListRetData]];
    }

    self.retData = [NSArray arrayWithArray:parsedCityListRetData];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.errMsg forKey:kCityListBaseClassErrMsg];
    [mutableDict setValue:[NSNumber numberWithDouble:self.errNum] forKey:kCityListBaseClassErrNum];
    NSMutableArray *tempArrayForRetData = [NSMutableArray array];
    for (NSObject *subArrayObject in self.retData) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForRetData addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForRetData addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForRetData] forKey:kCityListBaseClassRetData];

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

    self.errMsg = [aDecoder decodeObjectForKey:kCityListBaseClassErrMsg];
    self.errNum = [aDecoder decodeDoubleForKey:kCityListBaseClassErrNum];
    self.retData = [aDecoder decodeObjectForKey:kCityListBaseClassRetData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_errMsg forKey:kCityListBaseClassErrMsg];
    [aCoder encodeDouble:_errNum forKey:kCityListBaseClassErrNum];
    [aCoder encodeObject:_retData forKey:kCityListBaseClassRetData];
}

- (id)copyWithZone:(NSZone *)zone
{
    CityListBaseClass *copy = [[CityListBaseClass alloc] init];
    
    if (copy) {

        copy.errMsg = [self.errMsg copyWithZone:zone];
        copy.errNum = self.errNum;
        copy.retData = [self.retData copyWithZone:zone];
    }
    
    return copy;
}


@end
