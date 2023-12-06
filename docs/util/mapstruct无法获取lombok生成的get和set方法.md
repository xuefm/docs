## mapstruct无法获取lombok生成的get和set方法

版本：

jdk: 17

lombok:1.18.24

mapstruct:1.5.5.Final

### 1.问题描述

```java
@Data
public class AccountInfo implements Serializable {

    private static final long serialVersionUID = 1L;
    
    private String id;

    private String loginName;

    private String loginPassword;

    private Long loginTime;

    private Integer enabled;

    private Integer deleted;

    private Date createTime;

    private String createById;

    private Date updateTime;
    
    private String updateById;
}
```

```java
@Data
public class AccountVO implements java.io.Serializable {

    private static final long serialVersionUID = 1L;

    private String id;

    private String loginName;

    private Integer enabled;

    private Date createTime;
}
```

使用mapstruct将AccountInfo转为AccountVO

```java
@Mapper
public interface AccountMapper {

    AccountMapper  mapper = Mappers.getMapper(AccountMapper.class);

    AccountVO account2AccountVO(AccountInfo account);
}
```

该文件在/src/main/java/下时生成的.class文件为下方

```java
public class AccountMapperImpl implements AccountMapper {
    public AccountMapperImpl() {
    }

    public AccountVO account2AccountVO(AccountInfo account) {
        if (account == null) {
            return null;
        } else {
            AccountVO accountVO = new AccountVO();
            return accountVO;
        }
    }
}
```

该文件在/src/test/java/下时生成的.class文件为下方

```java
public class AccountMapperImpl implements AccountMapper {
    public AccountMapperImpl() {
    }

    public AccountVO account2AccountVO(AccountInfo account) {
        if (account == null) {
            return null;
        } else {
            AccountVO accountVO = new AccountVO();
            accountVO.setId(account.getId());
            accountVO.setLoginName(account.getLoginName());
            accountVO.setEnabled(account.getEnabled());
            accountVO.setCreateTime(account.getCreateTime());
            return accountVO;
        }
    }
}
```

发现main文件夹下生成的比起test文件夹下生成的少了accountVO.setId(account.getId());等代码

我们希望main文件夹下也能生成accountVO.setId(account.getId());等代码

### 2.问题解决过程和分析

经过尝试发现当不适用lombok的@Data注解而是使用手写get和set方法时候可以正常生成accountVO.setId(account.getId());等代码

lombok和都是mapstruct在编译时通过注解生成.class文件

猜测是否是mapstruct在生成impl时lombok还未生成get和set方法，

那为什么/src/test/java/下的有accountVO.setId(account.getId());等代码，应该是此时lombok已经处理完了此时已经可以获取到get和set方法了

那有没有办法指定代码的编译顺序呢，

maven项目下做以下尝试 在模块A中写实体类，在模块B中导入A模块，在模块B中写mapstructMapper接口 

经过尝试，这种方法可以解决该问题impl中可以有accountVO.setId(account.getId());等代码(但是这种方法限制了实体类必须和mapstructMapper放在不同模块中)

继续在网上找解决办法，终于找到解决此问题的方法

原来打包插件

```xml
    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.11.0</version>
                <configuration>
                    <source>${java.version}</source>
                    <target>${java.version}</target>
                    <encoding>UTF-8</encoding>
                </configuration>
            </plugin>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
                <version>${spring-boot.version}</version>
                <configuration>
                    <excludes>
                        <exclude>
                            <groupId>org.projectlombok</groupId>
                            <artifactId>lombok</artifactId>
                        </exclude>
                    </excludes>
                </configuration>
            </plugin>
        </plugins>
    </build>
```

修改后打包插件

```xml
    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.11.0</version>
                <configuration>
                    <source>${java.version}</source>
                    <target>${java.version}</target>
                    <encoding>UTF-8</encoding>
                    <!--主要代码就在这里 -->
                    <annotationProcessorPaths>
                        <!-- Lombok 在编译时会通过这个插件生成代码 -->
                        <path>
                            <groupId>org.projectlombok</groupId>
                            <artifactId>lombok</artifactId>
                            <version>1.18.24</version>
                        </path>
                        <!-- MapStruct 在编译时会通过这个插件生成代码 -->
                        <path>
                            <groupId>org.mapstruct</groupId>
                            <artifactId>mapstruct-processor</artifactId>
                            <version>${mapstruct.version}</version>
                        </path>
                    </annotationProcessorPaths>
                </configuration>
            </plugin>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
                <version>${spring-boot.version}</version>
                <configuration>
                    <excludes>
                        <exclude>
                            <groupId>org.projectlombok</groupId>
                            <artifactId>lombok</artifactId>
                        </exclude>
                    </excludes>
                </configuration>
            </plugin>
        </plugins>
    </build>
```





