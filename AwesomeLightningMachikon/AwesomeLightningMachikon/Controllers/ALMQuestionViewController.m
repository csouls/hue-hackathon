//
//  ALMQuestionViewController.m
//  AwesomeLightningMachikon
//
//  Created by MORITA NAOKI on 2014/03/22.
//  Copyright (c) 2014年 machikons. All rights reserved.
//

#import "ALMQuestionViewController.h"

@interface ALMQuestionViewController ()

@end

@implementation ALMQuestionViewController

/// 各回答ボタンのtag
static const int tagANSWER_A = 1;
static const int tagANSWER_B = 2;
static const int tagANSWER_C = 3;
static const int tagANSWER_D = 4;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        number = 0;// 最初は0
    }
    return self;
}

-(void)setNumber:(NSInteger)number_
{
    number = number + 1;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    for(UIButton *button in answerButtons){
        [button addTarget:self action:@selector(answer:)
         forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action
-(void)answer:(id)sender
{
    UIButton *button = sender;
    NSLog(@"View.tag:%d",button.tag);
    ALMQuestionViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Question"];
    [controller setNumber:number];
    [self.navigationController pushViewController:controller animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
