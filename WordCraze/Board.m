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

- (void)initBoard: (CGRect)bvFrame : (int)dx : (int)dy : (CGFloat)offset : (CGFloat)buffer :(WordLogic*)wl {
    
    NSMutableArray *row;
    
    Space *newSpace;
    
    CGFloat os2 = offset/2.0;
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
    
    pcFrm.size.width = pieceWidth - offset/2.0;
    pcFrm.size.height = pieceHeight - offset/2.0;
    
    spaces = [[NSMutableArray alloc] initWithCapacity:dimx];
    
    xini = bvFrame.origin.x+buffer/2.0;
    yini = bvFrame.origin.y+buffer/2.0;
    
    for(int i=0; i<dimx; i++) {
        
        row = [[NSMutableArray alloc] initWithCapacity:dimy];
        
        for(int j=0; j<dimy; j++) {
            
            spcFrm.origin.x = xini + j*spaceWidth;
            spcFrm.origin.y = yini + i*spaceHeight;
            
            pcFrm.origin.x = spcFrm.origin.x + os2/2.0;
            pcFrm.origin.y = spcFrm.origin.y + os2/2.0;
            
            newSpace = [[Space alloc] init];
            
            [newSpace initSpace:i :j :spcFrm :pcFrm];
            
            [row addObject:newSpace];
        }
        
        [spaces addObject:row];
    }
    
 /*   spcFrm.size.width = 1.35*spcFrm.size.width;
    spcFrm.size.height -= offset;
    
    for(int i=0; i<dimx; i++) {
    
        newSpace = spaces[i][dimy-1];
        
        spcFrm.origin.x = newSpace.piece.frame.origin.x + newSpace.piece.frame.size.width + 0.1*buffer + os2;
        spcFrm.origin.y = newSpace.piece.frame.origin.y + os2;
      
        newSpace = [[Space alloc] init];
        
        [newSpace initSpace:i :-1 :spcFrm :spcFrm];
        
        [rowTypes addObject:newSpace];
    } */
    
    [self findNeighbors];
    
    tileImages = [[TileImages alloc] init];
    [tileImages setUp:pcFrm.size];
    
    wLPointer = wl;
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

- (void)addPiece: (int)ival :(int)jval :(NSString*)val {
    
    Space *space = spaces[ival][jval];
    
    int pVal = [wLPointer pointValueForLetter:val];
    
    uint rnum = arc4random() % 25;
    
    if(pVal < 0) pVal = 0;
    
    space.isOccupied = YES;
    space.value = val;
    space.pointValue = pVal;
    
    if(rnum == 5 || rnum == 11 || rnum == 21)
        space.backPieceVal = 2;
    else
        space.backPieceVal = 1;
    
    [space configurePiece:NO :[tileImages backgroundImageForIndex:pVal]];
    
    space.piece.hidden = false;
}
- (void)addBottomRow: (NSMutableArray*)vals {

    NSString *value;
    
    for(int i=0; i<dimy; i++) {
        value = [vals objectAtIndex:i];
        [self addPiece:dimx-1 :i :value];
    }
    
 //   value = [vals objectAtIndex:dimy];
 //   [self addRefPiece:dimx-1 :value];
}

- (Space*)getSpaceForIndices: (int)ii : (int)ji {
    
    return spaces[ii][ji];
}

//- (Space*)getRefSpaceFromIndex:(int)loc {

//    return rowTypes[loc];
//}

- (Space*)getSpaceFromPoint: (CGPoint)loc {
    
    Space *space;
    
    for(int i=0; i<dimx; i++) {
        for(int j=0; j<dimy; j++) {
            
            space = spaces[i][j];
            
            if(CGRectContainsPoint(space.spaceFrame, loc)) return space;
        }
    }
    
//    for(int i=0; i<dimx; i++) {
            
 //           space = rowTypes[i];
            
   //         if(CGRectContainsPoint(space.spaceFrame, loc)) return space;
   // }

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
    
    space.backPiece.hidden = YES;
    space.backPieceVal = 1;
    space.pointsLabel.hidden = YES;
    
    space.value = @"-";
    space.pointValue = 0;
}

- (void)clearBoard {
    
    Space *space;
    
    for(int i=0; i<dimx; i++) {
        
     //   space = rowTypes[i];
      //  space.isOccupied = NO;
      //  space.piece.hidden = YES;
        
        for(int j=0; j<dimy; j++) {
            
            space = spaces[i][j];
            space.isOccupied = NO;
            space.piece.hidden = YES;
            
            space.backPieceVal = 1;
            space.backPiece.hidden = YES;
            
            space.pointsLabel.hidden = YES;
            space.pointsLabel.text = @"";
            
            space.piece.text = @"";
            space.value = @"";
            
            space.pointValue = 0;
        }
    }
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
            space.pointValue = spaceBelow.pointValue;
            space.backPieceVal = spaceBelow.backPieceVal;
            
            space.pointsLabel.hidden = spaceBelow.pointsLabel.hidden;
            
            [space configurePiece:NO :[tileImages backgroundImageForIndex:space.pointValue]];
        }
        
  //      space = rowTypes[i];
  //      spaceBelow = rowTypes[i+1];
        
 //       space.value = spaceBelow.value;
  //      space.isOccupied = spaceBelow.isOccupied;
  //      space.piece.hidden = spaceBelow.piece.hidden;
        
    //    [space configurePiece:YES :nil];
    }
    
    return NO;
}

- (BOOL)topRowOccupied {
    
    Space *space;

    for(int i=0; i<dimy; i++) {
        
        space = spaces[0][i];
       
        if(space.isOccupied || !space.piece.hidden)
            return YES;
    }

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
            space.pointValue = spaceAbove.pointValue;
            space.backPieceVal = spaceAbove.backPieceVal;
            
            space.pointsLabel.hidden = spaceAbove.pointsLabel.hidden;
            
            [space configurePiece:NO :[tileImages backgroundImageForIndex:space.pointValue]];
        }

  //      space = rowTypes[i];
  //      spaceAbove = rowTypes[i-1];
        
  //      space.value = spaceAbove.value;
  //      space.isOccupied = spaceAbove.isOccupied;
  //      space.piece.hidden = spaceAbove.piece.hidden;
  //      [space configurePiece:YES :nil];
    }
    
    for(int j=0; j<dimy; j++) {
        
        space = spaces[0][j];
        space.value = 0;
        space.pointValue = 0;
        space.isOccupied = NO;
        space.piece.hidden = YES;
        space.backPiece.hidden = YES;
        space.backPieceVal = 1;
        
        [space configurePiece:NO :0];
    }
    
 //  space = rowTypes[0];
 //   space.value = 0;
 //   space.isOccupied = NO;
  //  space.piece.hidden = YES;
    
  //  [space configurePiece:YES :nil];
}

- (void)shiftColumnsDown {

    Space *space, *spaceAbove;
    
    int emptyRow;
    int occRow;
    
    for(int i=0; i<dimy; i++) {
        
        [self findEmptySpaces:&emptyRow :&occRow :i];
        
        if(emptyRow > -1 && occRow > -1) {
            
            for(int j=occRow; j>-1; j--) {
                
                space = spaces[emptyRow][i];
                spaceAbove = spaces[j][i];
                
                space.value = spaceAbove.value;
                space.isOccupied = spaceAbove.isOccupied;
                space.piece.hidden = spaceAbove.piece.hidden;
                space.pointValue = spaceAbove.pointValue;
                space.backPieceVal = spaceAbove.backPieceVal;
                space.pointsLabel.hidden = spaceAbove.pointsLabel.hidden;
                
                [space configurePiece:NO :[tileImages backgroundImageForIndex:space.pointValue]];
                
                --emptyRow;
            }
        }
    }
}

- (void)findEmptySpaces:(int*) emptyRow :(int*)occRow :(int)column {

    Space* space;
    
    *occRow = -1;
    *emptyRow = -1;
    
    for(int i=dimx-1; i>-1; i--) {
        
        space = spaces[i][column];
        
        if(!space.isOccupied) {
            *emptyRow = i;
            break;
        }
    }
    
    for(int i=*emptyRow; i>-1; i--) {
        
        space = spaces[i][column];
        
        if(space.isOccupied) {
 
            *occRow = i;
            break;
        }
    }
}

- (NSString*)makeWordFromRow: (uint)row {
    
    NSMutableString *word = [[NSMutableString alloc] initWithString:@""];
    
    Space *space;
    
    for(int i=0; i<dimy; i++) {
        
        space = spaces[row][i];
        
        if(space.isOccupied)
            [word appendString:space.piece.text];
    }
    
    return word;
}

- (int)sumRow:(uint)row :(BOOL)absValue {

    Space* space;
    
    int sum = 0;
    
    for(int i=0; i<dimy; i++) {
        
        space = spaces[row][i];
        
        if(absValue)
            sum += abs(space.pointValue);//*space.backPieceVal);
        else
            sum += space.pointValue;//*space.backPieceVal;
    }
    
    return sum;
}

- (uint)numRowsOccupied {
    
    Space *space;
    
    uint nOcc = 0;
    
    for(int i=0; i<dimx; i++) {
        
        for(int j=0; j<dimy; j++)
            space = spaces[i][j];
        
        if(space.isOccupied && !space.piece.hidden) ++nOcc;
    }
    
    return nOcc;
}

- (void)hideOccupiedPieces {
    
    Space *space;
    
    for(int i=0; i<dimx; i++) {
        
    //    space = rowTypes[i];
        
  //      if(space.isOccupied) space.piece.hidden = YES;
        
        for(int j=0; j<dimy; j++) {
            
            space = spaces[i][j];
            
            if(space.isOccupied) space.piece.hidden = YES;
            if(space.backPieceVal > 1) space.backPiece.hidden = YES;
            
            space.pointsLabel.hidden = YES;
        }
    }
}


- (void)hideOccupiedPiecesInRow:(uint)row {

    Space *space;
        
  //  space = rowTypes[row];
        
  //  if(space.isOccupied) space.piece.hidden = YES;
        
    for(int j=0; j<dimy; j++) {
            
        space = spaces[row][j];
            
        if(space.isOccupied) space.piece.hidden = YES;
        if(space.backPieceVal > 1) space.backPiece.hidden = YES;
            
        space.pointsLabel.hidden = YES;
    }
}

- (void)unHideOccupiedPieces {
    
    Space *space;
    
    for(int i=0; i<dimx; i++) {
        
   //     space = rowTypes[i];
        
   //     if(space.isOccupied) space.piece.hidden = NO;
        
        for(int j=0; j<dimy; j++) {
            
            space = spaces[i][j];
            
            if(space.isOccupied) {
                
                space.piece.hidden = NO;
                space.pointsLabel.hidden = NO;
            }
            
            if(space.backPieceVal > 1) space.backPiece.hidden = NO;
        }
    }
}

- (void)unHidePiecesInRow:(uint)row {
    
    Space *space;
    
    for(int j=0; j<dimy; j++) {
        
        space = spaces[row][j];
        space.piece.hidden = NO;
        space.pointsLabel.hidden = NO;
    }

//    space = rowTypes[row];
//    space.piece.hidden = NO;
}

- (void)hideBackPiecesInRow:(uint)row { 
    
    Space *space;
    
    for(int j=0; j<dimy; j++) {
        
        space = spaces[row][j];
        space.backPiece.hidden = YES;
        
        space.pointsLabel.hidden = YES;
    }
}

- (void)hidePointsLabelInRow:(uint)row {

    Space *space;
    
    for(int j=0; j<dimy; j++) {
        
        space = spaces[row][j];
        space.pointsLabel.hidden = YES;
    }
}

- (void)unHideBackPiecesInRow:(uint)row {
    
    Space *space;
    
    for(int j=0; j<dimy; j++) {
        
        space = spaces[row][j];
        
        if(space.backPieceVal > 1)
            space.backPiece.hidden = NO;
        
        if(space.isOccupied)
            space.pointsLabel.hidden = NO;
    }
}

- (void)hideAllBackPieces {
    
    Space *space;
    
    for(int i=0; i<dimx; i++) {
        for(int j=0; j<dimy; j++) {
            
            space = spaces[i][j];
            space.backPiece.hidden = YES;
            space.pointsLabel.hidden = YES;
        }
    }
}

- (void)clearAllBackPieces {

    Space *space;
    
    for(int i=0; i<dimx; i++) {
        for(int j=0; j<dimy; j++) {
            
            space = spaces[i][j];
            [space setBackhighlightClear];
        }
    }
}

- (void)getPiecesInRow:(NSMutableArray*)pieces :(uint)row :(BOOL)getCatPiece :(uint)numPieces {

    Space *space;
    
    [pieces removeAllObjects];
    
    uint iterateTo = dimy;
    
    if(numPieces > 0)
        iterateTo = numPieces;
    
    for(int j=0; j<iterateTo; j++) {
        
        space = spaces[row][j];
        [pieces addObject:space.piece];
    }
    
 //   if(getCatPiece) {
 //
 //       space = [rowTypes objectAtIndex:row];
 //       [pieces addObject:space.piece];
  //  }
}

- (BOOL)addWordToTopUnOccupiedRow:(NSString*)word :(NSString*)category {

    int topUnOccupiedRow = dimx - [self numRowsOccupied] - 1;
    
    uint cnt=0;
    
    if(topUnOccupiedRow < 0)
        return NO;
    
    for(int i=0; i < [word length]; i++) {
        [self addPiece:topUnOccupiedRow :i :[word substringWithRange:NSMakeRange(i, 1)]];
        ++cnt;
    }
    
   // for(int i=cnt; i<dimy; i++)
     //   [self addPiece:topUnOccupiedRow :i :@""];
    
  //  [self addRefPiece:topUnOccupiedRow :category];
    
    return YES;
}

- (void)getAllVisiblePieces:(NSMutableArray*)allPieces :(BOOL)getRefPiece {

    Space *space;
    
    [allPieces removeAllObjects];
    
    for(int i=0; i<dimx; i++) {
        
 //       if(getRefPiece) {
            
   //         space = [rowTypes objectAtIndex:i];
        
 //       if(space.isOccupied)
 //           [allPieces addObject:space.piece];
  //      }
        
        for(int j=0; j<dimy; j++) {
            
            space = spaces[i][j];
            
            if(space.isOccupied)
                [allPieces addObject:((Space*)spaces[i][j]).piece];
        }
    }
}

/*- (BOOL)isCategoryRow:(uint)row {

    Space *space = rowTypes[row];
    
    if(!space.isOccupied && space.piece.hidden == YES)
        return NO;
    
    return YES;
} */

- (void)deconstruct {
    
    Space* space;
    
    for(int i=0; i<dimx; i++) {
        
   //     space = rowTypes[i];
   //     [space deconstruct];
        
        for(int j=0; j<dimy; j++) {
            space = spaces[i][j];
            [space deconstruct];
        }
    }
    
    [spaces removeAllObjects];
  //  [rowTypes removeAllObjects];
    [rows removeAllObjects];
    
    spaces = nil;
//    rowTypes = nil;
    rows = nil;
    
    [tileImages deconstruct];
    tileImages = nil;
}

@end
