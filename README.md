# iOS-Learning-Test
hhl's Objective-C and iOS learning notes and test demo

## UI布局

自动布局两种方式：代码手写 和 Interface builder

苹果为我们提供的适配框架有：VFL、UIViewAutoresizing、**Auto Layout**、Size Classes等


## OC

### 关键词
常用关键字以@开头
> @interface、@implementation、@end、
> @public、@protected、@private、
> @protocol、@optional、@required、@class、@property、
> @synthesize(给实例变量起个别名/指定与属性对应的实例变量)、@dynamic(阻止自动合成)
> @ selector @try、@catch、@throw、@finally

不以@开头关键字
> self、super、id、_cmd、__block、__strong、__weak等

### 属性
@property (nonatomic,assign) int b; //申明属性 

> 内存管理特性：retain assign copy strong weak unsafe_unretained autoreleasing
> 
> 读 /写特性：readwrite readonly
> 
> 多线程特性：nonatomic atomic
> 
> 方法名特性：setter getter

成员变量
> 是定义在｛｝号中的变量，如果变量的数据类型是一个类则称这个变量为实例变量。
> 成员变量用于类内部，无需与外界接触的变量。因为成员变量不会生成set、get方法，所以外界无法与成员变量接触。

实例变量
> 是成员变量的一种特殊情况，只是实例是针对类而言，实例是指类的声明,所以实例变量也是类内部使用的，无需与外部接触的变量，这个也就是所谓的类私有变量。
> id是OC特有的类，本质上讲id等同于（void *）。所以id data属于实例变量。

属性变量
> 是用于与其他对象交互的变量。允许让其他对象访问到该变量（因为属性创建过程中自动产生了set 和get方法）。
> 当然，你可以设置只读或者可写等，设置方法也可自定义。

通常把需要与外部接触的变量定义在.h文件中，只在本类中使用的变量定义在.m文件中。
详见：[成员变量和属性区别（@property那点事儿）](https://www.cnblogs.com/huangzs/p/7508583.html)[学习总结】声明变量在@interface括号中与使用@property的区别](https://www.cnblogs.com/cwllong/p/5058849.html)

### 占位符
>%d  十进制整数<br>
>%f  十进制小数(浮点型)<br>
>%c  字符<br>
>%s  字符串 <br>
>%@  OC字符串


## 多线程

### [NSThread](https://developer.apple.com/documentation/foundation/nsthread?language=objc)
[iOS 多线程：『pthread、NSThread』详尽总结](https://www.jianshu.com/p/cbaeea5368b1)

    线程安全解决方案：
    可以给线程加锁，在一个线程执行该操作的时候，不允许其他线程进行操作。
    iOS 实现线程加锁有很多种方式。@synchronized、 NSLock、NSRecursiveLock、NSCondition、NSConditionLock、pthread_mutex、dispatch_semaphore、OSSpinLock、atomic(property) set/ge等等各种方式。

### [Grand Central Dispatch(GCD)](https://developer.apple.com/documentation/dispatch?language=objc)
[iOS 多线程：『GCD』详尽总结](https://www.jianshu.com/p/2d57c72016c6)：

```
// 串行队列的创建方法
dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_SERIAL);
// 并发队列的创建方法
dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_CONCURRENT);
// 主队列的获取方法
dispatch_queue_t queue = dispatch_get_main_queue();
// 全局并发队列的获取方法
dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

// 同步执行任务创建方法
dispatch_sync(queue, ^{
    // 这里放同步执行任务代码
});
// 异步执行任务创建方法
dispatch_async(queue, ^{
    // 这里放异步执行任务代码
});
```

| 区别 | 并发队列 | 串行队列 | 主队列  |
| :------| ------: |------: | :------: |
| 同步(sync) | 没有开启新线程，串行执行任务 | 没有开启新线程，串行执行任务 |主线程调用：死锁卡住不执行<br>其他线程调用：没有开启新线程，串行执行任务 |
| 异步(async) | 有开启新线程，并发执行任务 | 有开启新线程(1条)，串行执行任务 | 没有开启新线程，串行执行任务 |

### [NSOperationQueue](https://developer.apple.com/documentation/foundation/nsoperationqueue?language=objc)
[iOS 多线程：『NSOperation、NSOperationQueue』详尽总结](https://www.jianshu.com/p/4b1d77054b35)：

NSOperation 实现多线程的使用步骤分为三步：

1.  创建操作：先将需要执行的操作封装到一个 NSOperation 对象中。
    1. 使用子类 NSInvocationOperation
    2. 使用子类 NSBlockOperation
    3. 自定义继承自 NSOperation 的子类，通过实现内部相应的方法来封装操作。
2.  创建队列：创建 NSOperationQueue 对象。
    1. 主队列
    ```
    // 主队列获取方法
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    ```
    2. 自定义队列（非主队列）
    ```
    // 自定义队列创建方法
    //同时包含了：串行、并发功能。
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    ```

3.  将操作加入到队列中：将 NSOperation 对象添加到 NSOperationQueue 对象中。
    1. ```- (void)addOperation:(NSOperation *)op;```
    2. ```- (void)addOperationWithBlock:(void (^)(void))block;```

4. maxConcurrentOperationCount**最大并发操作数**
5.  NSOperation 操作依赖
    1. ``` - (void)addDependency:(NSOperation *)op;``` 添加依赖，使当前操作依赖于操作 op 的完成。
    2. ```- (void)removeDependency:(NSOperation *)op;``` 移除依赖，取消当前操作对操作 op 的依赖。
    3. ```@property (readonly, copy) NSArray<NSOperation *> *dependencies; ```在当前操作开始执行之前完成执行的所有操作对象数组。
    
6. NSOperation 优先级
7. NSOperation、NSOperationQueue 线程间的通信
8. NSOperation、NSOperationQueue 线程同步和线程安全(使用NSLock对象示例)

## [iOS 网络请求](https://www.jianshu.com/p/c34f0740f178)
### [AFNetworking](https://github.com/AFNetworking/AFNetworking)

### **CFNetworking**

#### [CFNetwork编程指南（一）——CFNetwork概念（CFNetwork Concepts）](https://blog.csdn.net/HDFQQ188816190/article/details/52672694)

> Web Kit -> NSURL -> CFNetwork -> BSD scokets

[URL Loading System Programming Guide](https://developer.apple.com/documentation/foundation/url_loading_system?language=objc)

CFNetwork依赖的两个API：CFSocket和CFStream是核心基础框架的一部分。

1. CFSocket [CFSocket Reference](https://developer.apple.com/documentation/corefoundation/cfsocket?language=objc)

2. CFStream
    1. CFReadStream
    2. CFWriteStream
    
    > ![CFStream API结构](http://upload-images.jianshu.io/upload_images/674853-964ddfb719c079ec.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

3. CFNetwork
    1. [CFFTP API](https://developer.apple.com/library/archive/documentation/Networking/Conceptual/CFNetwork/CFFTPTasks/CFFTPTasks.html#//apple_ref/doc/uid/TP30001132-CH9-SW1)
    2. [CFHTTP API](https://developer.apple.com/library/archive/documentation/Networking/Conceptual/CFNetwork/CFHTTPTasks/CFHTTPTasks.html#//apple_ref/doc/uid/TP30001132-CH5-SW2)
    3. [CFHTTPAuthentication API](https://developer.apple.com/library/archive/documentation/Networking/Conceptual/CFNetwork/CFHTTPAuthenticationTasks/CFHTTPAuthenticationTasks.html#//apple_ref/doc/uid/TP30001132-CH8-SW1)：OS X v10.4的新功能是提供持续请求功能。在OS X v10.3中，每次请求被怀疑，你必须从头开始身份验证。现在，你为每个服务器维护一组CFHTTPAuthentication 对象。当你收到一个401或407响应，你查找服务器正确的对象和凭证，并请求。CFNetwork使用存储在对象的信息尽可能高效的处理请求。
    4. CFHost API：使用CFHost API获取主机信息，包括名称、地址和可达性信息。获取信息的过程被称为解析。
    5. [CFNetServices API](https://developer.apple.com/library/ios/documentation/Networking/Conceptual/NSNetServiceProgGuide/Introduction.html#//apple_ref/doc/uid/TP40002736)
    6. CFNetDiagnostics API

## KVC 与 KVO
 [基础理解](https://magicalboy.com/kvc_and_kvo.html)

## Block块 `^`

[精通Objective-C块](https://blog.csdn.net/sps900608/article/details/51911625)

[Objective-C代码块Block详解](https://blog.csdn.net/CHENYUFENG1991/article/details/49402789)

声明
```
//无参数无返回值的block!
typedef void(^NewType)();

//有返回值有参数的block
typedef int(^NewType2)(int num1, int num2);
```

 block代码块是OC的一个特性，除了可执行的代码外，还可能包含变量的自动绑定（栈），或内存托管（堆）。所以一个block维护一个状态集（数据），可以在任何时候执行。block用来作为回调特别有用。

 block可以作为函数参数或者函数的返回值，而本身又可以带输入参数或返回值 [refer1](https://blog.csdn.net/dfman1978/article/details/52171638) [refer2](https://blog.csdn.net/shadowee/article/details/73200872)。在多线程，异步任务，集合遍历，接口回调等地方用得比较多。使用标识符^.。

 为了性能，block都是分配在栈stack上面的，它的作用域就是当前函数。
 <br>
 block和函数的相似性：
> 1. 可以保存代码；
> 2. 有返回值；
> 3. 有形参；
> 4. 调用方式一样；

其他注意点：
> 1. block可以访问外边先定义的变量
> 2. block中可以定义外界同名变量
> 3. block默认无法修改外界定义的变量，因为block会拷贝一份外界定义的变量至堆内存中
> 4. 因为是拷贝，所以在block调用之前修改外界定义的变量不会影响block内部的同名变量
> 5. 如果外边给变量修饰上__block后，则反编译成C++后显示是指针传递，也就是说外部修改后会影响到block内部，反之亦然。
> 6. block默认存放在栈中，进行一次copy操作后会转移到堆中

## * 和&
>  *p：表示的是一个指针； &p：表示的是一个地址。

【a】表示a对应的存储单元中的数据。 

【&a】表示a对应的存储单元的地址。 

【*a】表示：首先，要求a对应的存储单元中的数据一定是另一个存储单元的地址。 于是，*a表示另一个存储单元中的数据。

1. 在C语言中的数组本质上其实也是指针，即：*a 等同于 a[]。
2. a == &*a 都是该存储单元的地址。
3. int a，a中存储的是一个整数数值，通过a可以访问（读取或修改）这个数值。 
4. int* a，a中存储的是一个存储单元的地址，而该存储单元中存储的数据是一个整数数值；通过*a可以访问（读取或修改）这个数值。a == &*a 都是该存储单元的地址。 
5. int** a，a中存储的是一个存储单元的地址，而该存储单元中存储的数据是另外一个存储单元的地址，另外这个存储单元中存储的是一个整数数值；通过**a可以访问（读取或修改）这个数值。 

## Category `()`
1. 一个分类可以将方法的实现分解进一系列分离的文件
2. 分类中的方法是在运行时被加入类中的
3. 其代码可以访问包括私有类成员变量在内的所有成员变量
4. 若分类声明了与类中原有方法同名的函数，则分类中的方法会被调用。
```
@interface Integer(Arithmetic)
- (id) add: (Integer *) addend;
- (id) sub: (Integer *) subtrahend;
@end
```

[分类（类别/Category）与 类扩展（Extension）](https://www.cnblogs.com/pengyunjing/p/5908460.html)

## Protocol `<>`
类似于“接口”
```
//定义一个协议
@protocol Locking
- (void)lock;
- (void)unlock;
@end
//一个实现该协议的声明
@interface SomeClass : SomeSuperClass <Locking>
@end
//实现该协议中具体方法
@implementation SomeClass
- (void)lock {
// 實現lock方法...
}
- (void)unlock {
// 實現unlock方法...
}
@end
```

[protocol 和delegate(协议和代理)的区别](http://www.cnblogs.com/36bian/p/5240517.html)