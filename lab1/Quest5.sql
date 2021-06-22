#设计一个存储过程，检查每本图书 status 是否正确，并返回 status 不正确的图书数
USE Library;
DROP PROCEDURE IF EXISTS CheckStatus;

DELIMITER //
CREATE PROCEDURE CheckStatus(OUT cnt INT)
BEGIN
	DECLARE cnt1 INT DEFAULT 0;
    DECLARE cnt2 INT DEFAULT 0;

	SELECT count(*)    #图书中归还 在 借书表中未归还
	FROM Book
	WHERE status = 0      
	and ID IN(
		SELECT book_ID FROM Borrow WHERE Return_Date IS NULL           	
	)
    INTO cnt1;
    
    SELECT count(*)
	FROM Book
	WHERE status = 1  #图书中未归还 不在 借书表中未归还
	and ID NOT IN(
		SELECT book_ID FROM Borrow WHERE Return_Date IS NULL     
	)
    INTO cnt2;
    
    
    SET cnt = cnt1 + cnt2;
END //

DELIMITER ;