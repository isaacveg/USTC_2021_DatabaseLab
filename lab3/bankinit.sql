use mydb;
delete from Bank where city is not NULL ;
delete from Department where ID is not NULL ;
delete from Staff where ID is not NULL ;
# 银行初始化
insert into Bank(city,name) values("合肥","合肥西支行");
insert into Bank(city,name) values("合肥","合肥东支行");
insert into Bank(city,name) values("上海","上海总部");
select * from Bank;
# 部门初始化
insert into Department(ID,name,type,managerID,Bank_name) values("01","营销部","loan","00001","合肥西支行");
insert into Department(ID,name,type,managerID,Bank_name) values("02","客服部","service","00002","合肥西支行");
insert into Department(ID,name,type,managerID,Bank_name) values("01","营销部","loan","00003","合肥东支行");
insert into Department(ID,name,type,managerID,Bank_name) values("02","客服部","service","00004","合肥东支行");
insert into Department(ID,name,type,managerID,Bank_name) values("01","营销部","loan","00005","上海总部");
insert into Department(ID,name,type,managerID,Bank_name) values("02","客服部","service","00006","上海总部");
select * from Department;
# 员工初始化
insert into staff values("00001","张三","120418","合肥西路38号","2000/12/5","01","合肥西支行","manager");
insert into staff values("00002","李四","195182","合肥南路60号","2012/5/23","02","合肥西支行","manager");
insert into staff values("00007","王五","102321","合肥东路12号","2012/5/23","02","合肥西支行","general");
insert into staff values("00003","小明","684930","合肥北路20号","2010/3/12","01","合肥东支行","manager");
insert into staff values("00008","小强","656306","合肥火车站20号","2019/4/4","01","合肥东支行","general");
insert into staff values("00004","小李","698203","合肥广场31号","2009/11/12","02","合肥东支行","manager");
insert into staff values("00005","大牛","799103","上海大厦3栋","2009/11/12","01","上海总部","manager");
insert into staff values("00006","James","745443","上海红星1号","2001/1/12","02","上海总部","manager");
insert into staff values("00009","Hades","787771","上海红星1号","1999/10/2","02","上海总部","general");
select * from staff;