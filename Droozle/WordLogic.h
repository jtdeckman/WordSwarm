//
//  WordLogic.h
//  Droozle
//
//  Created by Jason Deckman on 11/5/15.
//  Copyright © 2015 JDeckman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WordLogic : NSObject {
    
    NSMutableArray *letters;
    
    int nArraySelections;
}

@property (nonatomic) int nArraySelections;

- (void)initLetters;

- (NSString*)getLetter;
- (NSString*)randomLetter;

@end
