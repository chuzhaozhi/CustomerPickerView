//
//  CustomerPickerView.h
//
//
//  Created by chuzhaozhi on 
//

@interface DateChoosePickerView : UIView

@property (nonatomic,copy) NSString *dateFormat;

/**
 *  地址选择器
 */
@property (nonatomic,strong)UIDatePicker *pickerView;

-(void)show:(UIDatePickerMode)mode withBlock:(void (^)(NSString *date))block;


@end
