//
//  GMKeyedArchiverTool.h
//  FBSnapshotTestCase
//
//  Created by 小飞鸟 on 2019/09/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMKeyedArchiverTool : NSObject
/*
 * 系统对象归档到 一个文件
 * NSArray
 * NSDictionary
 */
+(void)setKeyedArchiverValue:(id)value FilePath:(NSString*)path;
/*
 * 解档文件到一个对象
 * NSArray
 * NSDictionary
 */
+(id)getKeyedArchiverValueForFilePath:(NSString*)path;

/*归档用户自定义对象
 *
 *
 */
+(void)setKeyedArchiverUserDefinedValue:(id)value Obj:(Class)objClass;

/*获取归档的内容*/
+(id)getKeyArchiveUserDefinedValueFor:(Class)objClass;

@end

NS_ASSUME_NONNULL_END
