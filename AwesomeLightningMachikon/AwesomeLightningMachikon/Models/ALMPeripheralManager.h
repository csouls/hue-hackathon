//
//  ALMPeripheralManager.h
//  AwesomeLightningMachikon
//
//  Created by Maezono Yusaku on 2014/03/22.
//  Copyright (c) 2014年 machikons. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  いわゆる送信側マネージャー(クラスメソッド諏訪さんのソースをまるコピー)
 */
@interface ALMPeripheralManager : NSObject

/**
 *  シングルトンオブジェクトを返す
 *
 *  @return シングルトンオブジェクト
 */
+ (ALMPeripheralManager *)sharedManager;

@end
