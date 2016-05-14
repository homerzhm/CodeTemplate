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

/*!
 @protocal HInputViewControllerDelegate
 @brief When a UIViewController want to present HInputViewController, must confirm with this protocol
 */
@protocol HInputViewControllerDelegate <NSObject>

/*! @brief send message and if complete block with value is YES, we clean up input field, else we keep it*/
-(void)sendMessage:(NSString *)message withComplete:(void(^)(BOOL success))complete;

@optional

/*! @brief get offset of origin.y when initial the input view*/
-(CGFloat)getInitialOffsetIfNeed;

/*! @brief get offset of origin.y when we update the input view when keyboard is showing*/
-(CGFloat)getKeyBoardUpOffsetIfNeed;

/*! @brief get offset of origin.y when we update the input view when keyboard is showing*/
-(void)inputControllerChangeWithFrame:(CGRect) frame;

@end


/*!
 @class HInputViewController
 @brief easy use for dynamic input view appending in the keyboard
 @code
 //Examples
 - (void)viewDidLoad {
    [super viewDidLoad];
    [self initialInputVC];
 }
 -(void)initialInputVC{
    self.inputVC = [[HInputViewController alloc]initInVC:self];
    [self addChildViewController:self.inputVC];
    [self.view addSubview:self.inputVC.view];
 }
 @endcode
 */
@interface HInputViewController : UIViewController<UITextViewDelegate>

@property (nonatomic) IBOutlet UITextView * inputText;
@property (nonatomic) IBOutlet UIView * textViewContainer;
@property (nonatomic) IBOutlet UIButton * sendButton;
@property (nonatomic) IBOutlet UILabel * placeHolder;
@property (nonatomic) id<HInputViewControllerDelegate> delegate;

/*!
 @brief use to initial this input view in centern View controller as child view controller
 @param vc ViewController that need to use this input view, and it has to imprement HInputViewControllerDelegate
 */
-(instancetype)initInVC:(UIViewController<HInputViewControllerDelegate> *)vc;

-(IBAction)sendButtonAction:(id)sender;


@end
