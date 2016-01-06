//
//  ResultViewController.h
//  calculator
//
//  Created by James on 15/12/09.
//  Copyright © 2015年 James Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"
#import "RoundedButton.h"
#import "NYSegmentedControl.h"

@interface ResultViewController : UIViewController<UIWebViewDelegate, NJKWebViewProgressDelegate>{
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
    NYSegmentedControl *_segmentedSort;
}
@property (weak, nonatomic) IBOutlet UIWebView *webViewResult;
@property (weak, nonatomic) IBOutlet UIImageView *imageBack;
@property (weak, nonatomic) IBOutlet RoundedButton *btnClear;
@property (weak, nonatomic) IBOutlet UIImageView *imageListArrangement;
@property (weak, nonatomic) IBOutlet UILabel *labQueryContext;

@property(nonatomic,strong) NSString *queryContext;

@end
