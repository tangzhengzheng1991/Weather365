//
//  todayDetailsBaseClass.m
//
//  Created by   on 15/12/27
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "todayDetailsBaseClass.h"
#import "todayDetailsRetData.h"


NSString *const ktodayDetailsBaseClassErrMsg = @"errMsg";
NSString *const ktodayDetailsBaseClassErrNum = @"errNum";
NSString *const ktodayDetailsBaseClassRetData = @"retData";


@interface todayDetailsBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation todayDetailsBaseClass

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
            self.errMsg = [self objectOrNilForKey:ktodayDetailsBaseClassErrMsg fromDictionary:dict];
            self.errNum = [[self objectOrNilForKey:ktodayDetailsBaseClassErrNum fromDictionary:dict] doubleValue];
            self.retData = [todayDetailsRetData modelObjectWithDictionary:[dict objectForKey:ktodayDetailsBaseClassRetData]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.errMsg forKey:ktodayDetailsBaseClassErrMsg];
    [mutableDict setValue:[NSNumber numberWithDouble:self.errNum] forKey:ktodayDetailsBaseClassErrNum];
    [mutableDict setValue:[self.retData dictionaryRepresentation] forKey:ktodayDetailsBaseClassRetData];

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

    self.errMsg = [aDecoder decodeObjectForKey:ktodayDetailsBaseClassErrMsg];
    self.errNum = [aDecoder decodeDoubleForKey:ktodayDetailsBaseClassErrNum];
    self.retData = [aDecoder decodeObjectForKey:ktodayDetailsBaseClassRetData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_errMsg forKey:ktodayDetailsBaseClassErrMsg];
    [aCoder encodeDouble:_errNum forKey:ktodayDetailsBaseClassErrNum];
    [aCoder encodeObject:_retData forKey:ktodayDetailsBaseClassRetData];
}

- (id)copyWithZone:(NSZone *)zone
{
    todayDetailsBaseClass *copy = [[todayDetailsBaseClass alloc] init];
    
    if (copy) {

        copy.errMsg = [self.errMsg copyWithZone:zone];
        copy.errNum = self.errNum;
        copy.retData = [self.retData copyWithZone:zone];
    }
    
    return copy;
}


@end
