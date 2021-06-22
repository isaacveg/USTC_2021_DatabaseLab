# 客户以及账户初始化
use mydb;
delete from Costumer_has_SavingAccounts where Costumer_ID is not NULL;
delete from Costumer_has_CheckAccounts where Costumer_ID is not NULL;
delete from SavingAccounts where id is not NULL;
delete from CheckAccounts where id is not NULL;
delete from costumer where id is not NULL;
insert into Costumer value("10294","王大海","423890","王小河","423891","xiaohe@163.com","父子","合肥蜀山区黄山南路10号") ; 
insert into Costumer value("10188","齐秦",  "124090","齐天赐","124091","qtc@foxmail.com","母女","上海浦东新区红星小区2栋207");
insert into Costumer value("21233","Is'ral",  "787712","O'neil","787713","oneil@gmail.com","夫妻","Shanghai Hongxing Dist. 711");
select * from Costumer;
insert into SavingAccounts value("001",30000,"2008/12/30","2021/4/13","0.035","CNY","合肥西支行");
insert into Costumer_has_SavingAccounts value("10188","001","合肥西支行");
insert into Costumer_has_SavingAccounts value("10294","001","合肥西支行");
insert into SavingAccounts value("002",40000,"2009/2/3","2021/5/15","0.03","JPY","合肥东支行");
insert into SavingAccounts value("003",20000,"2010/11/4","2021/6/1","0.05","USD","上海总部");
insert into Costumer_has_SavingAccounts value("10294","002","合肥东支行");
insert into Costumer_has_SavingAccounts value("10294","003","上海总部");
SELECT SavingAccounts_ID, Savings, CoinType, Ratio, OpenDate, CheckinDate, name,Costumer_ID, SavingAccounts_Bank_name from Costumer,Costumer_has_SavingAccounts,SavingAccounts 
			where Costumer.ID=Costumer_has_SavingAccounts.Costumer_ID and Costumer_has_SavingAccounts.SavingAccounts_ID=SavingAccounts.ID;

insert into CheckAccounts value("500",30000,"2019/2/28","2021/5/5",50000,"合肥西支行");
insert into Costumer_has_CheckAccounts value("10188","500","合肥西支行");
insert into checkAccounts value("502",40000,"2009/2/3","2021/5/15",50000,"合肥东支行");
insert into checkAccounts value("503",20000,"2010/11/4","2021/6/1",10000,"上海总部");
insert into Costumer_has_checkAccounts value("10294","502","合肥东支行");
insert into Costumer_has_checkAccounts value("10294","503","上海总部");