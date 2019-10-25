

# 要点

- **SQL查询总结**

```mysql
    3、select ...聚合函数 from 表名
    1、where ...
    2、group by ...
    4、having ...
    5、order by ...
    6、limit ...;
```

- **聚合函数（铁三角之一）**

avg(...) sum(...) max(...) min(...) 
count(字段名)  # 空值NULL不会被统计

- **group by（铁三角之二）**

给查询结果进行分组
如果select之后的字段名和group by之后的字段不一致,则必须对该字段进行聚合处理(聚合函数)

- **having语句（铁三角之三）**

对查询的结果进行进一步筛选
**注意**
1、having语句通常和group by语句联合使用,过滤由group by语句返回的记录集
2、where只能操作表中实际存在字段,having可操作由聚合函数生成的显示列

- **distinct** 

select distinct 字段1,字段2 from 表名;

- **查询时做数学运算**

select 字段1*2,字段2+5 from 表名;

update 表名 set attack=attack*2 where 条件;

- **索引(BTree)**

优点 ：加快数据检索速度
缺点 ：占用物理存储空间,需动态维护,占用系统资源
SQL命令运行时间监测

		mysql>show variables like '%pro%';
	
		1、开启 ：mysql> set profiling=1;
		2、查看 ：mysql> show profiles;
		3、关闭 ：mysql> set profiling=0;

- **普通(MUL)、唯一(UNI,字段值不能重复,可为NULL)**

  **创建**
  		index(字段名),index(字段名)
  		unique(字段名),unique(字段名)
  		create [unique] index 索引名 on 表名(字段名);

  **查看**
  		desc 表名;
  		show index from 表名\G;  
  			Non_Unique:1 :index
  			Non_Unique:0 :unique

  **删除**
  		drop index 索引名 on 表名; (只能一个一个删)

## **外键**

**原理** 

```
让当前表字段的值在另一张表的范围内去选择
```

**使用规则**

```mysql
1、数据类型要一致
2、主表被参考字段必须为KEY的一种 : PRI
```

**级联动作**

```mysql
1、cascade : 删除 更新同步(被参考字段)
2、restrict(默认) : 不让主表删除 更新
3、set null : 删除 更新,从表该字段值设置为NULL
```

## **嵌套查询（子查询）**

**定义**

```
把内层的查询结果作为外层查询的条件
```

## **多表查询**

**笛卡尔积**

```
多表查询不加where条件,一张表的每条记录分别和另一张表的所有记录分别匹配一遍
```

## **连接查询**

**分类**

```mysql
1、内连接（表1 inner join 表2 on 条件）
2、外连接（表1 left|right join 表2 on 条件）
	1、左连接 ：以左表为主显示查询结果
	2、右连接 ：以右表为主显示查询结果
```

**语法**

```mysql
select 表名.字段名 from 表1 inner join 表2 on 条件；
```

## **数据导入**

**方式一（使用source命令）**

```mysql
mysql> source /home/tarena/xxx.sql
```

**方式二（使用load命令）**

```mysql
1、将导入文件拷贝到数据库搜索路径中
   show variables like 'secure%';
2、在数据库中创建对应的表
3、执行数据导入语句
```

## **索引**

**定义**

```
对数据库表中一列或多列的值进行排序的一种结构(BTree)
```

**优点**

```mysql
加快数据的检索速度
```

**缺点**

```mysql
1、占用实际物理存储空间
2、索引需动态维护，消耗资源，降低数据的维护速度
```

**分类及约束**

```mysql
1、普通索引（MUL）: 无约束
2、唯一索引（UNI）：字段值不允许重复，但可为NULL
3、主键（PRI）	：字段值不允许重复，不可为NULL
4、外键		 ：让当前表字段的值在另一张表的范围内选择
```

## **1、数据库概念**

**数据库**

- 存储数据的仓库（逻辑概念，并未真实存在）

**数据库软件**

- 真实软件，用来实现数据库这个逻辑概念

**数据仓库**

- 数据量更加庞大，更加侧重数据分析和数据挖掘，供企业决策分析之用，主要是数据查询，修改和删除很少

```
内存存储比磁盘存储快，MySQL基于磁盘存储。数据是以文件形式存放在数据库目录/var/lib/mysql下
查看sql是否已启动 ps -aux|grep 'mysql' 
```

## 2、MySQL的特点

- 关系型数据库
- 跨平台
- 支持多种编程语言（python、java、php）
- 基于磁盘存储，数据是以文件形式存放在数据库目录/var/lib/mysql下

## **3、启动连接**

- 服务端启动 

```mysql
sudo /etc/init.d/mysql start|stop|restart|status
sudo service mysql start|stop|restart|status
```

- 客户端连接

```mysql
mysql -hIP地址 -u用户名 -p密码
本地连接可省略 -h 选项
```



## **4、基本SQL命令**

### **库管理**

```mysql
    1、查看已有库；
   		mysql -u root -p 123456
   		show databases;
   		
    2、创建库并指定字符集；
		create database 库名 charset utf8;
		
    3、查看当前所在库；
      	select database();
      
    4、切换库；
      	use 库名;
      
      
    5、查看库中已有表；
      	show tables
      
      
    6、删除库；
      
      drop database 库名
      
```

### **表管理**

```
create table sanguo (
id int primary key auto_increment,
name varchar(32),
attack int ,
defense int ,
gender varchar(32),
country varchar(32)
)charset=utf8;
```

```
    --设置此表中的o_id字段为customers表中c_id字段的外键,更新删除同步。
    -- drop table orders;
        create table orders(
        o_id int,
        o_name varchar(30),
        o_price decimal(12,2),
        foreign key(o_id) references customers(c_id) on delete cascade on update cascade 
        )charset=utf8;
        insert into orders values(1,"iphone",5288),(1,"ipad",3299),(2,"iwatch",2222),(2,"r11",4400);
```

```
添加id字段,要求主键自增长,显示宽度为3,位数不够用0填充alter table scoretab add id int(3) zerofill primary key auto_increment first;
​```
```

```mysql
    1、创建表并指定字符集；
    	create table 表名(字段名 类型 xxx)charset=utf8;

    2、查看创建表的语句 (字符集、存储引擎)；
      	show create table 标名
      
    3、查看表结构;
      	desc 标名
      	
    4、删除表;
		drop table 表名1,表名2      
```

### 表记录管理

```mysql
    1、增 ： insert into sanguo values(1,'诸葛亮',101,95,'男','蜀国'),(2,'赵云',401,75,'男','蜀国'); 
    2、删 ： delete from 表名 where 条件
    3、改 ： update 表名 set 字段名=值 where 条件
    4、查 ： select 字段名 或者 * from 表名 where 条件
```

### **表字段管理（alter table 表名）**

```mysql
    1、增 ： alter table 表名 add 字段名 类型 first|after xxx
    2、删 ： alter table 表名 drop 字段名
    3、改 ： alter table 表名 modify 字段名 新类型
    4、表重命名： alter table 表名 rename 新表名
    5、删除customers主键限制
	alter table 表名  modify 字段名 类型;
	alter table 表名 drop primary key ;
	6、增加customers主键限制c_id
 alter table 表名 add primary key (字段名) ;
```

## **5、数据类型**

**四大数据类型**

-  数值类型

```mysql
 int 4  smallint 2  tinyint 1  bigint 8
 float  decimal(7,3) 0000.000 
```

- 字符类型

```mysql
char()  varchar()  text  blob 

varchar 预留1-2字节 用于存储 当前字段实际存储的数据长度

```

- 枚举类型 

```mysql
enum()   set()

```

- 日期时间类型

```mysql
date  datetime timestamp time year

created_time - datetime 
updated_time - datetime  


```

**日期时间函数** 

```mysql
NOW()  CURDATE()  CURTIME()  YEAR(字段名) 

```

### **日期时间运算**

```mysql
select * from 表名 where 字段名 运算符(NOW()-interval 间隔);
间隔单位: 1 day | 3 month | 2 year
eg1:查询1年以前的用户充值信息
  select * from user_pay where created_time < (NOW() - interval 1 year)

```

## 6、MySQL运算符

- **数值比较**

```mysql
> >= < <= = !=
eg1 : 查询成绩不及格的学生
      select * from students where score < 60;
eg2 : 删除成绩不及格的学生
      delete from students where score < 60;      
eg3 : 把id为3的学生的姓名改为 周芷若
      update students set name='周芷若' where id=3;

```

- **逻辑比较** 

```mysql
and  or             gender 'M'男  'F'女
eg1 : 查询成绩不及格的男生
		select * from students where score < 60 and gender = 'M';
  
eg2 : 查询成绩在60-70之间的学生
  		select * from students where score > 60 and score < 70;

```



- **范围内比较** 

```mysql
between 值1 and 值2 、in() 、not in()
eg1 : 查询不及格的学生姓名及成绩
  		select name,score from students where score between 0 and 59 
  		
eg2 : 查询AID19和AID18班的学生姓名及成绩
  		select name,score from students where class in('AID19','AID18');

```

- **模糊比较（like）**

```mysql
where 字段名 like 表达式( % _ )  
eg1 : 查询北京的姓赵的学生信息
  		select * from students where address='bj' and name like '赵%';

```



- **NULL判断**

```mysql
is NULL 、is not NULL
eg1 : 查询姓名字段值为NULL的学生信息
  select * from students where name is NULL;

```



## 7、高级查询

- **order by**

给查询的结果进行排序(永远放在SQL命令的倒数第二的位置写)

```mysql
order by 字段名 ASC/DESC
eg1 : 查询成绩从高到低排列
  select * from students order by score DESC

```

- **limit**

限制显示查询记录的条数（永远放在SQL命令的最后写）

```mysql
limit n ：显示前n条
limit m,n ：从第(m+1)条记录开始，显示n条
分页：每页显示10条，显示第6页的内容
     limit (6-1)*10 , 10

```

- **将赵云的攻击力设置为360,防御力设置为68**

  ```mysql
  update sanguo set attack=360,defence=68 where name='赵云';
  
  ```

- **将吴国英雄中攻击值为110的英雄的攻击值改为100,防御力改为60**

  ```mysql
  update sanguo set attack=100, defence=60 where country='吴国';
  
  ```

- **找出攻击值高于200的蜀国英雄的名字、攻击力**

  ```mysql
  select name,attack from sanguo where country='蜀国' and  attack > 200;
  
  ```

- **将蜀国英雄按攻击值从高到低排序**

  ```mysql
  select * from sanguo where country='蜀国' order by attack DESC;
  
  ```

- **魏蜀两国英雄中名字为三个字的按防御值升序排列**

  ```mysql
  select * from sanguo where country in('魏国','蜀国') and  name like '___' order by defence;
  
  ```

- **在蜀国英雄中,查找攻击值前3名且名字不为 NULL 的英雄的姓名、攻击值和国家**

  ```mysql
  select name, attack,country from sanguo
  where country='蜀国' and name is not NULL
  order by attack DESC
  limit 3;
  
  ```

## MySQL查询顺序

```mysql
    3、select ...聚合函数 from 表名
    1、where ...
    2、group by ...
    4、having ...
    5、order by ...
    6、limit ...;

```

### 聚合函数 

| 方法                                         | 功能                 |
| -------------------------------------------- | -------------------- |
| avg(字段名)                                  | 该字段的平均值       |
| max(字段名)                                  | 该字段的最大值       |
| min(字段名)                                  | 该字段的最小值       |
| sum(字段名)                                  | 该字段所有记录的和   |
| count(字段名)                                | 统计该字段记录的个数 |
| count(*)  可统计所有数据，包括值为null的数据 |                      |

eg1 : 找出表中的最大攻击力的值？

```mysql
select max(attack) from sanguo;

```

eg2 : 表中共有多少个英雄？

```mysql
select count(*) as number from sanguo;

```

eg3 : 蜀国英雄中攻击值大于200的英雄的数量

```mysql
select count(id) from sanguo where country='蜀国' and attack > 200;

```

### group by

给查询的结果进行分组
eg1 : 计算每个国家的平均攻击力

```mysql
select  country , avg(attack) from sanguo group by country;

魏国   司马懿
蜀国   诸葛亮。。。
吴国   貂蝉。。。

```


eg2 : 所有国家的男英雄中 英雄数量最多的前2名的 国家名称及英雄数量

```mysql
select country, count(id) as number from sanguo 
where gender = 'M' 
group by country
order by number DESC
limit 2

```

​	==group by后字段名必须要为select后的字段==
​	==查询字段和group by后字段不一致,则必须对该字段进行聚合处理(聚合函数)==

### having语句

对分组聚合后的结果进行进一步筛选

```mysql
eg1 : 找出平均攻击力大于105的国家的前2名,显示国家名称和平均攻击力
	select country, avg(attack) from sanguo
	group by country
	having avg(attack) > 105
	order by avg(attack) DESC
	limit 2;

```

注意

```mysql
having语句通常与group by联合使用
having语句存在弥补了where关键字不能与聚合函数联合使用的不足,where只能操作表中实际存在的字段,having操作的是聚合函数生成的显示列

```

### distinct语句

不显示字段重复值

```mysql
eg1 : 表中都有哪些国家
		select distinct country from sanguo;
  
eg2 : 计算一共有多少个国家
        select count(distinct country) from sanguo;
        

```


注意

```mysql
distinct和from之间所有字段都相同才会去重
distinct不能对任何字段做聚合处理

```

### 查询表记录时做数学运算

运算符 ： +  -  *  /  %  **

```mysql
查询时显示攻击力翻倍
    select name,attack*2 from sanguo;
      
更新蜀国所有英雄攻击力 * 2
update sanguo set attack=attack*2 where country='蜀国';
```

## 索引概述-Btree

### 定义

对数据库表的一列或多列的值进行排序的一种结构(Btree方式)

### B树和B+树

```
    二叉树：树的高度没法保证，每个节点最多两个叉
        树太高/每次向下查找都是一次磁盘IO
    多路查询：1.B树-每个节点多叉/路，既存储索引又存储数据
            2.B+树-每个节点只存索引/
            数据统一存放在叶子节点/
            叶子节点索引是有序的且相连的；
    B树：1，所有查询均要从根节点往下查找
         2，每个节点里是多叉的，且每个节点里及存储索引ID又存储对应具体数据，故整体树的高度未到最优
    B+树：1，非叶子节点只存储索引ID不存储数据；故单个节点可存储的索引ID比B树多,从而等量数据的B+树会比B树矮【胖】
          2，所有数据均在叶子节点；并且是有序相连的，故根据索引ID做范围查询时速度更快【where id >5 and id<20】
```



### 优点

加快数据检索速度

### 缺点

```mysql
占用物理存储空间(/var/lib/mysql)
当对表中数据更新时,索引需要动态维护,降低数据维护速度
```

### 索引示例

```mysql
# cursor.executemany(SQL,[data1,data2,data3])
# 以此IO执行多条表记录操作，效率高，节省资源
1、开启运行时间检测
  mysql>show variables like '%pro%';
  mysql>set profiling=1;
2、执行查询语句(无索引)
  select name from students where name='Tom99999';
3、查看执行时间
  show profiles;
4、在name字段创建索引
  create index name on students(name);
5、再执行查询语句
  select name from students where name='Tom88888';
6、查看执行时间
  show profiles;
```

## 索引分类

#### 普通(MUL)  and 唯一(UNI)

- **使用规则**

```mysql
1、可设置多个字段
2、普通索引 ：字段值无约束,KEY标志为 MUL
3、唯一索引(unique) ：字段值不允许重复,但可为 NULL
                    KEY标志为 UNI
4、哪些字段创建索引:经常用来查询的字段、where条件判断字段、order by排序字段
```

- **创建普通索引and唯一索引**

创建表时

```mysql
create table 表名(
字段名 数据类型，
字段名 数据类型，
index(字段名),
index(字段名),
unique(字段名)
);
```

已有表中创建

```mysql
create [unique] index 索引名 on 表名(字段名);
```

- **查看索引**

```mysql
1、desc 表名;  --> KEY标志为：MUL 、UNI
2、show index from 表名\G;
```

- **删除索引**

```mysql
drop index 索引名 on 表名;
```

#### **主键(PRI)and自增长(auto_increment)**

- **使用规则**

```mysql
1、只能有一个主键字段
2、所带约束 ：不允许重复,且不能为NULL
3、KEY标志(primary) ：PRI
4、通常设置记录编号字段id,能唯一锁定一条记录
```

- **创建**

创建表添加主键

```mysql
create table student(
id int auto_increment,
name varchar(20),
primary key(id)
)charset=utf8,auto_increment=10000;##设置自增长起始值
```

已有表添加主键

```mysql
alter table 表名 add primary key(id);
```

已有表操作自增长属性	

```mysql
1、已有表添加自增长属性
  alter table 表名 modify id int auto_increment;
2、已有表重新指定起始值：
  alter table 表名 auto_increment=20000;
```

- **删除**

```mysql
1、删除自增长属性(modify)
  alter table 表名 modify id int;
2、删除主键索引
  alter table 表名 drop primary key;
```

## **外键（foreign key）聚簇索引**

- **定义**

  让当前表字段的值在另一个表的范围内选择

- **语法**

  ```mysql
  foreign key(参考字段名)
  references 主表(被参考字段名)
  on delete 级联动作
  on update 级联动作
  ```

- **使用规则**

1、主表、从表字段数据类型要一致
2、主表被参考字段 ：KEY的一种，一般为主键

- **示例**

表1、缴费信息表(财务)

```mysql
id   姓名     班级     缴费金额
1   唐伯虎   AID19     300
2   点秋香   AID19     300
3   祝枝山   AID19     300
create database db2 charset utf8;
        use db2;
        create table master(
            id int primary key,
            name varchar(20),
            class char(5),
            money decimal(6,2)
        )charset=utf8;
        insert into master values
        (1,'唐伯虎','AID19',300),
        (2,'点秋香','AID19',300),
        (3,'祝枝山','AID19',300);
```

表2、学生信息表(班主任) -- 做外键关联

```mysql
stu_id   姓名   缴费金额
  1     唐伯虎    300
  2     点秋香    300
 create table slave(
        stu_id int,
        name varchar(20),
        class char(5),
        money decimal(6,2),
        foreign key(stu_id) references master(id) on delete cascade on update cascade 
        )charset=utf8;
```

- **删除外键**

```mysql
alter table 表名 drop foreign key 外键名;
外键名 ：show create table 表名;

第一步找到外键名 ：show create table 表名;
第二步更新表,删除外键名： alter table 表名 drop foreign key 外键名;
```

- **级联动作**

```mysql
cascade
数据级联删除、更新(参考字段)
restrict(默认)
从表有相关联记录,不允许主表操作
set null
主表删除、更新,从表相关联记录字段值为NULL
```

```
    cascade •数据级联删除、更新(参考字段)
        create table slave(
        stu_id int,
        name varchar(20),
        class char(5),
        money decimal(6,2),
        foreign key(stu_id) references master(id) on delete cascade on update cascade 
        )charset=utf8;
    
    restrict(默认) •从表有相关联记录,不允许主表操作
        create table slave_2(
        stu_id int,
        name varchar(20),
        class char(5),
        money decimal(6,2),
        foreign key(stu_id) references master(id) 
        )charset=utf8;
    
    set null •主表删除、更新,从表相关联记录字段值为NULL
        drop table slave_2;
    
        create table slave_3(
        stu_id int,
        name varchar(20),
        money decimal(6,2),
        foreign key(stu_id) references master(id) on delete set null on update set null
        )charset=utf8;
    
        insert into slave_3 values
        (8,'点秋香',300),
        (3,'祝枝山',300);
    
    select * from master;
    update master set id=2 where id=8;
```

- 已有表添加外键**

```mysql
alter table 表名 add foreign key(参考字段) references 主表(被参考字段) on delete 级联动作 on update 级联动作
```



## 嵌套查询(子查询)

定义

把内层的查询结果作为外层的查询条件

语法格式

```mysql
select ... from 表名 where 条件(select ....);
```

示例

```mysql
 1.把攻击值小于平均攻击值的英雄名字和攻击值显示出来
    select name,attack from sanguo where attack<(select avg(attack) from sanguo);
    
    2、找出每个国家攻击力最高的英雄的名字和攻击值(子查询)
    select name,attack from sanguo 
    where (country,attack) in 
    (select country,max(attack) from sanguo group by country);
 
```

## **多表查询**

**sql脚本资料：join_query.sql**

```mysql
mysql -uroot -p123456
mysql>use country;
mysql>source /home/tarena/join_query.sql
```

```mysql
create table if not exists province(
id int primary key auto_increment,
pid int,
pname varchar(15)
)default charset=utf8;

insert into province values
(1, 130000, '河北省'),
(2, 140000, '陕西省'),
(3, 150000, '四川省'),
(4, 160000, '广东省'),
(5, 170000, '山东省'),
(6, 180000, '湖北省'),
(7, 190000, '河南省'),
(8, 200000, '海南省'),
(9, 200001, '云南省'),
(10,200002,'山西省');

create table if not exists city(
id int primary key auto_increment,
cid int,
cname varchar(15),
cp_id int
)default charset=utf8;

insert into city values
(1, 131100, '石家庄市', 130000),
(2, 131101, '沧州市', 130000),
(3, 131102, '廊坊市', 130000),
(4, 131103, '西安市', 140000),
(5, 131104, '成都市', 150000),
(6, 131105, '重庆市', 150000),
(7, 131106, '广州市', 160000),
(8, 131107, '济南市', 170000),
(9, 131108, '武汉市', 180000),
(10,131109, '郑州市', 190000),
(11,131110, '北京市', 320000),
(12,131111, '天津市', 320000),
(13,131112, '上海市', 320000),
(14,131113, '哈尔滨', 320001),
(15,131114, '雄安新区', 320002);

create table if not exists county(
id int primary key auto_increment,
coid int,
coname varchar(15),
copid int
)default charset=utf8;

insert into county values
(1, 132100, '正定县', 131100),
(2, 132102, '浦东新区', 131112),
(3, 132103, '武昌区', 131108),
(4, 132104, '哈哈', 131115),
(5, 132105, '安新县', 131114),
(6, 132106, '容城县', 131114),
(7, 132107, '雄县', 131114),
(8, 132108, '嘎嘎', 131115);
```

- **笛卡尔积**

```mysql
select 字段名列表 from 表名列表; 
```

- **多表查询**

```mysql
select 字段名列表 from 表名列表 where 条件;
```

- **示例**

```mysql
显示 省 市 县 详细信息
select province.pname,city.cname,county.coname from province ,city,county where city.cp_id=province.pid and city.cid=county.copid;
```

## 连接查询

- **内连接（结果同多表查询，显示匹配到的记录）**

````mysql
select 字段名 from  表1 inner join 表2 on 条件 inner join 表3 on 条件; 

eg : 显示省 市 县 详细信息
  select province.pname,city.cname,county.coname from  province inner join city on city.cp_id=province.pid inner join county on city.cid=county.copid;
````

- **左外连接**

以 左表 为主显示查询结果

```mysql
select 字段名 from 表1 left join 表2 on 条件 left join 表3 on 条件;
eg1 : 显示 省 市 详细信息（要求省全部显示）
 
 ​    select province.pname,city.cname,county.coname from  province left join city on city.cp_id=province.pid left join county on city.cid=county.copid;

```

- **右外连接**

用法同左连接,以右表为主显示查询结果

```mysql
select 字段名 from 表1 right join 表2 on 条件 right join 表3 on 条件;

right join 右外连接:用法同左连接,以右表为主显示查询结果
​    select province.pname,city.cname,county.coname from  province right join city on city.cp_id=province.pid right join county on city.cid=county.copid;

```

## **数据导入**

==掌握大体步骤==

==source 文件名.sql==

### **作用**

把文件系统的内容导入到数据库中

### 方式一：使用source命令

source 文件名.sql

 mysql> source /home/tarena/xxx.sql

### 方式二：使用load命令

load data infile "文件名"
into table 表名
fields terminated by "分隔符"
lines terminated by "\n"
**示例**
scoretable.csv文件导入到数据库db2的表

```mysql
 1、将scoretable.csv放到数据库搜索路径中
​        --查看路径
​        mysql>show variables like 'secure_file_priv';
​         /var/lib/mysql-files/
​        --终端复制文件
​        Linux>
​        ls |grep 'score'
​        pwd 
​        sudo cp /home/tarena/scoreTable.csv /var/lib/mysql-files/
​        tarena@tarena:~$ sudo su
​        root@tarena:/home/tarena# cd /var/lib/mysql-files/
​        root@tarena:/var/lib/mysql-files# ls scoreTable.csv
​        --查看权限
​        root@tarena:/var/lib/mysql-files# ll
​        root@tarena:/var/lib/sanguo.csv# ll
​        --修改权限全开 chmod 666 文件名 让当前文件具备rw-rw-rw
​        root@tarena:/var/lib/mysql-files# chmod 666 scoreTable.csv 
​        --chmod 777 文件 让当前文件具备全部权限 rwx-rwx-rwx
​    2、在数据库中创建对应的表
​        create table scoretab(
​        rank int,
​        name varchar(20),
​        score float(5,2),
​        phone char(11),
​        class char(7)
​        )charset=utf8;
​    3、执行数据导入语句
​        load data infile '/var/lib/mysql-files/scoreTable.csv'
​        into table scoretab
​        fields terminated by ','
​        lines terminated by '\n';
```

## **数据导出**

**作用**

将数据库中表的记录保存到系统文件里

**语法格式**

select ... from 表名
into outfile "文件名"
fields terminated by "分隔符"
lines terminated by "分隔符";

**练习**

```mysql
1、把sanguo表中英雄的姓名、攻击值和国家三个字段导出来,放到 sanguo.csv中

 select name,attack,country from sanguo
​    into outfile "/var/lib/mysql-files/sanguo.csv" 
​    fields terminated by "," 
​    lines terminated by "\n";
​    --移动到/home/tarena/路径下
​    root@tarena:/var/lib/mysql-files# mv sanguo.csv /home/tarena/

2、将mysql库下的user表中的 user、host两个字段的值导出到 user2.txt，将其存放在数据库目录下

 select User,Host from user
into outfile "/var/lib/mysql-files/user2.txt" 
fields terminated by "," 
lines terminated by "\n";
```

**注意**

```
1、导出的内容由SQL查询语句决定
2、执行导出命令时路径必须指定在对应的数据库目录下
```

## 数据备份

1. 备份命令格式

>mysqldump -u用户名 -p 源库名 > ~/stu.sql
>
>> --all-databases  备份所有库
>> 库名             备份单个库
>> -B 库1 库2 库3   备份多个库
>> 库名 表1 表2 表3 备份指定库的多张表

2. 恢复命令格式

>mysql -uroot -p 目标库名 < stu.sql
>从所有库备份中恢复某一个库(--one-database)
>
>>mysql -uroot -p --one-database 目标库名 < all.sql

## 表的复制

==1、表能根据实际需求复制数据==

==2、复制表时不会把KEY属性复制过来==

**语法**

```mysql
create table 表名 select 查询命令;

复制表结构:+where false;

create table students3 select * from students where false;
```

**练习**

```mysql
1、复制sanguo表的全部记录和字段,sanguo2
  
2、复制sanguo表的 id,name,country 三个字段的前3条记录,sanguo4
  create table sanguo4 select id,name,country from country.sanguo limit3;

```

**注意**

复制表的时候不会把原有表的 KEY 属性复制过来

**复制表结构**
create table 表名 select 查询命令 where false;

## **锁（自动加锁和释放锁）**重点

### **目的**

解决客户端并发访问的冲突问题

### **锁类型分类**

```
读锁(共享锁)：select 加读锁之后别人不能更改表记录,但可以进行查询
写锁(互斥锁、排他锁)：加写锁之后别人不能查、不能改
```

### **锁粒度分类**

表级锁 ：myisam
行级锁 ：innodb

## 存储引擎

**定义**

```mysql
处理表的处理器
```

**基本操作**

```mysql
1、查看所有存储引擎
   mysql> show engines;
2、查看已有表的存储引擎
   mysql> show create table 表名;
3、创建表指定
   create table 表名(...)engine=MyISAM,charset=utf8,auto_increment=10000;
4、已有表指定
   alter table 表名 engine=InnoDB;   
```

## 常用存储引擎及特点

### InnoDB

写，事务， 行级锁

```mysql
1、支持行级锁
2、支持外键、事务、事务回滚
3、表字段和索引同存储在一个文件中
   1、表名.frm ：表结构
   2、表名.ibd : 表记录及索引文件
```

### MyISAM

查询速度快

```mysql
1、支持表级锁
2、表字段和索引分开存储
   1、表名.frm ：表结构
   2、表名.MYI : 索引文件(my index)
   3、表名.MYD : 表记录(my data)
```

### MEMORY

临时表 内存型 存储的数据持久化要求不高

```mysql
1、表记录存储在内存中，效率高
2、服务或主机重启，表记录清除
```

## 如何选择存储引擎

```mysql
1、执行查操作多的表用 MyISAM
2、执行写操作多的表用 InnoDB
3、临时表 ： MEMORY

4, 具体业务具体分析 - 具体到数据表结构，数量级 
```

mvcc 多版本控制协议【innodb锁机制中 包含该机制】

1， 数据行中 预留一个version字段   该字段在数据更新时 + 1

2， 当执行有version字段的数据更新时，我们需要查询一下 起初select 获取到的该数据行的version 是否改变；若改变，则放弃此次更新【证明在我执行更新操作之前，已经有其他客户端进行了该行数据的更新】；后续，可重复执行若干次相同的更新方式；若多次执行失败，可考虑更改方案

## 存储引擎：处理表的处理器

​    1、查看所有存储引擎
​    mysql> show engines;
​    2、查看已有表的存储引擎
​    mysql> show create table 表名;
​    3、创建表指定
​    create table 表名(...)engine=MyISAM,charset=utf8,auto_increment=10000;

eg:create table myi(id int)engine=MYISAM;

​	4、已有表指定--很少用到
​	alter table 表名 engine=InnoDB;

## 存储引擎选择

具体根据业务场景、测试数据等具体选择，具体到数据表结构、数量级
    1、执行查操作多的表用 MyISAM
    2、执行写操作多的表用 InnoDB
    3、临时表 ： MEMORY

## 权限不够解决方案

​    bash: cd: /var/lib/mysql: 权限不够
​    tarena@tarena:~$ sudo su
​    [sudo] tarena 的密码：

## mysql数据存储路径 

​    root@tarena:/home/tarena# cd /var/lib/mysql

## 重启数据库

​    sudo /etc/init.d/mysql restart

## 查看数据库是否已经启动

​    ps aux|grep 'mysqld'
​    create table memoryt (id int)engine=MEMORY;
​    insert into memoryt values(1),(2);
​    select * from memoryt;



## MySQL的用户账户管理

**开启MySQL远程连接**

```mysql
更改配置文件，重启服务！
1、sudo su
2、cd /etc/mysql/mysql.conf.d
3、cp mysqld.cnf mysqld.cnf.bak   
4、vi mysqld.cnf #找到44行左右,加 # 注释
   #bind-address = 127.0.0.1    vi使用 : 按i ->编辑文件 ->ESC ->shift+: ->wq

5、保存退出
6、service mysql restart
7、mysql -uroot -h176.234.6.29 -p  --查看权限
8、select user,host from mysql.user \G
```

**添加授权用户**

```mysql
1、用root用户登录mysql
   mysql -uroot -p123456
2、授权
   grant select, on 库.表 to "用户名"@"地址" identified by "密码" 
3、刷新权限
   flush privileges;  
```

**授权关键字**

```
all privileges,select,insert ... ... 
库.表 ： *.* 代表所有库的所有表   ex: db2.*   country.sanguo
地址： localhost 或者 具体ip 或者 % 
	  当地址 用 % 代表可以用任何地址进入mysql
```

**示例**

1、添加授权用户work,密码123,对所有库的所有表有所有权限

```
mysql -uroot -p123456
mysql>grant all privileges on *.* to 'work'@'%' identified by '123' with grant option;
mysql>flush privileges; --将当前mysql.user中的数据 加载值内存中，供 mysql服务进行权限检查；
mysql>select user,host from mysql.user;

新开终端：
tarena@tarena:~$ mysql -uwork -h176.234.6.29 -p123
```

2、添加用户duty,对db2库中所有表有所有权限

```mysql
tarena@tarena:~$mysql -uroot -p123456
    mysql>grant all privileges on db2.* to 'duty'@'%' identified by '123';
    mysql>flush privileges; 
    mysql>select user,host from mysql.user;
    新开终端：
    tarena@tarena:~$ mysql -uduty -h176.234.6.29 -p123
```

3.添加授权 用户work4,密码1234,只对country的所有表有 select,update 权限

```
tarena@tarena:~$ mysql -uroot -p123456
        mysql>grant select,update on country.* to 'work4'@'%' identified by '1234';
        mysql>flush privileges; 
        mysql>select user,host from mysql.user;
        tarena@tarena:~$ mysql -uwork4 -h176.234.6.29 -p12;


```

mysql.user -  显示全部的mysql用户；该表显示的具体权限只针对于全局用户有效 【全局用户-指对当前mysql中所有库及所有表都有相应权限的用户】；

mysql.db  - 显示只有 对特定db有操作权限的用户 【grant时被指定数据库的用户】

当mysql服务接到 sql语句的时候， 权限排查 mysql.user -> mysql.db

## 事务和事务回滚

**事务定义**

```mysql
 一件事从开始发生到结束的过程
```

**作用**

```mysql
确保数据的一致性、准确性、有效性
```

**事务操作**

```mysql
1、开启事务
   mysql>begin; # 方法1
   mysql>start transaction; # 方法2
2、开始执行事务中的1条或者n条SQL命令
3、终止事务
   mysql>commit; # 事务中SQL命令都执行成功,提交到数据库,结束!
   mysql>rollback; # 有SQL命令执行失败,回滚到初始状态,结束!
```

### 事务四大特性（ACID）

- **1、原子性（atomicity）**

```
一个事务必须视为一个不可分割的最小工作单元，整个事务中的所有操作要么全部提交成功，要么全部失败回滚，对于一个事务来说，不可能只执行其中的一部分操作
```

- **2、一致性（consistency）**

```
数据库总是从一个一致性的状态转换到另一个一致性的状态
```

- **3、隔离性（isolation）**

```
一个事务所做的修改在最终提交以前，对其他事务是不可见的
```

- **4、持久性（durability）**

```
一旦事务提交，则其所做的修改就会永久保存到数据库中。此时即使系统崩溃，修改的数据也不会丢失
```

**注意**

```mysql
1、事务只针对于表记录操作(增删改)有效,对于库和表的操作无效
2、事务一旦提交结束，对数据库中数据的更改是永久性的
```

## **E-R模型(Entry-Relationship)**

**定义**		

```mysql
E-R模型即 实体-关系 数据模型,用于数据库设计
用简单的图(E-R图)反映了现实世界中存在的事物或数据以及他们之间的关系
```

**实体、属性、关系**

- 实体

```mysql
1、描述客观事物的概念
2、表示方法 ：矩形框
3、示例 ：一个人、一本书、一杯咖啡、一个学生
```

- 属性

```mysql
1、实体具有的某种特性
2、表示方法 ：椭圆形
3、示例
   学生属性 ：学号、姓名、年龄、性别、专业 ... 
   感受属性 ：悲伤、喜悦、刺激、愤怒 ...
```

- ==关系（重要）==

```mysql
1、实体之间的联系
2、一对一关联(1:1) ：老公对老婆
   A中的一个实体,B中只能有一个实体与其发生关联
   B中的一个实体,A中只能有一个实体与其发生关联
3、一对多关联(1:n) ：父亲对孩子
   A中的一个实体,B中有多个实体与其发生关联
   B中的一个实体,A中只能有一个与其发生关联
4、多对多关联(m:n) ：兄弟姐妹对兄弟姐妹、学生对课程
   A中的一个实体,B中有多个实体与其发生关联
   B中的一个实体,A中有多个实体与其发生关联
```

**ER图的绘制**

矩形框代表实体,菱形框代表关系,椭圆形代表属性

- 课堂示例（老师研究课题）

```mysql
1、实体 ：教师、课题
2、属性
   教师 ：教师代码、姓名、职称
   课题 ：课题名
3、关系
   多对多（m:n)
   # 一个老师可以选择多个课题，一个课题也可以被多个老师选
```

- 练习

设计一个学生选课系统的E-R图

```mysql
1、实体：学生、课程、老师
2、属性
3、关系
   学生 选择 课程 (m:n)
   课程 任课 老师 (1:n)
```

### 关系映射实现（重要）

```mysql
1:1实现 --> 主外键关联,外键字段添加唯一索引
  表t1 : id int primary key,
          1
  表t2 : t2_id int unique,
         foreign key(t2_id) references t1(id)
          1
1:n实现 --> 主外键关联
  表t1 : id int primary key,
         1
  表t2 : t2_id int,
         foreign key(t2_id) references t1(id)
         1
         1        
m:n实现(借助中间表):
   t1 : t1_id 
   t2 : t2_id 
```
### 多对多实现

老师研究课题

表1、老师表teacher  id int 主键  tname varchar(10) level varchar(10) 

1，郭小闹, good
2，王老师, goodgood

```
create table teacher(
            id int primary key,
            tname varchar(10),
            level varchar(20)
        )charset=utf8;
        insert into teacher values(1,'郭小闹','good'),(2,'王老师','goodgood');
```

表2、课题表course  id int 主键  cname  varchar(10)  

```mysql
create table course(
	id int primary key,
    cname varchar(10)
)charset=utf8;

insert into course values(1, 'python1'),(2,'python2'),(3,'python3');

1，python1
2, python2
3, python3


```

中间表  middle  id  tid  cid

```
create table middle(
 id int primary key,
 tid int,
 cid int,
 foreign key(tid) references teacher(id),
 foreign key(cid) references course(id)
)charset=utf8;

insert into middle values(1,1,1),(2,1,2),(3,2,1),(4,2,3);
```

### 使用中间表：实现多对多映射关系

```mysql
1、每个老师都在研究什么课题？
select teacher.tname, course.cname from teacher inner join middle on teacher.id=middle.tid inner join course on course.id = middle.cid;
2、郭小闹在研究什么课题？
select teacher.tname, course.cname from teacher inner join middle on teacher.id=middle.tid inner join course on course.id = middle.cid where teacher.tname='郭小闹';
```

## MySQL调优

**存储引擎优化**

```mysql
1、读操作多：MyISAM
2、写操作多：InnoDB
```

**索引优化**

```
在 select、where、order by 常涉及到的字段建立索引
```

**SQL语句优化**

```mysql
1、单条查询最后添加 LIMIT 1，停止全表扫描
2、where子句中不使用 != ,否则放弃索引全表扫描
3、尽量避免 NULL 值判断,否则放弃索引全表扫描
   优化前：select number from t1 where number is null;
   优化后：select number from t1 where number=0;
   # 在number列上设置默认值0,确保number列无NULL值
4、尽量避免 or 连接条件,否则放弃索引全表扫描
   优化前：select id from t1 where id=10 or id=20;
   优化后： select id from t1 where id=10 union all 
           select id from t1 where id=20;
5、模糊查询尽量避免使用前置 % ,否则全表扫描
   select name from t1 where name like "c%";
6、尽量避免使用 in 和 not in,否则全表扫描
   优化前：select id from t1 where id in(1,2,3,4);
   优化后：select id from t1 where id between 1 and 4;
7、尽量避免使用 select * ...;用具体字段代替 * ,不要返回用不到的任何字段
```

## 聚合函数题

有一张文章评论表comment如下

| **comment_id** | **article_id** | **user_id** | **date**            |
| -------------- | -------------- | ----------- | ------------------- |
| 1              | 10000          | 10000       | 2018-01-30 09:00:00 |
| 2              | 10001          | 10001       | ... ...             |
| 3              | 10002          | 10000       | ... ...             |
| 4              | 10003          | 10015       | ... ...             |
| 5              | 10004          | 10006       | ... ...             |
| 6              | 10025          | 10006       | ... ...             |
| 7              | 10009          | 10000       | ... ...             |

以上是一个应用的comment表格的一部分，请使用SQL语句找出在本站发表的所有评论数量最多的10位用户及评论数，并按评论数从高到低排序

备注：comment_id为评论id

​            article_id为被评论文章的id

​            user_id 指用户id

```
select user_id , count(user_id) from comment group by user_id order by count(user_id) DESC limit 10;
```

## 外键及查询题

综述：两张表，一张顾客信息表customers，一张订单表orders

表1：顾客信息表，完成后插入3条表记录

```
c_id 类型为整型，设置为主键，并设置为自增长属性
c_name 字符类型，变长，宽度为20
c_age 微小整型，取值范围为0~255(无符号)
c_sex 枚举类型，要求只能在('M','F')中选择一个值
c_city 字符类型，变长，宽度为20
c_salary 浮点类型，要求整数部分最大为10位，小数部分为2位
```

```mysql
create table customers(
c_id int primary key auto_increment,
c_name varchar(20),
c_age tinyint unsigned,
c_sex enum('M','F'),
c_city varchar(20),
c_salary decimal(12,2)
)charset=utf8;
insert into customers values(1,'Tom',25,'M','上海',10000),(2,'Lucy',23,'F','广州',12000),(3,'Jim',22,'M','北京',11000);
```

表2：顾客订单表（在表中插入5条记录）

```
o_id 整型
o_name 字符类型，变长，宽度为30
o_price 浮点类型，整数最大为10位，小数部分为2位
设置此表中的o_id字段为customers表中c_id字段的外键,更新删除同步
insert into orders values(1,"iphone",5288),(1,"ipad",3299),(3,"mate9",3688),(2,"iwatch",2222),(2,"r11",4400);
```

```mysql
create table orders(
o_id int,
o_name varchar(30),
o_price decimal(12,2),
foreign key(o_id) references customers(c_id) on delete cascade on update cascade
)charset=utf8;
insert into orders values(1,"iphone",5288),(1,"ipad",3299),(2,"iwatch",2222),(2,"r11",4400);
```

增删改查题

```mysql
1、返回customers表中，工资大于4000元，或者年龄小于29岁，满足这样条件的前2条记录
  select * from customers where c_salary>4000 or c_age<29 limit 2;
2、把customers表中，年龄大于等于25岁，并且地址是北京或者上海，这样的人的工资上调15%
  update customers set c_salary=c_salary*1.15 where c_age>=25 and c_city in('北京','上海');
3、把customers表中，城市为北京的顾客，按照工资降序排列，并且只返回结果中的第一条记录
  select * from customers where c_city='北京' order by c_salary DESC limit 1;
4、选择工资c_salary最少的顾客的信息
  select * from customers where c_salary=(select min(c_salary) from customers);
5、找到工资大于5000的顾客都买过哪些产品的记录明细	
  select * from orders where o_id in(select c_id from customers where c_salary>5000);
6、删除外键限制
  1、show create table orders;
  2、alter table orders drop foreign key 外键名;
7、删除customers主键限制
  1、alter table customers modify id int;
  2、alter table customers drop primary key;
8、增加customers主键限制c_id
  alter table customers add primary key(c_id);
  
```



MySQL数据库
==========================

## 数据库概述

### 数据存储阶段 

【1】 人工管理阶段

缺点 ：  数据无法共享,不能单独保持,数据存储量有限

【2】 文件管理阶段 （.txt  .doc  .xls）
    
优点 ： 数据可以长期保存,可以存储大量的数据,使用简单

缺点 ：  数据一致性差,数据查找修改不方便,数据冗余度可能比较大

【3】数据库管理阶段

优点 ： 数据组织结构化降低了冗余度,提高了增删改查的效率,容易扩展,方便程序调用，做自动化处理

缺点 ：需要使用sql 或者 其他特定的语句，相对比较复杂

### 数据库应用

>融机构、游戏网站、购物网站、论坛网站 ... ... 

![](/home/tarena/下载/11/MySQL/img/数据库系统.png)

### 基础概念

>数据 ： 能够输入到计算机中并被识别处理的信息集合

>数据结构 ：研究一个数据集合中数据之间关系的

>数据库 ： 按照数据结构，存储管理数据的仓库。数据库是在数据库管理系统管理和控制下，在一定介质上的数据集合。

>数据库管理系统 ：管理数据库的软件，用于建立和维护数据库

>数据库系统 ： 由数据库和数据库管理系统，开发工具等组成的集合 


### 数据库分类和常见数据库

* 关系型数据库和非关系型数据库
      

>关系型： 采用关系模型（二维表）来组织数据结构的数据库 

>非关系型： 不采用关系模型组织数据结构的数据库

* 开源数据库和非开源数据库

> 开源：MySQL、SQLite、MongoDB

> 非开源：Oracle、DB2、SQL_Server

* 常见的关系型数据库

> MySQL、Oracle、SQL_Server、DB2 SQLite  


### 认识关系型数据库和MySQL

1. 数据库结构 （图库结构）

>数据元素 --> 记录 -->数据表 --> 数据库

![](/home/tarena/下载/11/MySQL/img/库结构.png)

2. 数据库概念解析

>数据表 ： 存放数据的表格 

>字段： 每个列，用来表示该列数据的含义

>记录： 每个行，表示一组完整的数据

![](/home/tarena/下载/11/MySQL/img/表结构.png)

3. MySQL特点

* 是开源数据库，使用C和C++编写 
* 能够工作在众多不同的平台上
* 提供了用于C、C++、Python、Java、Perl、PHP、Ruby众多语言的API
* 存储结构优良，运行速度快
* 功能全面丰富

4. MySQL安装

>Ubuntu安装MySQL服务
>
>>安装服务端: sudo apt-get install mysql-server
>>安装客户端: sudo apt-get install mysql-client
>>
>>> 配置文件：/etc/mysql
>>> 命令集： /usr/bin
>>> 数据库存储目录 ：/var/lib/mysql

>Windows安装MySQL
>
>>下载MySQL安装包(windows)  https://dev.mysql.com/downloads/mysql/
>>mysql-installer***5.7.***.msi
>>安装教程去安装

5. 启动和连接MySQL服务

>服务端启动
>
>>查看MySQL状态: sudo /etc/init.d/mysql status
>>启动服务：sudo /etc/init.d/mysql start | stop | restart

>客户端连接
>
>>命令格式 
>>
>>>mysql -h主机地址 -u用户名 -p密码
>>>mysql -hlocalhost -uroot -p123456
>>>本地连接可省略 -h 选项: mysql -uroot -p123456

>关闭连接
>
>> ctrl-D
>> exit


## SQL语句

> 什么是SQL
>
> >结构化查询语言(Structured Query Language)，一种特殊目的的编程语言，是一种数据库查询和程序设计语言，用于存取数据以及查询、更新和管理关系数据库系统。

> SQL语句使用特点
>
> * SQL语言基本上独立于数据库本身
> * 各种不同的数据库对SQL语言的支持与标准存在着细微的不同
> * 每条命令必须以 ; 结尾
> * SQL命令关键字不区分字母大小写

## MySQL 数据库操作

### 数据库操作

1.查看已有库

>show databases;

2.创建库(指定字符集)

>create database 库名 [character set utf8];

```sql
e.g. 创建stu数据库，编码为utf8
create database stu character set utf8;
create database stu charset=utf8;
```

3.查看创建库的语句(字符集)

>show create database 库名;

```sql
e.g. 查看stu创建方法
show create database stu;
```

4.查看当前所在库

>select database();

5.切换库

>use 库名;

```sql
e.g. 使用stu数据库
use stu;
```

6.删除库

>drop database 库名;

```sql
e.g. 删除test数据库
drop database test;
```

7.库名的命名规则

>* 数字、字母、下划线,但不能使用纯数字
>* 库名区分字母大小写
>* 不能使用特殊字符和mysql关键字


### 数据表的管理

1. 表结构设计初步

   【1】 分析存储内容
   【2】 确定字段构成
   【3】 设计字段类型

2. 数据类型支持

>数字类型：
>
>>整数类型（精确值） - INTEGER，INT，SMALLINT，TINYINT，MEDIUMINT，BIGINT
>>定点类型（精确值） - DECIMAL
>>浮点类型（近似值） - FLOAT，DOUBLE
>>比特值类型 - BIT

![](/home/tarena/下载/11/MySQL/img/整型.png)

>对于精度比较高的东西，比如money，用decimal类型提高精度减少误差。列的声明语法是DECIMAL(M,D)。
>
>>M是数字的最大位数（精度）。其范围为1～65，M 的默认值是10。
>>D是小数点右侧数字的数目（标度）。其范围是0～30，但不得超过M。
>>比如 DECIMAL(6,2)最多存6位数字，小数点后占2位,取值范围-9999.99到9999.99。

> 比特值类型指0，1值表达2种情况，如真，假

----------------------------------

>字符串类型：
>
>>CHAR和VARCHAR类型
>>BLOB和TEXT类型
>>ENUM类型和SET类型

![](/home/tarena/下载/11/MySQL/img/字符串.png)

* char 和 varchar

>char：定长，效率高，一般用于固定长度的表单提交数据存储，默认1字符
>varchar：不定长，效率偏低 ，但是节省空间。

* text 和blob

>text用来存储非二进制文本
>blob用来存储二进制字节串

* enum 和 set

>enum用来存储给出的一个值
>set用来存储给出的值中一个或多个值

-------------------------------------------


1. 表的基本操作

>创建表(指定字符集)
>
>>create table 表名(
>>字段名 数据类型,
>>字段名 数据类型,
>>...
>>字段名 数据类型
>>);

>>* 如果你想设置数字为无符号则加上 unsigned
>>* 如果你不想字段为 NULL 可以设置字段的属性为 NOT NULL， 在操作数据库时如果输入该字段的数据为NULL ，就会报错。
>>* DEFAULT 表示设置一个字段的默认值
>>* AUTO_INCREMENT定义列为自增的属性，一般用于主键，数值会自动加1。
>>* PRIMARY KEY关键字用于定义列为主键。主键的值不能重复。

```sql
e.g.  创建班级表
create table class_1 (id int primary key auto_increment,name varchar(32) not null,age int unsigned not null,sex enum('w','m'),score float default 0.0);

e.g. 创建兴趣班表
create table interest (id int primary key auto_increment,name varchar(32) not null,hobby set('sing','dance','draw'),level char not null,price decimal(6,2),comment text);
```

> 查看数据表
>
> >show tables；

>查看已有表的字符集
>
>>show create table 表名;

>查看表结构
>
>>desc 表名;

>删除表
>
>>drop table 表名;


## 数据基本操作

### 插入(insert)

```SQL
insert into 表名 values(值1),(值2),...;
insert into 表名(字段1,...) values(值1),...;
```

```sql
e.g. 
insert into class_1 values (2,'Baron',10,'m',91),(3,'Jame',9,'m',90);
```

### 查询(select)

```SQL
select * from 表名 [where 条件];
select 字段1,字段名2 from 表名 [where 条件];
```

```sql
e.g. 
select * from class_1;

select name,age from class_1;

```

### where子句

where子句在sql语句中扮演了重要角色，主要通过一定的运算条件进行数据的筛选

MySQL 主要有以下几种运算符：

>算术运算符
>比较运算符
>逻辑运算符
>位运算符

#### 算数运算符

![](/home/tarena/下载/11/MySQL/img/算数.png)

```sql
e.g.
select * from class_1 where age % 2 = 0;

```


#### 比较运算符

![](/home/tarena/下载/11/MySQL/img/比较.png)

```sql
e.g.
select * from class_1 where age > 8;
select * from class_1 where between 8 and 10;
select * from class_1 where age in (8,9);

```

#### 逻辑运算符

![](/home/tarena/下载/11/MySQL/img/逻辑.png)

```sql
e.g.
select * from class_1 where sex='m' and age>9;

```

#### 位运算符

![](/home/tarena/下载/11/MySQL/img/位.png)

![](/home/tarena/下载/11/MySQL/img/运算符.png)


### 更新表记录(update)

```SQL
update 表名 set 字段1=值1,字段2=值2,... where 条件;

```

```sql
e.g.
update class_1 set age=11 where name='Abby';

```


###　删除表记录（delete）

```SQL
delete from 表名 where 条件;

注意:delete语句后如果不加where条件,所有记录全部清空

```

```sql
e.g.
delete from class_1 where name='Abby';

```


### 表字段的操作(alter)

```SQL
语法 ：alter table 表名 执行动作;

* 添加字段(add)
    alter table 表名 add 字段名 数据类型;
    alter table 表名 add 字段名 数据类型 first;
    alter table 表名 add 字段名 数据类型 after 字段名;
* 删除字段(drop)
    alter table 表名 drop 字段名;
* 修改数据类型(modify)
    alter table 表名 modify 字段名 新数据类型;
* 修改字段名(change)
    alter table 表名 change 旧字段名 新字段名 新数据类型;
* 表重命名(rename)
    alter table 表名 rename 新表名;

```

```sql
e.g. 
alter table interest add tel char(11) after name;

```


### 时间类型数据

>时间和日期类型:
>
>>DATE，DATETIME和TIMESTAMP类型
>>TIME类型
>>年份类型YEAR

![](/home/tarena/下载/11/MySQL/img/时间.png)

#### 时间格式

> date ："YYYY-MM-DD"
> time ："HH:MM:SS"
> datetime ："YYYY-MM-DD HH:MM:SS"
> timestamp ："YYYY-MM-DD HH:MM:SS"
> 注意
> 1、datetime ：以系统时间存储
> 2、timestamp ：以标准时间存储但是查看时转换为系统时区，所以表现形式和datetime相同



```sql
e.g.
create table marathon (id int primary key auto_increment,athlete varchar(32),birthday date,registration_time datetime,performance time);

```





#### 日期时间函数

  * now()  返回服务器当前时间,格式对应datetime类型
  * curdate() 返回当前日期，格式对应date类型
  * curtime() 返回当前时间，格式对应time类型

#### 时间操作

* 查找操作

```sql
  select * from marathon where birthday>='2000-01-01';
  select * from marathon where birthday>="2000-07-01" and performance<="2:30:00";

```

* 日期时间运算

  - 语法格式

    select * from 表名  where 字段名 运算符 (时间-interval 时间间隔单位);

  - 时间间隔单位：   2 hour | 1 minute | 2 second | 2 year | 3 month |  1 day

```sql
  select * from marathon where registration_time > (now()-interval 7 day);

```

### 高级查询语句


#### 模糊查询和正则查询

LIKE用于在where子句中进行模糊查询，SQL LIKE 子句中使用百分号 %来表示任意0个或多个字符，下划线_表示任意一个字符。

使用 LIKE 子句从数据表中读取数据的通用语法：

```sql
SELECT field1, field2,...fieldN 
FROM table_name
WHERE field1 LIKE condition1

```

```sql
e.g. 
mysql> select * from class_1 where name like 'A%';

```

mysql中对正则表达式的支持有限，只支持部分正则元字符

```sql
SELECT field1, field2,...fieldN 
FROM table_name
WHERE field1 REGEXP condition1

```

```sql
e.g. 
select * from class_1 where name regexp '^B.+';

```

#### 排序

ORDER BY 子句来设定你想按哪个字段哪种方式来进行排序，再返回搜索结果。

使用 ORDER BY 子句将查询数据排序后再返回数据：

```sql
SELECT field1, field2,...fieldN from table_name1 where field1
ORDER BY field1 [ASC [DESC]]

```

默认情况ASC表示升序，DESC表示降序

```sql
select * from class_1 where sex='m' order by age;

```

#### 分页(限制)

LIMIT 子句用于限制由 SELECT 语句返回的数据数量 或者 UPDATE,DELETE语句的操作数量

带有 LIMIT 子句的 SELECT 语句的基本语法如下：

```sql
SELECT column1, column2, columnN 
FROM table_name
WHERE field
LIMIT [num]

```

#### 联合查询

UNION 操作符用于连接两个以上的 SELECT 语句的结果组合到一个结果集合中。多个 SELECT 语句会删除重复的数据。

UNION 操作符语法格式：

```sql
SELECT expression1, expression2, ... expression_n
FROM tables
[WHERE conditions]
UNION [ALL | DISTINCT]
SELECT expression1, expression2, ... expression_n
FROM tables
[WHERE conditions];

```

>expression1, expression2, ... expression_n: 要检索的列。
>tables: 要检索的数据表。
>WHERE conditions: 可选， 检索条件。
>DISTINCT: 可选，删除结果集中重复的数据。默认情况下 UNION 操作符已经删除了重复数据，所以 DISTINCT 修饰符对结果没啥影响。
>ALL: 可选，返回所有结果集，包含重复数据。

```sql
select * from class_1 where sex='m' UNION ALL select * from class_1 where age > 9;

```



### 数据备份

1. 备份命令格式

>mysqldump -u用户名 -p 源库名 > ~/stu.sql
>
>> --all-databases  备份所有库
>> 库名             备份单个库
>> -B 库1 库2 库3   备份多个库
>> 库名 表1 表2 表3 备份指定库的多张表

2. 恢复命令格式

>mysql -uroot -p 目标库名 < stu.sql
>从所有库备份中恢复某一个库(--one-database)
>
>>mysql -uroot -p --one-database 目标库名 < all.sql



## Python操作MySQL数据库

### pymysql安装

>sudo pip3 install pymysql


### pymysql使用流程

1. 建立数据库连接(db = pymysql.connect(...))
2. 创建游标对象(cur = db.cursor())
3. 游标方法: cur.execute("insert ....")
4. 提交到数据库或者获取数据 : db.commit()/db.fetchall()
5. 关闭游标对象 ：cur.close()
6. 断开数据库连接 ：db.close()

#### 常用函数

#### 操作流程

```
"""
mysql.py
pymysql 操作数据库基本流程
"""

import pymysql

# 连接数据库
db = pymysql.connect(host='localhost',
                     port = 3306,
                     user='root',
                     password = '123456',
                     database = 'stu',
                     charset='utf8')

# 获取游标 (操作数据库,执行sql语句,得到执行结果)
cur = db.cursor()

# 执行语句
sql = "insert into interest values\
 (4,'Emma','draw','C',14800,'xxxx');"
cur.execute(sql)  # 执行语句

# 提交到数据库
db.commit()

# 关闭游标
cur.close()

# 关闭数据库
db.close()

```

#### 读操作

```
"""
read_db.py
pymysql 读操作演示  (select)
"""

import pymysql

# 连接数据库
db = pymysql.connect(user='root',
                     passwd='123456',
                     database='stu',
                     charset='utf8')

# 获取游标
cur = db.cursor()

# 获取数据
sql="select name,hobby from interest \
where hobby = 'draw';"
cur.execute(sql)

# 可以直接遍历游标
# for i in cur:
#     print(i)

# 获取所有查询结果
# all_row = cur.fetchall()
# print(all_row)

# 获取多个查询结果
many_row = cur.fetchmany(2)
print(many_row)

# 获取一个查询结果
one_row = cur.fetchone()
print(one_row)

cur.close()
db.close()


```

#### 写操作

```
"""
write_db.py
pymysql 写操作演示 (insert update  delete)
"""

import  pymysql

# 连接数据库
db = pymysql.connect(user='root',
                     passwd='123456',
                     database='stu',
                     charset='utf8')

# 获取游标
cur = db.cursor()

# 执行sql语句
# name = input("Name:")
# age = input('Age:')
# score = input("Score:")

try:
    # 插入操作
    # 合成一个正确的sql语句才能正确commit
    # sql = "insert into class_1 (name,age,score) \
    # values ('%s',%d,%f);"%(name,age,score)

    # sql语句值参量可以通过execute传入
    # sql = "insert into class_1 (name,age,score) \
    # values (%s,%s,%s)"
    # cur.execute(sql,[name,age,score]) # 执行语句

    #  修改操作
    sql = "update class_1 set score=91 \
    where name='Abby'"
    cur.execute(sql)

    # 删除操作
    sql = "delete from class_1 \
    where name = 'Jame'"
    cur.execute(sql)

    db.commit() # 同步数据库
except Exception as e:
    print(e)
    db.rollback()  # 回滚到没有commit之前的状态


cur.close()
db.close()



```



#### 单词插入数据库

```
"""
创建数据库 dict
   创建数据表  words

     id    word    mean

   将单词本中的单词插入数据库
"""

import pymysql
import re

f = open('dict.txt')

# 连接数据库
db = pymysql.connect(user='root',
                     password = '123456',
                     database = 'dict',
                     charset='utf8')

# 获取游标 (操作数据库,执行sql语句,得到执行结果)
cur = db.cursor()

# 执行语句
sql="insert into words (word,mean) values (%s,%s)"

for line in f:
    # tmp = line.split(' ',1)
    # word = tmp[0]
    # mean = tmp[1].strip()
    # cur.execute(sql,[word,mean])

    tup = re.findall(r'(\S+)\s+(.*)',line)[0]
    cur.execute(sql, tup)

try:
    db.commit()
except:
    db.rollback()

# 关闭游标
cur.close()
# 关闭数据库
db.close()

```

模拟用户注册、登录

```
"""
   编写一个程序,模拟用户注册,登录的数据库行为

   stu->user表

   * 用户名不能重复
   * 要包含用户名和密码字段
"""

import pymysql

class User:
    def __init__(self,database):
        self.db = pymysql.connect(user='root',
                                  passwd='123456',
                                  database=database,
                                  charset='utf8')
        self.cur = self.db.cursor()

    def register(self,name,passwd):
        sql = "select * from user where name=%s"
        self.cur.execute(sql,[name])
        r = self.cur.fetchone()
        # 查找到说明用户存在
        if r:
            return False

        # 插入用户名密码
        sql = "insert into user (name,passwd) \
        values (%s,%s)"
        try:
            self.cur.execute(sql, [name,passwd])
            self.db.commit()
            return True
        except:
            self.db.rollback()

    def login(self,name,passwd):
        sql = "select * from user \
        where name=%s and passwd=%s"
        self.cur.execute(sql, [name,passwd])
        r = self.cur.fetchone()
        # 查找到则登录成功
        if r:
            return True



if __name__ == '__main__':
    user = User('stu')

    # if user.register('Abby','123'):
    #     print("注册成功")

    if user.login('Abby','1234'):
        print("登录成功")
```

#### 二进制文件存取

```
"""
save_file.py
二进制文件存取示例
"""

import pymysql

# 连接数据库
db = pymysql.connect(user='root',
                     password = '123456',
                     database = 'stu',
                     charset='utf8')

# 获取游标 (操作数据库,执行sql语句,得到执行结果)
cur = db.cursor()

# 执行语句

# 存入图片
# with open('0.jpg','rb') as f:
#     data = f.read()
#
# sql = "insert into images values (1,%s,%s)"
# cur.execute(sql,[data,'初恋'])
# db.commit()

# 提取图片
sql = "select photo from images \
where comment='初恋'"
cur.execute(sql)
data = cur.fetchone()[0]
with open('1.jpg','wb') as f:
    f.write(data)

# 关闭游标
cur.close()

# 关闭数据库
db.close()

```



>db = pymysql.connect(参数列表)
>
>>host ：主机地址,本地 localhost
>>port ：端口号,默认3306
>>user ：用户名
>>password ：密码
>>database ：库
>>charset ：编码方式,推荐使用 utf8

> 数据库连接对象(db)的方法
>
> > cur = db.cursor() 返回游标对象,用于执行具体SQL命令
> > db.commit() 提交到数据库执行
> > db.rollback() 回滚，用于当commit()出错是回复到原来的数据形态
> > db.close() 关闭连接

>游标对象(cur)的方法
>
>>cur.execute(sql命令,[列表]) 执行SQL命令
>>cur.fetchone() 获取查询结果集的第一条数据，查找到返回一个元组否则返回None
>>cur.fetchmany(n) 获取前n条查找到的记录，返回结果为元组嵌套元组， ((记录1),(记录2))。
>>cur.fetchall() 获取所有查找到的记录，返回结果形式同上。
>>cur.close() 关闭游



正则表达式
==========================

## 动机

1. 文本处理已经成为计算机常见工作之一

2. 对文本内容的搜索，定位，提取是逻辑比较复杂的工作

3. 为了快速方便的解决上述问题，产生了正则表达式技术

## 简介

1. 定义

> 即文本的高级匹配模式，提供搜索，替换等功能。其本质是由一系列字符和特殊符号构成的字串，这个字串即正则表达式。

2. 原理

> 通过普通字符和有特定含义的字符，来组成字符串，用以描述一定的字符串规则，比如：重复，位置等，来表达某类特定的字符串，进而匹配。

3. 目标

* 熟练掌握正则表达式元字符

* 能够读懂常用正则表达式，编辑简单的正则规则

* 能够熟练使用re模块操作正则表达式

## 元字符使用

#### 普通字符

* 匹配规则：每个普通字符匹配其对应的字符

```
e.g.
In : re.findall('ab',"abcdefabcd")
Out: ['ab', 'ab']
```

* 注意事项：正则表达式在python中也可以匹配中文

#### 或关系

* 元字符: | 

* 匹配规则: 匹配 | 两侧任意的正则表达式即可

```
e.g.
In : re.findall('com|cn',"www.baidu.com/www.tmooc.cn")
Out: ['com', 'cn']

```

#### 匹配单个字符

* 元字符： . 

* 匹配规则：匹配除换行外的任意一个字符

```
e.g.
In : re.findall('张.丰',"张三丰,张四丰,张五丰")
Out: ['张三丰', '张四丰', '张五丰']

```

#### 匹配字符集

* 元字符： [字符集]

* 匹配规则: 匹配字符集中的任意一个字符

* 表达形式: 

>> [abc#!好] 表示 [] 中的任意一个字符
>> [0-9],[a-z],[A-Z] 表示区间内的任意一个字符
>> [_#?0-9a-z]  混合书写，一般区间表达写在后面

```
e.g.
In : re.findall('[aeiou]',"How are you!")
Out: ['o', 'a', 'e', 'o', 'u']
```

#### 匹配字符集反集

* 元字符：[^字符集]

* 匹配规则：匹配除了字符集以外的任意一个字符

```
e.g.
In : re.findall('[^0-9]',"Use 007 port")
Out: ['U', 's', 'e', ' ', ' ', 'p', 'o', 'r', 't']
```

#### 匹配字符串开始位置

* 元字符: ^

* 匹配规则：匹配目标字符串的开头位置

```
e.g.
In : re.findall('^Jame',"Jame,hello")
Out: ['Jame']
```

#### 匹配字符串的结束位置

* 元字符:  $

* 匹配规则: 匹配目标字符串的结尾位置

```
e.g.
In : re.findall('Jame$',"Hi,Jame")
Out: ['Jame']
```

* 规则技巧: ^ 和 $必然出现在正则表达式的开头和结尾处。如果两者同时出现，则中间的部分必须匹配整个目标字符串的全部内容。


#### 匹配字符重复

* 元字符: *

* 匹配规则：匹配前面的字符出现0次或多次

```
e.g.
In : re.findall('wo*',"wooooo~~w!")
Out: ['wooooo', 'w']
```

--------------------

* 元字符：+

* 匹配规则： 匹配前面的字符出现1次或多次

```
e.g.
In : re.findall('[A-Z][a-z]+',"Hello World")
Out: ['Hello', 'World']

```

--------------------

* 元字符：?

* 匹配规则： 匹配前面的字符出现0次或1次

```
e.g. 匹配整数
In [28]: re.findall('-?[0-9]+',"Jame,age:18, -26")
Out[28]: ['18', '-26']

```

-----------------------

* 元字符：{n}

* 匹配规则： 匹配前面的字符出现n次

```
e.g. 匹配手机号码
In : re.findall('1[0-9]{10}',"Jame:13886495728")
Out: ['13886495728']


```

-----------------------

* 元字符：{m,n}

* 匹配规则： 匹配前面的字符出现m-n次

```
e.g. 匹配qq号
In : re.findall('[1-9][0-9]{5,10}',"Baron:1259296994") 
Out: ['1259296994']

```

#### 匹配任意（非）数字字符

* 元字符： \d   \D

* 匹配规则：\d 匹配任意数字字符，\D 匹配任意非数字字符

```
e.g. 匹配端口
In : re.findall('\d{1,5}',"Mysql: 3306, http:80")
Out: ['3306', '80']

```

#### 匹配任意（非）普通字符

* 元字符： \w   \W

* 匹配规则: \w 匹配普通字符，\W 匹配非普通字符

* 说明: 普通字符指数字，字母，下划线，汉字。

```
e.g.
In : re.findall('\w+',"server_port = 8888")
Out: ['server_port', '8888']

```

#### 匹配任意（非）空字符

* 元字符： \s   \S

* 匹配规则: \s 匹配空字符，\S 匹配非空字符

* 说明：空字符指 空格 \r \n \t \v \f 字符

```
e.g.
In : re.findall('\w+\s+\w+',"hello    world")
Out: ['hello    world']

```

#### 匹配开头结尾位置

* 元字符： \A   \Z

* 匹配规则： \A 表示开头位置，\Z 表示结尾位置

#### 匹配（非）单词的边界位置

* 元字符： \b   \B

* 匹配规则： \b 表示单词边界，\B 表示非单词边界

* 说明：单词边界指数字字母(汉字)下划线与其他字符的交界位置。

```
e.g.
In : re.findall(r'\bis\b',"This is a test.")
Out: ['is']

```

| 类别     | 元字符                           |
| -------- | -------------------------------- |
| 匹配字符 | . [...] [^...] \d \D \w \W \s \S |
| 匹配重复 | * +  ?  {n}  {m,n}               |
| 匹配位置 | ^  $  \A  \Z  \b   \B            |
| 其他     | `|`   ()    \                    |


## 正则表达式的转义

1. 如果使用正则表达式匹配特殊字符则需要加 \ 表示转义。

>>特殊字符: . * + ? ^ $ [] () {} | \

```
e.g. 匹配特殊字符 . 时使用 \. 表示本身含义
In : re.findall('-?\d+\.?\d*',"123,-123,1.23,-1.23")
Out: ['123', '-123', '1.23', '-1.23']

```

2. 在编程语言中，常使用原生字符串书写正则表达式避免多重转义的麻烦。

```
e.g.
python字符串  -->    正则    -->    目标字符串
"\\$\\d+"   解析为   \$\d+   匹配   "$100"

"\\$\\d+"  等同于  r"\$\d+"

```

## 贪婪模式和非贪婪模式

1. 定义

>贪婪模式: 默认情况下，匹配重复的元字符总是尽可能多的向后匹配内容。比如: *  +  ?  {m,n}

>非贪婪模式(懒惰模式): 让匹配重复的元字符尽可能少的向后匹配内容。

2. 贪婪模式转换为非贪婪模式

* 在匹配重复元字符后加 '?' 号即可

```
*  :  *?
+  :  +?
?  :  ??
{m,n} : {m,n}?

```

```
e.g.
In : re.findall(r'\(.+?\)',"(abcd)efgh(higk)")
Out: ['(abcd)', '(higk)']

```

## 正则表达式分组

1. 定义

> 在正则表达式中，以()建立正则表达式的内部分组，子组是正则表达式的一部分，可以作为内部整体操作对象。

2. 作用

* 可以被作为整体操作，改变元字符的操作对象

```
e.g.  改变 +号 重复的对象
In : re.search(r'(ab)+',"ababababab").group()
Out: 'ababababab'

e.g. 改变 |号 操作对象
In : re.search(r'(王|李)\w{1,3}',"王者荣耀").group()
Out: '王者荣耀'

```

* 可以通过编程语言某些接口获取匹配内容中，子组对应的内容部分

```
e.g. 获取url协议类型
re.search(r'(https|http|ftp|file)://\S+',"https://www.baidu.com").group(1)


```

3. 捕获组

可以给正则表达式的子组起一个名字，表达该子组的意义。这种有名称的子组即为捕获组。

>格式：`(?P<name>pattern)`

```
e.g. 给子组命名为 "pig"
In : re.search(r'(?P<pig>ab)+',"ababababab").group('pig')
Out: 'ab'


```

4. 注意事项

* 一个正则表达式中可以包含多个子组
* 子组可以嵌套，但是不要重叠或者嵌套结构复杂
* 子组序列号一般从外到内，从左到右计数

![分组](/home/tarena/下载/11/re/img/re.png)

## 正则表达式匹配原则

1. 正确性,能够正确的匹配出目标字符串.
2. 排他性,除了目标字符串之外尽可能少的匹配其他内容.
3. 全面性,尽可能考虑到目标字符串的所有情况,不遗漏.

## Python re模块使用

***参考代码day13/regex.py***

```
import re

def get_address(file):
    """
    :param file: 查找目标
    :return: 查找到的地址
    """
    port = input("端口:")

    while True:
        data = ''
        for line in file:
            if line == '\n':
                break
            data += line
        obj = re.match(r'\S+',data) # 匹配首单词
        if not obj:
            # 文件结束
            return "PORT ERROR"
        if obj.group() == port:
            # 匹配到了
            # pattern = r"(\d{1,3}\.){3}\d{1,3}/\d+"
            pattern=r"[0-9a-f]{4}\.[0-9a-f]{4}\.[0-9a-f]{4}"
            m = re.search(pattern,data)
            if m:
                return m.group()
            return

if __name__ == '__main__':
    f = open('exc.txt')
    print(get_address(f))

```

```
"""
regex.py  re模块
"""

import re

s = "Alex:1997,Sunny:1996" # 目标字符串
pattern = r"(\w+):(\d+)" # 正则表达式

# re模块调用
l = re.findall(pattern,s)
print(l)

# 正则对象调用
regex = re.compile(pattern)
l = regex.findall(s,0,10)
print(l)


# 正则表达式内容切割字符串
l = re.split(r',',s)
print(l)


# 替换目标字符串
s = re.subn(r':','--',s,4)
print(s)

```

```
"""
regex1.py  re模块演示
生成match对象的函数
"""

import re

s = "热烈庆祝达内17周年，2002年至今，学生60万"
pattern = r'\d+'

# 返回迭代对象
it = re.finditer(pattern,s)

# 每个match对象对应一处匹配内容
for i in it:
    print(i.group()) # 获取match对象匹配内容

# 完全匹配
obj = re.fullmatch(r'.+',s)
print(obj.group())

# 匹配开始
obj = re.match(r'\w+',s)
print(obj.group())

# 匹配第一处
obj = re.search(r'\d+',s)
print(obj.group())

```

```
"""
regex2.py
match对象属性方法演示
"""
import re

pattern = r'(ab)cd(?P<pig>ef)'
regex = re.compile(pattern)
obj = regex.search("abcdefghi",0,7)

# 属性变量
# print(obj.pos)  # 目标字符串开始位置
# print(obj.endpos) # 匹配目标结束位置
# print(obj.re) # 正则
# print(obj.string) # 目标字符串
# print(obj.lastgroup) # 最后一组组名
# print(obj.lastindex) # 最后一组序号

# 属性方法
print(obj.span()) # 匹配内容在目标字符串中的位置
print(obj.start())
print(obj.end())
print(obj.groupdict()) # 捕获组组名和对应内容字典
print(obj.groups()) # 子组对应内容
print(obj.group()) # 获取match对象内容
print(obj.group('pig'))

```



----------------------

```python
 regex = compile(pattern,flags = 0)
 功能: 生产正则表达式对象
 参数: pattern  正则表达式
      flags  功能标志位,扩展正则表达式的匹配
 返回值: 正则表达式对象

```

------------------------

```python
 re.findall(pattern,string,flags = 0)
 功能: 根据正则表达式匹配目标字符串内容
 参数: pattern  正则表达式
      string 目标字符串
      flags  功能标志位,扩展正则表达式的匹配
 返回值: 匹配到的内容列表,如果正则表达式有子组则只能获取到子组对应的内容

```

------------------------

```python
 regex.findall(string,pos,endpos)
 功能: 根据正则表达式匹配目标字符串内容
 参数: string 目标字符串
      pos 截取目标字符串的开始匹配位置
      endpos 截取目标字符串的结束匹配位置
 返回值: 匹配到的内容列表,如果正则表达式有子组则只能获取到子组对应的内容

```

------------------------

 ```python
 re.split(pattern,string,flags = 0)
 功能: 使用正则表达式匹配内容,切割目标字符串
 参数: pattern  正则表达式
      string 目标字符串
      flags  功能标志位,扩展正则表达式的匹配
 返回值: 切割后的内容列表

 ```

------------------------

```python
 re.sub(pattern,replace,string,count,flags = 0)
 功能: 使用一个字符串替换正则表达式匹配到的内容
 参数: pattern  正则表达式
      replace  替换的字符串
      string 目标字符串
      max  最多替换几处,默认替换全部
      flags  功能标志位,扩展正则表达式的匹配
 返回值: 替换后的字符串

```

------------------------

```python
 re.subn(pattern,replace,string,count,flags = 0)
 功能: 使用一个字符串替换正则表达式匹配到的内容
 参数: pattern  正则表达式
      replace  替换的字符串
      string 目标字符串
      max  最多替换几处,默认替换全部
      flags  功能标志位,扩展正则表达式的匹配
 返回值: 替换后的字符串和替换了几处

```

------------------------

***参考代码day13/regex1.py***

```python
 re.finditer(pattern,string,flags = 0)
 功能: 根据正则表达式匹配目标字符串内容
 参数: pattern  正则表达式
      string 目标字符串
      flags  功能标志位,扩展正则表达式的匹配
 返回值: 匹配结果的迭代器

```

------------------------

```python
re.fullmatch(pattern,string,flags=0)
功能：完全匹配某个目标字符串
参数：pattern 正则
	string  目标字符串
返回值：匹配内容match object

```

------------------------

```python
re.match(pattern,string,flags=0)
功能：匹配某个目标字符串开始位置
参数：pattern 正则
	string  目标字符串
返回值：匹配内容match object

```

------------------------

```python
re.search(pattern,string,flags=0)
功能：匹配目标字符串第一个符合内容
参数：pattern 正则
	string  目标字符串
返回值：匹配内容match object

```

------------------------

compile对象属性
	  

	【1】 pattern ： 正则表达式
	【2】 groups ： 子组数量
	【3】 groupindex ： 捕获组名与组序号的字典

------------------------

### match对象的属性方法

***参考代码day13/regex2.py***

1. 属性变量

* pos   匹配的目标字符串开始位置
* endpos  匹配的目标字符串结束位置
* re     正则表达式
* string  目标字符串
* lastgroup  最后一组的名称
* lastindex  最后一组的序号

2. 属性方法

* span()  获取匹配内容的起止位置

* start() 获取匹配内容的开始位置

* end()   获取匹配内容的结束位置

* groupdict()  获取捕获组字典，组名为键，对应内容为值

* groups() 获取子组对应内容

* group(n = 0)

  功能：获取match对象匹配内容
    参数：默认为0表示获取整个match对象内容，如果是序列号或者组名则表示获取对应子组内容
    返回值：匹配字符串

![结构](/home/tarena/下载/11/re/img/re1.png)

### flags参数扩展

***参考代码day13/flags.py***

```
"""
flags.py
扩展标志位演示
"""

import re

s = """Hello
北京
"""

# 只能匹配ASCII编码
# regex = re.compile(r'\w+',flags=re.A)

# 忽略字母大小写
# regex = re.compile(r'[a-z]+',flags=re.I)

# . 可以匹配换行
# regex = re.compile(r'.+',flags=re.S)

# ^ $ 可以匹配每行开头结尾位置
# regex = re.compile(r'Hello$',flags=re.M)

pattern = '''hello # 匹配Hello
\s #匹配换行
\w+ # 匹配 北京
'''
regex = re.compile(pattern,flags=re.X | re.I)

l = regex.findall(s)
print(l)
```



    1. 使用函数：re模块调用的匹配函数。如：re.compile,re.findall,re.search....
    
    2. 作用：扩展丰富正则表达式的匹配功能
    
    3. 常用flag

> A == ASCII  元字符只能匹配ascii码

> I == IGNORECASE  匹配忽略字母大小写

> S == DOTALL  使 . 可以匹配换行

> M == MULTILINE  使 ^  $可以匹配每一行的开头结尾位置

  4. 使用多个flag

     方法：使用按位或连接  
       e.g. ：  flags = re.I | re.A

