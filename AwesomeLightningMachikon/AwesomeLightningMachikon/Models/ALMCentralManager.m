//
//  ALMCentralManager.m
//  AwesomeLightningMachikon
//
//  Created by Maezono Yusaku on 2014/03/22.
//  Copyright (c) 2014年 machikons. All rights reserved.
//

#import "ALMCentralManager.h"
#import "ABFBeacon.h"

@interface ALMCentralManager () <ABFBeaconDelegate>

@property (nonatomic, strong) ABFBeacon *beacon;
@property (nonatomic, strong) NSDate *sentAPIDate;

@end

@implementation ALMCentralManager

static ALMCentralManager *_sharedInstance = nil;

#pragma mark - Public Methods

/**
 *  シングルトンオブジェクトを返す
 *
 *  @return シングルトンオブジェクト
 */
+ (ALMCentralManager *)sharedManager {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
	    _sharedInstance = [[ALMCentralManager alloc] init];
	    _sharedInstance.beacon = [ABFBeacon sharedManager];
	    _sharedInstance.beacon.delegate = _sharedInstance;
        _sharedInstance.beacon.loggingEnabled = NO;
	    [_sharedInstance.beacon registerRegion:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" identifier:@"ALM"];
	    [_sharedInstance.beacon startMonitoring];
	});
	return _sharedInstance;
}

#pragma mark - ABFBeaconDelegate

/**
 *  Peripheralの状態が変更した場合に呼ばれるデリゲート
 *
 *  @param state state
 */
- (void)didUpdatePeripheralState:(CBPeripheralManagerState)state {
	NSLog(@"%@", NSStringFromSelector(_cmd));

	switch (state) {
		case CBPeripheralManagerStateUnknown:
			NSLog(@"CBPeripheralManagerStateUnknown");
			break;

		case CBPeripheralManagerStateResetting:
			NSLog(@"CBPeripheralManagerStateResetting");
			break;

		case CBPeripheralManagerStateUnsupported:
			NSLog(@"CBPeripheralManagerStateUnsupported");
			break;

		case CBPeripheralManagerStateUnauthorized:
			NSLog(@"CBPeripheralManagerStateUnauthorized");
			break;

		case CBPeripheralManagerStatePoweredOff:
			NSLog(@"CBPeripheralManagerStatePoweredOff");
			break;

		case CBPeripheralManagerStatePoweredOn:
			NSLog(@"CBPeripheralManagerStatePoweredOn");
			break;

		default:
			break;
	}
}

/**
 *  位置情報サービスの設定が変更された場合に呼ばれるデリゲート
 *
 *  kCLAuthorizationStatusNotDetermined 位置情報のリセットをした場合など
 *  kCLAuthorizationStatusRestricted	 機能制限で位置情報サービスの利用を「オフ」から変更できないようにした場合
 *  kCLAuthorizationStatusDenied 位置情報サービスを「オフ」にした場合
 *  kCLAuthorizationStatusAuthorized 位置情報サービスを「オン」にした場合
 *
 *  @param status  status
 */
- (void)didUpdateAuthorizationStatus:(CLAuthorizationStatus)status {
	NSLog(@"%@", NSStringFromSelector(_cmd));

	switch (status) {
		case kCLAuthorizationStatusNotDetermined:
			NSLog(@"kCLAuthorizationStatusNotDetermined");
			break;

		case kCLAuthorizationStatusRestricted:
			NSLog(@"kCLAuthorizationStatusRestricted");
			break;

		case kCLAuthorizationStatusDenied:
			NSLog(@"kCLAuthorizationStatusDenied");
			break;

		case kCLAuthorizationStatusAuthorized:
			NSLog(@"kCLAuthorizationStatusAuthorized");
			break;

		default:
			break;
	}
}

/**
 *  指定したRegionに対して、検出したビーコンに対応するCLBeaconの配列が通知されます。
 *  ビーコンがいようが、いまいが、1秒毎に通知が来ます。ビーコンがないときは、配列は空です。
 *  また、ビーコンのインスタンスは、同じビーコンであっても、インスタンスは異なります。
 *  スキャンで検出したビーコンを、そのままCLBeaconのインスタンスにして、1秒毎にアプリに配列にして渡している素直な実装なのでしょう。(わふう氏のサイトよりコピペ)
 *
 *  @param region  region
 */
- (void)didRangeBeacons:(ABFBeaconRegion *)region {
    //NSLog(@"%@", NSStringFromSelector(_cmd));
    
	// ビーコンが1個もなかった場合はreturn
	if (region.beacons.count == 0) {
		return;
	}

	// 繰り返しのAPI送信を防ぐ
	if (![self isRequireReSendAPI]) {
		return;
	}

	// 距離がNearのビーコンリストを作成する
	NSMutableArray *nearBeacons = @[].mutableCopy;
	for (CLBeacon *beacon in region.beacons) {
		CLProximity proximity = beacon.proximity;
		if (proximity == CLProximityNear) {
			[nearBeacons addObject:beacon];
		}

		// デバッグ
		switch (proximity) {
			case CLProximityUnknown:
				NSLog(@"%@ proximity CLProximityImmediate", NSStringFromSelector(_cmd));
				break;

			case CLProximityImmediate:
				NSLog(@"%@ proximity CLProximityImmediate", NSStringFromSelector(_cmd));
				break;

			case CLProximityNear:
				NSLog(@"%@ proximity CLProximityImmediate", NSStringFromSelector(_cmd));
				break;

			case CLProximityFar:
				NSLog(@"%@ proximity CLProximityImmediate", NSStringFromSelector(_cmd));
				break;

			default:
				break;
		}
	}

	// APIでサーバーに送信
	_sentAPIDate = [NSDate date];

	// TODO
}

/**
 *  領域に入った時と、領域から出た時に呼ばれるデリゲート
 *
 *  @param region region
 */
- (void)didUpdateRegionEnterOrExit:(ABFBeaconRegion *)region {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
	// 領域に入った、かつ距離がNearの時のみ処理するので、ここでは何もしない
}

#pragma - Private Methods

/**
 *  保存した時間と現在の時間を比較して10秒以上経過していたらYESを返す
 *
 *  @return 10秒以上経過していたらYES
 */
- (BOOL)isRequireReSendAPI {
	NSDate *now = [NSDate date];
	float tmp = [now timeIntervalSinceDate:_sentAPIDate];
	int hh = (int)(tmp / 3600);
	int mm = (int)((tmp - hh) / 60);
	float ss = tmp - (float)(hh * 3600 + mm * 60);
	if (ss >= 10) {
		return YES;
	}
	return NO;
}

@end
