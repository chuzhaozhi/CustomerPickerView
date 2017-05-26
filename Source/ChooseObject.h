//
// Created by chuzhaozhi 
//

#import <Foundation/Foundation.h>

@interface ChooseObjcet:NSObject

@property (nonatomic, copy) NSString *chooseName;
@property (nonatomic, copy) NSString *chooseID;
@property (nonatomic, copy) NSString *parentID;
@property (nonatomic, assign) NSInteger guideLimit;
@property (nonatomic, assign) BOOL choose;

+(NSArray*)initWithArr:(NSArray*)arr;

@end
