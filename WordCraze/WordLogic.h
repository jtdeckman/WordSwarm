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
    
    NSMutableDictionary *pointsForLetters;
    
    int nArraySelections;
    
    Lexicontext *dictionary;
}

@property (nonatomic) int nArraySelections;

@property (nonatomic, strong) NSMutableArray *letters;
@property (nonatomic, strong) NSMutableArray *wordTypes;

- (void)initLetters;
- (void)reinitLetters;

- (NSString*)getLetter;
- (NSString*)randomLetter;
- (NSString*)getType;

- (BOOL)isWord:(NSString*)word inCategory:(NSString*)cat;
- (BOOL)checkWord:(NSString*)word forCategory:(NSString*)cat;

- (void)deconstruct;
- (void)initWordTypesForLevel:(int)level;

- (int)pointValueForLetter:(NSString*)letter;

@end
