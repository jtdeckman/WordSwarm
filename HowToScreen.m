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
    
    screen = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"howToScreen.png"]];
    screen.frame = self.view.frame;
    
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

@end
