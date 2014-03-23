//
//  ALMAdvertiserViewController.m
//  AwesomeLightningMachikon
//
//  Created by MORITA NAOKI on 2014/03/22.
//  Copyright (c) 2014年 machikons. All rights reserved.
//

#import "ALMAdvertiserViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "ALMAPIFetcher.h"
#import "ALMPeripheralManager.h"

@interface ALMAdvertiserViewController ()

@end

@implementation ALMAdvertiserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 結局UUIDはいらない？
    NSUUID *vendorUUID = [UIDevice currentDevice].identifierForVendor;
    //postData = [self loadExam:@"ALMAnswers"];
    
    isSending = false;
    
    // データをかき集めて構造を作る
    postData = [[NSMutableDictionary alloc] init];
    [postData setObject:[self loadExam:@"ALMAnswers"] forKey:@"Questions"];
    [postData setValue:vendorUUID.UUIDString forKey:@"device_token"];
    [postData setValue:[[NSNumber alloc] initWithInt:1] forKey:@"monor_id"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action
-(IBAction)send:(id)sender
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    audioPlayer.volume = 0.5;
    [audioPlayer prepareToPlay];
    [audioPlayer play];
    
    UIButton *button = sender;
    if(!isSending)
    {
        backgroundView.image = [UIImage imageNamed:@"Matikon_Net_On"];
        isSending = true;
        CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = [NSNumber numberWithFloat:(M_PI / 180) * 360];
        rotationAnimation.duration = 10.0f;
        rotationAnimation.repeatCount = HUGE_VALF;
        [runningView.layer addAnimation:rotationAnimation forKey:@"rotateAnimation"];
        
        [button setTitle:@"キャンセル" forState:UIControlStateNormal];
        /// !!!: スタート系の呼び出し
        NSUInteger minor = [ALMAPIFetcher sharedManager].minor;
        [[ALMPeripheralManager sharedManager] startAdvertising:minor];
        [ALMPeripheralManager sharedManager];
    }
    else
    {
        backgroundView.image = [UIImage imageNamed:@"Matikon_Net_Off"];
        isSending = false;
        CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = [NSNumber numberWithFloat:0];
        rotationAnimation.duration = 10.0f;
        rotationAnimation.repeatCount = 0;
        [runningView.layer addAnimation:rotationAnimation forKey:@"rotateAnimation"];
        [button setTitle:@"送信" forState:UIControlStateNormal];
        /// !!!: ストップ系の呼び出し
        [[ALMPeripheralManager sharedManager] stopAdvertizing];
    }
    
}

#pragma mark - private
-(NSMutableDictionary*)loadExam:(NSString*)filename
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
    return [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
}

#pragma mark - private
-(void)post:(NSDictionary*)dict_
{
//     AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
//     [manager POST:@"http://xxxx"
//     parameters:dict_ success:^(AFHTTPRequestOperation *operation, id responseObject) {
//     NSLog(@"response: %@", responseObject);
//     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//     NSLog(@"Error: %@", error);
//     }];
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://sample-json-api5000.herokuapp.com/countries"
       parameters:dict_ success:^(AFHTTPRequestOperation *operation, id responseObject) {
           NSLog(@"response: %@", responseObject);
       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           NSLog(@"Error: %@", error);
       }];
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
