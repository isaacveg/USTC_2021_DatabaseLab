USE Library;

#实体完整性：主键不为0。下方语句无法运行，证明实体完整性
INSERT INTO Book(name,author) VALUE ('测试手册', '测试员');

#参照完整性：参照关系R的任一个外码值必须等于被参照关系S中所参照的候选码的某个值或者为空。下方语句无法运行，证明参照完整性
INSERT INTO Borrow(Reader_ID,book_ID) VALUE ('测试手册', '测试员');

#用户自定义完整性：针对某一具体数据的约束条件，反映某一具体应用所涉及的数据必须满足的特殊语义，由应用环境决定。
#比如定义Book的name不为0，下方语句无法运行，证明用户自定义完整性
INSERT INTO Book(ID,author,status) VALUE ('b14', '测试员2',1);