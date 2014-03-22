//
//  ALMQuestionViewController.h
//  AwesomeLightningMachikon
//
//  Created by MORITA NAOKI on 2014/03/22.
//  Copyright (c) 2014年 machikons. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALMQuestionViewController : UIViewController
{
    IBOutletCollection(UIButton) NSArray *answerButtons;
    
    /// 出題文
    IBOutlet UITextView *examSentence;
    
    /// 出題写真
    IBOutlet UIImageView *examPicture;
    
}

@end
