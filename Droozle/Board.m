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
    
    CGFloat os2 = 0;//offset/2.0;
    CGFloat xini, yini;
    
    CGRect spcFrm, pcFrm;
    
    dimx = dx;
    dimy = dy;
    
    numSpaces = dimx*dimy;
    
    spaceWidth = (bvFrame.size.width - buffer)/(CGFloat)dy;
    spaceHeight = spaceWidth;//(bvFrame.size.height - offset)/(CGFloat)dx;
    
    pieceWidth = spaceWidth;
    pieceHeight = pieceWidth; //spaceHeight - offset;
    
    pw2 = pieceWidth/2.0;
    ph2 = pieceWidth/2.0;
    
    spcFrm.size.width = spaceWidth;
    spcFrm.size.height = spaceHeight;
    
    pcFrm.size.width = pieceWidth;
    pcFrm.size.height = pieceHeight;
    
    spaces = [[NSMutableArray alloc] initWithCapacity:dimx];
    rowTypes = [[NSMutableArray alloc] initWithCapacity:dimx];
    
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
    
    spcFrm.size.width = 2.0*spcFrm.size.width;
    spcFrm.size.height -= offset;
    
    for(int i=0; i<dimx; i++) {
    
        newSpace = spaces[i][dimy-1];
        
        spcFrm.origin.x = newSpace.piece.frame.origin.x + newSpace.piece.frame.size.width + 0.1*buffer + os2;
        spcFrm.origin.y = newSpace.piece.frame.origin.y + os2;
      
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

- (void)addPiece: (int)ival : (int)jval : (NSString*)val {
    
    Space *space = spaces[ival][jval];
    
    space.isOccupied = YES;
    space.value = val;
    
    [space configurePiece:NO];
    
    space.piece.hidden = false;
}

- (void)addRefPiece: (int)ival :(NSString*)val {
    
    Space *space = rowTypes[ival];
    
    space.isOccupied = YES;
    space.value = val;
    
    [space configurePiece:YES];
    
    space.piece.hidden = NO;
}

- (void)addBottomRow: (NSMutableArray*)vals {

    NSString *value;
    
    for(int i=0; i<dimy; i++) {
        value = [vals objectAtIndex:i];
        [self addPiece:dimx-1 :i :value];
    }
    
    value = [vals objectAtIndex:dimy];
    [self addRefPiece:dimx-1 :value];
}

- (Space*)getSpaceForIndices: (int)ii : (int)ji {
    
    return spaces[ii][ji];
}

- (Space*)getRefSpaceFromIndex:(int)loc {

    return rowTypes[loc];
}

- (Space*)getSpaceFromPoint: (CGPoint)loc {
    
    Space *space;
    
    for(int i=0; i<dimx; i++) {
        for(int j=0; j<dimy; j++) {
            
            space = spaces[i][j];
            
            if(CGRectContainsPoint(space.spaceFrame, loc)) return space;
        }
    }
    
    for(int i=0; i<dimx; i++) {
            
            space = rowTypes[i];
            
            if(CGRectContainsPoint(space.spaceFrame, loc)) return space;
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
            [space configurePiece:NO];
        }
        
        space = rowTypes[i];
        spaceBelow = rowTypes[i+1];
        
        space.value = spaceBelow.value;
        space.isOccupied = spaceBelow.isOccupied;
        space.piece.hidden = spaceBelow.piece.hidden;
        [space configurePiece:YES];
    }
    
    return NO;
}

- (BOOL)topRowOccupied {
    
    Space *space;

    space = rowTypes[0];
        if(space.isOccupied) return YES;

    return NO;
}

- (void)eliminateRow:(uint)row {
    
    Space *space, *spaceAbove;
    
    for(int i=row; i>0; i--) {
        
        for(int j=0; j<dimy; j++) {
            space = spaces[i][j];
            spaceAbove = spaces[i-1][j];
            space.value = spaceAbove.value;
            space.isOccupied = spaceAbove.isOccupied;
            space.piece.hidden = spaceAbove.piece.hidden;
            [space configurePiece:NO];
        }

        space = rowTypes[i];
        spaceAbove = rowTypes[i-1];
        
        space.value = spaceAbove.value;
        space.isOccupied = spaceAbove.isOccupied;
        space.piece.hidden = spaceAbove.piece.hidden;
        [space configurePiece:YES];
    }
    
    for(int j=0; j<dimy; j++) {
        
        space = spaces[0][j];
        space.value = 0;
        space.isOccupied = NO;
        space.piece.hidden = YES;
    }
    
    space = rowTypes[0];
    space.value = 0;
    space.isOccupied = NO;
    space.piece.hidden = YES;
}

- (NSString*)makeWordFromRow: (uint)row {
    
    NSMutableString *word = [[NSMutableString alloc] initWithString:@""];
    
    Space *space;
    
    for(int i=0; i<dimy; i++) {
        
        space = spaces[row][i];
        [word appendString:space.piece.text];
    }
    
    return word;
}


@end
