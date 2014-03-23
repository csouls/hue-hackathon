//
//  MessageHTTPFetcher.m
//  StoreBeacon
//
//  Created by Maezono Yusaku on 2014/01/02.
//  Copyright (c) 2014年 crossgate.bz. All rights reserved.
//

#import "ALMAPIFetcher.h"

@interface ALMAPIFetcher()

@end

@implementation ALMAPIFetcher

static ALMAPIFetcher *_sharedInstance = nil;

#pragma mark - Public Methods

/**
 *  シングルトンオブジェクトを返す
 *
 *  @return シングルトンオブジェクト
 */
+ (ALMAPIFetcher *)sharedManager {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
	    _sharedInstance = [[ALMAPIFetcher alloc] init];
	});
	return _sharedInstance;
}

/**
 *iBeacon情報登録APIを送信する
 *
 *@param deviceTokenデバイストークン
 *@param successBlock successBlock
 *@param failureBlock failureBlock
 */
- (void)registerDevice:(NSString *)deviceToken success:(HTTPSuccessBlock)successBlock failure:(HTTPFailureBlock)failureBlock
{
    _deviceToken = deviceToken;
    
    NSDictionary *parameters = @{@"device_id":deviceToken};
    
    [self sendAsynchronousPOSTRequest:@"http://192.168.1.56:3000/beacons" parameters:parameters success:^(id responseObject) {
        NSDictionary *result = (NSDictionary *)responseObject;
        _minor = [result[@"minor_id"] unsignedIntegerValue];
        successBlock(nil);
    } failure:^(NSError *error){
        failureBlock(error);
    }];
}

/**
 *質問情報を送信する
 *
 *@param deviceTokenデバイストークン
 *@param successBlock successBlock
 *@param failureBlock failureBlock
 */
- (void)registerAnswers:(NSDictionary *)answers success:(HTTPSuccessBlock)successBlock failure:(HTTPFailureBlock)failureBlock
{
    // 仮
    _deviceToken = @"1";
    
    NSArray *answerList = @[@"A", @"B"];
    
    NSDictionary *parameters = @{@"minor_id":@(1), @"questions": answerList};
 
    NSError *error;
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
    NSURL *url = [NSURL URLWithString:@"http://192.168.1.56:3000/questions"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    
    [request setHTTPMethod:@"POST"];
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&error];
    [request setHTTPBody:postData];
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
    }];
    
    [postDataTask resume];
}

@end
