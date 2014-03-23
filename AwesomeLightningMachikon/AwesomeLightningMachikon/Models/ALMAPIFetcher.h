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
 *  UUIDを条件にして全メッセージを取得してmessagesを更新する
 *
 *  @param uuid         UUID
 *  @param successBlock successBlock
 *  @param failureBlock failureBlock
 */
- (void)fetchAllMessagesByUUID:(NSString *)uuid success:(HTTPSuccessBlock)successBlock failure:(HTTPFailureBlock)failureBlock;

@end
