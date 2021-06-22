# 贷款初始化
use mydb;
delete from Costumer_has_loans where Costumer_ID is not NULL;
delete from LoansDetail where Loans_ID is not NULL;
delete from Loans where id is not NULL;

insert into Loans value("900",320000,"合肥西支行");
insert into Loans value("901",120000,"合肥西支行");
insert into Loans value("902",440000,"合肥东支行");
insert into Loans value("903",770000,"上海总部");

insert into Costumer_has_Loans value("10294","900");
insert into Costumer_has_Loans value("10294","902");
insert into Costumer_has_Loans value("10188","903");
insert into Costumer_has_Loans value("10188","901");
insert into Costumer_has_Loans value("10294","901");

insert into LoansDetail value(200000,"2019/6/16",1,"900");
insert into LoansDetail value(120000,"2020/6/16",2,"900");
insert into LoansDetail value(350000,"2002/8/21",1,"903");

