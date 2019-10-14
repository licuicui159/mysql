数据库：database 数据表：table  字段：column  记录：row  主键：primary key

--终端打开mysql数据库
mysql -u root -p 123456
--创建数据库
create database books charset=utf8;
show databases;

-- 创建表
-- 第一步：
use books;

-- 第二步：
create table book (
   id int primary key auto_increment,
   title varchar(64) not null,
   passwd varchar(32) not null，
   author varchar(32) default "佚名",
   price float,
   publication varchar(256),
   time datetime default now(),
   comment text
   )charset=utf8,auto_increment=10000;##设置自增长起始值
--#查看表结构
desc [tb] 
show create table [tb]
--增删改查
insert into [tb] values(val1,val2...)
delete from user where name='小王';
update book set publication_date='2004-01-07' where id=2;
select * from book where publication_date > (curdate()-interval 3 year);

--#按出版日期默认升序排序
select * from book order by publication_date;
				 
--#按价格降序排序取前２位
select * from book order by price desc limit 2; 

--limit限制显示查询记录的条数（永远放在最后写）
   limit n ：显示前n条
   limit m,n ：从第(m+1)条记录开始，显示n条
   limit(6-1)*10,10 分页：每页显示10条，显示第6页的内容

--正则表达式取值
select * from book where publication like '%中国%';
select * from book where publication regexp '中国';
select * from book where publication regexp '^B.+';
				 
--表字段的操作(alter)
语法 :alter table 表名 执行动作;
* 添加字段(add)
alter table 表名 add 字段名 数据类型;
alter table 表名 add 字段名 数据类型 first;
alter table book add publication_date date after price;
* 删除字段(drop)
alter table 表名 drop 字段名;
* 修改数据类型(modify)
alter table 表名 modify 字段名 新数据类型;
* 修改字段名(change)
alter table 表名 change 旧字段名 新字段名 新数据类型;
* 表重命名(rename)
alter table 表名 rename 新表名;
e.g.
alter table interest add tel char(11) after name;
--*删除表
drop table [tb]

-- #创建图片表
create table images(
   id int primary key auto_increment,
   photo blob,
   comment text
   );

--#　插入图片
with open('0.jpg','rb') as f:
	data=f.read()
sql="insert into images values (1,%s,%s)"
cur.execute(sql,[data,'初恋'])
db.commit()
				 
--#　提取图片
sql="select photo from images where comment='初恋';"
cur.execute(sql)
data=cur.fetchone()[0]
with open('1.jpg','wb') as f:
    f.write(data)
--创建表类型
   c_id 类型为整型，设置为主键，并设置为自增长属性
   c_name 字符类型，变长，宽度为20
   c_age 微小整型，取值范围为0~255(无符号)
   c_sex 枚举类型，要求只能在('M','F')中选择一个值
   c_city 字符类型，变长，宽度为20
   c_salary 浮点类型，要求整数部分最大为10位，小数部分为2位

   create table customers (
      c_id int primary key auto_increment,
      c_name varchar(20),
      c_age tinyint unsigned,
      c_sex enum('M','F'),
      c_city varchar(20),
      c_salary float(12,2)
   );

＃　备份命令
tarena@tarena:~/1907/base2_mysql/day15$ mysqldump -uroot -p stu>./class_1.sql
Enter password: 
tarena@tarena:~/1907/base2_mysql/day15$ ls
book.sql  class_1.sql  stu.sql

＃　将字典插入数据库
f=open('dict.txt')
sql="insert into words (word,mean) values (%s,%s);"
for line in f:
    tmp=line.split(' ',1)
    word=tmp[0]
    mean=tmp[1].strip()
    cur.execute(sql,[word,mean])				 				 
					 
'''
write_db.py
pymysql写操作（insert,delete,updata）
'''
import pymysql

# 建立数据库连接(db = pymysql.connect(...))
db=pymysql.connect(host='localhost',
                   port=3306,
                   user='root',
                   password='123456',
                   database='stu',
                   charset='utf8'
                   )

# 获取游标
cur=db.cursor()

#　输入数据
id=int(input("Id:"))
name=input("Name:")
age=int(input("Age:"))
score=int(input("Score:"))

try:

    # sql="insert into class_1 (name,age,score) values('%s',%d,%d);" % (name,age,score)

    # 插入操作
    sql = "insert into class_1 (id,name,age,score) values (%s,%s,%s,%s)"
    cur.execute(sql,[id,name,age,score])

    #修改操作
    sql="update class_1 set score=60 where name='YDFJ';"
    cur.execute(sql)

    #删除操作
    sql="delete from class_1 where id=8;"
    cur.execute(sql)

    db.commit()  #同步数据库
except Exception as e:
    print(e)
    db.rollback() # 回滚到没有commit之前的状态

cur.close()
db.close()
					 
#  json ： 数据格式 "{'xxx':'abc'}"  "[1,2,3,4]"
import json
json.dumps(dict/list)  #将字典或者列表转换为json格式
json.loads(json)  #将json数据解析为Python类型
					 
让程序后台执行
服务器部署ps -aux | grep python3

# python声明路径
#!/usr/bin/env python3
					 
让程序后台运行

  1. 程序第一行加解释器路径
     #! /usr/bin/env python3

  2. 设置程序的可执行权限
     chmod 774 httpserer.py

  3. 执行的时候后面加 &
     ./httpserver.py  &

  4. 如果想让程序在任意目录下都可以执行可以添加到/usr/bin下

     cd /usr/bin
     sudo  ln -s /home/tarena/.../httpserver.py  http
					 
					 