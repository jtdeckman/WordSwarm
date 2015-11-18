//
//  WordLogic.m
//  Droozle
//
//  Created by Jason Deckman on 11/5/15.
//  Copyright © 2015 JDeckman. All rights reserved.
//

#import "WordLogic.h"

@implementation WordLogic

@synthesize nArraySelections;

- (void)initLetters {

    dictionary = [Lexicontext sharedDictionary];
    
    wordTypes = [[NSMutableArray alloc] initWithObjects:@"Word", @"Noun", @"Verb", @"Adj", nil];
    
    letters = [[NSMutableArray alloc] initWithObjects:@"A",
               @"A",
               @"A",
               @"A",
               @"A",
               @"A",
               @"A",
               @"A",
               @"A",
               @"B",
               @"B",
               @"C",
               @"C",
               @"D",
               @"D",
               @"E",
               @"E",
               @"E",
               @"E",
               @"E",
               @"E",
               @"E",
               @"E",
               @"E",
               @"E",
               @"E",
               @"E",
               @"E",
               @"F",
               @"F",
               @"G",
               @"G",
               @"G",
               @"H",
               @"H",
               @"H",
               @"H",
               @"I",
               @"I",
               @"I",
               @"I",
               @"I",
               @"I",
               @"I",
               @"I",
               @"J",
               @"K",
               @"K",
               @"L",
               @"L",
               @"L",
               @"L",
               @"M",
               @"M",
               @"N",
               @"N",
               @"N",
               @"N",
               @"N",
               @"O",
               @"O",
               @"O",
               @"O",
               @"O",
               @"O",
               @"O",
               @"O",
               @"P",
               @"P",
               @"Q",
               @"R",
               @"R",
               @"R",
               @"R",
               @"R",
               @"S",
               @"S",
               @"S",
               @"S",
               @"S",
               @"T",
               @"T",
               @"T",
               @"T",
               @"T",
               @"T",
               @"T",
               @"U",
               @"U",
               @"U",
               @"U",
               @"V",
               @"W",
               @"W",
               @"X",
               @"Y",
               @"Y",
               @"Z",
               @"",
               @"",
               @"",
               @"",
               @"",
               nil];
    
    nArraySelections = (int)[letters count];
   
}

- (NSString*)getLetter {
 
    int index;

    index = arc4random() % nArraySelections;
    
    return letters[index];
}

- (NSString*)randomLetter {
    
    int index = arc4random() % nArraySelections;
    
    return letters[index];
}

- (NSString*)getType {

    int index = arc4random() % [wordTypes count];
    
    return wordTypes[index];
}

- (BOOL)isWord:(NSString*)word {

    NSString *result = [dictionary definitionFor:word];
    
    NSString *subString = [result substringToIndex:20];
    NSArray *components = [subString componentsSeparatedByString:@" "];
    
    NSString *wrd1 = components[1];
    NSString *wrd2 = components[2];
    
    if([wrd1 isEqualToString:@"definition"] && [wrd2 isEqualToString:@"not"])
        return NO;
    
    else {
        
        return YES;
    }
    
    return NO;
}

@end
