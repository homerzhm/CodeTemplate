//
//  ComponentsTemplateController.m
//  CodeTemplate
//
//  Created by Hongming Zuo on 2016-04-16.
//  Copyright © 2016 Hongming Zuo. All rights reserved.
//

#import "ComponentsTemplateController.h"
#import "CircleLoadingView.h"

#define GapBetweenInTop 10.0

@interface ComponentsTemplateController ()
@property (nonatomic) NSMutableArray * componentArray;
@property (nonatomic) CircleLoadingView * circleLoading;
@property (nonatomic) NSTimer * uiTimer;
@end

@implementation ComponentsTemplateController

-(UIViewController *)initForPresent{
    self = [super initWithNibName:@"ComponentsTemplateController" bundle:nil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialComponentArray];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self refreshScrollView];
    [self componentTimer];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.uiTimer invalidate];
}

-(void)componentTimer{
    if (!self.uiTimer) {
        self.uiTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(refreshUIComponent) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop]addTimer:self.uiTimer forMode:NSDefaultRunLoopMode];
    }
}

-(void)initialComponentArray{
    self.componentArray = [[NSMutableArray alloc]init];
    CGRect mainFrame = [[[UIApplication sharedApplication]delegate]window].frame;
    
    [self.componentArray addObject:[self strikeThroughLabelWithMainFrame:mainFrame]];
    [self.componentArray addObject:[self underLineLabelWithMainFrame:mainFrame]];
    
    self.circleLoading = [self circleLoadingView:mainFrame];
    [self.componentArray addObject:self.circleLoading];
}

-(UILabel *)strikeThroughLabelWithMainFrame:(CGRect)mainFrame{
    UILabel * strikethroughStyleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, mainFrame.size.width, 30.0)];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:@"Strike through"];
    [attributeString addAttribute:NSStrikethroughStyleAttributeName value:@1 range:NSMakeRange(0, [attributeString length])];
    [strikethroughStyleLabel setAttributedText:attributeString];
    return strikethroughStyleLabel;
}

-(UILabel *)underLineLabelWithMainFrame:(CGRect)mainFrame{
    NSString * string = @"Underline for ---- here , and the color changed";
    
    UILabel * result= [[UILabel alloc]initWithFrame:CGRectMake(0, 0, mainFrame.size.width, 30.0)];
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange range = [string rangeOfString:@"here"];
    [attributeString addAttribute:NSUnderlineStyleAttributeName value:@1 range:range];
    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:range];
    
    [result setAttributedText:attributeString];
    return result;
}

-(CircleLoadingView *)circleLoadingView:(CGRect) mainFrame{
    CircleLoadingView * result = nil;
    result = [[CircleLoadingView alloc]initWithFrame:CGRectMake(20.0, 0, 100.0, 100.0)];
    [result customizedBGTint:[UIColor grayColor] progressTint:[UIColor blackColor] isAnnular:YES];
    return result;
}

-(void)refreshUIComponent{
    if (self.circleLoading) {
        CGFloat process = self.circleLoading.progress;
        process += 0.01;
        if (process > 1.0) {
            process = 0.0;
        }
        [self.circleLoading currentProgress:process];
    }
}

-(void)refreshScrollView{
    
    for (UIView * subViews in [self.mainScrollview subviews]) {
        [subViews removeFromSuperview];
    }
    
    CGRect mainFrame = [[[UIApplication sharedApplication]delegate]window].frame;
    CGFloat theHeight = 0.0;
    
    for (UIView * sub in self.componentArray) {
        CGRect theFrame = sub.frame;
        theFrame.origin.y = theHeight + GapBetweenInTop;
        sub.frame = theFrame;
        theHeight = theFrame.size.height + theFrame.origin.y;
        [self.mainScrollview addSubview:sub];
    }
    
    [self.mainScrollview setContentSize:CGSizeMake(mainFrame.size.width, MAX(mainFrame.size.height, theHeight))];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
