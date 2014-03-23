//
//  ALMAdvertiserViewController.h
//  AwesomeLightningMachikon
//
//  Created by MORITA NAOKI on 2014/03/22.
//  Copyright (c) 2014年 machikons. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioServices.h>

@interface ALMAdvertiserViewController : UIViewController
{
    IBOutlet UIButton *sendButton;
    IBOutlet UIImageView *backgroundView;
    
    IBOutlet UIImageView *runningView;
    
    bool isSending;
    
    NSMutableDictionary *postData;
    
    /// １秒に一回POSTするよう
    NSTimer *timer;
    
    AVAudioPlayer *audioPlayer;
    
}

-(IBAction)send:(id)sender;

@end
