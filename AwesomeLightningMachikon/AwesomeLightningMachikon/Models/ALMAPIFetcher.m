//
//  MessageHTTPFetcher.m
//  StoreBeacon
//
//  Created by Maezono Yusaku on 2014/01/02.
//  Copyright (c) 2014年 crossgate.bz. All rights reserved.
//

#import "ALMAPIFetcher.h"

@interface ALMAPIFetcher()

@property (nonatomic, copy) NSString *deviceToken;
@property (nonatomic, copy) NSString *minor;

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
 *  iBeacon情報登録APIを送信する
 *
 *  @param deviceToken  デバイストークン
 *  @param successBlock successBlock
 *  @param failureBlock failureBlock
 */
- (void)registerDevice:(NSString *)deviceToken success:(HTTPSuccessBlock)successBlock failure:(HTTPFailureBlock)failureBlock
{
    _deviceToken = deviceToken;
    
    NSDictionary *parameters = @{@"device_id":deviceToken};
    
    [self sendAsynchronousPOSTRequest:@"http://192.168.1.56:3000/beacons" parameters:parameters success:^(id responseObject) {
        NSDictionary *result = (NSDictionary *)responseObject;
        _minor = result[@"minor_id"];
        successBlock(successBlock);
    } failure:^(NSError *error){
        failureBlock(error);
    }];
}

/**
 *  質問情報を送信する
 *
 *  @param deviceToken  デバイストークン
 *  @param successBlock successBlock
 *  @param failureBlock failureBlock
 */
- (void)registerAnswers:(NSDictionary *)answers success:(HTTPSuccessBlock)successBlock failure:(HTTPFailureBlock)failureBlock
{
    // 仮
    _deviceToken = @"1";
    _minor = @"10";
    answers = @{@"1":@"A", @"2":@"B", @"3":@"C", @"4":@"D", @"5":@"A",};
    
    NSDictionary *parameters = @{@"minor_id":_minor, @"questions":answers};
    
    [self sendAsynchronousPOSTRequest:@"http://192.168.1.56:3000/questions" parameters:parameters success:^(id responseObject) {
        /*
         NSArray *results = (NSArray *)responseObject;
         NSMutableArray *resultDtos = @[].mutableCopy;
         for (NSDictionary *d in results) {
         BeaconDto *beaconDto = [[BeaconDto alloc] initWithUuid:d[@"uuid"] major:d[@"major"] minor:d[@"minor"] enterDate:nil exitDate:nil];
         MessageDto *messageDto = [[MessageDto alloc] initWithMessageId:d[@"message_id"] title:d[@"title"] message:d[@"message"] imageName1:d[@"image_name1"] imageName2:d[@"image_name2"] shop:nil shopId:d[@"shop_id"] beaconDto:beaconDto];
         [resultDtos addObject:messageDto];
         }*/
        successBlock(nil);
    } failure:^(NSError *error){
        failureBlock(error);
    }];
}
@end
