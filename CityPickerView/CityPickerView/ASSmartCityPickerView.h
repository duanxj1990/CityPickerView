//
//  ASSmartCityPickerView.h
//  whcrj
//
//  Created by 段兴杰 on 16/9/9.
//  Copyright © 2016年 Aisino. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASSmartCityPickerView;

@protocol ASSmartCityPickerViewDelegate <NSObject>

@optional
- (void)toobarDonBtnHaveClick:(ASSmartCityPickerView *)pickView resultString:(NSString *)resultString codeP:(NSString *)codeP codeC:(NSString *)codeC codeD:(NSString *)codeD;

@end

@interface ASSmartCityPickerView : UIView
@property (nonatomic, assign) id<ASSmartCityPickerViewDelegate> delegate;
@property (nonatomic, assign) NSInteger applyType;
@property (nonatomic, copy) void(^block)(NSString * resultString,NSString * codeP ,NSString *codeC,NSString * codeD);

- (void)show;

//后续完善
//- (void)showInController:(UIViewController *)controller
//                   block:(void(^)(NSString * resultString,NSString * codeP ,NSString *codeC,NSString * codeD))block;

@end
