//
//  CustomChoosePickerView.h
//  WL
//
//  Created by chuzhaozhi on
//

#import <UIKit/UIKit.h>

@class ChooseObjcet;

@interface CustomChoosePickerView : UIView
/**
 用来储存选中模型
 */
@property (nonatomic, strong) NSMutableArray<ChooseObjcet *>* chooseModelArr;

/**
 *  地址选择器
 */
@property (nonatomic,strong)UIPickerView *pickerView;
/**
 用来储存待选arr
 */
@property (nonatomic, strong) NSMutableArray <NSArray*>*dataArr;

-(void)showWithData:(void (^)(CustomChoosePickerView *pick,NSInteger row,NSString *chooseID))data withComponentCount:(NSInteger)componentCount finish:(void (^)(NSArray<ChooseObjcet *>* object))block;

- (void)getDataListWithModel:(ChooseObjcet*)object withComponent:(NSInteger)component;

@end
