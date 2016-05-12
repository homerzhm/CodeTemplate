//
//  HInputViewController.h
//  CodeTemplate
//
//  Created by Hongming Zuo on 2016-04-24.
//  Copyright © 2016 Hongming Zuo. All rights reserved.
//

#import <UIKit/UIKit.h>

#define InputViewSmallestHeigh 35.0
#define InputViewLargestHeigh 200.0


@protocol HInputViewControllerDelegate <NSObject>

-(void)sendMessage:(NSString *)message;
-(void)inputControllerChangeWithFrame:(CGRect) frame;

@optional
-(CGFloat)getInitialOffsetIfNeed;
-(CGFloat)getKeyBoardUpOffsetIfNeed;


@end

@interface HInputViewController : UIViewController

@property (nonatomic) IBOutlet UITextView * inputText;
@property (nonatomic) IBOutlet UIView * textViewContainer;
@property (nonatomic) IBOutlet UIButton * sendButton;
@property (nonatomic) id<HInputViewControllerDelegate> delegate;


-(instancetype)initInVC:(UIViewController<HInputViewControllerDelegate> *)vc;
-(IBAction)sendButtonAction:(id)sender;


@end
