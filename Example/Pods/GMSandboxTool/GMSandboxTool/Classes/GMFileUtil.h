//
//  GMFileUtil.h
//  FBSnapshotTestCase
//
//  Created by 小飞鸟 on 2019/09/29.
//

#import <Foundation/Foundation.h>

/*操作结果回调*/
typedef void(^GMActionResult)(BOOL result);


NS_ASSUME_NONNULL_BEGIN

@interface GMFileUtil : NSObject

/*获取Home的主路径*/
+(NSString*)getSandboxHome;
/*获取沙盒路径下的 document路径*/
+(NSString*)getSandboxDocutment;
/*获取沙盒路径的temp文件夹*/
+(NSString*)getSandboxTemp;
/*获取沙盒路径下的cache文件夹*/
+(NSString*)getSandboxCache;
/*获取沙盒路径下的 library路径*/
+(NSString*)getSandboxLibray;

/*判断一个文件是否存在*/
+(BOOL)isFileExist:(NSString*)filePath;
/*删除 某一个文件*/
+(BOOL)deleteFileAtPath:(NSString*)filePath;

/*计算一个文件夹路径的大小*/
+(CGFloat)getFileSizeAtPath:(NSString*)filePath;

@end

NS_ASSUME_NONNULL_END
