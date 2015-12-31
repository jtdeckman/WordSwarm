//
//  Animations.h
//  Droozle
//
//  Created by Jason Deckman on 12/30/15.
//  Copyright © 2015 JDeckman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Constants.h"

@interface Animations : NSObject {
    
    UILabel *textBox1;
    UILabel *textBox2;
    
    CGRect baseLocBox1;
}

@property (nonatomic, strong) UILabel *textBox1;

- (void)setUp:(CGRect)frame :(CGFloat)origy;
- (void)animateTextBox1:(CGFloat)duration :(CGFloat)startLoc :(CGFloat)delay :(NSString*)text;

- (void)deconstruct;

@end
