//
//  ModelHeader.h
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/15.
//  Copyright © 2019 yue. All rights reserved.
//

#import "YYKit.h"

#define PropCopy(type, name) @property(copy, nonatomic) type  * name;

#define PropAssign(type, name) @property(assign, nonatomic) type name;


//可以参考 https://blog.csdn.net/lvchaman/article/details/71080178
#define YYModelWhiteList(array) + (NSArray *)modelPropertyWhitelist {\
    return array;\
}\

#define YYModelCustomPropertyMapper(dict) + (NSDictionary *)modelCustomPropertyMapper {\
return (dict) ;\
}\

// 返回容器类中的所需要存放的数据类型 (以 Class 或 Class Name 的形式)。
#define YYModelContainerPropertyGenericClass(dict)    + (NSDictionary *)modelContainerPropertyGenericClass {\
    return dict ;\
}\

#define YYModelCommon - (NSString *)description {\
    return [self modelDescription];\
}\
- (void)encodeWithCoder:(NSCoder *)aCoder {\
 [self modelEncodeWithCoder:aCoder];\
}\
- (id)initWithCoder:(NSCoder *)aDecoder {\
  self = [super init];\
  return [self modelInitWithCoder:aDecoder];\
}\
- (id)copyWithZone:(NSZone *)zone {\
 return [self modelCopy];\
}\
- (NSUInteger)hash {\
 return [self modelHash];\
}\
- (BOOL)isEqual:(id)object {\
 return [self modelIsEqual:object];\
}\

#define  POSTER_FISHES  -(void)posterAndFishesCompatible:(NSDictionary *)dic {\
    NSArray * posters_fishes = @[@"posters",@"fishes"];\
    for (NSString *pf in posters_fishes) {\
        id value = dic[pf];\
        if (value == nil) {\
            continue;\
        }\
        if ([value isKindOfClass:[NSString class]]) {\
      NSString * p_f =      [value stringByReplacingOccurrencesOfString:@"，" withString:@","];\
            [self setValue:p_f forKey:pf];\
        }\
    }\
}\

#define YYModelDate( array ) - (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {\
NSMutableArray * items = [NSMutableArray  arrayWithArray:@[@"createTime",@"updateTime"]];\
   [items addObjectsFromArray:array];\
    for (NSString *item in items) {\
        id value = dic[item];\
        if (value == nil) {\
            continue;\
        }\
        NSNumber *timestamp = nil;\
        if ([value isKindOfClass:[NSNumber class]]) {\
            timestamp = value;\
        }else{\
    timestamp =        [NSNumber numberWithString:value];\
        }\
           if (![timestamp isKindOfClass:[NSNumber class]])\
               continue;\
            NSDate * dateItem = [NSDate dateWithTimeIntervalSince1970:timestamp.doubleValue/1000.0];\
        if ([self respondsToSelector:NSSelectorFromString(item)]) {\
            [self setValue:dateItem forKey:item];\
        }\
    }\
if ([self respondsToSelector:@selector(posterAndFishesCompatible:)]) {\
[self performSelector:@selector(posterAndFishesCompatible:) withObject:dic];\
}\
    return YES;\
}\
