//
//  HowToScreenInit.m
//  WordBatch
//
//  Created by Jason Deckman on 4/10/16.
//  Copyright © 2016 JDeckman. All rights reserved.
//

#import "HowToScreenInit.h"

@implementation HowToScreenInit

@synthesize checkBox;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    boxChecked = NO;
    
    screen.image = [UIImage imageNamed:@"HowToScreen-1.png"];
    
    CGRect frame;
    
    frame.size.width = 0.1*self.view.frame.size.width;
    frame.size.height = frame.size.width;
    
    frame.origin.x = 0.4*self.view.frame.size.width;
    frame.origin.y = 0.95*self.view.frame.size.height;
    
    checkBox = [[UIImageView alloc] initWithFrame:frame];
    
    UIGraphicsBeginImageContext(frame.size);
    
    UIImage *tmpImage = [UIImage imageNamed:@"unchecked.png"];
    [tmpImage drawInRect:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    
    boxUncheckedImg = UIGraphicsGetImageFromCurrentImageContext();
    
    tmpImage = [UIImage imageNamed:@"checked.png"];
    [tmpImage drawInRect:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    
    boxCheckedImg = UIGraphicsGetImageFromCurrentImageContext();
    
    checkBox.image = boxUncheckedImg;
    checkBox.hidden = NO;
    
    [self.view addSubview:checkBox];
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
            checkBox.image = boxUncheckedImg;
            
            [defaults setBool:NO forKey:@"howToScreenSeen"];
        }
        else {
            
            boxChecked = YES;
            checkBox.image = boxCheckedImg;
            
            [defaults setBool:YES forKey:@"howToScreenSeen"];
        }
        
        [defaults synchronize];
    }
   // else if(CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>))
}

- (void)deconstruct {
    
    screen = nil;
}

- (BOOL)prefersStatusBarHidden {
    
    return YES;
}

@end
