package cn.poile.blog.common.security;

import cn.poile.blog.common.filter.AuthorizationTokenFilter;
import cn.poile.blog.common.security.CustomAccessDeniedHandler;
import cn.poile.blog.common.security.CustomAuthenticationEntryPoint;
import cn.poile.blog.common.sms.SmsCodeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

/**
 * 安全配置
 *
 * @author: yaohw
 * @create: 2019-10-24 16:17
 **/
@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {


    @Autowired
    private UserDetailsService userDetailsService;

    @Autowired
    private AuthorizationTokenFilter authorizationTokenFilter;

    @Autowired
    private SmsCodeService smsCodeService;


    /**
     * 配置认证管理器
     *
     * @return
     * @throws Exception
     */
    @Bean
    @Override
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }

    /**
     * 这里是对认证管理器的添加配置
     *
     * @param auth
     * @throws Exception
     */
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.authenticationProvider(provider())
                .userDetailsService(userDetailsService)
                .passwordEncoder(passwordEncoder());
    }

    /**
     * 配置密码加密对象（解密时会用到PasswordEncoder的matches判断是否正确）
     * 用户的password用到，所以存的时候存该bean encode过的密码
     *
     * @return
     */
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }


    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.cors()
                .and()
                .csrf().disable()
                .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                .and()
                .authorizeRequests()
                .antMatchers("/account/login", "/mobile/login","/websocket", "/user/register", "/sms/**", "/file/**", "/v2/api-docs", "/swagger/api-docs", "/swagger-resources/**", "/swagger-ui.html", " /webjars/**").permitAll()
                .anyRequest().authenticated()
                .and()
                .logout().logoutRequestMatcher(new AntPathRequestMatcher("/logout", "GET"));
        http.exceptionHandling()
                .authenticationEntryPoint(new CustomAuthenticationEntryPoint())
                .accessDeniedHandler(new CustomAccessDeniedHandler());
        http.addFilterBefore(authorizationTokenFilter, UsernamePasswordAuthenticationFilter.class);
    }

    @Override
    public void configure(WebSecurity web) {
        web
                .ignoring()
                .antMatchers(
                        HttpMethod.GET,
                        "/",
                        "/*.html",
                        "/favicon.ico",
                        "/**/*.html",
                        "/**/*.css",
                        "/**/*.js"
                );
    }

    /**
     * 自定义手机验证码认证提供者
     *
     * @return
     */
    @Bean
    public MobileCodeAuthenticationProvider provider() {
        MobileCodeAuthenticationProvider provider = new MobileCodeAuthenticationProvider();
        provider.setSmsCodeService(smsCodeService);
        provider.setUserDetailsService(userDetailsService);
        return provider;
    }
}

