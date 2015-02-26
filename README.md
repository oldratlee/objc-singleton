`Objective C` `Singleton`
===================================

:point_right: 实现**安全**的`Objective C` `Singleton`。

:beer: 关于安全
----------------------

“安全”是指：

1. 多线程安全
1. 使用安全，即通过`new`类方法、`init`方法仍然返回的是同一个单例对象。`new`/`init`方法不做处理用户是可以调用的。  

第二点在场景上看起来有些吹毛求疵，用户会粘贴示例代码或是会看一下文档来使用。

在各篇`Objective C` `Singleton`文章中这方面几乎都没有得到重视，但对于`API`的用户[防痴呆设计](http://javatar.iteye.com/blog/804187)上是有意义的。

> 关于[`API`设计](http://weibo.com/1836334682/C1yHCniu1)：  
> - 只有几人两三应用使用的API，不要谈API设计重要或复杂。  
> 这种情况下，积极感受问题跟进改进API看起来更有性价比。
> - 没写给成百上千人上百应用使用的API，不要谈API设计不重要或复杂。  
> 这种情况下，一个细微的改进能省下支持工作，并值得提高用户的体验和用户对产品的评价。

### 解决线程安全

有以下方案：

1. 通过`+ (void)initialize`。
2. 通过`@synchronized`。
3. 通过`GCD`的`dispatch_once`。

### 解决使用安全

在非`ARC`的实现，能保证使用安全，参见[UT代码](objc-singleton-Tests/SingletonSafetyTests.m#L67)。

`ARC`的实现中，没有解决这个问题。参见[UT代码](objc-singleton-Tests/SingletonSafetyTests.m#L88)。

但可以通过`__attribute__ unavailable`做些补救。详见[如何禁止一个方法的外部调用](#如何禁止一个方法的外部调用)。

:beer: 使用宏简化`Singleton`实现
----------------------

:beer: 相关资料
----------------------

### `Objective C` Singleton文章

- [Avoiding Singleton Abuse - objc.io](http://www.objc.io/issue-13/singletons.html)
- [Singletons in Objective-C](http://www.galloway.me.uk/tutorials/singleton-classes/)  
- [Objective-C中单例模式的实现](http://cocoa.venj.me/blog/singleton-in-objc/)   
    讨论了几种实现方式并给了出处
- [Objective-C Singleton](http://blog.db-in.com/objective-c-singleton/)
- [What should my Objective-C singleton look like? - stackoverflow.com](http://stackoverflow.com/questions/145154/what-should-my-objective-c-singleton-look-like/145164#145164)
- [How to create singleton class in objective - stackoverflow.com C](http://stackoverflow.com/questions/5381085/how-to-create-singleton-class-in-objective-c)

### 涉及的资料

#### 如何禁止一个方法的外部调用

[Singleton Implementation. Blocking the alloc and init methods for external usage](http://stackoverflow.com/questions/20867180/singleton-implementation-blocking-the-alloc-and-init-methods-for-external-usage)提到了一个如何禁止方法在外部调用的方法，即设置方法只能类实现中调用。

通过`__attribute__ unavailable`可以让指定方法的外部直接调用在**编译时**报错且给出错误信息：

```objc
- (id)init __attribute__((unavailable("cannot use init for this class, use +(MYClass*)sharedInstance instead")));
```

由于`__attribute__ unavailable`是在**编译时**的检查，所以不能阻止**运行时**的动态调用。  
如在`Class`变量上进行调用（这点在[UT实现代码](objc-singleton-Tests/SingletonSafetyTests.m#L33)可以编译通过得到验证）：

```objc
id instance = [[clazz alloc] init];
```

关于`__attribute__`详见[Attributes in Clang](http://clang.llvm.org/docs/AttributeReference.html)

#### 如何关闭指定文件的`ARC`

- [How can I disable ARC for a single file in a project?](http://stackoverflow.com/questions/6646052/how-can-i-disable-arc-for-a-single-file-in-a-project)  
- [Disable Automatic Reference Counting for Some Files](http://stackoverflow.com/questions/6448874/disable-automatic-reference-counting-for-some-files)

#### 官方文档及源码

- [官方文档：Objective-C Automatic Reference Counting (ARC)](http://clang.llvm.org/docs/AutomaticReferenceCounting.html#general)，ARC的编译选项说明。
- [Attributes in Clang](http://clang.llvm.org/docs/AttributeReference.html)，`__attribute__`说明
- [NSObject.mm源码 - opensource.apple.com](http://opensource.apple.com/source/objc4/objc4-532.2/runtime/NSObject.mm)
- [NSNull.m源码](https://code.google.com/p/cocotron/source/browse/Foundation/NSNull.m)
