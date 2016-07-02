//
//  CircleLoadingView.h
//  CodeTemplate
//
//  Created by Hongming Zuo on 2016-06-15.
//  Copyright © 2016 Hongming Zuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleLoadingView : UIView

@property (nonatomic) float progress;

-(void)currentProgress:(float) value; // 0 to 1.0
-(void)customizedBGTint:(UIColor *)bgT progressTint:(UIColor *)insideTint isAnnular:(BOOL) value;

@end
