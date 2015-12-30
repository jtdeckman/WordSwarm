//
//  SettingsViewController.m
//  Droozle
//
//  Created by Jason Deckman on 12/29/15.
//  Copyright © 2015 JDeckman. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setUp];
   
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)setUp {

    CGRect frm;
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    
    UIImage *tmpImage = [UIImage imageNamed:@"stars1.png"];
    [tmpImage drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    tmpImage = UIGraphicsGetImageFromCurrentImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:tmpImage];
    
    frm.size.width = 0.85*self.view.frame.size.width;
    frm.size.height = 0.35*frm.size.width;
    frm.origin.y = 0.8*frm.size.height;
    frm.origin.x = (self.view.frame.size.width - frm.size.width)/2.0;

    playModeBox = [[UILabel alloc] initWithFrame:frm];
    
    playModeBox.hidden = NO;
    playModeBox.layer.cornerRadius = 5.0;
    playModeBox.clipsToBounds = YES;
    playModeBox.opaque = NO;
    playModeBox.layer.borderWidth = 0.75f;
    
    [playModeBox.layer setBorderColor:[[UIColor clearColor] CGColor]];
    playModeBox.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.15];
    
    [self.view addSubview:playModeBox];
    
    frm.size.height *= 0.25;
    frm.origin.y += 0.5*frm.size.height;
    
    playModeLabel = [[UILabel alloc] initWithFrame:frm];
    
    playModeLabel.hidden = NO;
    playModeLabel.layer.cornerRadius = 5.0;
    playModeLabel.clipsToBounds = YES;
    playModeLabel.opaque = NO;
    
    [playModeLabel setTextAlignment:NSTextAlignmentCenter];
    [playModeLabel setFont:[UIFont fontWithName:@"Helvetica-Oblique" size:1.75*FONT_FACT*playModeLabel.frame.size.height]];
    
    playModeLabel.textColor = [UIColor colorWithRed:0.1 green:0.7 blue:0.9 alpha:1.0];
    playModeLabel.backgroundColor = [UIColor clearColor];
    
    playModeLabel.text = @"Game Play Mode";
    
    [self.view addSubview:playModeLabel];
    
    frm = playModeLabel.frame;
    frm.size.width *= 0.75;
    frm.origin.y += 1.75*frm.size.height;
    frm.origin.x = (self.view.frame.size.width - frm.size.width)/2.0;
    
  //  UIFont *font = [UIFont fontWithName:@"Helvetica-Oblique" size:1.45*FONT_FACT*frm.size.height];
 //   NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                             //                              forKey:NSFontAttributeName];
    
    playModeControl = [[UISegmentedControl alloc] initWithItems:@[@"Leveled Play",@"Free Play"]];
    [playModeControl setFrame:frm];
    [playModeControl addTarget:self action:@selector(segmentedControlValueDidChange:) forControlEvents:UIControlEventValueChanged];
  //  [playModeControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    [playModeControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    
    playModeControl.tintColor = [UIColor lightGrayColor];
    [self.view addSubview:playModeControl];
}

- (void)segmentedControlValueDidChange : (UISegmentedControl*)controlItem {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if(controlItem == playModeControl) {
        if(controlItem.selectedSegmentIndex == 1)
            [defaults setBool:YES forKey:@"gamePlay"];
        else
            [defaults setBool:NO forKey:@"gamePlay"];
    }
    
}

@end
