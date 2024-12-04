package com.synergisticit.config;


import com.fasterxml.jackson.databind.util.Converter;
import com.synergisticit.domain.*;
import com.synergisticit.service.InformEmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;
;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.firewall.StrictHttpFirewall;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.templateresolver.ClassLoaderTemplateResolver;

import javax.sql.DataSource;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Properties;

@Configuration
public class AppConfig {
	@Value("${FILE_PATH}")
	private String path;

	@Autowired DataSource dataSource;
	
	/*
	@Bean
	public DataSource dataSource() {
		DriverManagerDataSource dataSource = new DriverManagerDataSource();
		dataSource.setUrl("jdbc:mysql://localhost:3306/deedb?useSSL=false&serverTimezone=UTC");
		dataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");
		dataSource.setUsername("root");
		dataSource.setPassword("admin");
		return dataSource;
	}
	*/



	@Bean
	@Primary
	public LocalContainerEntityManagerFactoryBean entityManagerFactory() {
		LocalContainerEntityManagerFactoryBean entityManager = new LocalContainerEntityManagerFactoryBean();
		
		entityManager.setDataSource(dataSource);
		//entityManager.setDataSource(dataSource());
		entityManager.setPackagesToScan("com.synergisticit.domain");
		
		entityManager.setJpaVendorAdapter(new HibernateJpaVendorAdapter());
		entityManager.setJpaProperties(properties());
		return entityManager;
	}
	
	public Properties properties() {
		Properties p = new Properties();
		p.setProperty("hibernate.hbm2ddl.auto", "update");
		
		//'hibernate.dialect' (remove the property setting and it will be selected by default)
		p.setProperty("hibernate.dialect", "org.hibernate.dialect.MySQL8Dialect");
		return p;
	}
	
	@Bean
	public LocalSessionFactoryBean sessionFactory() {
		LocalSessionFactoryBean sessionFactory = new LocalSessionFactoryBean();
		
		sessionFactory.setDataSource(dataSource);
		//sessionFactory.setDataSource(dataSource());
		sessionFactory.setAnnotatedPackages("com.synergisticit.domain");
		sessionFactory.setAnnotatedClasses(User.class, Role.class);
		sessionFactory.setHibernateProperties(properties());
		return sessionFactory;
	}
	
	@Bean
	public ViewResolver viewResolver() {
		 InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
		 viewResolver.setPrefix("WEB-INF/jsp/");
		 viewResolver.setSuffix(".jsp");
		 return  viewResolver;
	}
	
	@Bean
	public MessageSource messageSource() {
		ReloadableResourceBundleMessageSource messageSource = new ReloadableResourceBundleMessageSource();
		messageSource.setBasename("WEB-INF/message/messages");
		
		return messageSource;
	}

	@Bean
	BCryptPasswordEncoder bCryptPasswordEncoder(){
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		return encoder;
	}

	@Bean
	public TemplateEngine templateEngine() {
		return new TemplateEngine();
	}

	@Bean
	public InformEmailService informEmailService() {
		return new InformEmailService(); // Assuming InformEmailServiceImpl is the implementation class
	}

	@Configuration
	public class WebConfig implements WebMvcConfigurer {
		@Override
		public void addResourceHandlers(ResourceHandlerRegistry registry) {
			registry.addResourceHandler("/files/**")
					.addResourceLocations("file:/Users/aileen/MyProjects/JQUERY/Project2/Project-2/AutoInsurance/");
		}


	}


	
}
