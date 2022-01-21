//
//  LTextField.m
//  dysx
//
//  Created by chengbo on 2022/1/20.
//

#import "LTextField.h"

@implementation LTextField

//- (CGRect)placeholderRectForBounds:(CGRect)bounds
//{
//    CGRect inset = CGRectMake(bounds.origin.x+100, bounds.origin.y, bounds.size.width -10, bounds.size.height);//更好理解些
//    return inset;
//}

 // 修改文本展示区域，一般跟editingRectForBounds一起重写
 - (CGRect)textRectForBounds:(CGRect)bounds
 {
     CGRect inset = CGRectMake(bounds.origin.x+10, bounds.origin.y, bounds.size.width-25, bounds.size.height);//更好理解些
     return inset;
 }
 // 重写来编辑区域，可以改变光标起始位置，以及光标最右到什么地方，placeHolder的位置也会改变
 - (CGRect)editingRectForBounds:(CGRect)bounds
 {
     CGRect inset = CGRectMake(bounds.origin.x+10, bounds.origin.y, bounds.size.width-25, bounds.size.height);//更好理解些
     return inset;
 }

@end
