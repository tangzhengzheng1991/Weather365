//
//  todayDetailsRetData.h
//
//  Created by   on 15/12/27
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface todayDetailsRetData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *postCode;
@property (nonatomic, strong) NSString *hTmp;
@property (nonatomic, strong) NSString *temp;
@property (nonatomic, strong) NSString *lTmp;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, assign) double longitude;
@property (nonatomic, assign) double latitude;
@property (nonatomic, strong) NSString *wD;
@property (nonatomic, strong) NSString *pinyin;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *weather;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *citycode;
@property (nonatomic, strong) NSString *wS;
@property (nonatomic, strong) NSString *sunrise;
@property (nonatomic, strong) NSString *altitude;
@property (nonatomic, strong) NSString *sunset;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
