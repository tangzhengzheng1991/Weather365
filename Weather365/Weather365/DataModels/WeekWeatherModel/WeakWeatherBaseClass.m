//
//  WeakWeatherBaseClass.m
//
//  Created by   on 15/12/17
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "WeakWeatherBaseClass.h"
#import "WeakWeatherRetData.h"


NSString *const kWeakWeatherBaseClassErrMsg = @"errMsg";
NSString *const kWeakWeatherBaseClassErrNum = @"errNum";
NSString *const kWeakWeatherBaseClassRetData = @"retData";


@interface WeakWeatherBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation WeakWeatherBaseClass

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
            self.errMsg = [self objectOrNilForKey:kWeakWeatherBaseClassErrMsg fromDictionary:dict];
            self.errNum = [[self objectOrNilForKey:kWeakWeatherBaseClassErrNum fromDictionary:dict] doubleValue];
            self.retData = [WeakWeatherRetData modelObjectWithDictionary:[dict objectForKey:kWeakWeatherBaseClassRetData]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.errMsg forKey:kWeakWeatherBaseClassErrMsg];
    [mutableDict setValue:[NSNumber numberWithDouble:self.errNum] forKey:kWeakWeatherBaseClassErrNum];
    [mutableDict setValue:[self.retData dictionaryRepresentation] forKey:kWeakWeatherBaseClassRetData];

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

    self.errMsg = [aDecoder decodeObjectForKey:kWeakWeatherBaseClassErrMsg];
    self.errNum = [aDecoder decodeDoubleForKey:kWeakWeatherBaseClassErrNum];
    self.retData = [aDecoder decodeObjectForKey:kWeakWeatherBaseClassRetData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_errMsg forKey:kWeakWeatherBaseClassErrMsg];
    [aCoder encodeDouble:_errNum forKey:kWeakWeatherBaseClassErrNum];
    [aCoder encodeObject:_retData forKey:kWeakWeatherBaseClassRetData];
}

- (id)copyWithZone:(NSZone *)zone
{
    WeakWeatherBaseClass *copy = [[WeakWeatherBaseClass alloc] init];
    
    if (copy) {

        copy.errMsg = [self.errMsg copyWithZone:zone];
        copy.errNum = self.errNum;
        copy.retData = [self.retData copyWithZone:zone];
    }
    
    return copy;
}


@end
