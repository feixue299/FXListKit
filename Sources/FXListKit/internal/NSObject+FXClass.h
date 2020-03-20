//
//  NSObject+FXClass.h
//  FXListKit
//
//  Created by Mr.wu on 2020/1/26.
//  Copyright © 2020 Mr.wu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (FXClass)

+ (BOOL)verifyClass:(Class)cl IsSubclassOfClass:(Class)cla;

@end

NS_ASSUME_NONNULL_END
