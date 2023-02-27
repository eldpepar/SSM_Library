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