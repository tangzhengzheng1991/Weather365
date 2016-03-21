//
//  CityListRetData.h
//
//  Created by   on 15/12/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CityListRetData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *nameCn;
@property (nonatomic, strong) NSString *nameEn;
@property (nonatomic, strong) NSString *provinceCn;
@property (nonatomic, strong) NSString *districtCn;
@property (nonatomic, strong) NSString *areaId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
