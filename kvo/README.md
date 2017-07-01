### KVO

代码运行结果：

```bash
control: <TestClass: 0x1002037e0>
	NSObject class TestClass
	libobjc class TestClass
	implements methods <setX:, setY:, setZ:, x, y, z>

x: <TestClass: 0x100203350>
	NSObject class TestClass
	libobjc class NSKVONotifying_TestClass
	implements methods <setY:, setX:, class, dealloc, _isKVOA>

y: <TestClass: 0x1002037a0>
	NSObject class TestClass
	libobjc class NSKVONotifying_TestClass
	implements methods <setY:, setX:, class, dealloc, _isKVOA>

xy: <TestClass: 0x1002037c0>
	NSObject class TestClass
	libobjc class NSKVONotifying_TestClass
	implements methods <setY:, setX:, class, dealloc, _isKVOA>

TestClass setX: 0x1000015b0
control setX: 0x1000015b0
x setX: 0x7fff8282156b
```