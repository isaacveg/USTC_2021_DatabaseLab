USE Library;
#DELETE FROM Book WHERE ID = 'b114514';
CALL ChangeBookID('b20','b1',@message);
SELECT @message;

CALL ChangeBookID('b1','b20',@message);
SELECT @message;
SELECT * FROM Book;
SELECT * FROM Borrow;



