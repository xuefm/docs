

创建方法

```java
public static <T> Predicate<T> distinctByKey(Function<? super T, Object> keyExtractor) {
    Map<Object, Boolean> seen = new ConcurrentHashMap<>();
    return object -> seen.putIfAbsent(keyExtractor.apply(object), Boolean.TRUE) == null;
}
```



使用stream进行去重

```java
 Long numberOfPeople = list.stream().filter(distinctByKey(Order::getUserInfoId)).count();
```

