//
//  globeResource.h
//  HXXY
//
//  Created by Apple on 9/8/15.
//  Copyright (c) 2015 广东华讯网络投资有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChangeStoryboardDelegate.h"

@interface GlobalResource : NSObject
+ (instancetype)sharedInstance;
@property (nonatomic,retain) id delegate;

@end
