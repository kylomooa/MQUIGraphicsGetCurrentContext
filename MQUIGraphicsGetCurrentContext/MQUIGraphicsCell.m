//
//  MQUIGraphicsCell.m
//  MQUIGraphicsGetCurrentContext
//
//  Created by maoqiang on 2020/5/18.
//  Copyright © 2020 maoqiang. All rights reserved.
//

#import "MQUIGraphicsCell.h"

@implementation MQUIGraphicsCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)drawRect:(CGRect)rect{
    
    [self drawArcInRect:rect];

    [self drawSepLine:rect];
    
    [self drawShadowLine:rect];

}

//画圆角
-(void)drawArcInRect:(CGRect)rect{
    
    // 1.获取上下文
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    //2.画圆角
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width-20, 80) cornerRadius:10];
    CGContextAddPath(contextRef, bezierPath.CGPath);
    
    // 3.修饰
    [[UIColor greenColor] set]; // 颜色
    // 4.渲染填充区域
    CGContextFillPath(contextRef);
    
}

//画底部分割线
-(void)drawSepLine:(CGRect)rect{
    
    // 1.获取上下文
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    // 2.画线
    CGContextMoveToPoint(contextRef, 10, 99); // 起点
    CGContextAddLineToPoint(contextRef, self.frame.size.width-10, 99);
    // 3.修饰
    CGContextSetStrokeColorWithColor(contextRef, [UIColor lightGrayColor].CGColor);
    CGContextSetLineWidth(contextRef, 1);
    CGContextSetLineCap(contextRef, kCGLineCapRound); // 起点和重点圆角
    CGContextSetLineJoin(contextRef, kCGLineJoinRound); // 转角圆角
    // 4.渲染线条
    CGContextStrokePath(contextRef);
}


//画阴影
-(void)drawShadowLine:(CGRect)rect{
    // 1.获取上下文
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    //2.画圆角
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width-20, 80) cornerRadius:10];
    CGContextAddPath(contextRef, bezierPath.CGPath);
    
    //3.添加阴影
    CGContextSetShadowWithColor(contextRef, CGSizeMake(4, 4), 0, [UIColor grayColor].CGColor);
    
    //4.渲染填充区域
    CGContextFillPath(contextRef);
}

@end
