### 1.pom 依赖spring-boot-autoconfigure

```xml


<properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <maven.compiler.encoding>UTF-8</maven.compiler.encoding>
        <java.version>17</java.version>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
        <java.version>17</java.version>
        <spring-boot.version>3.0.3</spring-boot.version>
</properties>

<dependencyManagement>
    <dependencies>
        <dependency>
            <!-- Import dependency management from Spring Boot -->
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-dependencies</artifactId>
            <version>${spring-boot.version}</version>
            <type>pom</type>
            <scope>import</scope>
        </dependency>
    </dependencies>
</dependencyManagement>

<dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-configuration-processor</artifactId>
            <optional>true</optional>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-autoconfigure</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-logging</artifactId>
            <scope>compile</scope>
        </dependency>
</dependencies>
```

### 2.1.自定义配置

```java
import com.expect.service.impl.ExpectServiceImpl;
import lombok.Data;
import org.springframework.boot.autoconfigure.AutoConfiguration;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Import;

@Data
@AutoConfiguration
@ConfigurationProperties(prefix = "expect")
//导入其他Bean
@Import({ExpectServiceImpl.class})
public class ExpectConfig {

    private String name;
    private String gender;
    private String age;


}
```



### 2.2自定义Service

```java
import com.expect.service.ExpectService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class ExpectServiceImpl implements ExpectService {


    @Override
    public void sayHello() {
        log.info("sayHello");
        System.out.println("sayHello");
    }

    @Override
    public void sayGoodbye() {
        log.info("sayGoodbye");
        System.out.println("sayGoodbye");
    }
}
```



### 3.注册为Spring Bean

#### 方式一

Spring Boot 3.0后不可用

在resources下新建META-INF文件夹，然后创建spring.factories文件

```te
org.springframework.boot.autoconfigure.EnableAutoConfiguration=\
com.expect.config.ExpectConfig
```

#### 方式二

Spring Boot 2.7后可用

创建文件 /resources/META-INF/spring/org.springframework.boot.autoconfigure.AutoConfiguration.imports

```tex
com.expect.config.ExpectConfig
```





升级spring boot 3注意事项：

自动配置文件变更

Spring Boot 2.7 引入了一个新的文件：

META-INF/spring/org.springframework.boot.autoconfigure.AutoConfiguration.imports

用于注册自动配置，同时保持与 spring.factories 中注册的向后兼容。Spring Boot 3.0 发布后，spring.factories已经被移除，只能通过imports文件来注册自动配置。
