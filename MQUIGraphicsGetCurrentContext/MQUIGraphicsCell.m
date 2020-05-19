//
//  MQUIGraphicsCell.m
//  MQUIGraphicsGetCurrentContext
//
//  Created by maoqiang on 2020/5/18.
//  Copyright © 2020 maoqiang. All rights reserved.
//

//参考博客说明:https://www.jianshu.com/p/d46bcc656e04

#import "MQUIGraphicsCell.h"

@implementation MQUIGraphicsCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        //直接调用setNeedsDisplay或者setNeedsDisplayInRect:会触发drawRect
        //frame的size不能为0
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setNeedsDisplay];
            NSLog(@"setNeedsDisplay");
        });
        
        //setNeedsLayout或者layoutIfNeed，会触发layoutSubviews
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setNeedsLayout];
        });
    }
    return self;
}

-(void)layoutSubviews{
    NSLog(@"layoutSubviews");
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
    
    NSLog(@"drawRect");
    
    [self drawArcInRect:rect];

    [self drawSepLine:rect];
    
    
    //CGContextSaveGState与CGContextRestoreGState配合使用，防止阴影效果影响后面的绘制
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSaveGState(contextRef);//保存绘图上下文状态
    [self drawShadow:rect];
    CGContextRestoreGState(contextRef);//还原绘图上下文状态

    [self drawCircle:rect];
}

//画矩形圆角
-(void)drawArcInRect:(CGRect)rect{
    
    // 1.获取上下文
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    // 2.画矩形圆角
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
-(void)drawShadow:(CGRect)rect{
    // 1.获取上下文
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    // 2.画圆角
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width-20, 80) cornerRadius:10];
    CGContextAddPath(contextRef, bezierPath.CGPath);
    
    // 3.添加阴影
    CGContextSetShadowWithColor(contextRef, CGSizeMake(4, 4), 0, [UIColor grayColor].CGColor);
    
    // 4.渲染填充区域
    CGContextFillPath(contextRef);
}

-(void)drawCircle:(CGRect)rect{
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    //画圆
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(40, 40, 20, 20) cornerRadius:10];
    CGContextAddPath(contextRef, bezierPath.CGPath);

    CGContextSetLineWidth(contextRef, 4);
    CGContextSetStrokeColorWithColor(contextRef, [UIColor blackColor].CGColor);
    
    CGContextStrokePath(contextRef);
}

@end
