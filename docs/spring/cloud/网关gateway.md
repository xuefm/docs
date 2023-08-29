

### 1.pom

```xml
<!--gateway-->
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-gateway</artifactId>
</dependency>
<!--由于springcloud2020弃用了Ribbon，因此Alibaba在2021版本nacos中删除了Ribbon的jar包，因此无法通过lb路由到指定微服务，出现了503情况。
所以只需要引入springcloud loadbalancer包即可-->
<!--客户端负载均衡loadbalancer-->
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-loadbalancer</artifactId>
</dependency>
```

### 2.yml

```yml
info:
  name: ${spring.application.name}
  version: ${project.version}
  description: ${project.description}
  port: ${server.port}


server:
  port: 10010

spring:
  application:
    name: gateway
  cloud:
    nacos:
      discovery:
        server-addr: 127.0.0.1:8848
    gateway:
      discovery:
        locator:
          enabled: true
  main:
    web-application-type: reactive
logging:
  level:
    com.expect.user.feign.*: debug


```

### 3.转发配置

```java
import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.cloud.gateway.route.builder.RouteLocatorBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class GatewayConfig {
    @Bean
    public RouteLocator customRouteLocator(RouteLocatorBuilder builder) {
        return builder.routes()
                .route("auth-service", r -> r.path("/auth/**")
                        .uri("lb://auth-service"))
                .route("file-service", r -> r.path("/file/**")
                        .uri("lb://file-service"))
                .route("websocket-service", r -> r.path("/websocket/**")
                        .uri("lb://websocket-service"))
                .build();
    }
```



### 4.跨域配置

#### 4.1 Spring Gateway使用WebFlux之前只需配置此项即可

```java
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.reactive.CorsWebFilter;
import org.springframework.web.cors.reactive.UrlBasedCorsConfigurationSource;
import org.springframework.web.util.pattern.PathPatternParser;

/**
 * 跨域配置
 */
@Configuration
public class CorsConfig  {


    @Bean
    public CorsWebFilter corsFilter() {
        CorsConfiguration config = new CorsConfiguration();
        config.addAllowedMethod("*");  // 是什么请求方法，比如GET POST PUT DELATE ...
        config.addAllowedOrigin("*");  // 来自哪个域名的请求，*号表示所有
        config.addAllowedHeader("*");  // 是什么请求头部
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource(new PathPatternParser());
        source.registerCorsConfiguration("/**", config);

        return new CorsWebFilter(source);
    }
}
```

#### 4.2 Spring Gateway使用WebFlux后还需添加一下配置

> > 原因：由于Netty的bug 请求头会重复，所以需要自己写方法去掉重复的返回头

```java
import lombok.extern.slf4j.Slf4j;
import org.slf4j.MDC;
import org.springframework.cloud.gateway.filter.GatewayFilterChain;
import org.springframework.cloud.gateway.filter.GlobalFilter;
import org.springframework.cloud.gateway.filter.NettyWriteResponseFilter;
import org.springframework.core.Ordered;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

import java.util.Optional;
import java.util.Set;

@Slf4j
@Component("corsResponseHeaderFilter")
public class CorsRemoveHeaderFilter implements GlobalFilter, Ordered {


    @Override
    public int getOrder() {
        return NettyWriteResponseFilter.WRITE_RESPONSE_FILTER_ORDER + 21;
    }

    @Override
    public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {
        Optional.ofNullable(MDC.get(Constants.TraceId)).ifPresent((t) -> {
            exchange.getResponse().getHeaders().add(Constants.TraceId, t);
        });

        return chain.filter(exchange).then(Mono.defer(() -> {
            //移除重复的返回头
            HttpHeaders rpsHeaders = exchange.getResponse().getHeaders();
            Set<String> headers =  Constants.headers();
            for (String header : headers) {
                if(rpsHeaders.containsKey(header)) {
                    String value = rpsHeaders.getFirst(header);
                    exchange.getResponse().getHeaders().remove(header);
                    if (Constants.Access_Control_Allow_Methods.equals(header)) {
                        value = Constants.ACCESS_CONTROL_ALLOW_METHODS_VALUE;
                    }
                    exchange.getResponse().getHeaders().set(header, value);
                }
            }
            return chain.filter(exchange);
        }));
    }
}

```

常量

```java
package com.expect.cloudgateway.data;

import java.util.HashSet;
import java.util.Set;

public class Constants {

    public static final String ORIGIN = "Origin";
    public static final String Access_Control_Allow_Origin = "Access-Control-Allow-Origin";
    public static final String Access_Control_Allow_Credentials = "Access-Control-Allow-Credentials";
    public static final String Access_Control_Allow_Methods = "Access-Control-Allow-Methods";
    public static final String Access_Control_Request_Headers = "Access-Control-Request-Headers";
    public static final String Access_Control_Allow_Headers = "Access-Control-Allow-Headers";
    public static final String TraceId = "X-B3-TraceId";
    public static final String X_FRAME_OPTIONS = "X-Frame-Options";
    public static final String X_XSS_Protection = "X-XSS-Protection";
    public static final String VARY = "Vary";
    public static final String ACCESS_CONTROL_ALLOW_METHODS_VALUE ="GET,POST,PUT,DELETE,OPTIONS";


    public static Set<String> headers = new HashSet<>();

    static {
        headers.add(Access_Control_Allow_Origin);
        headers.add(Access_Control_Allow_Credentials);
        headers.add(Access_Control_Allow_Methods);
        headers.add(Access_Control_Request_Headers);
        headers.add(Access_Control_Allow_Headers);
        headers.add(VARY);
        headers.add(TraceId);
        headers.add(X_FRAME_OPTIONS);
        headers.add(X_XSS_Protection);
    }

    public static Set<String> headers(){
        return headers;
    }

}
```

