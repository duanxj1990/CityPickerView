//
//  ViewController.m
//  CityPickerView
//
//  Created by 段兴杰 on 16/10/12.
//  Copyright © 2016年 Aisino. All rights reserved.
//

#import "ViewController.h"
#import "ASSmartCityPickerView.h"

@interface ViewController ()
@property (nonatomic, strong) ASSmartCityPickerView * smartCityPickerView;
@property (nonatomic, strong) UITextField * cityTextF;
@end

@implementation ViewController
@synthesize smartCityPickerView;
@synthesize cityTextF;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    cityTextF = [[UITextField alloc] initWithFrame:CGRectMake(100, 200, 200, 50)];
    cityTextF.placeholder = @"请选择城市";
    cityTextF.layer.borderColor = [UIColor blackColor].CGColor;
    cityTextF.layer.borderWidth = 1;
    [self.view addSubview:cityTextF];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = cityTextF.frame;
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    smartCityPickerView = [[ASSmartCityPickerView alloc] init];
    [self.view addSubview:smartCityPickerView];
}

- (void)btnAction:(id)sender {
    [smartCityPickerView show];
    __weak typeof(self) weakself = self;
    smartCityPickerView.block = ^(NSString *resultString, NSString *codeP, NSString *codeC, NSString *codeD) {
        weakself.cityTextF.text = [NSString stringWithFormat:@"%@",resultString];
    };
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
