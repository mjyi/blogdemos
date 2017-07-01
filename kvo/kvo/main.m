//
//  main.m
//  kvo
//
//  Created by mervin on 2017/6/30.
//  Copyright © 2017年 mervin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface TestClass : NSObject
{
    int x;
    int y;
    int z;
}
@property int x;
@property int y;
@property int z;
@end
@implementation TestClass
@synthesize x, y, z;
@end

static NSArray *ClassMethodNames(Class c)
{
    NSMutableArray *array = [NSMutableArray array];
    
    unsigned int methodCount = 0;
    Method *methodList = class_copyMethodList(c, &methodCount);
    unsigned int i;
    for(i = 0; i < methodCount; i++)
        [array addObject: NSStringFromSelector(method_getName(methodList[i]))];
    free(methodList);
    
    return array;
}

static void PrintDescription(NSString *name, id obj)
{
    NSString *str = [NSString stringWithFormat:
                     @"%@: %@\n\tNSObject class %s\n\tlibobjc class %s\n\timplements methods <%@>",
                     name,
                     obj,
                     class_getName([obj class]),
                     class_getName(object_getClass(obj)),
                     [ClassMethodNames(object_getClass(obj)) componentsJoinedByString:@", "]];
    printf("%s\n\n", [str UTF8String]);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        TestClass *x = [[TestClass alloc] init];
        TestClass *y = [[TestClass alloc] init];
        TestClass *xy = [[TestClass alloc] init];
        TestClass *control = [[TestClass alloc] init];
        
        [x addObserver:x forKeyPath:@"x" options:0 context:NULL];
        [xy addObserver:xy forKeyPath:@"x" options:0 context:NULL];
        [y addObserver:y forKeyPath:@"y" options:0 context:NULL];
        [xy addObserver:xy forKeyPath:@"y" options:0 context:NULL];
        
        PrintDescription(@"control", control);
        PrintDescription(@"x", x);
        PrintDescription(@"y", y);
        PrintDescription(@"xy", xy);
        
        printf("TestClass setX: %p\n",
               method_getImplementation(class_getInstanceMethod([TestClass class], @selector(setX:))));
        
        printf("control setX: %p\n",
               [control methodForSelector:@selector(setX:)]);
        
        printf("x setX: %p\n",
               [x methodForSelector:@selector(setX:)]);
    
        [x removeObserver:x forKeyPath:@"x"];
        [xy removeObserver:xy forKeyPath:@"x"];
        [y removeObserver:y forKeyPath:@"y"];
        [xy removeObserver:xy forKeyPath:@"y"];
    }
    return 0;
}





