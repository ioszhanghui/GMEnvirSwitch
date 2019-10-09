//
//  GMKeyedArchiverTool.m
//  FBSnapshotTestCase
//
//  Created by 小飞鸟 on 2019/09/30.
//

#import "GMKeyedArchiverTool.h"
#import "NSObject+CategoryMethod.h"
#import <objc/runtime.h>

@implementation GMKeyedArchiverTool

//对象归档到 一个文件
+(void)setKeyedArchiverValue:(id)value FilePath:(NSString*)path{
    if (!path) {
        return ;
    }
    [NSKeyedArchiver archiveRootObject:value toFile:path];
}

/*
 * 系统对象归档到 一个文件
 * NSArray
 * NSDictionary
 */
+(id)getKeyedArchiverValueForFilePath:(NSString*)path{
    if (!path) {
        return nil;
    }
   id value = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return value;
}

/*归档用户自定义对象
 *
 *
 */
+(void)setKeyedArchiverUserDefinedValue:(id)value Obj:(Class)objClass{
    
    Class originClass = objClass;
    //NSCoding协议的处理
    [originClass  addProtocol:@"NSCoding" toClass:originClass];
    //为当前类 添加 initWithGomeCoder:方法
    [originClass addMethod:@selector(initWithGomeCoder:) Toclass:originClass FuncClass:[self class]];
    [originClass swizzleObjectMethod:@selector(initWithCoder:) SwizzleSel:@selector(initWithGomeCoder:)];
    
    //为当前类 添加 encodeWithGomeCoder方法
    [originClass addMethod:@selector(encodeWithGomeCoder:) Toclass:originClass FuncClass:[self class]];
    [originClass swizzleObjectMethod:@selector(encodeWithCoder:) SwizzleSel:@selector(encodeWithGomeCoder:)];
    
    id object = [originClass mj_objectWithKeyValues:value];
    NSString * filepath = [self getArchivePath:NSStringFromClass(originClass)];
    if (![GMFileUtil isFileExist:filepath]) {
        [[NSFileManager defaultManager]createDirectoryAtPath:[[GMFileUtil getSandboxDocutment] stringByAppendingPathComponent:NSStringFromClass(objClass)]
                                 withIntermediateDirectories:YES attributes:nil error:nil];
        [[NSFileManager defaultManager] createFileAtPath:filepath contents:nil attributes:nil];
    }
    [NSKeyedArchiver archiveRootObject:object toFile:filepath];
}

/*获取归档的内容*/
+(id)getKeyArchiveUserDefinedValueFor:(Class)objClass{
    
    NSString * filePath = [self getArchivePath:NSStringFromClass(objClass)];
   return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}

-(void)encodeWithGomeCoder:(NSCoder *)aCoder{
    
    unsigned int count ;
   objc_property_t * objc_propertyList =  class_copyPropertyList([self class], &count);
    for (int i=0; i<count; i++) {

        objc_property_t  objc =  objc_propertyList[i];
       const char * propertyName = property_getName(objc);
        NSString * ivarName = [NSString stringWithUTF8String:propertyName];
        id value = [self valueForKey:ivarName];
        [aCoder encodeObject:value forKey:ivarName];
    }
}

-(id)initWithGomeCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        unsigned int count ;
        objc_property_t * propertyList = class_copyPropertyList([self class], &count);
        for (int i=0; i<count; i++) {
            objc_property_t property = propertyList[i];
            NSString * propertyName = [NSString stringWithUTF8String:property_getName(property)];
            id value = [aDecoder decodeObjectForKey:propertyName];
            [self setValue:value forKey:propertyName];
        }
    }
    return  self;
}

//获取归档的文件路径
+(NSString*)getArchivePath:(NSString*)className{
    NSString * fileName = [NSString stringWithFormat:@"%@.archive",className];
    return [[[GMFileUtil getSandboxDocutment] stringByAppendingPathComponent:className] stringByAppendingPathComponent:fileName];
}

@end
