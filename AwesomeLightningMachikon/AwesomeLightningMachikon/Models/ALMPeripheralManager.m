//
//  ALMPeripheralManager.m
//  AwesomeLightningMachikon
//
//  Created by Maezono Yusaku on 2014/03/22.
//  Copyright (c) 2014年 machikons. All rights reserved.
//

@import CoreLocation;
@import CoreBluetooth;

#import "ALMPeripheralManager.h"

@interface ALMPeripheralManager()<CBPeripheralManagerDelegate>

@property(nonatomic) CLBeaconRegion *region;
@property(nonatomic) CBPeripheralManager *manager;
@property(nonatomic) NSUUID *proximityUUID;

@end

@implementation ALMPeripheralManager

static ALMPeripheralManager *_sharedInstance = nil;

#pragma mark - Public Methods

/**
 *  シングルトンオブジェクトを返す
 *
 *  @return シングルトンオブジェクト
 */
+ (ALMPeripheralManager *)sharedManager {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
	    _sharedInstance = [[ALMPeripheralManager alloc] init];
	    _sharedInstance.proximityUUID = [[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"];
        _sharedInstance.manager = [[CBPeripheralManager alloc] initWithDelegate:_sharedInstance queue:nil options:nil];
	});
	return _sharedInstance;
}

/**
 *  アドバタイズを開始する
 *
 *  @param minor マイナー値
 */
- (void)startAdvertising:(NSInteger)minor
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:_proximityUUID
                                                                           major:1
                                                                           minor:minor
                                                                      identifier:@"ALM"];
    
    NSDictionary *beaconPeripheralData = [beaconRegion peripheralDataWithMeasuredPower:nil];
    
    [self.manager stopAdvertising];
    
    //    NSDictionary *beaconPeripheralData = [self beaconAdvertisement:self.proximityUUID
    //                                                             major:1
    //                                                             minor:minor
    //                                                     measuredPower:-58];

    [self.manager startAdvertising:beaconPeripheralData];
}

- (NSDictionary *)beaconAdvertisement:(NSUUID *)proximityUUID
                                major:(uint16_t)major
                                minor:(uint16_t)minor
                        measuredPower:(int8_t)measuredPower  {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    NSString *beaconKey = @"kCBAdvDataAppleBeaconKey";
    
    unsigned char advertisementBytes[21] = {0};
    
    [_proximityUUID getUUIDBytes:(unsigned char *)&advertisementBytes];
    
    advertisementBytes[16] = (unsigned char)(major >> 8);
    advertisementBytes[17] = (unsigned char)(major & 255);
    
    advertisementBytes[18] = (unsigned char)(minor >> 8);
    advertisementBytes[19] = (unsigned char)(minor & 255);
    
    advertisementBytes[20] = measuredPower;
    
    NSMutableData *advertisement = [NSMutableData dataWithBytes:advertisementBytes length:21];
    
    return [NSDictionary dictionaryWithObject:advertisement forKey:beaconKey];
}

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    switch (peripheral.state) {
        case CBPeripheralManagerStatePoweredOn:
            NSLog(@"CBPeripheralManagerStatePoweredOn");
            [self startAdvertising:100];
            
            break;
        case CBPeripheralManagerStatePoweredOff:
            NSLog(@"CBPeripheralManagerStatePoweredOff");
            
            break;
        case CBPeripheralManagerStateResetting:
            NSLog(@"CBPeripheralManagerStateResetting");
            
            break;
        case CBPeripheralManagerStateUnauthorized:
            NSLog(@"CBPeripheralManagerStateUnauthorized");
            
            break;
        case CBPeripheralManagerStateUnknown:
            NSLog(@"CBPeripheralManagerStateUnknown");
            
            break;
        case CBPeripheralManagerStateUnsupported:
            NSLog(@"CBPeripheralManagerStateUnsupported");
            
            break;
    }
}


@end
