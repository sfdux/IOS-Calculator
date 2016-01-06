//
//  MainViewController.h
//  calculator
//
//
//  Created by James on 15/12/09.
//  Copyright © 2015年 James Shi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *textViewScreen;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *allButtons;

@end
