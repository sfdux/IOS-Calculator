//
//  SystemUtil.m
//  calculator
//
//  Created by James on 15/12/09.
//  Copyright © 2015年 James Shi. All rights reserved.
//

#import "SystemUtil.h"

@implementation SystemUtil

+(NSString *) getCurrentDateTime:(NSString *)format{
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:format];
    NSString *datetime =[dateformatter stringFromDate:[NSDate date]];
    return datetime;
}

+(BOOL) isEmptyOrNull:(NSString *)value{
    if ([value isEqualToString: @""] || value == nil) {
        return true;
    }else{
        return false;
    }
}

+(void) writeToFile: (NSString*)fileName withContent:(NSString*) contentToWrite isAppend:(BOOL) isAppend{
    NSString *docsDir;
    NSArray *dirPaths;
    
    @try {
        dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        docsDir = [dirPaths objectAtIndex:0];
        NSString *databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent:fileName]];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:databasePath] ){
            [[NSFileManager defaultManager] createFileAtPath:databasePath contents: nil attributes:nil];
        } else if (!isAppend) {
            [[NSFileManager defaultManager] removeItemAtPath:databasePath error:NULL];
            [[NSFileManager defaultManager] createFileAtPath:databasePath contents: nil attributes:nil];
        }
        
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:databasePath];
        
        [fileHandle seekToEndOfFile];
        [fileHandle writeData:[contentToWrite dataUsingEncoding:NSUTF8StringEncoding]];
        [fileHandle closeFile];
    }
    @catch (NSException *exception) {
        NSLog(@"%@", [exception callStackSymbols]);
    }
    @finally {
    }
}

+(BOOL) isFileExist: (NSString*)fileName{
    NSString *docsDir;
    NSArray *dirPaths;
    NSString *filePath;
    
    @try {
        dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        docsDir = [dirPaths objectAtIndex:0];
        filePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent:fileName]];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:filePath] ){
            return NO;
        } else {
            return YES;
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@", [exception callStackSymbols]);
    }
}

+(NSString*) getLocalFolderPath{
    @try {
        return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    }
    @catch (NSException *exception) {
        NSLog(@"%@", [exception callStackSymbols]);
    }
}

+(void) deleteFile: (NSString*) fileName{
    @try {
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        NSString *filePath = [[SystemUtil getLocalFolderPath] stringByAppendingPathComponent:fileName];
        NSError *error = nil;
        if (![fileManager removeItemAtPath:filePath error:&error]){
            NSLog(@"Delete file failed due to: %@", error);
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@", [exception callStackSymbols]);
    }
}

+ (id)getPlistValue: (NSString *) key {
    NSString *filename =
    [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"Config.plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    if([data valueForKey:key]) {
        return (NSString *)[data valueForKey:key];
    }
    return [NSString string];
}

+ (void)setPlistValue: (id) value key: (NSString *) key {
    NSString *filename=
    [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"Config.plist"];
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    if(!data) {
        data = [[NSMutableDictionary alloc] init];
    }
    [data setObject:value forKey:key];
    [data writeToFile:filename atomically:YES];
}

+(void)sortMutableArray:(NSMutableArray *)mutableArray keyName:(NSString *)key ascending:(BOOL)ascend{
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key
                                                 ascending:ascend];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    [mutableArray sortUsingDescriptors:sortDescriptors];
}

+(NSString*)getDeviceName{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString* code = [NSString stringWithCString:systemInfo.machine
                                        encoding:NSUTF8StringEncoding];
    
    static NSDictionary* deviceNamesByCode = nil;
    
    if (!deviceNamesByCode) {
        
        deviceNamesByCode = @{@"i386"      :@"Simulator",
                              @"iPod1,1"   :@"iPod Touch",      // (Original)
                              @"iPod2,1"   :@"iPod Touch",      // (Second Generation)
                              @"iPod3,1"   :@"iPod Touch",      // (Third Generation)
                              @"iPod4,1"   :@"iPod Touch",      // (Fourth Generation)
                              @"iPhone1,1" :@"iPhone",          // (Original)
                              @"iPhone1,2" :@"iPhone",          // (3G)
                              @"iPhone2,1" :@"iPhone",          // (3GS)
                              @"iPad1,1"   :@"iPad",            // (Original)
                              @"iPad2,1"   :@"iPad 2",          //
                              @"iPad3,1"   :@"iPad",            // (3rd Generation)
                              @"iPhone3,1" :@"iPhone 4",        // (GSM)
                              @"iPhone3,3" :@"iPhone 4",        // (CDMA/Verizon/Sprint)
                              @"iPhone4,1" :@"iPhone 4S",       //
                              @"iPhone5,1" :@"iPhone 5",        // (model A1428, AT&T/Canada)
                              @"iPhone5,2" :@"iPhone 5",        // (model A1429, everything else)
                              @"iPad3,4"   :@"iPad",            // (4th Generation)
                              @"iPad2,5"   :@"iPad Mini",       // (Original)
                              @"iPhone5,3" :@"iPhone 5c",       // (model A1456, A1532 | GSM)
                              @"iPhone5,4" :@"iPhone 5c",       // (model A1507, A1516, A1526 (China), A1529 | Global)
                              @"iPhone6,1" :@"iPhone 5s",       // (model A1433, A1533 | GSM)
                              @"iPhone6,2" :@"iPhone 5s",       // (model A1457, A1518, A1528 (China), A1530 | Global)
                              @"iPhone7,1" :@"iPhone 6 Plus",   //
                              @"iPhone7,2" :@"iPhone 6",        //
                              @"iPhone8,1" :@"iPhone 6s Plus",
                              @"iPhone8,2" :@"iPhone 6s",
                              @"iPad4,1"   :@"iPad Air",        // 5th Generation iPad (iPad Air) - Wifi
                              @"iPad4,2"   :@"iPad Air",        // 5th Generation iPad (iPad Air) - Cellular
                              @"iPad4,4"   :@"iPad Mini",       // (2nd Generation iPad Mini - Wifi)
                              @"iPad4,5"   :@"iPad Mini"        // (2nd Generation iPad Mini - Cellular)
                              };
    }
    
    NSString* deviceName = [deviceNamesByCode objectForKey:code];
    
    if (!deviceName) {
        // Not found in database. At least guess main device type from string contents:
        
        if ([code rangeOfString:@"iPod"].location != NSNotFound) {
            deviceName = @"iPod Touch";
        } else if([code rangeOfString:@"iPad"].location != NSNotFound) {
            deviceName = @"iPad";
        } else if([code rangeOfString:@"iPhone"].location != NSNotFound){
            deviceName = @"iPhone";
        } else {
            deviceName = @"Simulator";
        }
    }
    
    return deviceName;
}

+(NSString*)getOSVersion{
    return [[UIDevice currentDevice] systemVersion];
}

+(BOOL)compareImageView:(UIImage *)imageNew isEqualTo:(UIImage *)imageOld
{
    NSData *dataNew = UIImagePNGRepresentation(imageNew);
    NSData *dataOld = UIImagePNGRepresentation(imageOld);
    
    return [dataNew isEqual:dataOld];
}


@end
