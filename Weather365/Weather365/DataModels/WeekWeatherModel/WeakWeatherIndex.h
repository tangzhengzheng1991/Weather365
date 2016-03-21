//
//  WeakWeatherIndex.h
//
//  Created by   on 15/12/17
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface WeakWeatherIndex : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *details;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *otherName;
@property (nonatomic, strong) NSString *index;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
