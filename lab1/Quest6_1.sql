USE Library;

#借出，status变为1
SELECT ID,name,status FROM Book;
INSERT INTO Borrow VALUE ('b8','r1','2021/4/15',NULL);
SELECT * FROM Borrow;
SELECT ID,name,status FROM Book;

#返还，status变为0
UPDATE Borrow SET Return_Date = '2021/4/16' WHERE book_ID = 'b8' and reader_ID = 'r1';
SELECT ID,name,status FROM Book;
SELECT * FROM Borrow;