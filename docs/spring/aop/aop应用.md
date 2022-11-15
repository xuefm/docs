### 打印入参数和出参

参数打印借助 swagger的ApiOperation注解（可根据情况自定义注解或去除相关部分）

```java
package com.zk.supplychain.aop;

import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONUtil;
import com.alibaba.fastjson.JSONObject;
import com.zk.supplychain.util.WebUtils;
import com.zk.supplychain.webdata.R;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.stereotype.Component;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

@Aspect
@Component
@Slf4j
@AllArgsConstructor
public class LogAspect {

    private final RequestsLimitingService requestsLimitingService;


    @Pointcut("@annotation(io.swagger.annotations.ApiOperation)")
    public void pointcut() {
    }

    /**
     * 环绕通知
     * @param joinPoint
     * @return
     * @throws Throwable
     */
    @Around("pointcut()")
    public Object execParamLogAspect(ProceedingJoinPoint joinPoint) throws Throwable {

        // 如果停用日志打印，则直接执行原有代码逻辑，跳过打印日志
        if (false) {
            return joinPoint.proceed();
        }
        long startingTime = System.currentTimeMillis();
        // 如果启用日志分析，则获取方法上的注解信息，并打印方法入参出参
        Method method = this.getMethod(joinPoint);
        //包
        String pack=method.getDeclaringClass().getName();
        //方法名
        String methodName=method.getName();
        //拼接包和方法
        String str= StrUtil.format("{}.{}",pack,methodName);
        //传入的参数
        Object[] args = joinPoint.getArgs();
        //借用swagger注解
        ApiOperation apiOperation = method.getAnnotation(ApiOperation.class);
        if (Objects.nonNull(apiOperation)){
            String apiOperationValue = apiOperation.value();
            str=StrUtil.format("{}---------->[{}]",str,apiOperationValue);
        }
        //防止重复请求
        DisallowRepeatedRequests disallowRepeatedRequests = method.getAnnotation(DisallowRepeatedRequests.class);
        if (Objects.nonNull(disallowRepeatedRequests)){
            Boolean requestCharacteristic = requestsLimitingService.getRequestCharacteristic(disallowRepeatedRequests, joinPoint);
            if (!requestCharacteristic){
                HttpServletResponse response = WebUtils.getResponse();
                response.setContentType("application/json;charset=UTF-8");
                ServletOutputStream outputStream = null;
                R<Object> r = R.failed("9999", "请勿重复操作");
                try {
                    outputStream = response.getOutputStream();
                    outputStream.write(JSONUtil.parseObj(r,false).toString().getBytes("UTF-8"));
                } catch (IOException e) {
                    e.printStackTrace();
                } finally {
                    outputStream.flush();
                    outputStream.close();
                    // 打印出参
                    this.printResult(str, r);
                    log.info("本次请求响应时间为:[{}]",System.currentTimeMillis()-startingTime);
                    return null;
                }

            }
        }

        // 打印入参
        this.printParam(str, args);
        // 执行原有方法逻辑
        Object result = joinPoint.proceed();
        // 打印出参
        this.printResult(str, result);
        log.info("本次请求响应时间为:[{}]",System.currentTimeMillis()-startingTime);
        return result;
    }

    private Method getMethod(JoinPoint jp) throws Exception {
        MethodSignature methodSignature = (MethodSignature) jp.getSignature();
        Method method = methodSignature.getMethod();
        return jp.getTarget().getClass().getDeclaredMethod(method.getName(), method.getParameterTypes());
    }



    /**
     * 打印入参
     * @param key  方法名称
     * @param args 参数
     */

    private void printParam(String key, Object[] args) {
        if (log.isInfoEnabled()) {
            if (args.length!=0){
            log.info("{}方法入参为：\n{}", key, JSONUtil.toJsonPrettyStr(args));
            }else {
                log.info("{}方法无参数传入",key);
            }
        }
    }


    /**
     * 打印出参
     * @param key    方法名称
     * @param result 方法返回值
     */

    private void printResult(String key, Object result) {
        if (log.isInfoEnabled()) {
            try{
                cn.hutool.json.JSONObject jsonObject = JSONUtil.parseObj(result, false,true);
                //如果不是json则为部包一层data
                if (jsonObject.size()==0){
                    Map<String,Object> map =new HashMap<>();
                    map.put("data",result);
                    jsonObject=JSONUtil.parseObj(map, false,true);
                }
                String JsonData=JSONUtil.toJsonPrettyStr(jsonObject);
                log.info("{}方法出参为：\n{}", key, JsonData);

            }catch (Exception e){
                log.info("{}方法出参为：\n{}", key, JSONObject.toJSONString(result,true));
            }


        }
    }


}


```





### 防止短时间内重复请求

自定义注解

```java
package com.zk.supplychain.aop;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 禁止重复请求
 */
@Target({ElementType.METHOD, ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
public @interface DisallowRepeatedRequests {

    /**
     * 间隔时间(毫秒) 默认 1000
     */
    long interval() default 1000;


}
```





```java
package com.zk.supplychain.aop;

import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.SecureUtil;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.zk.supplychain.util.WebUtils;
import lombok.AllArgsConstructor;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;
import java.util.Date;
import java.util.concurrent.TimeUnit;

@Service
@Slf4j
@AllArgsConstructor
public class RequestsLimitingService {

    private final StringRedisTemplate stringRedisTemplate;

    /**
     *
     * @param joinPoint aop环绕通知参数
     * @return
     */
    @SneakyThrows
    public Boolean getRequestCharacteristic(DisallowRepeatedRequests disallowRepeatedRequests,ProceedingJoinPoint joinPoint){
        // 如果启用日志分析，则获取方法上的注解信息，并打印方法入参出参
        Method method = this.getMethod(joinPoint);
        //包
        String pack=method.getDeclaringClass().getName();
        //方法名
        String methodName=method.getName();
        //拼接包和方法
        String str= StrUtil.format("{}.{}",pack,methodName);
        //传入的参数
        Object[] args = joinPoint.getArgs();
        HttpServletRequest request = WebUtils.getRequest();
        String uri = request.getRequestURI();
        String ip = WebUtils.getIpAddr();
        String accountId = WebUtils.getAccountId();
        JSONObject obj = JSONUtil.createObj();
        obj.set("methodName",str);
        obj.set("parameter",args);
        obj.set("uri",uri);
        obj.set("ip",ip);
        obj.set("accountId",accountId);
        String s = obj.toString();
        String tag = SecureUtil.md5(s);
        String redisKeyTemplate="RequestsLimiting:"+tag+"";
        Date date = new Date();
        Boolean allowRequest = stringRedisTemplate.opsForValue().setIfAbsent(redisKeyTemplate, String.valueOf(date.getTime()),disallowRepeatedRequests.interval(), TimeUnit.MILLISECONDS);
        return allowRequest;
    }

    private Method getMethod(JoinPoint jp) throws Exception {
        MethodSignature methodSignature = (MethodSignature) jp.getSignature();
        Method method = methodSignature.getMethod();
        return jp.getTarget().getClass().getDeclaredMethod(method.getName(), method.getParameterTypes());
    }
}
```