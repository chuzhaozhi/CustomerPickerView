//
//  CustomerPickerView.m
//
//
//  Created by chuzhaozhi on 
//

#import "DateChoosePickerView.h"

@interface DateChoosePickerView()

/** 自定义工具条*/
@property (nonatomic,strong)UIView *toolbar;

/** 取消按钮*/
@property (nonatomic,strong)UIButton *cancelBtn;

/** 确定按钮*/
@property (nonatomic,strong)UIButton *sureBtn;

@property (nonatomic,strong)UIView *backView;

@end

@implementation DateChoosePickerView{
    
    void (^_block)(NSString *date);
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.backView];
        [self.backView addSubview:self.pickerView];
        [self.backView addSubview:self.toolbar];
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelAction:)];
        [self addGestureRecognizer:ges];
        
    }
    return self;
}

-(UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH, ScreenW, 260)];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

-(UIDatePicker *)pickerView{
    if (!_pickerView) {
        _pickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, ScreenW, 216)];
        _pickerView.backgroundColor = [UIColor whiteColor];
    }
    return _pickerView;
}

-(UIView *)toolbar{
    if (!_toolbar) {
        _toolbar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 44)];
        _toolbar.backgroundColor = [UIColor whiteColor];
        
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancelBtn.frame = CGRectMake(0, 0, 60, 44);
        [_cancelBtn setTitleColor:COLOR_ITEM forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [_toolbar addSubview:_cancelBtn];
        
        _sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:COLOR_ITEM forState:UIControlStateNormal];
        _sureBtn.frame = CGRectMake(ScreenW - 60, 0, 60, 44);
        [_sureBtn addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [_toolbar addSubview:_sureBtn];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.toolbar.frame.size.height-1, ScreenW, 1)];
        line.backgroundColor = RGB(242, 242, 242);
        [_toolbar addSubview:line];
    }
    return _toolbar;
}

-(void)sureAction:(id)sender{
    
    if(_block){
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        if(self.dateFormat){
            formatter.dateFormat = self.dateFormat;
        }else{
            formatter.dateFormat = @"yyyy-MM-dd";
        }
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        
        formatter.locale = locale;
        
        NSString *chooseDate = [formatter stringFromDate:_pickerView.date];
        
        _block(chooseDate);
        
    }
    [self hide];
    
}


-(void)cancelAction:(id)sender{
    
    [self hide];
    
}

-(void)show:(UIDatePickerMode)mode withBlock:(void (^)(NSString *date))block{
    
    _pickerView.datePickerMode = mode;
    
    _block = block;
    
    UIWindow *win = [UIApplication sharedApplication].keyWindow;
    
    UIView *topView = win.subviews.firstObject;
    
    self.frame = topView.frame;
    
    [topView addSubview:self];
    
    [UIView animateWithDuration:.5f animations:^{
        self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:.6];
        self.backView.frame = CGRectMake(0, ScreenH - 260, ScreenW, 260);
        
    }completion:^(BOOL finished) {
        
    }];
    
}

-(void)hide{
    
    [UIView animateWithDuration:.5f animations:^{
        self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0];
        self.backView.frame = CGRectMake(0, ScreenH, ScreenW, 260);
        
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}


@end
