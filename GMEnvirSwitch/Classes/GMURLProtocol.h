//
//  GMURLProtocol.h
//  GMEnvirSwitch
//
//  Created by 小飞鸟 on 2019/10/09.
//

#ifndef GMURLProtocol_h
#define GMURLProtocol_h
@protocol GMURLConfigProtocol <NSObject>

@optional
//配置请求的URL
-(NSArray*)configEnvirURL;

@end

#endif /* GMURLProtocol_h */
