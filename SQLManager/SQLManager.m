//
//  SQLManager.m
//  SQLManager
//
//  Created by zezefamily on 15/6/26.
//  Copyright (c) 2015年 zezefamily. All rights reserved.
//
/*
 iOS程序要访问本地数据库，就只能访问沙盒中的文件，之前我在用模拟器开发的时候，会把数据库的sql文件直接拖进模拟器的沙盒里，程序功能能够正常实现。但是如果用真机的话，这种做法是万万不可取的，因为在程序安装到机器之前，手机或者iPad上并不存在与该程序对应的沙盒，普通用户更是不可能找到这个沙盒。因此，正确的做法是：将数据库文件放在工程中，在程序第一次加载的时候，将数据库移至程序沙盒。
 */
#import "SQLManager.h"

@implementation SQLManager
static SQLManager *manager = nil;

+ (SQLManager *)sharedInstance
{
    dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[super allocWithZone:NULL]init];
    });
    return manager;
}
+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

#pragma mark - 将工程里的文件(数据库文件)在程序加载时移至沙盒
+ (void)moveToDBFileWithResource:(NSString *)resource type:(NSString *)type
{
//    获取数据库文件
    NSString *path = [[NSBundle mainBundle]pathForResource:resource ofType:type];
    
//    获取沙盒目录文件夹 创建数据文件
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    NSString *desPath = [documentPath stringByAppendingString:[NSString stringWithFormat:@"%@.%@",resource,type]];
    
//    通过NSFileManager,将工程中的数据库文件复制到沙盒
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:desPath]){
        NSError *error = nil;
        if([fileManager copyItemAtPath:path toPath:desPath error:&error]){
            NSLog(@"数据库文件复制成功");
        }else {
            NSLog(@"数据库文件复制失败");
        }
        
    }
    
}

#pragma mark - 获取沙盒目录中的文件路径
+ (NSString *)getFilePathWithFileName:(NSString *)fileName
{
    NSArray *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *doucumentPath = [docPath objectAtIndex:0];
    NSString *dbFilePath = [doucumentPath stringByAppendingString:fileName];
    return dbFilePath;
}

/******************未完待续(泽泽正在努力学习中)******************/

@end
