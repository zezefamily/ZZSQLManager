//
//  SQLManager.h
//  SQLManager
//
//  Created by zezefamily on 15/6/26.
//  Copyright (c) 2015年 zezefamily. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQLManager : NSObject

+ (SQLManager *)sharedInstance;

/**
 将工程里的文件(数据库文件)在程序加载时移至沙盒
 @param resource  is a file name.
 @param type   is a file type.
 */
+ (void)moveToDBFileWithResource:(NSString *)resource type:(NSString *)type;

/**
 获取沙盒目录中的文件路径
 @param fileName  such as <database.sqlite>
 */
+ (NSString *)getFilePathWithFileName:(NSString *)fileName;


@end
