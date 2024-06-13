# MapStruct 使用教程

MapStruct 是一个 Java 注解处理器，用于生成类型安全的 bean 映射代码。它通过简单的注解配置，自动生成各种对象之间的转换代码，从而减少手动编写映射逻辑所需的样板代码。下面是一些 MapStruct 的基本用法和示例。

### 1. 添加依赖

首先，需要在项目中添加 MapStruct 的依赖。如果使用 Maven，可以在 `pom.xml` 中添加以下依赖：

```xml
<dependencies>
    <dependency>
        <groupId>org.mapstruct</groupId>
        <artifactId>mapstruct</artifactId>
        <version>1.5.5.Final</version> <!-- 请根据最新版本替换 -->
    </dependency>
    <dependency>
        <groupId>org.mapstruct</groupId>
        <artifactId>mapstruct-processor</artifactId>
        <version>1.5.5.Final</version> <!-- 请根据最新版本替换 -->
        <scope>provided</scope>
    </dependency>
</dependencies>
```

### 2. 创建源对象和目标对象

假设我们有两个简单的类 `Person` 和 `PersonDTO`，需要相互转换。

```java
public class Person {
    private String firstName;
    private String lastName;
    private int age;

    // Getters and Setters
}

public class PersonDTO {
    private String firstName;
    private String lastName;
    private int age;

    // Getters and Setters
}
```

### 3. 创建 Mapper 接口

使用 MapStruct 时，需要定义一个接口并使用 `@Mapper` 注解。MapStruct 会自动生成该接口的实现类。

```java
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface PersonMapper {
    PersonMapper INSTANCE = Mappers.getMapper(PersonMapper.class);

    PersonDTO personToPersonDTO(Person person);
    Person personDTOToPerson(PersonDTO personDTO);
}
```

### 4. 使用 Mapper

一旦接口定义好并且编译成功，MapStruct 会生成实现类。可以像下面这样使用生成的 Mapper：

```java
public class Main {
    public static void main(String[] args) {
        Person person = new Person();
        person.setFirstName("John");
        person.setLastName("Doe");
        person.setAge(30);

        // 使用 MapStruct 生成的实现类进行转换
        PersonDTO personDTO = PersonMapper.INSTANCE.personToPersonDTO(person);

        System.out.println("PersonDTO: " + personDTO.getFirstName() + " " + personDTO.getLastName() + ", Age: " + personDTO.getAge());

        // 反向转换
        Person convertedPerson = PersonMapper.INSTANCE.personDTOToPerson(personDTO);
        System.out.println("Person: " + convertedPerson.getFirstName() + " " + convertedPerson.getLastName() + ", Age: " + convertedPerson.getAge());
    }
}
```

### 5. 自定义映射

有时字段名称或类型不完全一致，可以使用 `@Mapping` 注解来自定义映射。例如：

```java
public class Person {
    private String firstName;
    private String lastName;
    private int age;
    private String dateOfBirth; // 例如，格式为 "yyyy-MM-dd"

    // Getters and Setters
}

public class PersonDTO {
    private String firstName;
    private String lastName;
    private int age;
    private LocalDate birthDate; // 日期类型不同

    // Getters and Setters
}
```

在 Mapper 接口中定义自定义映射：

```java
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@Mapper
public interface PersonMapper {
    PersonMapper INSTANCE = Mappers.getMapper(PersonMapper.class);

    @Mapping(source = "dateOfBirth", target = "birthDate", dateFormat = "yyyy-MM-dd")
    PersonDTO personToPersonDTO(Person person);

    @Mapping(source = "birthDate", target = "dateOfBirth", dateFormat = "yyyy-MM-dd")
    Person personDTOToPerson(PersonDTO personDTO);
}
```

### 6. 使用表达式和方法

可以使用表达式或自定义方法来处理复杂的映射逻辑。

```java
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@Mapper
public interface PersonMapper {
    PersonMapper INSTANCE = Mappers.getMapper(PersonMapper.class);

    @Mapping(source = "dateOfBirth", target = "birthDate", dateFormat = "yyyy-MM-dd")
    PersonDTO personToPersonDTO(Person person);

    @Mapping(target = "dateOfBirth", expression = "java(mapBirthDate(personDTO.getBirthDate()))")
    Person personDTOToPerson(PersonDTO personDTO);

    default String mapBirthDate(LocalDate birthDate) {
        return birthDate != null ? birthDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) : null;
    }
}
```

### 7. 处理嵌套映射

对于嵌套对象之间的映射，也可以使用 MapStruct。例如：

```java
public class Address {
    private String street;
    private String city;

    // Getters and Setters
}

public class User {
    private String name;
    private Address address;

    // Getters and Setters
}

public class AddressDTO {
    private String street;
    private String city;

    // Getters and Setters
}

public class UserDTO {
    private String name;
    private AddressDTO address;

    // Getters and Setters
}
```

定义嵌套映射：

```java
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface UserMapper {
    UserMapper INSTANCE = Mappers.getMapper(UserMapper.class);

    UserDTO userToUserDTO(User user);
    User userDTOToUser(UserDTO userDTO);
}
```

### 总结

MapStruct 是一个功能强大且高效的对象映射工具，通过注解配置可以极大地减少手动编写映射代码的工作量。它支持简单和复杂的映射场景，包括嵌套对象、不同字段类型、定制化转换等。使用 MapStruct 可以提高代码的可读性和可维护性。