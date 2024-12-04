package com.synergisticit.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;


@Configuration
@EnableWebSecurity
public class SercurityConfig {

    @Autowired
    UserDetailsService u;

    @Autowired
    AuthenticationSuccessHandler authSuccessHandler;

    @Autowired
    AccessDeniedHandler accessDeniedHandler;


    @Bean
    SecurityFilterChain filterChain(HttpSecurity http) throws Exception{
        //http.authorizeHttpRequests().anyRequest().permitAll(); //bypasses all the http security.



        http.csrf().disable()
                .authorizeRequests()
                .requestMatchers("/", "/home","/userForm","/driverForm","/autoPlan").permitAll().and()
                .exceptionHandling().accessDeniedPage("/accessDeniedPage").and()
                .authorizeRequests()
                .requestMatchers("/driverForm","/documentForm","/claimForm").hasAnyAuthority("User","Admin").and()
                .formLogin()
                .loginPage("/login")
                .defaultSuccessUrl("/home").permitAll().and()
                .logout()
                .logoutSuccessUrl("/home")
                .invalidateHttpSession(true)
                .deleteCookies("JSESSIONID")
                .permitAll();

        return http.build();
    }
}
