//
//  CircleLoadingView.m
//  CodeTemplate
//
//  Created by Hongming Zuo on 2016-06-15.
//  Copyright © 2016 Hongming Zuo. All rights reserved.
//

#import "CircleLoadingView.h"

@implementation CircleLoadingView
{
    BOOL annular;
    UIColor * progressTintColor;
    UIColor * backgroundTintColor;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)init {
    return [self initWithFrame:CGRectMake(0.f, 0.f, 37.f, 37.f)];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        self.progress = 0.f;
        annular = NO;
        progressTintColor = [[UIColor alloc] initWithWhite:1.f alpha:1.f];
        backgroundTintColor = [[UIColor alloc] initWithWhite:1.f alpha:.1f];
    }
    return self;
}

-(void)customizedBGTint:(UIColor *)bgT progressTint:(UIColor *)insideTint isAnnular:(BOOL) value{
    progressTintColor = insideTint;
    backgroundTintColor = bgT;
    annular = value;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    
    CGRect allRect = self.bounds;
    CGRect circleRect = CGRectInset(allRect, 2.0f, 2.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
        if (annular) {
    // Draw background
    BOOL isPreiOS7 = NSFoundationVersionNumber < kCFCoreFoundationVersionNumber_iOS_7_0;
    CGFloat lineWidth = isPreiOS7 ? 5.f : 2.f;
    UIBezierPath *processBackgroundPath = [UIBezierPath bezierPath];
    processBackgroundPath.lineWidth = lineWidth;
    processBackgroundPath.lineCapStyle = kCGLineCapButt;
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    CGFloat radius = (self.bounds.size.width - lineWidth)/2;
    CGFloat startAngle = - ((float)M_PI / 2); // 90 degrees
    CGFloat endAngle = (2 * (float)M_PI) + startAngle;
    [processBackgroundPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    [backgroundTintColor set];
    [processBackgroundPath stroke];
    // Draw progress
    UIBezierPath *processPath = [UIBezierPath bezierPath];
    processPath.lineCapStyle = isPreiOS7 ? kCGLineCapRound : kCGLineCapSquare;
    processPath.lineWidth = lineWidth;
    endAngle = (self.progress * 2 * (float)M_PI) + startAngle;
    [processPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    [progressTintColor set];
    [processPath stroke];
        } else {
            // Draw background
            [progressTintColor setStroke];
            [backgroundTintColor setFill];
            CGContextSetLineWidth(context, 2.0f);
            CGContextFillEllipseInRect(context, circleRect);
            CGContextStrokeEllipseInRect(context, circleRect);
            // Draw progress
            CGPoint center = CGPointMake(allRect.size.width / 2, allRect.size.height / 2);
            CGFloat radius = (allRect.size.width - 4) / 2;
            CGFloat startAngle = - ((float)M_PI / 2); // 90 degrees
            CGFloat endAngle = (self.progress * 2 * (float)M_PI) + startAngle;
            CGContextSetRGBFillColor(context, 1.0f, 1.0f, 1.0f, 1.0f); // white
            CGContextMoveToPoint(context, center.x, center.y);
            CGContextAddArc(context, center.x, center.y, radius, startAngle, endAngle, 0);
            CGContextClosePath(context);
            CGContextFillPath(context);
        }
}

-(void)currentProgress:(float)value{
    self.progress = value;
    [self setNeedsDisplay];
}

@end
