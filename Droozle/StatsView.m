//
//  StatsView.m
//  Droozle
//
//  Created by Jason Deckman on 12/29/15.
//  Copyright © 2015 JDeckman. All rights reserved.
//

#import "StatsView.h"

@interface StatsView ()

@end

@implementation StatsView

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setUp];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)setUp {
    
    CGRect frm;
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    
    UIImage *tmpImage = [UIImage imageNamed:@"stars1.png"];
    [tmpImage drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    tmpImage = UIGraphicsGetImageFromCurrentImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:tmpImage];
    
    frm.size.width = 0.6*self.view.frame.size.width;
    frm.size.height = 0.4*frm.size.width;
    frm.origin.y = 1.25*frm.size.height;
    frm.origin.x = (self.view.frame.size.width - frm.size.width)/2.0;
    
    highScoreBox = [[UILabel alloc] initWithFrame:frm];
    
    highScoreBox.hidden = NO;
    highScoreBox.layer.cornerRadius = 5.0;
    highScoreBox.clipsToBounds = YES;
    highScoreBox.opaque = NO;
    highScoreBox.layer.borderWidth = 0.75f;
    
    [highScoreBox.layer setBorderColor:[[UIColor clearColor] CGColor]];
    highScoreBox.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.15];
    
    [self.view addSubview:highScoreBox];
    
    frm.size.height *= 0.25;
    frm.origin.y += 0.275*frm.size.height;
    
    highScoreLabel = [[UILabel alloc] initWithFrame:frm];
    
    highScoreLabel.hidden = NO;
    highScoreLabel.layer.cornerRadius = 5.0;
    highScoreLabel.clipsToBounds = YES;
    highScoreLabel.opaque = NO;
    
    [highScoreLabel setTextAlignment:NSTextAlignmentCenter];
    [highScoreLabel setFont:[UIFont fontWithName:@"Helvetica-Oblique" size:2.0*FONT_FACT*highScoreLabel.frame.size.height]];
    
    highScoreLabel.textColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.2 alpha:1.0];
    highScoreLabel.backgroundColor = [UIColor clearColor];
    
    highScoreLabel.text = @"High Score";
    
    [self.view addSubview:highScoreLabel];

    frm.size.height *= 2.5;
    frm.origin.y = highScoreLabel.frame.origin.y + highScoreLabel.frame.size.height;
    
    highScore = [[UILabel alloc] initWithFrame:frm];
    
    highScore.hidden = NO;
    highScore.layer.cornerRadius = 5.0;
    highScore.clipsToBounds = YES;
    highScore.opaque = NO;
    
    [highScore setTextAlignment:NSTextAlignmentCenter];
    [highScore setFont:[UIFont fontWithName:@"Helvetica-Oblique" size:1.0*FONT_FACT*highScore.frame.size.height]];
    
    highScore.textColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
    highScoreLabel.backgroundColor = [UIColor clearColor];
    
    highScore.text = @"1437882365";
    
    [self.view addSubview:highScore];
    
    frm = highScoreBox.frame;
    
    frm.origin.y += frm.size.height + 0.35*frm.size.height;
    
    highestWordScoreBox = [[UILabel alloc] initWithFrame:frm];
    
    highestWordScoreBox.hidden = NO;
    highestWordScoreBox.layer.cornerRadius = 5.0;
    highestWordScoreBox.clipsToBounds = YES;
    highestWordScoreBox.opaque = NO;
    highestWordScoreBox.layer.borderWidth = 0.75f;
    
    [highestWordScoreBox.layer setBorderColor:[[UIColor clearColor] CGColor]];
    highestWordScoreBox.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.15];
    
    [self.view addSubview:highestWordScoreBox];
    
    frm.size.height *= 0.25;
    frm.origin.y += 0.275*frm.size.height;
    
    highestWordScoreLabel = [[UILabel alloc] initWithFrame:frm];
    
    highestWordScoreLabel.hidden = NO;
    highestWordScoreLabel.layer.cornerRadius = 5.0;
    highestWordScoreLabel.clipsToBounds = YES;
    highestWordScoreLabel.opaque = NO;
    
    [highestWordScoreLabel setTextAlignment:NSTextAlignmentCenter];
    [highestWordScoreLabel setFont:[UIFont fontWithName:@"Helvetica-Oblique" size:2.0*FONT_FACT*highestWordScoreLabel.frame.size.height]];
    
    highestWordScoreLabel.textColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.2 alpha:1.0];
    highestWordScoreLabel.backgroundColor = [UIColor clearColor];
    
    highestWordScoreLabel.text = @"Highest Word Score";
    
    [self.view addSubview:highestWordScoreLabel];
    
    frm.size.height *= 2.5;
    frm.origin.y = highestWordScoreLabel.frame.origin.y + highestWordScoreLabel.frame.size.height;
    
    highestWordScore = [[UILabel alloc] initWithFrame:frm];
    
    highestWordScore.hidden = NO;
    highestWordScore.layer.cornerRadius = 5.0;
    highestWordScore.clipsToBounds = YES;
    highestWordScore.opaque = NO;
    
    [highestWordScore setTextAlignment:NSTextAlignmentCenter];
    [highestWordScore setFont:[UIFont fontWithName:@"Helvetica-Oblique" size:1.0*FONT_FACT*highestWordScore.frame.size.height]];
    
    highestWordScore.textColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
    highestWordScoreLabel.backgroundColor = [UIColor clearColor];
    
    highestWordScore.text = @"1437882365";
    
    [self.view addSubview:highestWordScore];

    frm = highestWordScoreBox.frame;
    
    frm.origin.y += frm.size.height + 0.35*frm.size.height;
    
    highestLevelBox = [[UILabel alloc] initWithFrame:frm];
    
    highestLevelBox.hidden = NO;
    highestLevelBox.layer.cornerRadius = 5.0;
    highestLevelBox.clipsToBounds = YES;
    highestLevelBox.opaque = NO;
    highestLevelBox.layer.borderWidth = 0.75f;
    
    [highestLevelBox.layer setBorderColor:[[UIColor clearColor] CGColor]];
    highestLevelBox.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.15];
    
    [self.view addSubview:highestLevelBox];
    
    frm.size.height *= 0.25;
    frm.origin.y += 0.275*frm.size.height;
    
    highestLevelLabel = [[UILabel alloc] initWithFrame:frm];
    
    highestLevelLabel.hidden = NO;
    highestLevelLabel.layer.cornerRadius = 5.0;
    highestLevelLabel.clipsToBounds = YES;
    highestLevelLabel.opaque = NO;
    
    [highestLevelLabel setTextAlignment:NSTextAlignmentCenter];
    [highestLevelLabel setFont:[UIFont fontWithName:@"Helvetica-Oblique" size:2.0*FONT_FACT*highestLevelLabel.frame.size.height]];
    
    highestLevelLabel.textColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.2 alpha:1.0];
    highestLevelLabel.backgroundColor = [UIColor clearColor];
    
    highestLevelLabel.text = @"Highest Level";
    
    [self.view addSubview:highestLevelLabel];
    
    frm.size.height *= 2.5;
    frm.origin.y = highestLevelLabel.frame.origin.y + highestLevelLabel.frame.size.height;
    
    highestLevel = [[UILabel alloc] initWithFrame:frm];
    
    highestLevel.hidden = NO;
    highestLevel.layer.cornerRadius = 5.0;
    highestLevel.clipsToBounds = YES;
    highestLevel.opaque = NO;
    
    [highestLevel setTextAlignment:NSTextAlignmentCenter];
    [highestLevel setFont:[UIFont fontWithName:@"Helvetica-Oblique" size:1.5*FONT_FACT*highestLevel.frame.size.height]];
    
    highestLevel.textColor = [UIColor colorWithRed:0.2 green:0.6 blue:1.0 alpha:1.0];
    highestLevelLabel.backgroundColor = [UIColor clearColor];
    
    highestLevel.text = @"14";
    
    [self.view addSubview:highestLevel];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
