//
//  AppDelegate.m
//  Droozle
//
//  Created by Jason Deckman on 9/4/15.
//  Copyright (c) 2015 JDeckman. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
  
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    [(ViewController*)self.window.rootViewController saveDefaults];
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)resetApp {
    
    _window.rootViewController = nil;
    
    ViewController *rootView = [[ViewController alloc] init];
    
    _window.rootViewController = rootView;
    
    [AppDelegate setUpDefaults];
}

+ (void)setUpDefaults {

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    BOOL initialized = [defaults boolForKey:@"initialized"];
    
    if(!initialized) {
        
        [defaults setInteger:0 forKey:@"difficulty"];
        [defaults setInteger:0 forKey:@"gamePlay"];
        
        [defaults setInteger:0 forKey:@"highScore"];
        [defaults setInteger:1 forKey:@"highestLevel"];
        [defaults setInteger:0 forKey:@"highestWordScore"];
        
        [defaults setInteger:1 forKey:@"numBombs"];
        [defaults setInteger:1 forKey:@"numNukes"];
        
        [defaults setBool:YES forKey:@"initialized"];
    }
}

@end
