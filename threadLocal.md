# ThreadLocal 解析

[TOC]

## 简介

>**ThreadLocal**类提供了线程局部 (thread-local) 变量。这些变量不同于它们的普通对应物，因为访问某个变量（通过其 get 或 set 方法）的每个线程都有自己的局部变量，它独立于变量的初始化副本。ThreadLocal 实例通常是类中的 *private static* 字段，它们希望将状态与某一个线程（例如，用户 ID 或事务 ID）相关联。 

>例如，以下类生成对每个线程唯一的局部标识符。线程 ID 是在第一次调用 UniqueThreadIdGenerator.getCurrentThreadId() 时分配的，在后续调用中不会更改。 

``` java

    import java.util.concurrent.atomic.AtomicInteger;

    public class UniqueThreadIdGenerator {

        private static final AtomicInteger uniqueId = new AtomicInteger(0);

        private static final ThreadLocal < Integer > uniqueNum = 
            new ThreadLocal < Integer > () {
                @Override protected Integer initialValue() {
                    return uniqueId.getAndIncrement();
            }
        };

        public static int getCurrentThreadId() {
            return uniqueId.get();
        }
    } // UniqueThreadIdGenerator

```

>每个线程都保持对其线程局部变量副本的*隐式引用*，只要线程是活动的并且 ThreadLocal 实例是可访问的；**在线程消失之后，其 thread-local 实例的所有副本都会被垃圾回收（除非存在对这些副本的其他引用）**。

## 使用

关于 ThreadLocal 使用可以参照: [链接](http://ifeve.com/threadlocal%E4%BD%BF%E7%94%A8/)

## 类结构

### ThreadLocal&lt;T&gt;

ThreadLocal 提供 3 个 public 函数, 1 个 protected 函数, 1 个空的构造函数.

| return | name | description |
| :--- | :-- | :-- |
|public  T | get | 返回此线程局部变量的当前线程副本中的值. 如果变量没有用于当前线程的值, 则先将其初始化为调用 initialValue() 方法返回的值. |
| protected T | initialValue | 默认实现返回 null ; 如果希望线程局部变量具有 null 以外的值，则必须为 ThreadLocal 创建子类，并重写此方法。通常将使用匿名内部类完成此操作。 |
| public void | remove | 移除此线程局部变量当前线程的值。如果此线程局部变量随后被当前线程读取，且这期间当前线程没有设置其值，则将调用其 initialValue() 方法重新初始化其值。这将导致在当前线程多次调用 initialValue 方法. |
| public void | set | 将此线程局部变量的当前线程副本中的值设置为指定值。大部分子类不需要重写此方法，它们只依靠 initialValue() 方法来设置线程局部变量的值. |

ThreadLocal  还有一个重要的**静态内部类 ThreadLocalMap**

### ThreadLocalMap

这货是个 Map 但是它并没有实现 Map&lt;K,V&gt; 接口. 与其他的 Map 一样, 它也有个静态内部类 Entry , 但是这个 Entry 类是继承自 WeakReference<ThreadLocal>. 

这里使用 WeakReference (弱连接) 也就对应了前面的 **在线程消失之后，其 thread-local 实例的所有副本都会被垃圾回收（除非存在对这些副本的其他引用）**; 

英文原文是: **after a thread goes away, all of its copies of thread-local instances are subject to garbage collection (unless other references to these copies exist)**

这有些类似与 WeakHashMap&lt;K,V&gt;, 关于引用展开又是另一个话题, 这里不过多赘述, 简单了解可以参照: [链接](http://droidyue.com/blog/2014/10/12/understanding-weakreference-in-java/)

ThreadLocalMap 解决冲突的方式也与 HashMap 不同, ThreadLocalMap 的键值 K 是一个 thread-local 实例;
value 就是 ThreadLocal&lt;T&gt; 中的 T ; 内部使用一个数组来存储所有的 value , 可以理解为一个环状数组. 
解决冲突的方式是直接在数组上顺时针向后顺延. 超过阈值后会进行 rehash, resize 操作. 阈值为数组长度的 2 / 3.

与 HashMap 一样的是数组大小一定是 2 的 n 次方, 可以用与运算快速定位. 数组初始大小 16 .

## ThreadLocal 实现

在Thread类中有一个包级私有成员:

``` java
    /* ThreadLocal values pertaining to this thread. This map is maintained
     * by the ThreadLocal class. */
    ThreadLocal.ThreadLocalMap threadLocals = null;
```

到这里我们会发现, 每个线程实例都会持有各自的 threadLocals 成员. 因为 threadLocals 里保存了真正的变量, 也就实现了变量的线程隔离效果. 其实也没那么神奇.

### get & initialValue

``` java

    public T get() {
        Thread t = Thread.currentThread();
        ThreadLocalMap map = getMap(t);
        if (map != null) {
            ThreadLocalMap.Entry e = map.getEntry(this);
            if (e != null)
                return (T)e.value;
        }
        return setInitialValue();
    }

    ThreadLocalMap getMap(Thread t) {
        return t.threadLocals;
    }

    private T setInitialValue() {
        T value = initialValue();
        Thread t = Thread.currentThread();
        ThreadLocalMap map = getMap(t);
        if (map != null)
            map.set(this, value);
        else
            createMap(t, value);
        return value;
    }

    // 可以重写此方法
    protected T initialValue() {
        return null;
    }

```

`Thread.currentThread();` 会返回当前运行线程的实例, `getMap(t);` 则直接返回就是线程实例内部的 threadLocals. 
如果 threadLocals == null 或者 threadLocals 无对应值, 则执行 setInitialValue ,这时候会执行 initialValue ,如果我们重写了这个方法就可以设置默认的返回值, 避免返回 null. 之后会根据 threadLocals 是否为 null 选择插入或者创建一个 ThreadLocalMap 实例作为当前线程的 threadLocals.

通常情况下 initialValue 对每个线程最多调用一次, *但如果在调用 get() 后又调用了 remove()，则可能再次调用此方法*.

### set & remove

``` java

    public void set(T value) {
        Thread t = Thread.currentThread();
        ThreadLocalMap map = getMap(t);
        if (map != null)
            map.set(this, value);
        else
            createMap(t, value);
    }

    public void remove() {
         ThreadLocalMap m = getMap(Thread.currentThread());
         if (m != null)
             m.remove(this);
     }

```

代码逻辑简单只需注意 *移除此线程局部变量当前线程的值。如果此线程局部变量随后被当前线程读取，且这期间当前线程没有设置其值，则将调用其 initialValue() 方法重新初始化其值。这将导致在当前线程多次调用 initialValue 方法*

## ThreadLocalMap 实现

### Entry

在了解 ThreadLocalMap 实现之前有必要先简单了解一下 Entry 的实现.

``` java

        /**
         * The entries in this hash map extend WeakReference, using
         * its main ref field as the key (which is always a
         * ThreadLocal object).  Note that null keys (i.e. entry.get()
         * == null) mean that the key is no longer referenced, so the
         * entry can be expunged from table.  Such entries are referred to
         * as "stale entries" in the code that follows.
         */
        static class Entry extends WeakReference<ThreadLocal> {
            /** The value associated with this ThreadLocal. */
            Object value;

            Entry(ThreadLocal k, Object v) {
                super(k);
                value = v;
            }
        }

```

Entry 继承了 WeakReference, entry 对象一般是一个指向 thread-local 实例的弱引用, entry.get() == null 代表没有任何强引用指向这个 thread-local 对象, 
所以这个 entry 可以从 table 中擦除了, 这些 entries 被称为 stale entries.

### expungeStaleEntry

entry.get() == null 需要执行的擦除操作. 这个函数会在后面的函数中直接或间接的大量使用.

``` java

        private int expungeStaleEntry(int staleSlot) {
            Entry[] tab = table;
            int len = tab.length;

            // expunge entry at staleSlot
            tab[staleSlot].value = null;
            tab[staleSlot] = null;
            size--;

            // Rehash until we encounter null
            Entry e;
            int i;
            for (i = nextIndex(staleSlot, len);
                 (e = tab[i]) != null;
                 i = nextIndex(i, len)) {
                ThreadLocal k = e.get();
                if (k == null) {
                    e.value = null;
                    tab[i] = null;
                    size--;
                } else {
                    int h = k.threadLocalHashCode & (len - 1);
                    if (h != i) {
                        tab[i] = null;

                        // Unlike Knuth 6.4 Algorithm R, we must scan until
                        // null because multiple entries could have been stale.
                        while (tab[h] != null)
                            h = nextIndex(h, len);
                        tab[h] = e;
                    }
                }
            }
            return i;
        }

```

### get 

### set

### remove

### rehash