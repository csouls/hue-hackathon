//
//  ALMAdvertiserViewController.m
//  AwesomeLightningMachikon
//
//  Created by MORITA NAOKI on 2014/03/22.
//  Copyright (c) 2014年 machikons. All rights reserved.
//

#import <AudioToolbox/AudioServices.h>

#import "ALMAdvertiserViewController.h"
#import "AFHTTPRequestOperationManager.h"

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
    postData = [self loadExam:@"ALMAnswers"];
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
    if(timer == nil)
    {
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                               target:self
                                             selector:@selector(onTimer)
                                             userInfo:nil
                                              repeats:YES];
    }
    [self post:postData];
    [self sound];
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

-(void)onTimer
{
    [self post:postData];
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
     AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
     [manager POST:@"http://xxxx"
     parameters:dict_ success:^(AFHTTPRequestOperation *operation, id responseObject) {
     NSLog(@"response: %@", responseObject);
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     NSLog(@"Error: %@", error);
     }];
}

-(void)sound
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"warp1" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    audioPlayer.volume = 0.1;
    [audioPlayer prepareToPlay];
    [audioPlayer play];
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
