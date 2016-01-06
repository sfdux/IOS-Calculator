//
//  MainViewController.m
//  calculator
//
//
//  Created by James on 15/12/09.
//  Copyright © 2015年 James Shi. All rights reserved.

#import "MainViewController.h"
#import "ResultViewController.h"
#import "SystemEnum.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initView];
}

-(void)initView{
    _textViewScreen.font = TEXT_SCREEN_FONT;
//    _textViewScreen.backgroundColor = TEXT_SCREEN_BACKGROUND_COLOR;
//    _textViewScreen.layer.borderColor = [TEXT_SCREEN_BACKGROUND_COLOR CGColor];
    //    _textViewScreen.layer.borderWidth = 5.0f;
    _textViewScreen.editable = NO;
    _textViewScreen.textColor = SCREEN_TEXT_COLOR;
    
    [self displayString:@"" withMethod:CoverMethod];
    
    for(UIButton *button in self.allButtons)
    {
        int digit = (int) button.tag;
        
        switch (digit) {
            case -2:
            case -1:
            case 0:
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
            case 6:
            case 7:
            case 8:
            case 9:
                button.tintColor = NUMBER_BACKGROUND_COLOR;
                break;
            case 20:
                break;
            default:
                button.tintColor = PARAMETER_BACKGROUND_COLOR;
                break;
        }
        
        button.titleLabel.font = BUTTON_TITLE_FONT;
        
        [button addTarget:self action:@selector(clickButtons:) forControlEvents:UIControlEventTouchUpInside];
    }
}

//±100: -2
//,: -1
//+: 18
//=: 19
//C: 20
-(void)clickButtons:(UIButton *)btn{
    [self processDigit:btn];
}

-(void)processDigit:(UIButton *)btn{
    int digit = (int) btn.tag;
    
    switch (digit) {
        case 19:
            [self clickEqual];
            break;
        case 20:
            [self clickClear];
            break;
        default:
            [self displayString:btn.titleLabel.text withMethod:AddMethod];
            break;
    }
}

-(void)displayString:(NSString *)str withMethod:(int)method
{
    NSMutableString *displayString=[NSMutableString stringWithString:self.textViewScreen.text];
    
    switch(method){
        case CoverMethod:
            displayString=[NSMutableString stringWithString:str];
            break;
        case AddMethod:
            [displayString appendString:str];
            break;
        default:
            break;
    }
    
    self.textViewScreen.text = displayString;
}

-(void)clickEqual{
//    ResultViewController *resultVC = [ResultViewController new];
//    resultVC.queryContext = self.textViewScreen.text;
//    [self.navigationController pushViewController:resultVC animated:true];
}

-(void)clickClear{
    [self displayString:@"" withMethod:CoverMethod];
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
