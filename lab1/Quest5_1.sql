USE Library;

INSERT INTO Borrow VALUE('b8','r5','2019/12/4',NULL);		#借出去但是图书表是0
SELECT * FROM Borrow;
CALL CheckStatus(@cnt);
SELECT @cnt;

DELETE FROM Borrow WHERE book_ID = 'b8' and reader_ID = 'r5';

INSERT INTO Borrow VALUE('b8','r5','2019/12/4',NULL);
UPDATE Book SET status = 1 WHERE ID = 'b5';					#图书表是1但是并没有借出去
SELECT * FROM Borrow;
CALL CheckStatus(@cnt);
SELECT @cnt;