//
//  NSObject+FXClass.m
//  FXListKit
//
//  Created by Mr.wu on 2020/1/26.
//  Copyright © 2020 Mr.wu. All rights reserved.
//

#import "NSObject+FXClass.h"

@implementation NSObject (FXClass)

+ (BOOL)verifyClass:(Class)cl IsSubclassOfClass:(Class)cla {
    return [cl isSubclassOfClass:cla];
}

@end
