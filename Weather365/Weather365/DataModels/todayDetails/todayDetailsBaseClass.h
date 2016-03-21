//
//  todayDetailsBaseClass.h
//
//  Created by   on 15/12/27
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class todayDetailsRetData;

@interface todayDetailsBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *errMsg;
@property (nonatomic, assign) double errNum;
@property (nonatomic, strong) todayDetailsRetData *retData;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
