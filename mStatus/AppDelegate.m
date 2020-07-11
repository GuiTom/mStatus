//
//  AppDelegate.m
//  mStatus
//
//  Created by Jerry Chen on 2020/7/11.
//  Copyright © 2020 cc. All rights reserved.
//

#import "AppDelegate.h"
#import <Cocoa/Cocoa.h>
#import "NetWorkUtil.h"
@interface AppDelegate ()
@property(nonatomic,strong)NSStatusItem* statusItem;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:100];
//    self.statusItem.image = [NSImage imageNamed:NSImageNameUserGroup];
//    self.statusItem.button.bezelColor = [NSColor redColor];
   
//    self.statusItem.button.target = self;
//    self.statusItem.button.action = @selector(hello:);
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateStatus) userInfo:nil repeats:YES];
    
    //为NSStatusItem添加NSMenu
    NSMenu * theMenu = [[NSMenu alloc] initWithTitle:@"MianMenu"];

    [theMenu insertItemWithTitle:@"   退出"action:@selector(quit)keyEquivalent:@"" atIndex:0];
    
    [self.statusItem setMenu:theMenu];

}
-(void)updateStatus{
    if([NetWorkUtil getLastInBytes] > 0){
        self.statusItem.button.title = [NetWorkUtil getByteRate];
    }else {
        [NetWorkUtil getByteRate];
    }
}
-(void)quit{
    exit(0);
}
- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
