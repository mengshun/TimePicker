//
//  ViewController.m
//  TimePicker
//
//  Created by MS on 15/12/31.
//  Copyright © 2015年 孟顺. All rights reserved.
//

#import "ViewController.h"
#import "DateChoosePickerView.h"

@interface ViewController ()<DateChoosePickerViewDelegate>{
    
}




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DateChoosePickerView *view = [[DateChoosePickerView alloc]initWithFrame:CGRectMake(0, 568-130, 320, 130)];
    view.delegate =self;
    [self.view addSubview:view];
  

    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    

    
}

- (void)dateChoosePickerView:(DateChoosePickerView *)pickerView chooseModel:(DateChoosePickerViewModel *) pickerModel{
    NSLog(@"%@",pickerModel);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
