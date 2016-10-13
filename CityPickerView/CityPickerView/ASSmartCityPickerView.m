//
//  ASSmartCityPickerView.m
//  whcrj
//
//  Created by 段兴杰 on 16/9/9.
//  Copyright © 2016年 Aisino. All rights reserved.
//

#import "ASSmartCityPickerView.h"
#import "NSDictionary+NullToNil.h"
#import "UIView+Frame.h"
#import "AppDelegate.h"

#define ZHToobarHeight 40

@interface ASSmartCityPickerView()<UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, strong) NSArray *rootArray;
@property (nonatomic, strong) NSMutableArray *component1Array;
@property (nonatomic, strong) NSMutableArray *component2Array;
@property (nonatomic, strong) NSMutableArray *component3Array;
@property (nonatomic) NSInteger row1;
@property (nonatomic) NSInteger row2;
@property (nonatomic) NSInteger row3;
@property (nonatomic, strong) NSString *codeDistrict;
@property (nonatomic, strong) NSString *codeProvince;
@property (nonatomic, strong) NSString *codeCity;
@property (nonatomic, strong) UIButton * grayBackgroundView;
@end

@implementation ASSmartCityPickerView
@synthesize rootArray;
@synthesize component1Array;
@synthesize component2Array;
@synthesize component3Array;
@synthesize row1;
@synthesize row2;
@synthesize row3;
@synthesize delegate;
@synthesize codeDistrict;
@synthesize codeProvince;
@synthesize codeCity;
@synthesize applyType;
@synthesize grayBackgroundView;

- (instancetype)init {
    self = [super init];
    if (self) {
        //黑色半透明背景
        grayBackgroundView=[UIButton buttonWithType:UIButtonTypeCustom];
        grayBackgroundView.frame=[UIScreen mainScreen].bounds;
        grayBackgroundView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        [grayBackgroundView addTarget:self action:@selector(popAndPushPickerView) forControlEvents:UIControlEventTouchUpInside];
        [self initPickerView];
    }
    return self;
}

- (NSArray *)getPlistArrayByplistName:(NSString *)plistName{
    NSString *path= [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    NSArray *array =[[NSArray alloc] initWithContentsOfFile:path];
    return array;
}

#pragma mark piackView 数据源方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger pickerRows = 0;
    switch (component) {
        case 0:
        {
            if (applyType == 1 || applyType == 2) {
                pickerRows = 1;
            } else {
                pickerRows = [rootArray count];
            }
        }
            break;
        case 1:
            @try {
                if (applyType == 1) {
                    pickerRows = 1;
                } else {
                    NSArray *cityArray = [[rootArray objectAtIndex:row1] noNullobjectForKey:@"sub"];
                    pickerRows = cityArray.count;
                }
            } @catch (NSException *exception) {
                
            } @finally {
                
            }
            
            break;
        case 2:
            @try {
                pickerRows = [[[[[rootArray objectAtIndex:row1] noNullobjectForKey:@"sub"] objectAtIndex:row2] noNullobjectForKey:@"sub"] count];
            }
            @catch (NSException *exception) {
                
            } @finally {
                
            }
            
            break;
        default:
            break;
    }
    return pickerRows;
}

#pragma mark UIPickerViewdelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *str;
    switch (component) {
        case 0:
            @try {
                str = [[rootArray objectAtIndex:row] noNullobjectForKey:@"province"];
            } @catch (NSException *exception) {
                
            } @finally {
                
            }
            break;
        case 1:
            @try {
                str = [[[[rootArray objectAtIndex:row1] noNullobjectForKey:@"sub"] objectAtIndex:row] noNullobjectForKey:@"city"];
            } @catch (NSException *exception) {
                
            } @finally {
                
            }
            
            
            break;
        case 2:
            @try {
                str = [[[[[[rootArray objectAtIndex:row1] noNullobjectForKey:@"sub"] objectAtIndex:row2] noNullobjectForKey:@"sub"] objectAtIndex:row] noNullobjectForKey:@"district"];
            } @catch (NSException *exception) {
                
            } @finally {
                
            }
            break;
            
        default:
            break;
    }
    return str;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch (component) {
        case 0:
            row1 = row;
            row2 = 0;
            row3 = 0;
            [pickerView reloadComponent:1];
            [pickerView selectRow:0 inComponent:1 animated:NO];
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:NO];
            break;
        case 1:
            row2 = row;
            row3 = 0;
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:NO];
            break;
        case 2:
            row3 = row;
            break;
            
        default:
            break;
    }
}

#pragma mark ToolBar

- (void)initPickerView {
    rootArray = [self getPlistArrayByplistName:@"cityWithZipcode"];
    
    UIPickerView * pickerV =[[UIPickerView alloc] init];
    pickerV.backgroundColor=[UIColor grayColor];
    pickerV.frame = CGRectMake(0,  [UIScreen mainScreen].bounds.size.height - pickerV.height, [UIScreen mainScreen].bounds.size.width, pickerV.height);
    pickerV.delegate=self;
    pickerV.dataSource=self;
    [grayBackgroundView addSubview:pickerV];

    UIToolbar * toolbar=[self setToolbarStyle];
    toolbar.frame=CGRectMake(0, [UIScreen mainScreen].bounds.size.height - pickerV.height - ZHToobarHeight,[UIScreen mainScreen].bounds.size.width, ZHToobarHeight);
    [grayBackgroundView addSubview:toolbar];
}

- (UIToolbar *)setToolbarStyle{
    UIToolbar *bar=[[UIToolbar alloc] init];
//        由于地址是必填，所去掉取消按键
        UIBarButtonItem *lefttem=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(remove)];
    
    UIBarButtonItem *centerSpace=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(doneClick)];
    //    bar.items=@[lefttem,centerSpace,right];
    bar.items=@[lefttem,centerSpace,right];
    return bar;
}

- (void)doneClick
{
    NSString *string1 = [[rootArray objectAtIndex:row1] noNullobjectForKey:@"province"];
    codeProvince  = [[rootArray objectAtIndex:row1] noNullobjectForKey:@"zipcode"];
    
    NSString *string2 = [[[[rootArray objectAtIndex:row1] noNullobjectForKey:@"sub"] objectAtIndex:row2] noNullobjectForKey:@"city"];
    codeCity = [[[[rootArray objectAtIndex:row1] noNullobjectForKey:@"sub"] objectAtIndex:row2] noNullobjectForKey:@"zipcode"];
    
    NSString *string3 = [[[[[[rootArray objectAtIndex:row1] noNullobjectForKey:@"sub"] objectAtIndex:row2] noNullobjectForKey:@"sub"] objectAtIndex:row3] noNullobjectForKey:@"district"];
    codeDistrict = [[[[[[rootArray objectAtIndex:row1] noNullobjectForKey:@"sub"] objectAtIndex:row2] noNullobjectForKey:@"sub"] objectAtIndex:row3] noNullobjectForKey:@"zipcode"];
    
    NSString *resultStr = [NSString stringWithFormat:@"%@%@%@",string1, string2, string3];
    
    if (self.block) {
        self.block(resultStr,codeProvince,codeCity,codeDistrict);;
    }
    
    if ([delegate respondsToSelector:@selector(toobarDonBtnHaveClick:resultString:codeP:codeC:codeD:)]) {
        [delegate toobarDonBtnHaveClick:self resultString:resultStr codeP:codeProvince codeC:codeCity codeD:codeDistrict];
    }
    [self remove];
}

-(void)popAndPushPickerView {
    [self remove];
}

- (void)remove{
    [grayBackgroundView removeFromSuperview];
}

- (void)show {
    AppDelegate *app=(AppDelegate *)[UIApplication sharedApplication].delegate;
    [app.window.rootViewController.view addSubview:grayBackgroundView];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
