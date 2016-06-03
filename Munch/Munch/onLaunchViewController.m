//
//  onLaunchViewController.m
//  Munch
//
//  Created by Enoch Ng on 2016-06-02.
//  Copyright © 2016 Enoch Ng. All rights reserved.
//

#import "onLaunchViewController.h"


@interface onLaunchViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *topPiece;
@property (weak, nonatomic) IBOutlet UIImageView *bottomPiece;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *botConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (weak, nonatomic) IBOutlet UIView *animationView;
@property (weak, nonatomic) IBOutlet UIImageView *aniM;
@property (weak, nonatomic) IBOutlet UIImageView *aniU;
@property (weak, nonatomic) IBOutlet UIImageView *aniC;
@property (weak, nonatomic) IBOutlet UIImageView *aniN;
@property (weak, nonatomic) IBOutlet UIImageView *aniEx;
@property (weak, nonatomic) IBOutlet UIImageView *aniH;
@property (weak, nonatomic) IBOutlet UIImageView *aniLogo;
@property (nonatomic) NSArray *anis;

@end

@implementation onLaunchViewController



-(void)viewDidLoad{
    
    self.anis = @[self.aniM,self.aniU,self.aniC,self.aniN,self.aniH,self.aniEx,self.aniLogo];
    
    for(UIImageView *ani in self.anis){
        
        ani.alpha = 0.0;
        ani.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1);
    }
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    float gapTime = 0.1;
    
 [NSTimer scheduledTimerWithTimeInterval:0.13
                                     target:self
                                   selector:@selector(mPop)
                                   userInfo:nil
                                    repeats:NO];
    
    [NSTimer scheduledTimerWithTimeInterval:0.26+gapTime*1
                                     target:self
                                   selector:@selector(uPop)
                                   userInfo:nil
                                    repeats:NO];
    
    [NSTimer scheduledTimerWithTimeInterval:0.39+gapTime*2
                                     target:self
                                   selector:@selector(nPop)
                                   userInfo:nil
                                    repeats:NO];
    
    [NSTimer scheduledTimerWithTimeInterval:0.42+gapTime*3
                                     target:self
                                   selector:@selector(cPop)
                                   userInfo:nil
                                    repeats:NO];
    
    [NSTimer scheduledTimerWithTimeInterval:0.55+gapTime*4
                                     target:self
                                   selector:@selector(hPop)
                                   userInfo:nil
                                    repeats:NO];
    
    [NSTimer scheduledTimerWithTimeInterval:0.68+gapTime*5
                                     target:self
                                   selector:@selector(exPop)
                                   userInfo:nil
                                    repeats:NO];
    
    [NSTimer scheduledTimerWithTimeInterval:1.3+gapTime*5
                                     target:self
                                   selector:@selector(logoPop)
                                   userInfo:nil
                                    repeats:NO];
    
    [NSTimer scheduledTimerWithTimeInterval:2+gapTime*5
                                     target:self
                                   selector:@selector(splitScreenAnimation)
                                   userInfo:nil
                                    repeats:NO];
   
}


-(void)mPop{
    [self popLogoAnimation:self.aniM];
}
-(void)uPop{
    [self popLogoAnimation:self.aniU];
}
-(void)nPop{
    [self popLogoAnimation:self.aniN];
}
-(void)cPop{
    [self popLogoAnimation:self.aniC];
}
-(void)hPop{
    [self popLogoAnimation:self.aniH];
}
-(void)exPop{
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.aniEx.layer.transform = CATransform3DMakeScale(2,2,1);
                         self.aniEx.alpha = 1.0;
                     }
                     completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:0.07
                                               delay:0
                                             options:UIViewAnimationOptionCurveEaseOut
                                          animations:^{
                                              self.aniEx.layer.transform = CATransform3DMakeScale(1,1, 1);
                                          }
                                          completion:^(BOOL finished) {
                                              //dont run segue
                                          }];
                     }];
}
-(void)logoPop{
    [self popLogoAnimation:self.aniLogo];
}

-(void)popLogoAnimation:(UIImageView *)imageView{
    
    [UIView animateWithDuration:0.13
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         imageView.layer.transform = CATransform3DMakeScale(1.3,1.3,1);
                         imageView.alpha = 1.0;
                     }
                     completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:0.07
                                               delay:0
                                             options:UIViewAnimationOptionCurveEaseOut
                                          animations:^{
                                             imageView.layer.transform = CATransform3DMakeScale(1,1, 1);
                                          }
                                          completion:^(BOOL finished) {
                                              //dont run segue
                                          }];
                     }];
    
}

-(void)splitScreenAnimation{
    
    
    self.topConstraint.constant = -self.topPiece.frame.size.height;
    self.botConstraint.constant = -self.bottomPiece.frame.size.height;
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         for(UIImageView *ani in self.anis){
                             ani.alpha = 0.0;
                        }
 
                     }
                     completion:^(BOOL finished) {
                         
                     }];
    
    [UIView animateWithDuration:1.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self.view layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
                         self.topPiece.alpha = 0.8;
                         self.bottomPiece.alpha = 0.8;
                         self.animationView.hidden = YES;
                     }];

   
}
@end
