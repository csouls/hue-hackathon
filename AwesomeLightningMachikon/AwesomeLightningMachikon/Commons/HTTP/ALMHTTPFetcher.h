//
//  HTTPFetcher.h
//  StoreBeacon
//
//  Created by Maezono Yusaku on 2013/12/30.
//  Copyright (c) 2013年 crossgate.bz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void (^HTTPSuccessBlock)(id responseObject);
typedef void (^HTTPFailureBlock)(NSError *error);

@interface ALMHTTPFetcher : NSObject

/**
 *  指定したパラメータを設定したリクエストURLを返す。
 *
 *  @param path リクエストパス
 *  @param condition リクエストパラメータ
 *
 *  @return リクエストURL
 */
- (NSString *)createRequestUrlWithPath:(NSString *)path andCondtion:(NSDictionary *)condition;

/**
 *  非同期通信のHTTPリクエスト送信する(POST)
 *
 *  @param url             リクエストURL
 *  @param completionBlock completionBlock
 *  @param errorBlock      errorBlock
 */
- (void)sendAsynchronousPOSTRequest:(NSString *)url parameters:(NSDictionary *)parameters success:(HTTPSuccessBlock)completionBlock failure:(HTTPFailureBlock)failureBlock;

/**
 *  非同期通信のHTTPリクエスト送信する(GET)
 *
 *  @param url             リクエストURL
 *  @param completionBlock completionBlock
 *  @param errorBlock      errorBlock
 */
- (void)sendAsynchronousGETRequest:(NSString *)url success:(HTTPSuccessBlock)completionBlock failure:(HTTPFailureBlock)failureBlock;

@end
