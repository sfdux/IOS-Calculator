//
//  SystemUtil.h
//  calculator
//
//  Created by James on 15/12/09.
//  Copyright © 2015年 James Shi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sys/utsname.h>

@interface SystemUtil : NSObject
+(NSString *) getCurrentDateTime:(NSString *)format;
+(BOOL) isEmptyOrNull:(NSString *)value;
+(void) writeToFile: (NSString*)fileName withContent:(NSString*) content isAppend:(BOOL) isAppend;
+(BOOL) isFileExist: (NSString*)fileName;
+(NSString*) getLocalFolderPath;
+(void) deleteFile: (NSString*) fileName;
+ (id)getPlistValue: (NSString *) key;
+ (void)setPlistValue: (id) value key: (NSString *) key;
+(void)sortMutableArray:(NSMutableArray *)mutableArray keyName:(NSString *)key ascending:(BOOL)ascend;
+(NSString*)getDeviceName;
+(NSString*)getOSVersion;
+(BOOL)compareImageView:(UIImage *)imageNew isEqualTo:(UIImage *)imageOld;

@end
