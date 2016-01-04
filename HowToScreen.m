//
//  HowToScreen.m
//  Droozle
//
//  Created by Jason Deckman on 1/4/16.
//  Copyright © 2016 JDeckman. All rights reserved.
//

#import "HowToScreen.h"

@interface HowToScreen ()

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
    screen.image = [UIImage imageNamed:@"howToScreen.png"];
    
    [self.view addSubview:screen];

    touchCount = 0;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    if(touchCount > 0) {
        
        [self deconstruct];
        [self dismissViewControllerAnimated:NO completion:nil];
    }
    
    screen.image = [UIImage imageNamed:@"howToScreen-2.png"];
    
    ++touchCount;
}

- (void)deconstruct {

    screen = nil;
}

- (BOOL)prefersStatusBarHidden {
    
    return YES;
}

@end
