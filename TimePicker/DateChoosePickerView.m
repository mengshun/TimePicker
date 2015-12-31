
//
//  DateChoosePickerView.m
//  TimePicker
//
//  Created by MS on 15/12/31.
//  Copyright © 2015年 孟顺. All rights reserved.
//


#define kMainWidth [UIScreen mainScreen].bounds.size.width
#define kMainHeight [UIScreen mainScreen].bounds.size.height

#import "DateChoosePickerView.h"


@implementation DateChoosePickerViewModel

- (NSString *)description{
    return [NSString stringWithFormat:@"%ld %ld %ld %@",self.year,self.month,self.day,self.isPM?@"下午":@"上午"];
}

@end

@interface DateChoosePickerView ()<UIPickerViewDataSource,UIPickerViewDelegate>{
    int _numberOfMonth;
    UIPickerView *_pickerView ;
}

@property (nonatomic,strong)NSMutableArray *yearTitleArray;
@property (nonatomic,strong)NSMutableArray *monthTitleArray;
@property (nonatomic,strong)NSMutableArray *dayTitleArray;

@end

@implementation DateChoosePickerView



- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initData];
        [self initView];
        
    }
    return self;
}
- (void)initData{
    _numberOfMonth = 31;
    self.yearTitleArray = [NSMutableArray array];
    self.monthTitleArray = [NSMutableArray array];
    self.dayTitleArray = [NSMutableArray array];
    
    for (int i = 0; i<100; i++) {
        NSString *yearString = [NSString stringWithFormat:@"%d",i+2015];
        [self.yearTitleArray addObject:yearString];
    }
    
    for (int i = 0; i<12; i++) {
        NSString *monthString = [NSString stringWithFormat:@"%d",i+1];
        [self.monthTitleArray addObject:monthString];
    }
    for (int i = 0; i<31; i++) {
        NSString *dayString = [NSString stringWithFormat:@"%d",i+1];
        [self.dayTitleArray addObject:dayString];
    }
    
}
- (void)initView{
    _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 30, kMainWidth, 100)];
    _pickerView.backgroundColor = [UIColor greenColor];
    _pickerView.delegate =self;
    _pickerView.dataSource = self;
    [self addSubview:_pickerView];
    
    UILabel *yearLabel = [[UILabel alloc]initWithFrame:CGRectMake(75, 35, 40, 30)];
    yearLabel.text = @"年";
    //    [yearLabel setBackgroundColor:[UIColor lightGrayColor]];
    [_pickerView addSubview:yearLabel];
    
    
    
    UILabel *monthLabel = [[UILabel alloc]initWithFrame:CGRectMake(145, 35, 40, 30)];
    monthLabel.text = @"月";
    //    [monthLabel setBackgroundColor:[UIColor lightGrayColor]];
    [_pickerView addSubview:monthLabel];
    
    
    UILabel *dayLabel = [[UILabel alloc]initWithFrame:CGRectMake(220, 35, 40, 30)];
    dayLabel.text = @"日";
    //    [dayLabel setBackgroundColor:[UIColor lightGrayColor]];
    [_pickerView addSubview:dayLabel];
    
    
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, 30)];
    topView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:topView];
    
    
    UIButton *okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [okButton setTitle:@"确定" forState:normal];
    okButton.frame = CGRectMake(270, 0, 40, 30);
    okButton.backgroundColor = [UIColor blackColor];
    [okButton addTarget:self action:@selector(okButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:okButton];
    
    
    [self setCurrentDate];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 4;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    switch (component) {
        case 0:
        {
            return 200;
        }
            break;
        case 1:
        {
            return 12;
        }
            break;
        case 2:
        {
            return _numberOfMonth;
        }
            break;
        case 3:
        {
            return 2;
        }
            break;
        default:
            break;
    }
    return 0;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    switch (component) {
        case 0:
        {
            return self.yearTitleArray[row];
        }
            break;
        case 1:
        {
            return self.monthTitleArray[row];
        }
            break;
        case 2:
        {
            return self.dayTitleArray[row];
        }
            break;
        case 3:
        {
            return row ? @"下午":@"上午";
        }
            break;
        default:
            break;
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component == 0 || component == 1) {
        _numberOfMonth = [self numberOfMonth:[pickerView selectedRowInComponent:1]+1 inYear:[pickerView selectedRowInComponent:0]+2015 ];
        [pickerView reloadComponent:2];
    }
    
}


- (int)numberOfMonth:(NSInteger) month inYear:(NSInteger)year{
    if (month == 4 || month == 6 || month == 9 || month == 11) {
        return 30;
    } else if (month == 2) {
        if (year % 100 == 0) {
            if (year % 400 == 0) {
                if ( year % 3200 == 0) {
                    return 28;
                }
                return 29;
            } else {
                return 28;
            }
        } else {
            if (year % 4 == 0) {
                return 29;
            } else {
                return 28;
            }
        }
    }
    return 31;
}


- (void)setCurrentDate{
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    
    NSLog(@"localeDate : %@",localeDate);
    
    
    // Get Current Year
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy"];
    
    NSString *currentyearString = [NSString stringWithFormat:@"%@",
                                   [formatter stringFromDate:localeDate]];
    
    
    // Get Current  Month
    [formatter setDateFormat:@"MM"];
    NSString *currentMonthString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:localeDate]];
    
    
    // Get Current  Date
    [formatter setDateFormat:@"dd"];
    NSString *currentDateString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:localeDate]];
    
    
    // Get Current  Hour
    [formatter setDateFormat:@"a"];
    NSString *currentHourString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:localeDate]];
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_pickerView selectRow:[currentyearString integerValue]-2015 inComponent:0 animated:NO];
        [_pickerView selectRow:[currentMonthString integerValue]-1 inComponent:1 animated:NO];
        [_pickerView selectRow:[currentDateString integerValue]-1 inComponent:2 animated:NO];
        [_pickerView selectRow: [currentHourString isEqualToString:@"PM"] inComponent:3 animated:NO];
    });

}


- (void)okButtonAction:(id)sender{
    if ([_delegate respondsToSelector:@selector(dateChoosePickerView:chooseModel:)]) {
        DateChoosePickerViewModel *model = [DateChoosePickerViewModel new];
        model.year = [_pickerView selectedRowInComponent:0]+2015;
        model.month = [_pickerView selectedRowInComponent:1]+1;
        model.day = [_pickerView selectedRowInComponent:2]+1;
        model.isPM = [_pickerView selectedRowInComponent:3];
        [_delegate dateChoosePickerView:self chooseModel:model];
    }
}
@end
