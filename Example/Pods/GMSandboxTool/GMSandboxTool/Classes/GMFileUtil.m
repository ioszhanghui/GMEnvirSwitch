//
//  GMFileUtil.m
//  FBSnapshotTestCase
//
//  Created by 小飞鸟 on 2019/09/29.
//

#import "GMFileUtil.h"

@implementation GMFileUtil

/*获取Home的主路径*/
+(NSString*)getSandboxHome{
    return NSHomeDirectory();
}

/*获取沙盒路径下的 document路径*/
+(NSString*)getSandboxDocutment{
    
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

/*获取沙盒路径的temp文件夹*/
+(NSString*)getSandboxTemp{
    return NSTemporaryDirectory();
}

/*获取沙盒路径下的cache文件夹*/
+(NSString*)getSandboxCache{
    return  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
}

/*获取沙盒路径下的 library路径*/
+(NSString*)getSandboxLibray{
    //Libaray目录  various documentation, support, and configuration files, resources (Library)
    return  [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES) firstObject];
}

/*判断一个文件是否存在*/
+(BOOL)isFileExist:(NSString*)filePath{
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    BOOL exist = NO;
    if ([fileManager fileExistsAtPath:filePath]) {
        exist = YES;
    }
    return exist;
}

/*删除 某一个文件*/
+(BOOL)deleteFileAtPath:(NSString*)filePath{
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSError * error = nil;
    BOOL result = NO;
    if ([fileManager fileExistsAtPath:filePath]) {
        //路径存在 删除文件
       result = [fileManager removeItemAtPath:filePath error:&error];
    }
    return NO;
}

/*计算一个文件夹路径的大小*/
+(CGFloat)getFileSizeAtPath:(NSString*)filePath{
    CGFloat fileSzie = 0;
    NSFileManager * fileManager = [NSFileManager defaultManager];
    //文件是否存在
    BOOL exist ;
    //路径是否是文件夹
    BOOL isDirectory;
    //错误
    NSError * error;
    exist = [fileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
    if (!exist) {
        //如果不存在 那就为0
        return 0;
    }
    if (isDirectory) {
        //如果是 文件夹
       NSEnumerator * fileEnumerator = [[fileManager subpathsAtPath:filePath]objectEnumerator];
        NSString * fileName;
        while ((fileName = [fileEnumerator nextObject]) != nil) {
            NSString * fileAbsolutePath = [filePath stringByAppendingPathComponent:fileName];
            fileSzie += [[fileManager attributesOfItemAtPath:fileAbsolutePath error:nil] fileSize];
            NSLog(@"%@",fileAbsolutePath);
        }
    }else{
        fileSzie = [[fileManager attributesOfItemAtPath:filePath error:&error] fileSize];
    }
    return fileSzie/(1024*1024);
}
@end
