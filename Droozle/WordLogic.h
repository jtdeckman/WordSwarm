//
//  WordLogic.h
//  Droozle
//
//  Created by Jason Deckman on 11/5/15.
//  Copyright © 2015 JDeckman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Lexicontext.h"

@interface WordLogic : NSObject {
    
    NSMutableArray *letters;
    NSMutableArray *wordTypes;
    
    int nArraySelections;
    
    Lexicontext *dictionary;
}

@property (nonatomic) int nArraySelections;

- (void)initLetters;

- (NSString*)getLetter;
- (NSString*)randomLetter;
- (NSString*)getType;

- (BOOL)isWord:(NSString*)word;

@end
