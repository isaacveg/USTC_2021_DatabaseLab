#设计一个存储过程，实现对 Book 表的 ID 的修改(本题要求不得使用外键定义时的
#on update cascade 选项，因为该选项不是所有 DBMS 都支持)。
USE Library;
DROP PROCEDURE IF EXISTS ChangeBookID;

DELIMITER //
CREATE PROCEDURE ChangeBookID(IN oldID char(8), IN newID char(8), OUT message varchar(20))
BEGIN
	DECLARE bname varchar(20);
	DECLARE bauthor varchar(10);
	DECLARE bprice float;
	DECLARE bstatus int;
    
    DECLARE s int DEFAULT 0;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET s = 1;
	
	START TRANSACTION;
	SELECT name, author, price, status 
	FROM Book
	WHERE ID = oldID
	INTO bname, bauthor, bprice, bstatus;
        
	INSERT INTO Book VALUE (newID, bname, bauthor, bprice, bstatus);
	UPDATE Borrow SET book_ID = newID WHERE book_ID = oldID;
	DELETE FROM Book WHERE ID = oldID;
	
    IF s = 0 THEN
		SET message = 'SUCCESS!';
        COMMIT;
	ELSE
		SET message = 'ERROR OCCURED!';
        ROLLBACK;
	END IF;
END //
DELIMITER ;

