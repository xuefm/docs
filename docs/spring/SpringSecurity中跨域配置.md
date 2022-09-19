使用 spring Security 导致spring mvc 的跨域配置无效

spring Security提供以下配置方法

httpSecurity.cors().configurationSource(CorsConfigurationSource configurationSource);

示例

```java
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity httpSecurity) throws Exception {
        return httpSecurity
                // 关闭
                .csrf()
                .disable()
                //关闭session
                .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                .and()
                //认证相关
                .authorizeRequests()
                //允许匿名访问
                .antMatchers("/user/login")
                .permitAll()
				//.anonymous()
                //其他请求 认证后都能访问
                .anyRequest().authenticated()
                .and()
                //添加认证过滤器 在UsernamePasswordAuthenticationFilter之前
                .addFilterBefore(jwtAuthenticateFilter, UsernamePasswordAuthenticationFilter.class)
                //跨域配置
                .cors()
                .configurationSource(configurationSource())
                .and()
                .build();
    }

	/**
     * 跨域配置
     * @return
     */
   private CorsConfigurationSource configurationSource() {
        CorsConfiguration corsConfiguration = new CorsConfiguration();
        corsConfiguration.setAllowedHeaders(Collections.singletonList("*"));
        corsConfiguration.setAllowedMethods(Collections.singletonList("*"));
        corsConfiguration.setAllowedOrigins(Collections.singletonList("*"));
        corsConfiguration.setMaxAge(3600L);

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", corsConfiguration);
        return source;
    }
```