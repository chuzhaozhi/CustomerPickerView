//
//  CustomChoosePickerView.m
//
//  Created by chuzhaozhi on 
//

#import "CustomChoosePickerView.h"
#import "ChooseObject.h"

@interface CustomChoosePickerView()<UIPickerViewDelegate,UIPickerViewDataSource>

/** 自定义工具条*/
@property (nonatomic,strong)UIView *toolbar;

/** 取消按钮*/
@property (nonatomic,strong)UIButton *cancelBtn;

/** 确定按钮*/
@property (nonatomic,strong)UIButton *sureBtn;

@property (nonatomic,strong)UIView *backView;

@property (nonatomic,assign) NSInteger componentCount;

@end

@implementation CustomChoosePickerView{

    void (^_block)(NSArray<ChooseObjcet *>* object);
    void (^_dataBlock)(CustomChoosePickerView *pick,NSInteger row,NSString *chooseID);
    
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

-(UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, ScreenW, 216)];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
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
        
        _block(self.chooseModelArr);
        
    }
    [self hide];
    
}

-(void)cancelAction:(id)sender{
    
    [self hide];
    
}

-(void)showWithData:(void (^)(CustomChoosePickerView *pick,NSInteger row,NSString *chooseID))data withComponentCount:(NSInteger)componentCount finish:(void (^)(NSArray<ChooseObjcet *>* object))block{
    
    _block = block;
    
    _dataBlock = data;
    
    _componentCount = componentCount;
    
    NSMutableArray *arr = [NSMutableArray array];
    NSMutableArray *chooseArr = [NSMutableArray array];
    for (NSInteger i = 0; i < componentCount ; i++) {
        [arr addObject:[NSArray array]];
        [chooseArr addObject:[[ChooseObjcet alloc]init]];
    }
    self.dataArr = arr;
    self.chooseModelArr = chooseArr;
    
    [self getDataListWithModel:nil withComponent:0];
    
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

- (void)getDataListWithModel:(ChooseObjcet*)object withComponent:(NSInteger)component{
    
    if (_dataBlock) {
        _dataBlock(self,component,object.chooseID);
    }
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return _componentCount;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return self.dataArr[component].count;
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    ChooseObjcet *model = self.dataArr[component][row];
    return model.chooseName;
    
}

//重写方法
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:17]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(self.dataArr[component].count > 0){
    ChooseObjcet *model = self.dataArr[component][row];
    self.chooseModelArr[component] = model;
    if(component+1 < self.componentCount){
    [self getDataListWithModel:model withComponent:component+1];
    }
    }
}

@end
