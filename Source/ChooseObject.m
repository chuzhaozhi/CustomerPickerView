//
// Created by chzuhaozhi.
//

#import "ChooseObject.h"
#import "Tools.h"

@implementation ChooseObjcet

-(instancetype)init{

    self = [super init];
    if(self){

        self.chooseID = @"0";
        self.chooseName = @"";

    }
    return self;
}

-(instancetype)initWithDic:(NSDictionary*)dic{
    self = [super init];
    if(self){

        self.chooseID = dic[@"id"];
        self.chooseName = dic[@"name"];
        if([Tools dicContain:dic withKey:@"guidelimit"]){
            self.guideLimit = [dic[@"guidelimit"] integerValue];
        }
    }
    return self;
}

+(NSArray*)initWithArr:(NSArray*)arr{

    NSMutableArray *array = [NSMutableArray array];
    for(NSDictionary *dic in arr){
        ChooseObjcet *info = [[ChooseObjcet alloc] initWithDic:dic];
        [array addObject:info];
    }
    return [NSArray arrayWithArray:array];

}

@end
