//
//  BitDatePicker.m
//  Doorman
//
//  Created by Keaton Burleson on 2/6/16.
//  Copyright © 2016 Golgi. All rights reserved.
//

#import "BitDatePicker.h"

@implementation BitDatePicker

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (!self) {
        return nil;
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame maxDate:(NSDate *)maxDate minDate:(NSDate *)minDate showValidDatesOnly:(BOOL)showValidDatesOnly
{
    self = [super initWithFrame:frame];
    
    if (!self) {
        return nil;
    }
    
    
    return self;
}


- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    
    if (!self) {
        return nil;
    }
    
  
    
    
    return self;
}
-(void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 35;
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *lblDate = [[UILabel alloc] init];
    [lblDate setFont:[UIFont systemFontOfSize:25.0]];
    [lblDate setTextColor:[UIColor blueColor]];
    [lblDate setBackgroundColor:[UIColor clearColor]];
    
    
    return lblDate;
}


@end