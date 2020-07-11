//
//  NetWorkUtil.m
//  mStatus
//
//  Created by Jerry Chen on 2020/7/11.
//  Copyright © 2020 cc. All rights reserved.
//

#import "NetWorkUtil.h"


#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>

static long long inBytes,outBytes;
static long long lastInBytes,lastOutBytes;
@implementation NetWorkUtil
+ (long)getLastInBytes {
    return lastInBytes;
}
+ (NSString *)getByteRate {
    [[self class] updateInterfaceBytes];
    long long deltaInBytes = inBytes - lastInBytes;
    long long deltaOutBytes = outBytes - lastOutBytes;
    lastInBytes = inBytes;
    lastOutBytes = outBytes;
    NSString *inUnit = @"B";
    NSString *outUnit = @"B";
    long long _inBytes,_outBytes;
    if(deltaInBytes>>20>0){
        inUnit = @"M";
        _inBytes = deltaInBytes>>20;
    }else if(deltaInBytes>>10>0){
        inUnit = @"k";
        _inBytes = deltaInBytes>>10;
    }else {
        _inBytes = deltaInBytes;
    }
    if(deltaOutBytes>>20>0){
        outUnit = @"M";
        _outBytes = deltaOutBytes>>20;
    }else if(deltaOutBytes>>10>0){
        outUnit = @"K";
        _outBytes = deltaOutBytes>>10;
    }else {
        _outBytes = deltaOutBytes;
    }
    NSString *info = [NSString stringWithFormat:@"↓%lld%@↑%lld%@",_inBytes,inUnit,_outBytes,outUnit];
    return info;
    
}

+ (void) updateInterfaceBytes {
    struct ifaddrs *ifa_list = 0, *ifa;
    if (getifaddrs(&ifa_list) == -1) {
        return;
    }
    inBytes = 0;
    outBytes = 0;
    for (ifa = ifa_list; ifa; ifa = ifa->ifa_next) {
        if (AF_LINK != ifa->ifa_addr->sa_family)
            continue;
        if (!(ifa->ifa_flags & IFF_UP) && !(ifa->ifa_flags & IFF_RUNNING))
            continue;
        if (ifa->ifa_data == 0)
            continue;
        /* Not a loopback device. */
        
        if (strncmp(ifa->ifa_name, "lo", 2)){
            struct if_data *if_data = (struct if_data *)ifa->ifa_data;
            inBytes += if_data->ifi_ibytes;
            
            outBytes += if_data->ifi_obytes;
        
        }
    }
    
    freeifaddrs(ifa_list);
    NSLog(@"\n[getInterfaceBytes-Total]%lld,%lld",inBytes,outBytes);
   
}

@end
