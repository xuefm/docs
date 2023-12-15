## 介绍

在Redis中实现消息队列的广播模式（发布/订阅模式），可以使用Redis的发布（PUBLISH）和订阅（SUBSCRIBE）功能。

以下是广播模式的实现步骤：

1. 创建一个订阅者（Subscriber）并订阅频道（Channel）：

   ```bash
   SUBSCRIBE channel_name
   ```

2. 创建发布者（Publisher）并向指定频道发布消息：

   ```bash
   PUBLISH channel_name message
   ```

3. 订阅者会在频道有新消息发布时接收到消息。

通过这种方式，可以实现消息的广播，即一个发布者发布的消息会被所有订阅该频道的订阅者接收到。

需要注意的是，Redis的发布/订阅模式是一种异步的消息传递方式，并不保证消息的可靠性传递。如果需要确保消息的可靠性传递、持久化等更复杂的特性，可能需要考虑使用其他消息队列系统，如RabbitMQ、Kafka等。

## Spring boot代码

### 消息处理器

```java
import org.springframework.stereotype.Component;

@Component
public class RedisMessageListener {

    public void handleChannel1Message(String message) {
        // 处理接收到的channel1频道消息
        System.out.println("Received channel1 message: " + message);
    }

    public void handleChannel2Message(String message) {
        // 处理接收到的channel2频道消息
        System.out.println("Received channel2 message: " + message);
    }

    public void handleChannel3Message(String message) {
        // 处理接收到的channel3频道消息
        System.out.println("Received channel3 message: " + message);
    }
}
```

### 配置监听

```java
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.listener.ChannelTopic;
import org.springframework.data.redis.listener.RedisMessageListenerContainer;
import org.springframework.data.redis.listener.adapter.MessageListenerAdapter;

@Configuration
public class MyRedisConfig {

    @Bean
    public RedisMessageListenerContainer redisMessageListenerContainer(RedisConnectionFactory connectionFactory, MessageListenerAdapter channel1ListenerAdapter, MessageListenerAdapter channel2ListenerAdapter, MessageListenerAdapter channel3ListenerAdapter) {
        RedisMessageListenerContainer container = new RedisMessageListenerContainer();
        container.setConnectionFactory(connectionFactory);
        container.addMessageListener(channel1ListenerAdapter, new ChannelTopic("channel1"));
        container.addMessageListener(channel2ListenerAdapter, new ChannelTopic("channel2"));
        container.addMessageListener(channel3ListenerAdapter, new ChannelTopic("channel3"));
        return container;
    }

    @Bean
    public MessageListenerAdapter channel1ListenerAdapter(RedisMessageListener redisMessageListener) {
        return new MessageListenerAdapter(redisMessageListener, "handleChannel1Message");
    }

    @Bean
    public MessageListenerAdapter channel2ListenerAdapter(RedisMessageListener redisMessageListener) {
        return new MessageListenerAdapter(redisMessageListener, "handleChannel2Message");
    }

    @Bean
    public MessageListenerAdapter channel3ListenerAdapter(RedisMessageListener redisMessageListener) {
        return new MessageListenerAdapter(redisMessageListener, "handleChannel3Message");
    }


}
```

### 发送消息

```java
@Autowired
private RedisTemplate<String, String> redisTemplate;

public void publishMessage(String message) {
    redisTemplate.convertAndSend("channel_name", message);
}
```

