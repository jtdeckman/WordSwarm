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
    [self loadData];
   
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
    
/* // Play mode items
    
    frm.size.width = 0.7*self.view.frame.size.width;
    frm.size.height = 0.35*frm.size.width;
    frm.origin.y = 0.7*frm.size.height;
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
    
    playModeControl = [[UISegmentedControl alloc] initWithItems:@[@"Leveled Play",@"Free Play"]];
    [playModeControl setFrame:frm];
    [playModeControl addTarget:self action:@selector(segmentedControlValueDidChange:) forControlEvents:UIControlEventValueChanged];
    
    [playModeControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    
    playModeControl.tintColor = [UIColor lightGrayColor];
    [self.view addSubview:playModeControl]; */
    
    
// Difficulty items
    
    frm.size.width = 0.7*self.view.frame.size.width;
    frm.size.height = 0.35*frm.size.width;
    frm.origin.y = 0.7*frm.size.height;
    frm.origin.x = (self.view.frame.size.width - frm.size.width)/2.0;

  //  frm = playModeBox.frame;
    //frm.origin.y += frm.size.height + 0.5*frm.size.height;
    
    difficultyBox = [[UILabel alloc] initWithFrame:frm];
    
    difficultyBox.hidden = NO;
    difficultyBox.layer.cornerRadius = 5.0;
    difficultyBox.clipsToBounds = YES;
    difficultyBox.opaque = NO;
    difficultyBox.layer.borderWidth = 0.75f;
    
    [difficultyBox.layer setBorderColor:[[UIColor clearColor] CGColor]];
    difficultyBox.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.15];
    
    [self.view addSubview:difficultyBox];
    
    frm.size.height *= 0.25;
    frm.origin.y += 0.5*frm.size.height;
    
    difficultyLabel = [[UILabel alloc] initWithFrame:frm];
    
    difficultyLabel.hidden = NO;
    difficultyLabel.layer.cornerRadius = 5.0;
    difficultyLabel.clipsToBounds = YES;
    difficultyLabel.opaque = NO;
    
    [difficultyLabel setTextAlignment:NSTextAlignmentCenter];
    [difficultyLabel setFont:[UIFont fontWithName:@"Helvetica-Oblique" size:1.75*FONT_FACT*difficultyLabel.frame.size.height]];
    
    difficultyLabel.textColor = [UIColor colorWithRed:0.1 green:0.7 blue:0.9 alpha:1.0];
    difficultyLabel.backgroundColor = [UIColor clearColor];
    
    difficultyLabel.text = @"Difficulty";
    
    [self.view addSubview:difficultyLabel];
    
    frm = difficultyLabel.frame;
    frm.size.width *= 0.75;
    frm.origin.y += 1.75*frm.size.height;
    frm.origin.x = (self.view.frame.size.width - frm.size.width)/2.0;
    
    difficultyControl = [[UISegmentedControl alloc] initWithItems:@[@"Standard",@"Harder"]];
    [difficultyControl setFrame:frm];
    [difficultyControl addTarget:self action:@selector(segmentedControlValueDidChange:) forControlEvents:UIControlEventValueChanged];
    
    [difficultyControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    
    difficultyControl.tintColor = [UIColor lightGrayColor];
    
    [self.view addSubview:difficultyControl];
    
    frm = difficultyBox.frame;
    frm.size.width /= 3.0;
    frm.size.height /= 2.0;
    
    frm.origin.x = (self.view.frame.size.width - frm.size.width)/2.0;
    frm.origin.y = self.view.frame.size.height - 1.5*frm.size.height;
    
    acceptButton = [[UILabel alloc] initWithFrame:frm];
    
    acceptButton.hidden = NO;
    acceptButton.layer.cornerRadius = 5.0;
    acceptButton.clipsToBounds = YES;
    acceptButton.opaque = NO;
    acceptButton.layer.borderWidth = 0.75f;
    
    [acceptButton setTextAlignment:NSTextAlignmentCenter];
    [acceptButton setFont:[UIFont fontWithName:@"Helvetica-Oblique" size:1.75*FONT_FACT*difficultyLabel.frame.size.height]];
    
    [acceptButton.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    acceptButton.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.15];
    acceptButton.textColor = [UIColor lightGrayColor];
    
    acceptButton.text = @"Done";
    
    [self.view addSubview:acceptButton];
}

- (void)segmentedControlValueDidChange : (UISegmentedControl*)controlItem {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
 /*   if(controlItem == playModeControl) {
        
        if(controlItem.selectedSegmentIndex == 1)
            [defaults setInteger:1 forKey:@"gamePlay"];
        else
            [defaults setInteger:0 forKey:@"gamePlay"];
    } */
    
    if(controlItem == difficultyControl) {
        
        if(controlItem.selectedSegmentIndex == 1)
            [defaults setInteger:1 forKey:@"difficulty"];
        else
            [defaults setInteger:0 forKey:@"difficulty"];
    }
    
    [defaults synchronize];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self.view];
    
    if(CGRectContainsPoint(acceptButton.frame, location)) {
        
        [self deconstruct];
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

- (void)loadData {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
 //   [playModeControl setSelectedSegmentIndex:[defaults integerForKey:@"gamePlay"]];
    [difficultyControl setSelectedSegmentIndex:[defaults integerForKey:@"difficulty"]];
    
    [defaults synchronize];
}

- (void)deconstruct {
    
 /* [playModeBox removeFromSuperview];
    [difficultyBox removeFromSuperview];
    
    [playModeLabel removeFromSuperview];
    [difficultyLabel removeFromSuperview];

    [playModeControl removeFromSuperview];
    [difficultyControl removeFromSuperview];

    [acceptButton removeFromSuperview]; */
    
    acceptButton = nil;
    
  //  playModeBox = nil;
    difficultyBox = nil;
    
  //  playModeLabel = nil;
    difficultyLabel = nil;
    
  //  playModeControl = nil;
    difficultyControl = nil;
}

@end
