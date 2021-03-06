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

static const int MAX_EXAM = 5;

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
    
    if(NUMBER == 1)
    {
        [self clearAnswers];
    }
    
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
    NSArray *exams = [self loadExam:@"ALMQuestions"];
    
    for(UIButton *button in answerButtons){
        [button addTarget:self action:@selector(answer:)
         forControlEvents:UIControlEventTouchUpInside];
        NSDictionary *dict = [exams objectAtIndex:NUMBER-1];
        examSentence.text = [dict objectForKey:@"Sentence"];
        [button setTitle:[dict objectForKey:[[NSString alloc] initWithFormat:@"%c",button.tag + 'A'-1]] forState:UIControlStateNormal];
    }
    
    examSentence.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
    examSentence.textColor =[UIColor whiteColor];
    examSentence.font = [UIFont boldSystemFontOfSize:24];
    
    // buttonサイズ調整
    [answerButtons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        button.titleEdgeInsets = UIEdgeInsetsMake(0.0, 40.0, 0.0, 20.0);
        button.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    }];
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
    
    NSDictionary *dict = @{
                           [[NSString alloc] initWithFormat:@"%d",NUMBER] :
                           [[NSString alloc] initWithFormat:@"%c",button.tag + 'A'-1]
                           };
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud registerDefaults:@{@"questions":@[]}];
    NSMutableArray *arr = [[ud objectForKey:@"questions"] mutableCopy];
    [arr addObject:dict];
    [ud setObject:[NSArray arrayWithArray:arr
                   ] forKey:@"questions"];
    [ud synchronize];
    
    [ud objectForKey:@"questions"];
    
    [self saveAnswer:dict];
    // 引き続き質問
    if(NUMBER < MAX_EXAM)
    {
        ALMQuestionViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Question"];
        [self.navigationController pushViewController:controller animated:YES];
        
    }
    //質問完了
    else
    {
        ALMAdvertiserViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Advertiser"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
}

#pragma mark - private
-(NSMutableArray*)loadExam:(NSString*)filename
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:filename ofType:@"plist"];
    
    // ファイルマネージャを作成
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // ファイルが存在しないか デバック用
    if (![fileManager fileExistsAtPath:filePath]) {
        NSLog(@"plistが存在しません．");
        return nil;
    }
    
    // plistを読み込む
    return [NSMutableArray arrayWithContentsOfFile:filePath];
}

-(bool)saveAnswer:(NSDictionary*)dict_
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"ALMAnswers" ofType:@"plist"];
    
    // ファイルマネージャを作成
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // ファイルが存在しないか デバック用
    if (![fileManager fileExistsAtPath:filePath]) {
        NSLog(@"plistが存在しません．");
        return false;
    }
    
    NSMutableDictionary *arr = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
    [arr addEntriesFromDictionary:dict_];
    BOOL result = [arr writeToFile:filePath atomically:YES];
    return result;
}

-(bool)clearAnswers
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"ALMAnswers" ofType:@"plist"];
    
    // ファイルマネージャを作成
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // ファイルが存在しないか デバック用
    if (![fileManager fileExistsAtPath:filePath]) {
        NSLog(@"plistが存在しません．");
        return false;
    }
    NSDictionary *arr = [[NSDictionary alloc] init];
    BOOL result = [arr writeToFile:filePath atomically:YES];
    return result;
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
