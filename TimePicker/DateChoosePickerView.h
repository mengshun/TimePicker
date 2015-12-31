//
//  DateChoosePickerView.h
//  TimePicker
//
//  Created by MS on 15/12/31.
//  Copyright © 2015年 孟顺. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DateChoosePickerView;
@class DateChoosePickerViewModel;


@protocol DateChoosePickerViewDelegate <NSObject>

- (void)dateChoosePickerView:(DateChoosePickerView *)pickerView chooseModel:(DateChoosePickerViewModel *) pickerModel;
@end

@interface DateChoosePickerView : UIView

@property (nonatomic,assign) id <DateChoosePickerViewDelegate>delegate;

@end


@interface DateChoosePickerViewModel : NSObject
@property (nonatomic,assign) NSInteger year;
@property (nonatomic,assign) NSInteger month;
@property (nonatomic,assign) NSInteger day;
@property (nonatomic,assign) BOOL isPM;
@end
