USE Library;

#1. 检索读者 Rose 的读者号和地址;
SELECT ID, address FROM Reader WHERE name='Rose';

#2. 检索读者 Rose 所借阅读书(包括已还和未还图书)的图书名和借期;
SELECT Book.name, Borrow.Borrow_Date
FROM Reader, Book, Borrow
WHERE Book.ID=Borrow.book_ID and Borrow.Reader_ID=Reader.ID
and Reader.name = 'Rose';

#3. 检索未借阅图书的读者姓名;
SELECT name
FROM Reader
WHERE ID NOT IN (
	select distinct Reader_ID from Borrow
);

#4. 检索 Ullman 所写的书的书名和单价;
SELECT name, price
FROM Book
WHERE author='Ullman';

#5. 检索读者“李林”借阅未还的图书的图书号和书名;
SELECT Book.ID, Book.name
FROM Book, Reader, Borrow
WHERE Book.ID=Borrow.book_ID and Borrow.Reader_ID=Reader.ID
and Borrow.Return_Date IS NULL and Reader.name = '李林';

#6. 检索借阅图书数目超过 3 本的读者姓名;
SELECT Reader.name
FROM Reader, Borrow
WHERE Borrow.Reader_ID=Reader.ID
GROUP BY Reader.ID
HAVING COUNT(*)>3;

#7. 检索没有借阅读者“李林”所借的任何一本书的读者姓名和读者号;
SELECT name, ID
FROM Reader
WHERE ID NOT IN (
	SELECT distinct Reader_ID #借过李林的书的人
	FROM Borrow 
	WHERE book_ID IN (
		SELECT distinct Borrow.book_ID #李林借过的书
		FROM Reader, Borrow
		WHERE Borrow.Reader_ID=Reader.ID 
		and Reader.name='李林')
);

#8. 检索书名中包含“Oracle”的图书书名及图书号;
SELECT name, ID
FROM Book
WHERE name LIKE '%Oracle%';

#9. 创建一个读者借书信息的视图，该视图包含读者号、姓名、所借图书号、图书名和借期;
#并使用该视图查询最近一年所有读者的读者号以及所借阅的不同图书数;
#DROP VIEW ReaderBorrow;
CREATE VIEW ReaderBorrow(Reader_ID,Reader_name, Book_ID, Book_name, Borrow_Date) AS
SELECT Reader.ID, Reader.name, Book.ID, Book.name, Borrow.Borrow_Date
FROM Book, Reader, Borrow
WHERE Book.ID=Borrow.book_ID and Borrow.Reader_ID=Reader.ID;

SELECT Reader_ID, COUNT(*) AS BooksBorrowed
FROM ReaderBorrow
GROUP BY Reader_ID;



