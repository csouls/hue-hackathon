//
//  ALMAdvertiserViewController.h
//  AwesomeLightningMachikon
//
//  Created by MORITA NAOKI on 2014/03/22.
//  Copyright (c) 2014年 machikons. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALMAdvertiserViewController : UIViewController
{
    IBOutlet UIButton *sendButton;
    IBOutlet UIImageView *running;
}

-(IBAction)send:(id)sender;

@end
