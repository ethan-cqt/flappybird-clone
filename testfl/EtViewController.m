//
//  EtViewController.m
//  testfl
//
//  Created by Ethan on 15/9/11.
//  Copyright (c) 2015年 ___NeverLand___. All rights reserved.
//

#import "EtViewController.h"

@interface EtViewController ()

@end

@implementation EtViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self creatBg];
    
    [self creatBird];
    [self creatPipe];
	

    _scoreNumber = 0;
    _isUp = 3;
    needCreat = 1;
    _start =1;
    
    _score = [[UILabel alloc]init];
    _score.center = CGPointMake(160, 80);
    _score.bounds = CGRectMake(0, 0, 100, 80);
    _score.textAlignment = NSTextAlignmentCenter;
    _score.font = [UIFont boldSystemFontOfSize:60];
    _score.textColor = [UIColor whiteColor];
    _score.text = @"0";
    
    [self.view addSubview:_score];
    
    [self.view bringSubviewToFront:_bird];

    
    [self creatGameOver];

    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}



-(void)creatGameOver {
    
    _gameOver = [[UIImageView alloc]initWithFrame:CGRectMake((320-260)/2,-1000 + 120, 260, 80)];
    _gameOver.image = [UIImage imageNamed:@"game_over@2x"];
    [self.view addSubview:_gameOver];
    
    
    _scoreView = [[UIImageView alloc]initWithFrame:CGRectMake((320-220)/2, 1000 + 220, 220, 150)];
    _scoreView.image = [UIImage imageNamed:@"medal_plate@2x"];
    [self.view addSubview:_scoreView];
    
    _gameScore = [[UILabel alloc]initWithFrame:CGRectMake(174, 25, 80, 60)];
    _gameScore.textColor = [UIColor blackColor];
    _gameScore.font = [UIFont boldSystemFontOfSize:25];
    _gameScore.text = @"0";
    [_scoreView addSubview:_gameScore];
    
    
    _gameStart = [UIButton buttonWithType:UIButtonTypeCustom];
    _gameStart.frame = CGRectMake(15,1000 + 400, 135, 75);
    
    [_gameStart setBackgroundImage:[UIImage imageNamed:@"start.png"] forState:UIControlStateNormal];
    [self.view addSubview:_gameStart];
    
    [_gameStart addTarget:self action:@selector(getStart) forControlEvents:UIControlEventTouchUpInside];
    
    _rank = [UIButton buttonWithType:UIButtonTypeCustom];
    _rank.frame = CGRectMake(15+135+20, 1000 + 400, 135, 75);
    
    [_rank setBackgroundImage:[UIImage imageNamed:@"rank"] forState:UIControlStateNormal];
    [self.view addSubview:_rank];
    
    _medal = [[UIImageView alloc]initWithFrame:CGRectMake(74, - 1000 + 271, 116-74, 329-271)];
    _medal.image = [UIImage imageNamed:@"medal_bronze@2x.png"];
    
    [self.view addSubview:_medal];
    
    
}


-(void)getStart {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}

-(void)creatPipe {
    _pipeDownArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < 3; i++) {
        UIImageView *pipe = [[UIImageView alloc]init];
        pipe.image = [UIImage imageNamed:@"pipe_bottom@2x"];
        pipe.tag = 10;
        [self.view addSubview:pipe];

        [_pipeDownArray addObject:pipe];
    }
    
    
    _pipeUpArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < 3; i++) {
        UIImageView *pipe = [[UIImageView alloc]init];
        pipe.image = [UIImage imageNamed:@"pipe_top@2x"];
        pipe.tag = 20;
        [self.view addSubview:pipe];
        [_pipeUpArray addObject:pipe];
    }
    
    
    _findPipe = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(findPipe) userInfo:nil repeats:YES];

    [_findPipe setFireDate:[NSDate distantFuture]];
    
}


-(void)findPipe {
    needCreat = 0;
    _isScore = NO;
    static int distant = 130;
    int ran = arc4random()%121+80;
    
    for (UIImageView *pipeDown in _pipeDownArray) {
        if (pipeDown.tag == 10) {
            pipeDown.tag = 11;
            pipeDown.frame = CGRectMake(320, 568-ran-120, 60, ran);
            break;

        }
        
     
    }
    
    
    for (UIImageView *pipeUp in _pipeUpArray) {
        
        if (pipeUp.tag == 20) {
            pipeUp.tag = 21;
            pipeUp.frame = CGRectMake(320, 20, 60, 568-120-ran-distant);
            break;

        }


    }
    

    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    

    
    if (_ready.alpha == 1.0) {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    _ready.alpha = 0;
    _tap.alpha = 0;
    [UIView commitAnimations];
    [_menyBird invalidate];

}
    
    
    _oldPoint = _bird.center;
    
    if (_isOver == NO) {

        _isUp = 1;
    }

    
    if (_bird.center.y <= 12) {
        _isUp = 0;
        
    }
    if (needCreat == 1) {
        [_findPipe setFireDate:[NSDate date]];

    }
    
}

-(void)creatBird {
    
    _bird = [[UIImageView alloc]initWithFrame:CGRectMake(90, 240, 32, 24)];
    _bird.center = CGPointMake(90+16, 240+12);
    
    _bird.image = [UIImage imageNamed:@"bird_1@2x"];
    

    
    [self.view addSubview:_bird];
    
    
    NSMutableArray *birdArray = [NSMutableArray array];
    
    
    for (int i = 1; i < 3; i++) {
        
        
        UIImage *bird = [UIImage imageNamed:[NSString stringWithFormat:@"bird_%d@2x",i]];
        
        [birdArray addObject:bird];
 
        _bird.animationImages = birdArray;
        _bird.animationDuration = 0.3;
        [_bird startAnimating];
    }
    
    _menyBird = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(startMove) userInfo:nil repeats:YES];
}



-(void)startMove {
//    static int i = 1;
    CGRect temp = _bird.frame;
    
    
        temp.origin.y -= _start;
        _bird.frame = temp;

    if (_bird.frame.origin.y <= 230) {
        _start = -1;

    }
    
    if (_bird.frame.origin.y >= 240) {
        _start = 1 ;
    }
    
}



-(void)creatBg {
    
    UIImageView *bg = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, 320, 568)];
        bg.image = [UIImage imageNamed:@"back.png"];

        [self.view addSubview:bg];

    
    _groundArray = [NSMutableArray array];
    for (int i = 0; i < 2; i++) {
        UIImageView *ground = [[UIImageView alloc]initWithFrame:CGRectMake(320*i,568-120, 320, 120)];
        ground.image = [UIImage imageNamed:@"floor"];
        [self.view addSubview:ground];
        [_groundArray addObject:ground];
        _ground.frame = ground.frame;
    }

    
    UIImageView *ready = [[UIImageView alloc]initWithFrame:CGRectMake((320-260)/2, 120, 260, 80)];
    ready.image = [UIImage imageNamed:@"get_ready@2x"];
    
    [self.view addSubview:ready];
    _ready = ready;
    
    UIImageView *tap = [[UIImageView alloc]initWithFrame:CGRectMake((320-130) /2, 220, 130, 100)];
    tap.image = [UIImage imageNamed:@"taptap@2x"];
    [self.view addSubview:tap];
    _tap = tap;
    
    
    
   _move = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(groungMove) userInfo:nil repeats:YES];

}
-(void)groungMove {
    
    
    for (UIImageView *groung in _groundArray) {
        CGRect temp = groung.frame;
        temp.origin.x -= 2;
        groung.frame = temp;
        if (groung.frame.origin.x <= -320) {
            temp.origin.x = 320;
            groung.frame = temp;
        }

        
    }
    
    for (UIImageView *pipeDown in _pipeDownArray) {
        
        if (pipeDown.tag == 11 && _isOver == NO) {
            CGRect temp = pipeDown.frame;
            temp.origin.x -= 2;
            pipeDown.frame = temp;
            if (pipeDown.frame.origin.x <= -pipeDown.frame.size.width) {
                temp.origin.x = 320;
                pipeDown.frame = temp;
                pipeDown.tag = 10;
            }
        }
       
        if (CGRectIntersectsRect(_bird.frame, pipeDown.frame)) {
            _isUp = 0;
            _isOver = YES;
 

        }
        
        if (pipeDown.center.x == 90+24 && _isScore == NO ) {
            
            _isScore = YES;
            _scoreNumber ++;
            
            NSLog(@"%d",_scoreNumber);
            _score.text = [NSString stringWithFormat:@"%d",_scoreNumber];
        }
        
    }

    for (UIImageView *pipeUp in _pipeUpArray) {
        
        if (pipeUp.tag == 21 && _isOver == NO) {
            CGRect temp = pipeUp.frame;
            temp.origin.x -= 2;
            pipeUp.frame = temp;
            if (pipeUp.frame.origin.x <= -pipeUp.frame.size.width) {
                temp.origin.x = 320;
                pipeUp.frame = temp;
                pipeUp.tag = 20;
            }
            if (CGRectIntersectsRect(_bird.frame, pipeUp.frame)) {
                _isUp = 0;
                _isOver = YES;


            }
        }
        
    }

    
    
   static int angle;
   CGPoint temp = _bird.center;

    
    if (_isUp == 1) {
        

        _bird.transform = CGAffineTransformMakeRotation(-30*M_PI/180);
        temp.y += -5.5;
        upCount ++;
        if (upCount == 10) {
        
            _isUp = 0;
            upCount =0;
            speed = 0;
            angle = -30;
        }
        
        
    }
    
    if (_isUp == 0) {
        speed += 0.25;

        
        temp.y += speed;


        if (temp.y >= _oldPoint.y) {
            angle += 10;
         
            if (angle >= 90) {
                angle = 90;
            }
            
            _bird.transform = CGAffineTransformMakeRotation(angle*M_PI/180);
        }



    }
    
    
    
    _bird.center = temp;
    

    
    if ( _bird.center.y >= 568-120) {
        
        _bird.center = CGPointMake(_bird.center.x, 568-120-12);
        _bird.transform = CGAffineTransformMakeRotation(90*M_PI/180);
        [_bird stopAnimating];
        [_move invalidate];
        [_findPipe invalidate];
        _isOver = YES;
        [self performSelector:@selector(gameOver) withObject:nil afterDelay:1.0];
    }
    
    
}

-(void)gameOver {
    
    _score.hidden = YES;
    [UIView beginAnimations:nil context:nil];
    _gameOver.frame = CGRectMake((320-260)/2,120, 260, 80);
    _scoreView.frame = CGRectMake((320-220)/2,220, 220, 150);
    _gameStart.frame = CGRectMake(15,400, 135, 75);
    _rank.frame = CGRectMake(15+135+20, 400, 135, 75);
    _medal.frame = CGRectMake(74,  271, 116-74, 329-271);
    _medal.image = [UIImage imageNamed:@"medal_bronze@2x.png"];
    _gameScore.text = _score.text;

    [UIView commitAnimations];

    
    
    
    
    
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
