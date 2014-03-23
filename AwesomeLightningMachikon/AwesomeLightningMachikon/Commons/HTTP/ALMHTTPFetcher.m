//
//  HTTPFetcher.m
//  StoreBeacon
//
//  Created by Maezono Yusaku on 2013/12/30.
//  Copyright (c) 2013年 crossgate.bz. All rights reserved.
//

#import "ALMHTTPFetcher.h"

@implementation ALMHTTPFetcher

/**
 *  イニシャライザ
 *
 *  @return self
 */
- (id)init {
	self = [super init];
	if (self) {
	}
	return self;
}

#pragma mark - Create URL

/**
 *  指定したパラメータを設定したリクエストURLを返す。
 *
 *  @param path リクエストパス
 *  @param condition リクエストパラメータ
 *
 *  @return リクエストURL
 */
- (NSString *)createRequestUrlWithPath:(NSString *)path andCondtion:(NSDictionary *)condition {
	return nil;
}

#pragma mark - Send HTTP Request

/**
 *  非同期通信のAPIリクエスト送信する(POST)
 *
 *  @param url             リクエストURL
 *  @param completionBlock completionBlock
 *  @param errorBlock      errorBlock
 */
- (void)sendAsynchronousPOSTRequest:(NSString *)url parameters:(NSDictionary *)parameters success:(HTTPSuccessBlock)completionBlock failure:(HTTPFailureBlock)failureBlock
{
	NSLog(@"url = %@", url);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager POST:url  parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completionBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error);
    }];
}

/**
 *  非同期通信のAPIリクエスト送信する(GET)
 *
 *  @param url             リクエストURL
 *  @param completionBlock completionBlock
 *  @param errorBlock      errorBlock
 */
- (void)sendAsynchronousGETRequest:(NSString *)url success:(HTTPSuccessBlock)completionBlock failure:(HTTPFailureBlock)failureBlock
{
	NSLog(@"url = %@", url);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completionBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error);
    }];
}

@end
