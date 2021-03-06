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
    //NSArray *answerList = @[@"A", @"B"];
    
    NSArray *array = [answers objectForKey:@"Questions"];
    NSArray *nArray = @[
                        array[0][@"1"],
                        array[1][@"2"],
                        array[2][@"3"],
                        array[3][@"4"],
                        array[4][@"5"],
                        ];
    
    NSDictionary *parameters = @{@"minor_id":@(_minor), @"questions": nArray};
 
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

- (void)checkMatch:(NSArray *)minors success:(HTTPSuccessBlock)successBlock failure:(HTTPFailureBlock)failureBlock
{
    NSDictionary *parameters = @{@"from_minor_id":@(_minor), @"match_minor_ids": minors};
    
    NSError *error;
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
    NSURL *url = [NSURL URLWithString:@"http://192.168.1.56:3000/matches"];
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
