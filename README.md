`Objective C` Singleton
===================================

实现安全的`Objective C` Singleton：

- 多线程安全
- 使用安全，即通过`new`类方法、`init`方法仍然返回的是实例对象，并且没有内存泄露问题。

相关资料
----------------------

- [Singletons in Objective-C](http://www.galloway.me.uk/tutorials/singleton-classes/)
- [How can I disable ARC for a single file in a project?](http://stackoverflow.com/questions/6646052/how-can-i-disable-arc-for-a-single-file-in-a-project)
- [Disable Automatic Reference Counting for Some Files](http://stackoverflow.com/questions/6448874/disable-automatic-reference-counting-for-some-files)
- [官方文档：Objective-C Automatic Reference Counting (ARC)，包含禁用ARC的编译选项说明](http://clang.llvm.org/docs/AutomaticReferenceCounting.html#general)
- [NSObject.mm源码](http://opensource.apple.com/source/objc4/objc4-532.2/runtime/NSObject.mm)
- [NSNull.m源码](https://code.google.com/p/cocotron/source/browse/Foundation/NSNull.m)
