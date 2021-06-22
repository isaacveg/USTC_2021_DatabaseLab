#设计触发器，实现:当一本书被借出时，自动将 Book 表中相应图书的 status 修改为1;
#当某本书被归还时，自动将 status 改为 0。
DROP TRIGGER IF EXISTS AutoBorrow;
DROP TRIGGER IF EXISTS AutoBack;
DELIMITER //
CREATE TRIGGER AutoBorrow AFTER INSERT ON Borrow FOR EACH ROW
BEGIN
	UPDATE Book
    SET status = 1
    WHERE ID = new.book_ID;
END//


CREATE TRIGGER AutoBack AFTER UPDATE ON Borrow FOR EACH ROW
BEGIN
	IF new.Return_Date IS NOT NULL THEN
		UPDATE Book
		SET status = 0
		WHERE ID = new.book_ID and status = 1;
	END IF;
END //
DELIMITER ;
