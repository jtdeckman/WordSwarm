//
//  ViewController.m
//  Droozle
//
//  Created by Jason Deckman on 9/4/15.
//  Copyright (c) 2015 JDeckman. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setUpViewController];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

- (void)addPiecesToView {
    
    Space *space;
    
    for(int i=0; i<gamePlay.dimx; i++) {
        
        space = [board getRefSpaceFromIndex:i];
        [self.view addSubview:space.piece];
        
        for(int j=0; j<gamePlay.dimy; j++) {
            space = [board getSpaceForIndices:i :j];
            [self.view addSubview:space.piece];
        }
    }
}

- (void)setUpViewController {

    display = [[Display alloc] init];
    [display initDisplay:self.view.frame :self];
    
    board = [[Board alloc] init];
    
    gamePlay = [[GamePlay alloc] init];
    [gamePlay setUp:board];
    
    CGRect frm;
    
    frm.origin.x = 0.10*self.view.frame.size.width;
    frm.origin.y = display.boardView.frame.origin.y + 0.1*display.boardView.frame.size.height;
    frm.size.height = 0.8*display.boardView.frame.size.height;
    frm.size.width = 0.7*self.view.frame.size.width;

    [board initBoard:frm :gamePlay.dimx :gamePlay.dimy :0];
    
    [self addPiecesToView];
    
    [gamePlay rowOfValues];
    
    
}

@end
