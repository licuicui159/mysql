
-- 8月涨幅大于50%

select STOCK_CODE
      ,case when stat_date = 20190801 then sp end as first_sp
      ,max(sp) as max_sp
      ,case when stat_date = 20190830 then sp end as end_sp
from hs_tdx_jg_sx
where STAT_DATE between 20190801 and 20190831


select --STOCK_CODE
     -- ,case when stat_date = 20190801 then sp end as first_sp
      max(sp) as max_sp
      --,case when stat_date = 20190830 then sp end as end_sp
from hs_tdx_jg_sx
where STAT_DATE between 20190801 and 20190831

select  * from stock_data_info
where STOCK_CODE=000001;


1.用一条SQL 语句 查询出每门课都大于80 分的学生姓名
create table books.score(
stu_name VARCHAR(10),
kecheng VARCHAR(10),
score int
)

insert into books.score(stu_name ,kecheng ,score ) values ('张三','语文',81) ;
insert into books.score(stu_name ,kecheng ,score ) values ('张三','数学',75) ;
insert into books.score(stu_name ,kecheng ,score ) values ('李四','语文',76) ;
insert into books.score(stu_name ,kecheng ,score ) values ('李四','数学',90) ;
insert into books.score(stu_name ,kecheng ,score ) values ('王五','语文',81) ;
insert into books.score(stu_name ,kecheng ,score ) values ('王五','数学',100) ;
insert into books.score(stu_name ,kecheng ,score ) values ('王五','英语',90) ;	


-- 读2次表，效率比较低   剔除掉有任意一门小于80分的人
select stu_name from books.score where stu_name not in(
select stu_name from books.score
where score <80 )
group by stu_name

--读一次表，效率高，语法高级    先取出每个人的最小分数，然后判断最小分数是不是大于80
select stu_name,min(score) from books.score
group by stu_name
HAVING min(score) >80


2. 学生表 如下:
自动编号   学号   姓名 课程编号 课程名称 分数
1        2005001 张三 0001     数学    69
2        2005002 李四 0001      数学    89
3        2005001 张三 0001      数学    69
删除除了自动编号不同, 其他都相同的学生冗余信息、

create table books.stu_info(
stu_id int ,
stu_no int ,
stu_name VARCHAR(10) ,
kc_no int ,
kc_name VARCHAR(10) ,
score int 
)


 insert into books.stu_info( stu_id  ,stu_no ,stu_name ,kc_no ,kc_name,score ) VALUES (1,2005001,'张三',001,'数学',69) ;
 insert into books.stu_info( stu_id  ,stu_no ,stu_name ,kc_no ,kc_name,score ) VALUES (2,2005001,'李四',001,'数学',89) ;
 insert into books.stu_info( stu_id  ,stu_no ,stu_name ,kc_no ,kc_name,score ) VALUES (3,2005001,'张三',001,'数学',69) ;
 
 
mysql写法：
delete from books.stu_info a where a.stu_id not in(
select stu_id from(
select min(b.stu_id) as stu_id  from books.stu_info b
group by b.stu_no,b.stu_name,b.kc_no,b.kc_name,b.score )t )


oracle写法：
delete from stu_info a where a.stu_id not in(
select min(b.stu_id) as stu_id  from stu_info b
group by b.stu_no,b.stu_name,b.kc_no,b.kc_name,b.score )
 
 
 
--分组函数
select stu_id from (
select stu_id  
      ,stu_no 
      ,stu_name 
      ,kc_no 
      ,kc_name
      ,score 
      ,row_number()over(partition by stu_no,stu_name,kc_no,kc_name,score order by stu_id ) aa
from stu_info
)
where aa = 1
 
--exists  和in类似，但是效率高于in，一般优化会优化掉in，用exists替换掉
 
 create table stu_info_1(
stu_id int ,
stu_no int ,
stu_name VARCHAR(10) ,
kc_no int ,
kc_name VARCHAR(10) ,
score int 
)

 insert into stu_info( stu_id  ,stu_no ,stu_name ,kc_no ,kc_name,score ) VALUES (1,2005001,'张三',001,'数学',69) ;
 insert into stu_info( stu_id  ,stu_no ,stu_name ,kc_no ,kc_name,score ) VALUES (2,2005001,'李四',001,'数学',89) ;
 insert into stu_info( stu_id  ,stu_no ,stu_name ,kc_no ,kc_name,score ) VALUES (3,2005001,'张三',001,'数学',69) ;
 insert into stu_info( stu_id  ,stu_no ,stu_name ,kc_no ,kc_name,score ) VALUES (4,2005001,'王五',001,'数学',89) ;
 insert into stu_info( stu_id  ,stu_no ,stu_name ,kc_no ,kc_name,score ) VALUES (5,2005001,'王五',001,'数学',89) ;
 
 insert into stu_info_1( stu_id  ,stu_no ,stu_name ,kc_no ,kc_name,score ) VALUES (1,2005001,'张三',001,'数学',69) ;
 insert into stu_info_1( stu_id  ,stu_no ,stu_name ,kc_no ,kc_name,score ) VALUES (4,2005001,'王五',001,'数学',89) ;

 
 select * from stu_info ;
  select * from stu_info_1 ;
 -- 低级脚本
delete from  stu_info a where a.stu_id  in
(select stu_id from stu_info_1 b ) ;

--高级脚本
delete from  stu_info a where exists
(select 1 from stu_info_1 b where a.stu_id = b.stu_id) ;
 
--delete/drop/truncate优缺点分析 
 delete   操作慢    高水位        记录日志  删除表数据
 drop              不会造成高水位 不记录日志 删除表结构以及表中所有信息
 truncate 截断表快  不会造成高水位 不记录日志 只删除数据

 
--笛卡儿积：四个球队a,b,c,d,进行比赛，用一条sql 语句显示所有可能的比赛组合
SELECT  * FROM team A
LEFT OUTER JOIN TEAM B ON 1=1
WHERE A.TEAM_NAME <> B.TEAM_NAME  --  <> 不等于

WHERE 1=1  为真   1=2  为假

4.请用SQL 语句实现：从TestDB 数据表中查询出所有月份的发生额都比101 科目相应月份的发生额高的科目。请注意：TestDB 中有很多科目，都有1 －12 月份的发生额。
AccID ：科目代码，Occmonth ：发生额月份，DebitOccur ：发生额。
数据库名：JcyAudit ，数据集：Select * from TestDB

答：select a.*
from TestDB a 
,(select Occmonth,max(DebitOccur) Debit101ccur from TestDB where AccID='101' group by Occmonth) b
where a.Occmonth=b.Occmonth and a.DebitOccur>b.Debit101ccur

create table TestDB(
AccID int,
Occmonth int,
DebitOccur int
);


Select * from TestDB;

insert into TestDB(AccID,Occmonth,DebitOccur) values(101,1,100);
insert into TestDB(AccID,Occmonth,DebitOccur) values(101,2,150);
insert into TestDB(AccID,Occmonth,DebitOccur) values(101,3,500);
insert into TestDB(AccID,Occmonth,DebitOccur) values(101,4,1960);
insert into TestDB(AccID,Occmonth,DebitOccur) values(101,5,1000);
insert into TestDB(AccID,Occmonth,DebitOccur) values(101,6,5100);
insert into TestDB(AccID,Occmonth,DebitOccur) values(101,7,1800);
insert into TestDB(AccID,Occmonth,DebitOccur) values(101,8,10);
insert into TestDB(AccID,Occmonth,DebitOccur) values(101,9,800);
insert into TestDB(AccID,Occmonth,DebitOccur) values(101,10,150);
insert into TestDB(AccID,Occmonth,DebitOccur) values(101,11,1100);
insert into TestDB(AccID,Occmonth,DebitOccur) values(101,12,1900);
insert into TestDB(AccID,Occmonth,DebitOccur) values(102,1,9900);
insert into TestDB(AccID,Occmonth,DebitOccur) values(103,9,900);
insert into TestDB(AccID,Occmonth,DebitOccur) values(104,10,6900);


insert into TestDB(AccID,Occmonth,DebitOccur) values(101,1,200);
insert into TestDB(AccID,Occmonth,DebitOccur) values(101,2,151);
insert into TestDB(AccID,Occmonth,DebitOccur) values(101,3,525);
insert into TestDB(AccID,Occmonth,DebitOccur) values(101,4,1961);
insert into TestDB(AccID,Occmonth,DebitOccur) values(101,5,100);
insert into TestDB(AccID,Occmonth,DebitOccur) values(101,6,500);
insert into TestDB(AccID,Occmonth,DebitOccur) values(101,7,800);
insert into TestDB(AccID,Occmonth,DebitOccur) values(101,8,100);
insert into TestDB(AccID,Occmonth,DebitOccur) values(101,9,300);
insert into TestDB(AccID,Occmonth,DebitOccur) values(101,10,50);
insert into TestDB(AccID,Occmonth,DebitOccur) values(101,11,100);
insert into TestDB(AccID,Occmonth,DebitOccur) values(101,12,900);

select a.*
from TestDB a 
,(select Occmonth,max(DebitOccur) Debit101ccur from TestDB where AccID=101 group by Occmonth) b
where a.Occmonth=b.Occmonth and a.DebitOccur>b.Debit101ccur

 
5.面试题：怎么把这样一个表儿
year   month amount
1991   1     1.1
1991   2     1.2
1991   3     1.3
1991   4     1.4
1992   1     2.1
1992   2     2.2
1992   3     2.3
1992   4     2.4
查成这样一个结果
year m1   m2   m3   m4
1991 1.1 1.2 1.3 1.4
1992 2.1 2.2 2.3 2.4 



create table Test01(
year1 int,
month1 int,
amount float
);

select * from Test01

insert into Test01(year1,month1,amount) values(1991,1,1.1);
insert into Test01(year1,month1,amount) values(1991,2,1.2);
insert into Test01(year1,month1,amount) values(1991,3,1.3);
insert into Test01(year1,month1,amount) values(1991,4,1.4);
insert into Test01(year1,month1,amount) values(1992,1,2.1);
insert into Test01(year1,month1,amount) values(1992,2,2.2);
insert into Test01(year1,month1,amount) values(1992,3,2.3);
insert into Test01(year1,month1,amount) values(1992,4,2.4);


--练习查询执行计划 Explain plan
--效率低，单表读5次，耗费高
select year1, 
(select amount from   Test01 m where month1=1   and m.year1=Test01.year1) as m1,
(select amount from   Test01 m where month1=2   and m.year1=Test01.year1) as m2,
(select amount from   Test01 m where month1=3   and m.year1=Test01.year1) as m3,
(select amount from   Test01 m where month1=4   and m.year1=Test01.year1) as m4
from Test01   group by year1

-- 过程脚本
select year1
      ,case when month1= 1 then amount end  as m1
      ,case when month1= 2 then amount end  as m2
      ,case when month1= 3 then amount end  as m3
      ,case when month1= 4 then amount end  as m4
 from Test01 ;
 
 select * from Test01 ;

-- 结果脚本，效率高，耗费小
select year1
      ,max(case when month1= 1 then amount end ) as m1
      ,max(case when month1= 2 then amount end ) as m2
      ,max(case when month1= 3 then amount end ) as m3
      ,max(case when month1= 4 then amount end ) as m4
 from Test01
group by year1 ;
 
 
 

--函数学习
select avg(stock_price) as avg_price
      ,count(stock_code) as cnt_price
      ,max(stock_price) as max_price
      ,min(stock_price) as min_price
      ,sum(stock_price)  as sum_price
from stock_data_info
where STOCK_CODE=000001;

--group by  分组
select stock_code
      ,stock_name 
      ,avg(stock_price) as avg_price
      ,count(stock_code) as cnt_price
      ,max(stock_price) as max_price
      ,min(stock_price) as min_price
      ,sum(stock_price)  as sum_price
from stock_data_info
where STOCK_TRADE='房地产'
group by stock_code
      ,stock_name ;
      
-- having       
select stock_code
      ,stock_name 
      ,avg(stock_price) as avg_price
      ,count(stock_code) as cnt_price
      ,max(stock_price) as max_price
      ,min(stock_price) as min_price
      ,sum(stock_price)  as sum_price
from stock_data_info
where STOCK_TRADE='房地产'
group by stock_code
      ,stock_name 
having avg(stock_price)>10  and min(stock_price)>15   ;
      
--STAT_DATE,STOCK_CODE,STOCK_NAME,STOCK_PRICE

select * from hs_tdx_jg_sx
--STOCK_CODE,STAT_DATE,KP
 
 
 
 
 
 
