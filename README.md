# 黑马SSM整合图书馆项目

### 项目介绍
项目后端使用了Spring，SpringMVC，Mybatis框架，前端使用了Vue框架。项目实现了简单的CRUD操作，使用Junit进行了功能测试，使用postman测试接口的功能是否正常。项目需要安装maven helper插件，黑马视频里没有介绍。项目使用的是maven插件来运行tomcat，操作和之前的JavaWeb项目相同。操作方法如下

[JavaWeb第5篇项目实战](https://www.eldpepar.com/coding/46368/)

[项目地址](https://github.com/eldpepar/SSM_Library)

### 工作原理
客户端发送请求到DispacherServlet（前端控制器），DispatcherServlet 是 Spring MVC 中的前端控制器，也是 Spring MVC 内部非常核心的一个组件，负责 Spring MVC 请求的调度。当 Spring MVC 接收到用户的 HTTP 请求之后，会由 DispatcherServlet 进行截获，然后根据请求的 URL 初始化 WebApplicationContext（上下文信息），最后转发给业务的 Controller 进行处理。

### 配置分析
1.首先需要实现AbstractDispatcherServletInitializer抽象类的方法，该抽象类需要实现如下的方法。这个配置类就相当于 web.xml 的功能，当 Tomcat 启动的时候自动加载 Spring 和 SpringMVC 的配置类，初始化容器。
```java
    //这里需要返回Spring的核心配置
    @Override
    protected Class<?>[] getRootConfigClasses() {
        return new Class[]{SpringConfig.class};
    }

    //这里需要返回SpringMVC的核心配置
    @Override
    protected Class<?>[] getServletConfigClasses() {
        return new Class[]{MvcConfig.class};
    }

    //这里设置的是需要过滤的路径
    @Override
    protected String[] getServletMappings() {
        return new String[]{"/"};
    }

    //控制台乱码处理
    @Override
    protected Filter[] getServletFilters() {
        CharacterEncodingFilter filter = new CharacterEncodingFilter();
        filter.setEncoding("UTF-8");
        return new 
```

2.设置mvc的控制类，需要标记该类是控制类，并且扫描到ServletConfig的配置类和controller接口。这里只需要扫描对应的包即可，不要忘记开启mvc注解
```java
@Configuration
@ComponentScan({"com.eldpepar.controller","com.eldpepar.config"})
@EnableWebMvc
public class SpringMvcConfig {

}
```

3.如果有静态资源需要加载，则要设置WebMvcConfiguration，这里是实现了WebMvcConfigurationSupport接口
```java
@Configuration
public class SpringMvcSupport extends WebMvcConfigurationSupport {
    @Override
    protected void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/pages/**").addResourceLocations("/pages/");
        registry.addResourceHandler("/css/**").addResourceLocations("/css/");
        registry.addResourceHandler("/js/**").addResourceLocations("/js/");
        registry.addResourceHandler("/plugins/**").addResourceLocations("/plugins/");
    }
}
```

4.设置spring的核心配置，spring核心配置类主要工作是将myabatis的加载过程交给spirng来控制。这里需要使用@Import导入jdbc和mybatis的相关配置。同时需要使用@PropertySource设置数据源，需要加上classpath才能加载。通过@ComponentScan装配service。

**spring核心配置**
```java
@Configuration
@ComponentScan({"com.eldpepar.service"})
@PropertySource("classpath:jdbc.properties")
@Import({JdbcConfig.class, MybatisConfig.class})
@EnableTransactionManagement
public class SpringConfig {

}
```

**jdbc核心配置**
在jdbc的核心配置中，需要指定数据源，使用@Value注解读取相关的配置。同时需要配置事务管理器
```java
public class JdbcConfig {
    @Value("${jdbc.driver}")
    private String driver;
    @Value("${jdbc.url}")
    private String url;
    @Value("${jdbc.username}")
    private String username;
    @Value("${jdbc.password}")
    private String password;

    @Bean
    public DataSource dataSource() {
        DruidDataSource dataSource = new DruidDataSource();
        dataSource.setDriverClassName(driver);
        dataSource.setUrl(url);
        dataSource.setUsername(username);
        dataSource.setPassword(password);
        return dataSource;
    }

    @Bean
    public PlatformTransactionManager transactionManager(DataSource dataSource) {
        DataSourceTransactionManager ds = new DataSourceTransactionManager();
        ds.setDataSource(dataSource);
        return ds;
    }
}
```

**mybatis核心配置**
核心配置中需要使用SqlSessionFactoryBean来指定数据源和需要映射的domain包，并且需要使用MapperScannerConfigurer扫描dao
```java
public class MybatisConfig {

    @Bean
    public SqlSessionFactoryBean sqlSessionFactory(DataSource dataSource) {
        SqlSessionFactoryBean factoryBean = new SqlSessionFactoryBean();
        factoryBean.setDataSource(dataSource);
        factoryBean.setTypeAliasesPackage("com.eldpepar.domain");
        return factoryBean;
    }

    @Bean
    public MapperScannerConfigurer mapperScannerConfigurer() {
        MapperScannerConfigurer msc = new MapperScannerConfigurer();
        msc.setBasePackage("com.eldpepar.dao");
        return msc;
    }
}
```

5.

### 部署指南
如果导入maven依赖比较慢，需要更换maven源，操作方法如下所示(该文章同时也写了前端项目依赖导入问题的解决方案)

[各类依赖导入过慢问题解决方案](https://www.eldpepar.com/deploy/5460/)

运行如下sql代码，即可创建相关数据库、数据表、插入相关的数据
```SQL
create database ssm_db;
use ssm_db;
create table tbl_book
(
    id          int primary key auto_increment,
    type        varchar(20),
    `name`      varchar(50),
    description varchar(255)
);

insert into `tbl_book`(`id`, `type`, `name`, `description`)
values (1, '计算机理论', 'Spring实战 第五版', 'Spring入门经典教程，深入理解Spring原理技术内幕'),
       (2, '计算机理论', 'Spring 5核心原理与30个类手写实践', '十年沉淀之作，手写Spring精华思想'),
       (3, '计算机理论', 'Spring 5设计模式', '深入Spring源码刨析Spring源码中蕴含的10大设计模式'),
       (4, '计算机理论', 'Spring MVC+Mybatis开发从入门到项目实战',
        '全方位解析面向Web应用的轻量级框架，带你成为Spring MVC开发高手'),
       (5, '计算机理论', '轻量级Java Web企业应用实战', '源码级刨析Spring框架，适合已掌握Java基础的读者'),
       (6, '计算机理论', 'Java核心技术 卷Ⅰ 基础知识(原书第11版)',
        'Core Java第11版，Jolt大奖获奖作品，针对Java SE9、10、11全面更新'),
       (7, '计算机理论', '深入理解Java虚拟机', '5个纬度全面刨析JVM,大厂面试知识点全覆盖'),
       (8, '计算机理论', 'Java编程思想(第4版)', 'Java学习必读经典，殿堂级著作！赢得了全球程序员的广泛赞誉'),
       (9, '计算机理论', '零基础学Java(全彩版)', '零基础自学编程的入门图书，由浅入深，详解Java语言的编程思想和核心技术'),
       (10, '市场营销', '直播就这么做:主播高效沟通实战指南', '李子柒、李佳奇、薇娅成长为网红的秘密都在书中'),
       (11, '市场营销', '直播销讲实战一本通', '和秋叶一起学系列网络营销书籍'),
       (12, '市场营销', '直播带货:淘宝、天猫直播从新手到高手', '一本教你如何玩转直播的书，10堂课轻松实现带货月入3W+');
```

如果properties文件中的相关配置有所不同请更换为本地的配置，下面是参考配置。项目运行方法可参考前面提到的JavaWeb第5篇项目实战这篇文章
```
jdbc.driver=com.mysql.jdbc.Driver
jdbc.url=jdbc:mysql://localhost:3306/ssm_db?serverTimezone=GMT&useUnicode=true&characterEncoding=utf8&autoReconnect=true&useSSL=false
jdbc.username=root
jdbc.password=123456
```
