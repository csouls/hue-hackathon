//
//  MessageHTTPFetcher.h
//  StoreBeacon
//
//  Created by Maezono Yusaku on 2014/01/02.
//  Copyright (c) 2014年 crossgate.bz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALMHTTPFetcher.h"

@interface ALMAPIFetcher : ALMHTTPFetcher

/**
 *  シングルトンオブジェクトを返す
 *
 *  @return シングルトンオブジェクト
 */
+ (ALMAPIFetcher *)sharedManager;

/**
 *  iBeacon情報登録APIを送信する
 *
 *  @param deviceToken  デバイストークン
 *  @param successBlock successBlock
 *  @param failureBlock failureBlock
 */
- (void)registerDevice:(NSString *)deviceToken success:(HTTPSuccessBlock)successBlock failure:(HTTPFailureBlock)failureBlock;

/**
 *  質問情報を送信する
 *
 *  @param deviceToken  デバイストークン
 *  @param successBlock successBlock
 *  @param failureBlock failureBlock
 */
- (void)registerAnswers:(NSDictionary *)answers success:(HTTPSuccessBlock)successBlock failure:(HTTPFailureBlock)failureBlock;

@end
