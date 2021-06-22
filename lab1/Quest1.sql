USE Library;
DROP TABLES Book, Reader, Borrow;
#创建上述基本表，并插入部分测试数据;

CREATE TABLE IF NOT EXISTS Book(
    ID char(8) PRIMARY KEY,
    name varchar(20) NOT NULL,
    author varchar(10),
    price float,
    status int DEFAULT 0,
    Constraint state_c CHECK (status = 0 OR status = 1)
)charset=utf8;

CREATE TABLE IF NOT EXISTS Reader(
    ID char(8) PRIMARY KEY,
    name varchar(10) NOT NULL,
    age int,
    address varchar(20)
)charset=utf8;

CREATE TABLE IF NOT EXISTS Borrow(
	book_ID char(8),
    Reader_ID char(8),
    Borrow_Date date,
	Return_Date date,
    constraint PK PRIMARY KEY (book_ID, Reader_ID),
    constraint FK_rid FOREIGN KEY (Reader_ID) REFERENCES Reader (ID),
    constraint FK_bid FOREIGN KEY (book_ID) REFERENCES Book (ID)
)charset=utf8;

# 插入书籍
insert into Book value('b1', '数据库系统实现', 'Ullman', 59.0, 1);
insert into Book value('b2', '数据库系统概念', 'Abraham', 59.0, 1);
insert into Book value('b3', 'C++ Primer', 'Stanley', 78.6, 1);
insert into Book value('b4', 'Redis设计与实现', '黄建宏', 79.0, 1);
insert into Book value('b5', '人类简史', 'Yuval', 68.00, 0);
insert into Book value('b6', '史记(公版)', '司马迁', 220.2, 1);
insert into Book value('b7', 'Oracle Database 编程艺术', 'Thomas', 43.1, 1);
insert into Book value('b8', '分布式数据库系统及其应用', '邵佩英', 30.0, 0);
insert into Book value('b9', 'Oracle 数据库系统管理与运维', '张立杰', 51.9, 0);
insert into Book value('b10', '数理逻辑', '汪芳庭', 22.0, 0);
insert into Book value('b11', '三体', '刘慈欣', 23.0, 1);
insert into Book value('b12', 'Fluent python', 'Luciano', 354.2, 1);

# 插入读者
insert into Reader value('r1', '李林', 18, '中国科学技术大学东校区');
insert into Reader value('r2', 'Rose', 22, '中国科学技术大学北校区');
insert into Reader value('r3', '罗永平', 23, '中国科学技术大学西校区');
insert into Reader value('r4', 'Nora', 26, '中国科学技术大学北校区');
insert into Reader value('r5', '汤晨', 22, '先进科学技术研究院');

# 插入借书
insert into Borrow value('b5','r1',  '2021-03-12', '2021-04-07');
insert into Borrow value('b6','r1',  '2021-03-08', '2021-03-19');
insert into Borrow value('b11','r1',  '2021-01-12', NULL);

insert into Borrow value('b3', 'r2', '2021-02-22', NULL);
insert into Borrow value('b9', 'r2', '2021-02-22', '2021-04-10');
insert into Borrow value('b7', 'r2', '2021-04-11', NULL);

insert into Borrow value('b1', 'r3', '2021-04-02', NULL);
insert into Borrow value('b2', 'r3', '2021-04-02', NULL);
insert into Borrow value('b4', 'r3', '2021-04-02', '2021-04-09');
insert into Borrow value('b7', 'r3', '2021-04-02', '2021-04-09');

insert into Borrow value('b6', 'r4', '2021-03-31', NULL);
insert into Borrow value('b12', 'r4', '2021-03-31', NULL);

insert into Borrow value('b4', 'r5', '2020-04-10', NULL);

