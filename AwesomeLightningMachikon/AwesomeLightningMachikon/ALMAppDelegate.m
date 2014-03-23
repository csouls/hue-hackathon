//
//  ALMAppDelegate.m
//  AwesomeLightningMachikon
//
//  Created by MORITA NAOKI on 2014/03/22.
//  Copyright (c) 2014年 machikons. All rights reserved.
//

#import "ALMAppDelegate.h"
#import "ALMCentralManager.h"
#import "ALMPeripheralManager.h"
#import "ALMAPIFetcher.h"

@import AVFoundation;

@implementation ALMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // TODO 仮
    ALMCentralManager *centralManager = [ALMCentralManager sharedManager];
    ALMPeripheralManager *peripheralManager = [ALMPeripheralManager sharedManager];
    
    ALMAPIFetcher *APIFetcher = [ALMAPIFetcher sharedManager];
//    [APIFetcher registerDevice:@"2" success:^(id responseObject) {} failure:^(NSError *error){}];
//    [APIFetcher registerAnswers:nil success:^(id responseObject) {} failure:^(NSError *error){}];
    [APIFetcher registerAnswers:nil success:^(id responseObject) {} failure:^(NSError *error) {}];
    
    // APNS
    
    [[UIApplication sharedApplication]
     registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert |
                                         UIRemoteNotificationTypeBadge |
                                         UIRemoteNotificationTypeSound)];

    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - p

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken
{
    NSString *deviceToken = [[[[devToken description]
                               stringByReplacingOccurrencesOfString:@"<"withString:@""]
                              stringByReplacingOccurrencesOfString:@">" withString:@""]
                             stringByReplacingOccurrencesOfString: @" " withString: @""];
    NSLog(@"apns succeeded. deviceToken >> %@",deviceToken);
    
    [[[UIAlertView alloc] initWithTitle:@"success"
                                message:deviceToken
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil, nil] show];
    
    ALMAPIFetcher *APIFetcher = [ALMAPIFetcher sharedManager];
    [APIFetcher registerDevice:deviceToken success:^(id responseObject) {} failure:^(NSError *error){}];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"apns failed. error >> %@", [error localizedDescription]);
    
    [[[UIAlertView alloc] initWithTitle:@"fail"
                                message:nil
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil, nil] show];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    NSLog(@"did receive RemoteNotification");
    
    [[[UIAlertView alloc] initWithTitle:@"receive Push"
                               message:@"message"
                              delegate:nil
                     cancelButtonTitle:@"OK"
                     otherButtonTitles:nil, nil] show];
}

@end
