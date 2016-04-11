//
//  HowToScreen.m
//  Droozle
//
//  Created by Jason Deckman on 1/4/16.
//  Copyright © 2016 JDeckman. All rights reserved.
//

#import "HowToScreen.h"
#import "Constants.h"

@interface HowToScreen ()

@property(nonatomic,strong) UILabel *doneLabel;

@end

@implementation HowToScreen

- (void)viewDidLoad {
    
    [super viewDidLoad];

    CGRect frame = self.view.frame;
    
    if(self.view.frame.size.width/self.view.frame.size.height > 0.74) {
    
        frame.size.width = 0.5625*frame.size.height;
        frame.origin.x = (self.view.frame.size.width - frame.size.width)/2.0;
    }
    
    screen = [[UIImageView alloc] initWithFrame:frame];
    screen.image = [UIImage imageNamed:@"HowToScreen-2.png"];
    
    [self.view addSubview:screen];
    
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
