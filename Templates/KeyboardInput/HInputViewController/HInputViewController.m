//
//  HInputViewController.m
//  CodeTemplate
//
//  Created by Hongming Zuo on 2016-04-24.
//  Copyright © 2016 Hongming Zuo. All rights reserved.
//

#import "HInputViewController.h"

#define GapTop 8.0
#define GapSide 8.0

#define OffSetForTextView 0.0

@interface HInputViewController ()

@end

@implementation HInputViewController

-(instancetype)initInVC:(UIViewController<HInputViewControllerDelegate> *)vc{
    self = [super initWithNibName:@"HInputViewController" bundle:nil];
    if (self) {
        self.delegate = vc;
        self.view.autoresizingMask = UIViewAutoresizingNone;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect mainFrame = [[[UIApplication sharedApplication]delegate]window].bounds;

    [self.sendButton.layer setCornerRadius:4.0];
    [self initialTextViewWithSize:mainFrame.size];
    [self updatePositionWithSize:mainFrame.size];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initialTextViewWithSize:(CGSize) size{
    [self.textViewContainer.layer setCornerRadius:5.0];
    //self.inputText.autocorrectionType = UITextAutocorrectionTypeNo;
    [self updateTextTextViewWithSize:size];
    if (![self.textViewContainer superview]) {
        [self.view addSubview:self.textViewContainer];
    }
}

-(void)updateTextTextViewWithSize:(CGSize) size{
    CGRect theFrame = self.textViewContainer.frame;
    self.textViewContainer.autoresizingMask = UIViewAutoresizingNone;
    theFrame.origin.y = GapTop;
    theFrame.origin.x = GapSide;
    theFrame.size.width = size.width - GapSide * 2.0 - (self.sendButton.bounds.size.width + GapSide);
    theFrame.size.height = InputViewSmallestHeigh;
    self.textViewContainer.frame = theFrame;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)updatePositionWithSize:(CGSize) size{
    CGRect theFrame = self.view.frame;
    theFrame.size.width = size.width;
    theFrame.size.height = InputViewSmallestHeigh + GapTop * 2.0;
    theFrame.origin.x = 0.0;
    theFrame.origin.y = size.height - theFrame.size.height;
    if ([self.delegate respondsToSelector:@selector(getInitialOffsetIfNeed)]) {
        theFrame.origin.y += [self.delegate getInitialOffsetIfNeed];
    }
    self.view.frame = theFrame;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - KeyBoard

-(void)keyboardWillShow:(NSNotification *)notification{
    CGRect frame = [[notification.userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"]CGRectValue];
    CGAffineTransform transform = self.view.layer.affineTransform;
    CGRect theFrame = self.view.frame;
    CGFloat move = frame.origin.y - theFrame.size.height - theFrame.origin.y;
    transform.ty += move;
    if ([self.delegate respondsToSelector:@selector(getKeyBoardUpOffsetIfNeed)]) {
        transform.ty += [self.delegate getKeyBoardUpOffsetIfNeed];
    }
    self.view.layer.affineTransform = transform;
    [self.delegate inputControllerChangeWithFrame:self.view.frame];
}

#pragma mark - UItext view Delegate

-(void)textViewDidBeginEditing:(UITextView *)textView{
    
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    //[textView sizeToFit ];
    NSString * theText = [textView.text stringByReplacingCharactersInRange:range withString:text];
    [self updateInputViewHeightWithText:theText];
    return YES;
}

-(void)updateInputViewHeightWithText:(NSString *)text{
    NSAttributedString * at = [[NSAttributedString alloc]initWithString:text
                                                             attributes:@{NSFontAttributeName:self.inputText.font}];
    CGFloat theheight = [self textViewHeightForAttributedText:at andWidth:self.inputText.bounds.size.width];
    [self updateInputViewWithNewHeight:theheight];
    //NSLog(@"%f, ",theheight);
    [self.delegate inputControllerChangeWithFrame:self.view.frame];
    BOOL hasText = text.length != 0;
    self.placeHolder.hidden = hasText;
    [self.sendButton setEnabled:hasText];
    if (hasText) {
        [self.sendButton setBackgroundColor:[UIColor colorWithRed:147.0/255.0 green:108.0/255.0 blue:202.0/255.0 alpha:1.0]];
    }else{
        [self.sendButton setBackgroundColor:[UIColor colorWithRed:197.0/255.0 green:179.0/255.0 blue:223.0/255.0 alpha:1.0]];
    }
}

-(void)updateInputViewWithNewHeight:(CGFloat) height{
    BOOL needToChange = NO;
    if (self.textViewContainer.bounds.size.height != height + OffSetForTextView) {
        needToChange = YES;
    }
    if (needToChange) {
        CGRect theFrame = self.textViewContainer.frame;
        theFrame.size.height = MAX(height + OffSetForTextView,InputViewSmallestHeigh) ;
        if (theFrame.size.height!=InputViewSmallestHeigh) {
            theFrame.size.height = MIN(height+ OffSetForTextView,InputViewLargestHeigh);
        }
        CGRect viewFrame = self.view.frame;
        CGFloat newHeight = theFrame.size.height + 2*GapTop;
        viewFrame.origin.y -= (newHeight - viewFrame.size.height);
        viewFrame.size.height = newHeight;
        
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.textViewContainer.frame = theFrame;
            self.view.frame = viewFrame;
        } completion:^(BOOL finished) {
            CGSize contentSize = self.inputText.contentSize;
            CGSize frameSize = self.inputText.frame.size;
            CGPoint contentOffSet = self.inputText.contentOffset;
            contentOffSet.y = contentSize.height - frameSize.height ;
            self.inputText.contentOffset = contentOffSet;
        }];
        
    }
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [self updatePositionWithSize:size];
    [self updateTextTextViewWithSize:size];
    [self updateInputViewHeightWithText:self.inputText.text];
}

- (CGFloat)textViewHeightForAttributedText: (NSAttributedString*)text andWidth: (CGFloat)width {
    UITextView *calculationView = [[UITextView alloc] init];
    [calculationView setAttributedText:text];
    CGSize size = [calculationView sizeThatFits:CGSizeMake(width, FLT_MAX)];
    return size.height;
}

-(void)sendButtonAction:(id)sender{
    NSString * textString = [self.inputText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (textString.length == 0) {
        return;
    }
    [self.delegate sendMessage:textString withComplete:^(BOOL success) {
        if (success) {
            [self.inputText setText:@""];
            [self updateInputViewHeightWithText:@""];
        }
    }];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
