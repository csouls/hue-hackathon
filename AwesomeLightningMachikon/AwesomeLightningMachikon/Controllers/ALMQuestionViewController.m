//
//  ALMQuestionViewController.m
//  AwesomeLightningMachikon
//
//  Created by MORITA NAOKI on 2014/03/22.
//  Copyright (c) 2014年 machikons. All rights reserved.
//

#import "ALMQuestionViewController.h"
#import "ALMAdvertiserViewController.h"

@interface ALMQuestionViewController ()

@end

@implementation ALMQuestionViewController

/// 各回答ボタンのtag
static const int tagANSWER_A = 1;
static const int tagANSWER_B = 2;
static const int tagANSWER_C = 3;
static const int tagANSWER_D = 4;

static const int MAX_EXAM = 5 -1;//ロジック上 -1

static int NUMBER = 0;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (id)initWithCoder:(NSCoder*)decoder
{
    self = [super initWithCoder:decoder];
    if (!self) {
        return nil;
    }
    NUMBER += 1;
    
    return self;
}

-(void)setNumber:(NSInteger)number_
{
    //number = number + 1;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 問題設定 nilはこない前提
    NSArray *exams = [self loadExam];
    
    for(UIButton *button in answerButtons){
        [button addTarget:self action:@selector(answer:)
         forControlEvents:UIControlEventTouchUpInside];
        NSDictionary *dict = [exams objectAtIndex:NUMBER-1];
        examSentence.text = [dict objectForKey:@"Sentence"];
        [button setTitle:[dict objectForKey:[[NSString alloc] initWithFormat:@"%c",button.tag + 'A'-1]] forState:UIControlStateNormal];
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
    NSLog(@"exam:%d",NUMBER);
    NSLog(@"View.tag:%d",button.tag);
    if(NUMBER < MAX_EXAM)
    {
        ALMQuestionViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Question"];
        [self.navigationController pushViewController:controller animated:YES];
        
    }
    else
    {
        ALMAdvertiserViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Advertiser"];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark - private
-(NSArray*)loadExam
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"ALMQuestions" ofType:@"plist"];
    
    // ファイルマネージャを作成
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // ファイルが存在しないか?
    if (![fileManager fileExistsAtPath:filePath]) { // yes
        NSLog(@"plistが存在しません．");
        return nil;
    }
    
    // plistを読み込む
    return [NSArray arrayWithContentsOfFile:filePath];
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
