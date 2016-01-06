//
//  ResultViewController.m
//  calculator
//
//  Created by James on 15/12/09.
//  Copyright © 2015年 . All rights reserved.
//

#import "ResultViewController.h"
#import "SystemUtil.h"


@interface ResultViewController ()

@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initView];
}

-(void)initView{
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webViewResult.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    _btnClear.backgroundColor = RESULT_CLEAR_COLOR;
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigaitonBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigaitonBarBounds.size.height - progressBarHeight, navigaitonBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    [_imageBack setUserInteractionEnabled:YES];
    [_imageBack addGestureRecognizer:tap];
    
    _webViewResult.scrollView.showsHorizontalScrollIndicator = NO;
    _webViewResult.scrollView.showsVerticalScrollIndicator = NO;
    
    UITapGestureRecognizer* tapSort = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSort)];
    [_imageListArrangement setUserInteractionEnabled:YES];
    [_imageListArrangement addGestureRecognizer:tapSort];
    
    [_btnClear addTarget:self action:@selector(clickClear) forControlEvents:UIControlEventTouchUpInside];
    
    if(![SystemUtil isEmptyOrNull:_queryContext]){
        _labQueryContext.text = [NSString stringWithFormat:@"%@的结果为:",_queryContext];
    }
    
//    [self initSegmentedControl];
    [self loadWebView];
}

-(void)initSegmentedControl{
    _segmentedSort = [[NYSegmentedControl alloc] initWithItems:@[@"Light", @"Dark"]];
    [_segmentedSort addTarget:self action:@selector(segmentSelected) forControlEvents:UIControlEventValueChanged];
    _segmentedSort.titleFont = [UIFont fontWithName:@"AvenirNext-Medium" size:14.0f];
    _segmentedSort.titleTextColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
    _segmentedSort.selectedTitleFont = [UIFont fontWithName:@"AvenirNext-DemiBold" size:14.0f];
    _segmentedSort.selectedTitleTextColor = [UIColor whiteColor];
    _segmentedSort.borderWidth = 1.0f;
    _segmentedSort.borderColor = [UIColor colorWithWhite:0.15f alpha:1.0f];
    _segmentedSort.drawsGradientBackground = YES;
    _segmentedSort.segmentIndicatorInset = 2.0f;
    _segmentedSort.segmentIndicatorGradientTopColor = [UIColor colorWithRed:0.30 green:0.50 blue:0.88f alpha:1.0f];
    _segmentedSort.segmentIndicatorGradientBottomColor = [UIColor colorWithRed:0.20 green:0.35 blue:0.75f alpha:1.0f];
    _segmentedSort.drawsSegmentIndicatorGradientBackground = YES;
    _segmentedSort.segmentIndicatorBorderWidth = 0.0f;
    _segmentedSort.selectedSegmentIndex = 0;
    [_segmentedSort sizeToFit];
    [self.view addSubview:_segmentedSort];
}

-(void)clickSort{
    [self changeButtonState];
}

-(void)changeButtonState{
    NSURLRequest *request;
     if([SystemUtil compareImageView:_imageListArrangement.image isEqualTo:[UIImage imageNamed:@"sort_left"]]){
         [_imageListArrangement setImage:[UIImage imageNamed:@"sort_right"]];
         request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://www.infoq.com/cn/development/"]];
     }else{
         [_imageListArrangement setImage:[UIImage imageNamed:@"sort_left"]];
         request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://www.cocoachina.com/"]];
     }
    [_webViewResult loadRequest:request];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)loadWebView
{
//    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://192.168.1.200:8080/examples/jsp/dates/date.jsp"]];
    
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://www.infoq.com/cn/development/"]];
    [_webViewResult loadRequest:req];
}

-(void)clickClear{
    [_webViewResult loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)segmentSelected {

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
//    self.title = [_webViewResult stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title = @"结果";
}


@end
