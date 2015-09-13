//
//  EtViewController.h
//  testfl
//
//  Created by Ethan on 15/9/11.
//  Copyright (c) 2015年 ___NeverLand___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EtViewController : UIViewController
{
    UIImageView *_bird;
    UIImageView *_ready;
    UIImageView *_tap;
    UIImageView *_ground;
    UIImageView *_gameOver;
    UIImageView *_scoreView;
    UIImageView *_medal;

    UIButton *_gameStart;
    UIButton *_rank;





    NSMutableArray *_groundArray;
    NSMutableArray *_pipeDownArray;
    NSMutableArray *_pipeUpArray;


    NSTimer *_menyBird;
    int _angle;
    int _scoreNumber;
    CGRect _oldFrame;
    CGPoint _oldPoint;
    NSTimer *_move;
    NSTimer *_findPipe;

    BOOL _isOver;
    BOOL _isScore;
    int _isUp;
    float speed;
    int upCount;
    int _start;
    
    BOOL needCreat;
    
    UILabel *_score;
    UILabel *_gameScore;

    

}


@end
