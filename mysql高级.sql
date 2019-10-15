数据库:存储数据的仓库（逻辑概念，并未真实存在）
数据库软件:真实软件，用来实现数据库这个逻辑概念
数据仓库:数据量更加庞大，更加侧重数据分析和数据挖掘，供企业决策分析之用，主要是数据查询，修改和删除很少

内存存储比磁盘存储快，MySQL基于磁盘存储。数据是以文件形式存放在数据库目录/var/lib/mysql下
查看sql是否已启动 ps -aux|grep 'mysql' 

库管理
    1、查看已有库；
    show databases;

    2、创建库并指定字符集；
    create database 库名
    charset utf8;
    ​
    3、查看当前所在库；

    4、切换库；

    5、查看库中已有表；
    show tables

    6、删除库；
    drop database 库名
表管理
    1、创建表并指定字符集；
    create table 表名（字段名 类型 xxx）charset=utf8;

    2、查看创建表的语句
    (字符集、存储引擎)；
    show
    create table 表名
    3、查看表结构;
    desc 表名
    4、删除表;
    drop table 表名1
    ，表名2

表记录管理
    1、增 ：
    insert into 表名

    （字段名1，字段名2...） values
    (字段1值，字段名2...)
    2、删 ：
    delete from 表名 where 条件
    3、改 ： updata 表名
    set 字段名
    =值 where 条件
    4、查 ：
    select 字段1值
    ，字段名2 from 表名 where 条件
表字段管理（alter table 表名）
    1、增 ：
    alter table 表名 add 字段名 类型
    first|after xxx
    2、删 ：
    alter table 表名 drop 字段名
    3、改 ：
    alter table 表名 modify 字段名 新类型
    4、表重命名：
    alter table 表名 rename 新表名
    5、删除customers主键限制
    alter table 表名  modify 字段名 类型;
    alter table 表名 drop primary key ;
    6、增加customers主键限制c_id
    alter table 表名 add primary key (字段名) ;

四大数据类型
    1.数值类型：int 4  smallint 2  tinyint 1  bigint 8  float decimal(7,3) 0000.000
    2.字符类型
    ​char() text blob
    varchar():预留1-2个字节 用于存储 当前字段实际存储的数据长度
    3.日期时间类型
    date datetime timestamp time year
    created_time--datetime
    updated_time--datetime
    4.日期时间函数 
    now() curdate() curtime() year(字段名）
    5.日期时间运算
    select * from 表名 where 字段名 运算符(NOW()-interval 间隔);
    间隔单位: 1 day | 3 month | 2 year
查询
    eg1:查询1年以前的用户充值信息
    select * from user_pay where created_time <(now()-interval 1 year)
    查询AID19和AID19班的学生姓名及成绩
    select name,score from students where class in ('AID19','AID18';)
    查询北京的姓赵的学生信息
    select * from students where address='bj' and name like '赵%'；
    查询成绩从高到低排列(倒数第二位置)
    select * from students order by score DESC
    limit限制显示查询记录的条数（永远放在最后写）
        limit n ：显示前n条
        limit m,n ：从第(m+1)条记录开始，显示n条
        limit(6-1)*10,10 分页：每页显示10条，显示第6页的内容
mysql基本语句
    mysql -u root -p 123456
    create database country charset=utf8;
    show databases;
    use country;

    create table sanguo (
    id int primary key auto_increment,
    name varchar(32),
    attack int ,
    defense int ,
    gender varchar(32),
    country varchar(32)
    );
    
    --添加id字段,要求主键自增长,显示宽度为3,位数不够用0填充
        alter table scoretab add id int(3) zerofill primary key auto_increment first;

    desc sanguo; #查看表结构
    show create table sanguo;

    insert into sanguo values(1,'诸葛亮',101,95,'男','蜀国');
    insert into sanguo values(2,'司马懿',151,85,'男','魏国');
    insert into sanguo values(3,'貂蝉',500,55,'女','吴国');
    insert into sanguo values(4,'张飞',901,99,'男','蜀国');
    insert into sanguo values(5,'赵云',401,75,'男','蜀国');     

    查找所有蜀国人的信息
    select * from sanguo where country='蜀国';

    将赵云的攻击力设置为360,防御力设置为68
    update sanguo set attack=360,defense=68 where name='赵云';

    将吴国英雄中攻击值为110的英雄的攻击值改为100,防御力改为60
    update sanguo set attack=100,defense=60 where country='吴国' and  attack=500;

    找出攻击值高于200的蜀国英雄的名字、攻击力
    select name,attack from sanguo where country='蜀国' and attack>200;
    ​
    将蜀国英雄按攻击值从高到低排序
    select * from sanguo where country='蜀国' order by attack desc;

    魏蜀两国英雄中名字为三个字的按防御值升序排列
    select * from sanguo where country in ('魏国','蜀国') and name like '___' order by defense ;

    在蜀国英雄中,查找攻击值前3名且名字不为 NULL 的英雄的姓名、攻击值和国家
    select name,attack,country from sanguo 
    where country='蜀国' and  name is not NULL order by attack desc limit 3;

聚合函数
    方法	    功能
    avg(字段名)	平均值
    max(字段名)	最大值
    min(字段名)	最小值
    sum(字段名)	和
    count(id) 计数
    count(*)   可统计所有数据，包括值为NULL的数据
    找出表中的最大攻击力的值？
    select max(attack) as max from sanguo;

    表中共有多少个英雄？
    select count(id) as number from sanguo;
    ​
    蜀国英雄中攻击值大于200的英雄的数量
    select count(id) as number from sanguo where attack>200 and country='蜀国';
group by
    计算每个国家的平均攻击力
    select country,avg(attack) from sanguo group by country;

    所有国家的男英雄中 英雄数量最多的前2名的 国家名称及英雄数量
    select country,count(id) from sanguo 
    where gender='男' 
    group by country 
    order by count(id) desc 
    limit 2;
having
    where只能操作表中实际存在的字段,having操作的是聚合函数生成的显示列
    eg.找出平均攻击力大于105的国家的前2名,显示国家名称和平均攻击力
    select country,avg(attack) from sanguo 
    group by country
    having avg(attack)>105 
    order by avg(attack) desc 
    limit 2;
distinct
    distinct和from之间 所有字段都相同 才会去重
    distinct 不能做聚合处理

    eg.表中都有哪些国家
    select distinct name,country from sanguo;

    eg.计算一共有多少个国家
    select count(distinct country) from sanguo ;
运算符 ： +  -  *  /  %  **

    查询时显示攻击力翻倍
    select name,attack*2 from sanguo;
  
    更新蜀国所有英雄攻击力 * 2
    update sanguo set attack=attack*2 where country='蜀国';
索引：对数据库表中一列或多列的值进行排序的一种结构(BTree)
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
    优点：加快数据检索速度
    缺点：占用物理存储空间，需动态维护，占用系统资源，维护成本高
    索引实例
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
外键 聚簇索引
    语法
    foreign key(参考字段名 stu_id)
    references 主表 财务表(被参考字段名 id)
    on delete 级联动作
    on update 级联动作
    主表
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

    从表 级联动作
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
    删除外键
        第一步找到外键名 ：show create table 表名;
        第二步更新表,删除外键名： alter table 表名 drop foreign key 外键名;
        
    已有表添加外键
        alter table 表名 add foreign key(参考字段) references 主表(被参考字段) on delete 级联动作 on update 级联动作
嵌套查询(子查询)
    1.把攻击值小于平均攻击值的英雄名字和攻击值显示出来
    select name,attack from sanguo where attack<(select avg(attack) from sanguo);
    
    2、找出每个国家攻击力最高的英雄的名字和攻击值(子查询)
    select name,attack from sanguo 
    where (country,attack) in 
    (select country,max(attack) from sanguo group by country);
多表查询
    select province.pname,city.cname,county.coname from province ,city,county where city.cp_id=province.pid and city.cid=county.copid;
inner join 内连接（结果同多表查询，显示匹配到的记录）
    eg : 显示 省 市 县 详细信息
    select province.pname,city.cname,county.coname from  province inner join city on city.cp_id=province.pid inner join county on city.cid=county.copid;
left join 左外连接:以 左表 为主显示查询结果
    select province.pname,city.cname,county.coname from  province left join city on city.cp_id=province.pid left join county on city.cid=county.copid;
right join 右外连接:用法同左连接,以右表为主显示查询结果
    select province.pname,city.cname,county.coname from  province right join city on city.cp_id=province.pid right join county on city.cid=county.copid;
数据导入
    方式二（使用load命令）
    1、将scoretable.csv放到数据库搜索路径中
        --查看路径
        mysql>show variables like 'secure_file_priv';
         /var/lib/mysql-files/
        --终端复制文件
        Linux>
        ls |grep 'score'
        pwd 
        sudo cp /home/tarena/scoreTable.csv /var/lib/mysql-files/
        tarena@tarena:~$ sudo su
        root@tarena:/home/tarena# cd /var/lib/mysql-files/
        root@tarena:/var/lib/mysql-files# ls scoreTable.csv
        --查看权限
        root@tarena:/var/lib/mysql-files# ll
        root@tarena:/var/lib/sanguo.csv# ll
        --修改权限全开 chmod 666 文件名 让当前文件具备rw-rw-rw
        root@tarena:/var/lib/mysql-files# chmod 666 scoreTable.csv 
        --chmod 777 文件 让当前文件具备全部权限 rwx-rwx-rwx
    2、在数据库中创建对应的表
        create table scoretab(
        rank int,
        name varchar(20),
        score float(5,2),
        phone char(11),
        class char(7)
        )charset=utf8;
    3、执行数据导入语句
        load data infile '/var/lib/mysql-files/scoreTable.csv'
        into table scoretab
        fields terminated by ','
        lines terminated by '\n';
    方式一（使用source命令）
    mysql> source /home/tarena/xxx.sql

数据导出
    1.--把sanguo表中英雄的姓名、攻击值和国家三个字段导出来,放到 sanguo.csv中,
    select name,attack,country from sanguo
    into outfile "/var/lib/mysql-files/sanguo.csv" 
    fields terminated by "," 
    lines terminated by "\n";
    --移动到/home/tarena/路径下
    root@tarena:/var/lib/mysql-files# mv sanguo.csv /home/tarena/

    2.--将mysql库下的user表中的 user、host两个字段的值导出到 user2.txt，将其存放在数据库目录下
    select User,Host from user
    into outfile "/var/lib/mysql-files/user2.txt" 
    fields terminated by "," 
    lines terminated by "\n";
复制表
    提醒
    1、表能根据实际需求复制数据
    2、复制表时不会把KEY属性复制过来
    语法
    create table 表名 select 查询命令;
    eg:复制sanguo表的 id,name,country 三个字段的前3条记录,sanguo4    
    create table sanguo4 select id,name,country from country.sanguo limit3;
复制表结构:+where false;
    eg:
    create table students3 select * from students where false;
锁（自动加锁和释放锁）
    目的:解决客户端并发访问的冲突问题
    锁类型分类
        读锁(共享锁)：select 加读锁之后别人能查、不能改
        写锁(互斥锁、排他锁)：加写锁之后别人不能查、不能改
    锁粒度分类
        表级锁 ：myisam 
        行级锁 ：innodb
mvcc多版本控制协议【innodb锁机制中 包含该机制】
    1，数据行中，预留一个version字段，该字段在数据更新时+1；
    2，当执行有version字段的数据更新时，我们需要查询一下起初select获取到的该数据行的version是否改变，
    若改变，则放弃此次更新【证明在我执行更新操作之前，已经有其他客户端进行了该行数据的更新】
    后续，可重复执行若干次相同的更新方式。若多次执行失败，可考虑更改方案

存储引擎：处理表的处理器
    1、查看所有存储引擎
    mysql> show engines;
    2、查看已有表的存储引擎
    mysql> show create table 表名;
    3、创建表指定
    create table 表名(...)engine=MyISAM,charset=utf8,auto_increment=10000;

    eg:create table myi(id int)engine=MYISAM;
    
    4、已有表指定--很少用到
    alter table 表名 engine=InnoDB;

存储引擎选择--具体根据业务场景、测试数据等具体选择，具体到             数据表结构、数量级
    1、执行查操作多的表用 MyISAM
    2、执行写操作多的表用 InnoDB
    3、临时表 ： MEMORY
常用存储引擎及特点
InnoDB	--写，事务， 行级锁，外籍an	
    1、支持行级锁
    2、支持外键、事务、事务回滚
    3、表字段和索引同存储在一个文件中
        1、表名.frm ：表结构
        2、表名.ibd : 表记录及索引文件
MyISAM--查询速度快
    1、支持表级锁
    2、表字段和索引分开存储
        1、表名.frm ：表结构
        2、表名.MYI : 索引文件(my index)
        3、表名.MYD : 表记录(my data)
MEMORY--临时表 内存型 存储的数据持久化要求不过
    1、表记录存储在内存中，效率高
    2、服务或主机重启，表记录清除，表结构存在

权限不够
    bash: cd: /var/lib/mysql: 权限不够
    tarena@tarena:~$ sudo su
    [sudo] tarena 的密码：
mysql数据存储路径 
    root@tarena:/home/tarena# cd /var/lib/mysql
重启数据库
    sudo /etc/init.d/mysql restart
查看数据库是否已经启动
    ps aux|grep 'mysqld'
    create table memoryt (id int)engine=MEMORY;
    insert into memoryt values(1),(2);
    select * from memoryt;
MySQL的用户账户管理:开启MySQL远程连接
    更改配置文件，重启服务！
        1、sudo su
        2、cd /etc/mysql/mysql.conf.d
        3、cp mysqld.cnf mysqld.cnf.bak
        4、vi mysqld.cnf #找到44行左右,加 # 注释
                        #bind-address = 127.0.0.1
        vi使用 : 按i ->编辑文件 ->ESC ->shift+: ->wq

        5、保存退出
        6、service mysql restart
        7、mysql -uroot -h176.234.6.29 -p  --查看权限
        8、select user,host from mysql.user \G

    添加授权用户
        1、用root用户登录mysql
        mysql -uroot -p123456
        2、授权
        grant 权限列表 on 库.表 to "用户名"@"地址" identified by "密码" 
        3、刷新权限
        flush privileges;
    授权关键字
        all privileges,select,insert ... ... 
        库.表 ： *.* 代表所有库的所有表   ex: db2.*
        地址： localhost 或者 具体ip 或者 % 
        当地址 用 % 代表可以用任何地址进入mysql
    示例
        1、添加授权 用户work,密码123,对所有库的所有表有所有权限
        mysql -uroot -p123456
        mysql>grant all privileges on *.* to 'work'@'%' identified by '123' 
        with grant option;
        mysql>flush privileges; --将当前mysql.user中的数据 加载值内存中，供 mysql服务进行权限检查；
        mysql>select user,host from mysql.user;
        新开终端：
        tarena@tarena:~$ mysql -uwork -h176.234.6.29 -p123

        2、添加授权 用户work4,密码1234,只对country的所有表有 select,update 权限
        tarena@tarena:~$ mysql -uroot -p123456
        mysql>grant select,update on country.* to 'work4'@'%' identified by '1234';
        mysql>flush privileges; 
        mysql>select user,host from mysql.user;
        tarena@tarena:~$ mysql -uwork4 -h176.234.6.29 -p12;

        3、添加用户duty,对db2库中所有表有所有权限 
        tarena@tarena:~$mysql -uroot -p123456
        mysql>grant all privileges on db2.* to 'duty'@'%' identified by '123';
        mysql>flush privileges; 
        mysql>select user,host from mysql.user;
        新开终端：
        tarena@tarena:~$ mysql -uduty -h176.234.6.29 -p123

    mysql.user-显示全局的mysql用户，该表显示的具体权限只针对于全局用户有效【全局用户-指对当前mysql中所有库及所有表都有相应权限的用户】；
    mysql.db -显示只有对特定db有操作权限的用户【grant时被指定数据库的用户】
    当mysql服务接到sql语句的时候，权限排查 mysql.user->mysql.db 

事务和事务回滚
    事务定义:一件事从开始发生到结束的过程
    作用:确保数据的一致性、准确性、有效性
事务操作
    1、开启事务
    mysql>begin; # 方法1
    mysql>start transaction; # 方法2
    2、开始执行事务中的1条或者n条SQL命令
    3、终止事务
    mysql>commit; # 事务中SQL命令都执行成功,提交到数据库,结束!
    mysql>rollback; # 有SQL命令执行失败,回滚到初始状态,结束!
    update bank set money=100000 where name='wanger';

事务四大特性（ACID）
    1、原子性（atomicity）--结果
        一个事务必须视为一个不可分割的最小工作单元，整个事务中的所有操作要么全部提交成功，要么全部失败回滚，对于一个事务来说，不可能只执行其中的一部分操作
    2、一致性（consistency）--过程
        数据库总是从一个一致性的状态转换到另一个一致性的状态
    3、隔离性（isolation）
        一个事务所做的修改在最终提交以前，对其他事务是不可见的
    4、持久性（durability）
        一旦事务提交，则其所做的修改就会永久保存到数据库中。此时即使系统崩溃，修改的数据也不会丢失
    注意:
        1、事务只针对于 表记录操作(增删改)有效,对于库和表的操作无效
        2、事务一旦commit提交结束，对数据库中数据的更改是永久性的
E-R模型(Entry-Relationship)
    定义:
        E-R模型即 实体-关系 数据模型,用于数据库设计
        用简单的图(E-R图)反映了现实世界中存在的事物或数据以及他们之间的关系
    实体、属性、关系
        实体
        1、描述客观事物的概念
        2、表示方法 ：矩形框
        3、示例 ：一个人、一本书、一杯咖啡、一个学生
        属性
        1、实体具有的某种特性
        2、表示方法 ：椭圆形
        3、示例
        学生属性 ：学号、姓名、年龄、性别、专业 ... 
        感受属性 ：悲伤、喜悦、刺激、愤怒 ...
关系（重要）
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
ER图的绘制
    矩形框代表实体,菱形框代表关系,椭圆形代表属性
    https://www.processon.com/diagraming/5da42cd2e4b04913a134fc22

        课堂示例（老师研究课题）
        1、实体 ：教师、课题
        2、属性
        教师 ：教师代码、姓名、职称
        课题 ：课题号、课题名
        3、关系
        多对多（m:n)
        # 一个老师可以选择多个课题，一个课题也可以被多个老师选
关系映射实现（重要）
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
多对多实现
    老师研究课题:实现老师和课题之间的多对多映射关系
    表1、老师表
        create table teacher(
            id int primary key,
            tname varchar(10),
            level varchar(20)
        )charset=utf8;
        insert into teacher values(1,'郭小闹','good'),(2,'王老师','goodgood');
    表2、课题表
        create table course(
        id int primary key,
        cname varchar(10)
        )charset=utf8;
        insert into course values(1,'python1'),(2,'python2'),(3,'python3'),(4,'python4');
    中间表：
        create table middle1(
        id int primary key,
        tid int,
        cid int,
        foreign key(tid) references teacher(id),
        foreign key(cid) references course(id)
        )charset=utf8;

        insert into middle1 values(1,1,1),(2,1,2),(3,2,1),(4,2,1);
        update middle1 set cid=3 where id=4;

        select * from middle1;
    问：郭小闹在研究什么课题？(内联接)
        select teacher.tname,course.cname from middle1 
        inner join teacher on teacher.id=middle1.tid inner join course on course.id=middle1.cid
        where teacher.tname='郭小闹';    ​
MySQL调优
    存储引擎优化
        1、读操作多：MyISAM
        2、写操作多：InnoDB
    索引优化
        在 select、where、order by 常涉及到的字段建立索引
    SQL语句优化，否则放弃索引全表扫描
        1、单条查询最后添加 LIMIT 1
        2、where子句中不使用 !=
        3、避免 NULL 值判断，在number列上设置默认值0,确保number列无NULL值
            select number from t1 where number=0;
        4、避免 or 连接条件
            select id from t1 where id=10 union all select id from t1 where id=20;
        5、避免使用前置 % 
        6、避免使用 in 和 not in
            select id from t1 where id between 1 and 4;
        7、用具体字段代替 select * 


1、聚合函数题：找出在本站发表的所有评论数量最多的10位用户及评论数，并按评论数从高到低排序
    select user_id,count(user_id) from comment
    group by user_id
    order by count(user_id) desc
    limit 10;
2、增删改查题综述：
两张表，一张顾客信息表customers，一张订单表orders；
设置此表中的o_id字段为customers表中c_id字段的外键,更新删除同步。

表1：顾客信息表，完成后插入3条表记录
c_id 类型为整型，设置为主键，并设置为自增长属性
c_name 字符类型，变长，宽度为20
c_age 微小整型，取值范围为0~255(无符号)
c_sex 枚举类型，要求只能在('M','F')中选择一个值
c_city 字符类型，变长，宽度为20
c_salary 浮点类型，要求整数部分最大为10位，小数部分为2位
        create table customers(
        c_id int primary key auto_increment,
        c_name varchar(20),
        c_age tinyint unsigned,
        c_sex enum('M','F'),
        c_city varchar(20),
        c_salary decimal(12,2)
        )charset=utf8;
        insert into customers values(1,'Tom',25,'M','上海',10000),(2,'Lucy',23,'F','广州',12000),(3,'Jim',22,'M','北京',11000);
    表2：顾客订单表（在表中插入5条记录）
    o_id 整型
    o_name 字符类型，变长，宽度为30
    o_price 浮点类型，整数最大为10位，小数部分为2位
    --设置此表中的o_id字段为customers表中c_id字段的外键,更新删除同步。
    -- drop table orders;
        create table orders(
        o_id int,
        o_name varchar(30),
        o_price decimal(12,2),
        foreign key(o_id) references customers(c_id) on delete cascade on update cascade 
        )charset=utf8;
        insert into orders values(1,"iphone",5288),(1,"ipad",3299),(2,"iwatch",2222),(2,"r11",4400);

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


。。。
。。。
vim 常用命令
    i 进入插入模式，在当前光标处进行插入
    H J K L 移动光标 	
    u 进行编辑撤回
    Esc退出当前模式
    ：w 保存
    :wq 保存并退出
    行数+shift+g 定位到当前行
    连续按两次d 可进行当前行的删除
    n[行数]+两次d 可删除从当前行+n 行的数据
    ex: 3 dd 删除当前行往下3行数据【包含当前行】
    ：sp 水平分屏
    ：vs 垂直分屏
    :q 退出vim命令/退出当前光标所在分屏
    o 直接在当前行新起一空行，且进入插入模式    
    注意：光标移动 ctrl+w+H or J or K or L

    单行复制：
        yy 复制当前光标行整行内容
        p 粘贴
    多行复制：
        n+yy 复制当前行+【n-1】行内容
    选择复制：
        v + H or J or K or L 移动光标至想要复制内容结尾，点击y复制内容，复制后执行 V+H OR 可把复制的内容粘提到当前光标位置
        :E 打开当前文件所在路径下的 列表页，在当前页可进行其他文件查看，将光标移动到想查看的文件，执行回车即可进入其他vi模式
    :$ 立即跳转到当前文件最后一行
        shift + g 同上
    腾讯 华为 公有云 ubuntu 18.04
        
