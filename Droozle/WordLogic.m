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
    
    NSNumber *p0 = [NSNumber numberWithInt:0];
    NSNumber *p1 = [NSNumber numberWithInt:1];
    NSNumber *p2 = [NSNumber numberWithInt:2];
    NSNumber *p3 = [NSNumber numberWithInt:3];
    NSNumber *p4 = [NSNumber numberWithInt:4];
    NSNumber *p5 = [NSNumber numberWithInt:5];
    NSNumber *p7 = [NSNumber numberWithInt:7];
    NSNumber *p10 = [NSNumber numberWithInt:10];
    NSNumber *p12 = [NSNumber numberWithInt:12];

    pointsForLetters = [[NSMutableDictionary alloc]  initWithObjectsAndKeys:
                        p1,@"A",
                        p4,@"B",
                        p5,@"C",
                        p2,@"D",
                        p1,@"E",
                        p4,@"F",
                        p3,@"G",
                        p3,@"H",
                        p1,@"I",
                        p10,@"J",
                        p5,@"K",
                        p2,@"L",
                        p4,@"M",
                        p2,@"N",
                        p1,@"O",
                        p4,@"P",
                        p10,@"Q",
                        p1,@"R",
                        p1,@"S",
                        p1,@"T",
                        p2,@"U",
                        p7,@"V",
                        p7,@"W",
                        p10,@"X",
                        p4,@"Y",
                        p12,@"Z",
                        p0,@"",
                        nil];
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

- (int)pointValueForLetter:(NSString*)letter {

    
    if(letter.length > 1) return  -1;
    
    NSNumber *val = [pointsForLetters objectForKey:letter];
    
    return (int)[val integerValue];
}

- (void)deconstruct {
    
    dictionary = nil;
    wordTypes = nil;
    letters = nil;
    
    pointsForLetters = nil;
}

@end
