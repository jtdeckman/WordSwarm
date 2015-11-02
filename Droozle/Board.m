//
//  Board.m
//  Droozle
//
//  Created by Jason Deckman on 9/4/15.
//  Copyright (c) 2015 JDeckman. All rights reserved.
//

#import "Board.h"

@implementation Board

@synthesize selectedSpace, spaces;
@synthesize rows, dimx, dimy;

- (void)initBoard: (CGRect)bvFrame : (int)dx : (int)dy : (CGFloat)offset : (CGFloat)buffer {
    
    NSMutableArray *row;
    
    Space *newSpace;
    
    CGFloat os2 = offset/2.0;
    CGFloat xini, yini;
    
    CGRect spcFrm, pcFrm;
    
    dimx = dx;
    dimy = dy;
    
    numSpaces = dimx*dimy;
    
    spaceWidth = (bvFrame.size.width - offset - buffer)/(CGFloat)dy;
    spaceHeight = spaceWidth;//(bvFrame.size.height - offset)/(CGFloat)dx;
    
    pieceWidth = spaceWidth - offset;
    pieceHeight = pieceWidth; //spaceHeight - offset;
    
    pw2 = pieceWidth/2.0;
    ph2 = pieceWidth/2.0;
    
    spcFrm.size.width = spaceWidth;
    spcFrm.size.height = spaceHeight;
    
    pcFrm.size.width = pieceWidth;
    pcFrm.size.height = pieceHeight;
    
    spaces = [[NSMutableArray alloc] initWithCapacity:dimx];
    rowTypes = [[NSMutableArray alloc] initWithCapacity:dimx];
    rowSumPieces = [[NSMutableArray alloc] initWithCapacity:dimx];
    
    xini = bvFrame.origin.x;
    yini = bvFrame.origin.y;
    
    for(int i=0; i<dimx; i++) {
        
        row = [[NSMutableArray alloc] initWithCapacity:dimy];
        
        for(int j=0; j<dimy; j++) {
            
            spcFrm.origin.x = xini + j*spaceWidth;
            spcFrm.origin.y = yini + i*spaceHeight;
            
            pcFrm.origin.x = spcFrm.origin.x + os2;
            pcFrm.origin.y = spcFrm.origin.y + os2;
            
            newSpace = [[Space alloc] init];
            
            [newSpace initSpace:i :j :spcFrm :pcFrm];
            
            [row addObject:newSpace];
        }
        
        [spaces addObject:row];
    }
    
    spcFrm.size.width = 0.4*buffer;
    
    for(int i=0; i<dimx; i++) {
    
        newSpace = spaces[i][dimy-1];
        
        spcFrm.origin.x = newSpace.piece.frame.origin.x + newSpace.piece.frame.size.width + 0.1*buffer;
        spcFrm.origin.y = newSpace.piece.frame.origin.y;
      
        newSpace = [[Space alloc] init];
        
        [newSpace initSpace:i :-1 :spcFrm :spcFrm];
        
        [rowSumPieces addObject:newSpace];
        
        spcFrm.origin.x += spcFrm.size.width + 0.025*spcFrm.size.width;
        
        newSpace = [[Space alloc] init];
        
        [newSpace initSpace:i :-1 :spcFrm :spcFrm];
        
        [rowTypes addObject:newSpace];
        
    }
    
    [self findNeighbors];
}


- (void)findNeighbors {
    
    Space *space;
    
    int inbr, jnbr;
    
    for(int i=0; i<dimx; i++) {
        for(int j=0; j<dimy; j++) {
            
            space = [self getSpaceForIndices:i :j];
            
            inbr = i-1;
            jnbr = j;
            
            if(inbr > -1) {
                [space.nearestNbrs addObject:[self getSpaceForIndices:inbr :jnbr]];
                [space.neighbors addObject:[self getSpaceForIndices:inbr :jnbr]];
            }
            
            inbr = i+1;
            if(inbr < dimx) {
                [space.nearestNbrs addObject:[self getSpaceForIndices:inbr :jnbr]];
                [space.neighbors addObject:[self getSpaceForIndices:inbr :jnbr]];
            }
            
            inbr = i;
            jnbr = j-1;
            
            if(jnbr > -1) {
                [space.nearestNbrs addObject:[self getSpaceForIndices:inbr :jnbr]];
                [space.neighbors addObject:[self getSpaceForIndices:inbr :jnbr]];
            }
            
            jnbr = j+1;
            if(jnbr < dimy) {
                [space.nearestNbrs addObject:[self getSpaceForIndices:inbr :jnbr]];
                [space.neighbors addObject:[self getSpaceForIndices:inbr :jnbr]];
            }
            
            inbr = i-1;
            jnbr = j-1;
            
            if(inbr > -1 && jnbr > -1)
                [space.neighbors addObject:[self getSpaceForIndices:inbr :jnbr]];
            
            jnbr = j+1;
            if(inbr > -1 && jnbr < dimy)
                [space.neighbors addObject:[self getSpaceForIndices:inbr :jnbr]];
            
            inbr = i+1;
            if(inbr < dimx && jnbr < dimy)
                [space.neighbors addObject:[self getSpaceForIndices:inbr :jnbr]];
            
            jnbr = j-1;
            if(inbr < dimx && jnbr > -1)
                [space.neighbors addObject:[self getSpaceForIndices:inbr :jnbr]];
        }
    }
}

- (void)addPiece: (int)ival : (int)jval : (int)val {
    
    Space *space = spaces[ival][jval];
    
    space.isOccupied = YES;
    space.value = val;
    
    [space configurePiece:NO :NO];
    
    space.piece.hidden = false;
    
}

- (void)addRefPiece: (int)ival :(int)val {
    
    Space *space = rowTypes[ival];
    
    space.isOccupied = YES;
    space.value = val;
    
    [space configurePiece:YES :NO];
    
    space.piece.hidden = false;
    
    space = rowSumPieces[ival];
    space.isOccupied = YES;
    space.value = [self sumRow:ival];
    
    [space configurePiece:NO :YES];
    
    space.piece.hidden = NO;
}

- (void)addBottomRow: (NSMutableArray*)vals {

    NSNumber *value;
    
    for(int i=0; i<dimy; i++) {
        value = [vals objectAtIndex:i];
        [self addPiece:dimx-1 :i :(int)[value integerValue]];
    }
    
    value = [vals objectAtIndex:dimy];
    [self addRefPiece:dimx-1 :(int)[value integerValue]];
}

- (Space*)getSpaceForIndices: (int)ii : (int)ji {
    
    return spaces[ii][ji];
}

- (Space*)getRefSpaceFromIndex:(int)loc {

    return rowTypes[loc];
}

- (Space*)getSumSpaceFromIndex: (int)loc {

    return rowSumPieces[loc];
}

- (Space*)getSpaceFromPoint: (CGPoint)loc {
    
    Space *space;
    
    for(int i=0; i<dimx; i++) {
        for(int j=0; j<dimy; j++) {
            
            space = spaces[i][j];
            
            if(CGRectContainsPoint(space.spaceFrame, loc)) return space;
        }
    }
    
    return NULL;
}

- (int)nbrNearestOccupied: (Space*)space {
    
    int nocc = 0;
    
    if(space != nil)
        for(Space* item in space.nearestNbrs)
            if(item.isOccupied) ++nocc;
    
    return nocc;
}

- (int)nbrOccupied: (Space*)space {
    
    int nocc = 0;
    
    if(space != nil)
        for(Space* item in space.neighbors)
            if(item.isOccupied) ++nocc;
    
    return nocc;
}

- (void)removePiece: (Space*)space {
    
    space.isOccupied = NO;
    space.piece.hidden = YES;
}

- (void)clearBoard {
    
    Space *space;
    
    for(int i=0; i<dimx; i++) {
        for(int j=0; j<dimy; j++) {
            
            space = spaces[i][j];
            space.isOccupied = NO;
            space.piece.hidden = YES;
        }
    }
}

- (void)deconstruct {
    
    Space* space;
    
    for(int i=0; i<dimx; i++)
        for(int j=0; j<dimy; j++) {
            space = spaces[i][j];
            [space deconstruct];
        }
    
    [spaces removeAllObjects];
    
    spaces = nil;
}

- (BOOL)shiftRowsUp {

    if([self topRowOccupied])
        return YES;
    
    Space *space, *spaceBelow;
    
    for(int i=0; i<dimx-1; i++) {
     
        for(int j=0; j<dimy; j++) {
            space = spaces[i][j];
            spaceBelow = spaces[i+1][j];
            space.value = spaceBelow.value;
            space.isOccupied = spaceBelow.isOccupied;
            space.piece.hidden = spaceBelow.piece.hidden;
            [space configurePiece:NO : NO];
         //   if(!space.piece.hidden)
           //     NSLog(@"%d %d",i,j);
        }
        
        space = rowTypes[i];
        spaceBelow = rowTypes[i+1];
        
        space.value = spaceBelow.value;
        space.isOccupied = spaceBelow.isOccupied;
        space.piece.hidden = spaceBelow.piece.hidden;
        [space configurePiece:YES: NO];
        
        space = rowSumPieces[i];
        spaceBelow = rowSumPieces[i+1];
        space.value = spaceBelow.value;
        space.isOccupied = spaceBelow.isOccupied;
        space.piece.hidden = spaceBelow.piece.hidden;
        [space configurePiece:NO :YES];
    }
    
    return NO;
}

- (int)sumRow:(int)row {

    int sum = 0;
    
    Space *space;
    
    for(int i=0; i<dimy; i++) {
        space = spaces[row][i];
        sum += space.value;
    }
    
    return sum;
}

- (BOOL)topRowOccupied {
    
    Space *space;
    
    for(int i=0; i<dimy; i++) {

        space = spaces[0][i];
        if(space.isOccupied) return YES;
    }

    return NO;
}



@end
