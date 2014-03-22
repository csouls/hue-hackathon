//
//  ALMCentralManager.h
//  AwesomeLightningMachikon
//
//  Created by Maezono Yusaku on 2014/03/22.
//  Copyright (c) 2014年 machikons. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  いわゆる受信側マネージャー
 */
@interface ALMCentralManager : NSObject

/**
 *  シングルトンオブジェクトを返す
 *
 *  @return シングルトンオブジェクト
 */
+ (ALMCentralManager *)sharedManager;

@end
