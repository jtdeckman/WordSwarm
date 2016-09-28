//
//  HowToScreenInit.m
//  WordBatch
//
//  Created by Jason Deckman on 4/10/16.
//  Copyright © 2016 JDeckman. All rights reserved.
//

#import "HowToScreenInit.h"
#import "Constants.h"

@interface HowToScreenInit ()

@property(nonatomic,strong) UILabel *doneLabel;

@end

@implementation HowToScreenInit

@synthesize checkBox;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    boxChecked = NO;
    
    screen.image = [UIImage imageNamed:@"HowToScreen-1.png"];
    
    CGRect frame;
    
    frame.size.width = 0.05*self.view.frame.size.width;
    frame.size.height = frame.size.width;
    
    frame.origin.x = 0.35*self.view.frame.size.width;
    frame.origin.y = 0.9*self.view.frame.size.height;
    
    checkBox = [[UILabel alloc] initWithFrame:frame];
    
    checkBox.layer.cornerRadius = 2.50;
    checkBox.clipsToBounds = YES;
    checkBox.opaque = NO;
    
    checkBox.textColor = [UIColor blackColor];
    checkBox.layer.borderColor = [[UIColor whiteColor] CGColor];
    checkBox.layer.borderWidth = 0.85;
    checkBox.backgroundColor = [UIColor whiteColor];
    checkBox.hidden = NO;
    checkBox.text = @"";
    [checkBox setTextAlignment:NSTextAlignmentCenter];
    [checkBox setFont:[UIFont fontWithName:@"Copperplate" size:3.0*FONT_FACT*frame.size.width]];
    
    [self.view addSubview:checkBox];
    
    frame.size.width = 0.15*self.view.frame.size.width;
    frame.size.height = 0.5*frame.size.width;
    frame.origin.x = self.view.frame.size.width - 1.25*frame.size.width; //(self.view.frame.size.width - frame.size.width)/2.0;
    frame.origin.y = self.view.frame.size.height - 1.5*frame.size.height;
    
    _doneLabel = [[UILabel alloc] initWithFrame:frame];
    
    _doneLabel.layer.cornerRadius = 2.50;
    _doneLabel.clipsToBounds = YES;
    _doneLabel.opaque = NO;
    
    _doneLabel.textColor = [UIColor whiteColor];
    _doneLabel.layer.borderColor = [[UIColor whiteColor] CGColor];
    _doneLabel.layer.borderWidth = 0.85;
    _doneLabel.hidden = NO;
    _doneLabel.text = @"Done";
    
    [_doneLabel setTextAlignment:NSTextAlignmentCenter];
    [_doneLabel setFont:[UIFont fontWithName:@"Copperplate" size:0.7*FONT_FACT*frame.size.width]];
    
    [self.view addSubview:_doneLabel];

}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self.view];
    
    if(CGRectContainsPoint(checkBox.frame, location)) {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        if(boxChecked) {
            
            boxChecked = NO;
            checkBox.text = @"";
            
            [defaults setBool:NO forKey:@"howToScreenSeen"];
        }
        else {
            
            boxChecked = YES;
            checkBox.text = @"x";
            
            [defaults setBool:YES forKey:@"howToScreenSeen"];
        }
        
        [defaults synchronize];
    }
    
    if(CGRectContainsPoint(_doneLabel.frame, location)) {
        
        [self deconstruct];
        [self dismissViewControllerAnimated:NO completion:nil];
    }

}

- (void)deconstruct {
    
    screen = nil;
}

- (BOOL)prefersStatusBarHidden {
    
    return YES;
}

@end
