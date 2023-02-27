package com.eldpepar.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

@Configuration
@ComponentScan({"com.eldpepar.controller","com.eldpepar.config"})
@EnableWebMvc
public class SpringMvcConfig {

}
