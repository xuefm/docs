# lombok使用教程

Lombok 是一个可以简化 Java 代码的库，通过使用注解来自动生成常见的样板代码（如 getters、setters、构造函数等）。以下是 Lombok 提供的主要注解及其用法：

### 1.@Getter 和 @Setter

- 自动生成 getter 和 setter 方法。

```java
import lombok.Getter;
import lombok.Setter;

public class MyClass {
    @Getter @Setter
    private String name;

    @Getter @Setter
    private int age;
}
```

### 2.@ToString

- 自动生成 `toString` 方法。

```java
import lombok.ToString;

@ToString
public class MyClass {
    private String name;
    private int age;
}
```

### 3.@EqualsAndHashCode

   - 自动生成 `equals` 和 `hashCode` 方法。

   ```java
import lombok.EqualsAndHashCode;

@EqualsAndHashCode
public class MyClass {
    private String name;
    private int age;
}
   ```

### 4.@NoArgsConstructor、@AllArgsConstructor 和 @RequiredArgsConstructor

   - 自动生成无参构造函数、全参构造函数和根据 `final` 字段或 `@NonNull` 注解生成的构造函数。

   ```java
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.NonNull;

@NoArgsConstructor
public class NoArgsClass {
    private String name;
    private int age;
}

@AllArgsConstructor
public class AllArgsClass {
    private String name;
    private int age;
}

@RequiredArgsConstructor
public class RequiredArgsClass {
    @NonNull
    private String name;
    private int age;
}
   ```

### 5.@Data

   - 综合了 `@Getter`、`@Setter`、`@ToString`、`@EqualsAndHashCode` 和 `@RequiredArgsConstructor` 的功能。

   ```java
import lombok.Data;

@Data
public class MyClass {
    private String name;
    private int age;
}
   ```

### 6.@Value

   - 用于不可变类，相当于 `@Data` 但所有字段默认是 `final` 和 `private`，且没有生成 setters。

   ```java
import lombok.Value;

@Value
public class MyImmutableClass {
    private String name;
    private int age;
}
   ```

### 7.@Builder

   - 为类生成 Builder 模式的实现。

   ```java
import lombok.Builder;

@Builder
public class MyClass {
    private String name;
    private int age;
}
   ```

### 8.@SneakyThrows

   - 自动处理受检异常，将其转换为非受检异常。

   ```java
import lombok.SneakyThrows;

public class MyClass {
    @SneakyThrows
    public void myMethod() {
        throw new Exception("Checked exception");
    }
}
   ```

### 9.@Log 系列注解

   - 自动生成不同日志框架的日志对象，如 `@Log`、`@Slf4j`、`@Log4j` 等。

   ```java
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class MyClass {
    public void logSomething() {
        log.info("This is a log message");
    }
}
   ```

### 10.@Cleanup

- 确保资源在使用后被关闭，通常用于 I/O 操作。

```java
import lombok.Cleanup;
import java.io.*;

public class MyClass {
    public void readFile(String filePath) throws IOException {
        @Cleanup InputStream in = new FileInputStream(filePath);
        // Use the input stream...
    }
}
```

### 11.@Synchronized

- 为方法生成同步块，类似于 `synchronized` 关键字，但更加灵活。

```java
import lombok.Synchronized;

public class MyClass {
    @Synchronized
    public void synchronizedMethod() {
        // This method is synchronized
    }
}
```

### 12.@Delegate

- 简化委托模式的实现，将方法调用委托给其他对象。

```java
import lombok.Delegate;

public class MyClass {
    @Delegate
    private final List<String> list = new ArrayList<>();
}
```

这些注解大大减少了样板代码，使得代码更加简洁和易于维护。在使用 Lombok 时，需要安装 Lombok 插件并配置 IDE，以确保注解的正确处理和生成的代码能够被识别。