//
//  ALMAppDelegate.h
//  AwesomeLightningMachikon
//
//  Created by MORITA NAOKI on 2014/03/22.
//  Copyright (c) 2014年 machikons. All rights reserved.
//

#import <UIKit/UIKit.h>

#import<AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioServices.h>

@interface ALMAppDelegate : UIResponder <UIApplicationDelegate>
{
    AVAudioPlayer *audioPlayer;
}

@property (strong, nonatomic) UIWindow *window;

@end
