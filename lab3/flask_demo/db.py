import pymysql
from pymysql import cursors
from pymysql.cursors import Cursor
from pymysql.err import OperationalError
from werkzeug.utils import format_string

def db_login(user, passwd, server_addr, dbname):
    try:
        db = pymysql.connect(host=server_addr,user=user,password=passwd,db=dbname, port=3306)
    except OperationalError:
        db = None

    return db

# Costumer Operations
def db_searchcostumer(searchkey,type,db):
    cursor = db.cursor()
    if searchkey == '':
        cursor.execute("SELECT * FROM Costumer order by Costumer.ID")
    else:
        execstr = "select * from Costumer where "+type+" like "+"\"%"+searchkey+"%\""
        cursor.execute(execstr)
    tabs = cursor.fetchall()
    cursor.close()
    return tabs

def db_addcostumer(db,id,name,tel,cname,ctel,cmail,rel,addr):
    cursor=db.cursor()
    execstr="insert into Costumer value(\""+id+'\",\"'+name+'\",\"'+tel+'\",\"'+cname+'\",\"'+ctel+'\",\"'+cmail+'\",\"'+rel+'\",\"'+addr+'\")'
    try:
        cursor.execute(execstr)
        db.commit()
        cursor.close()
        return 1
    except:
        db.rollback()
        cursor.close()
        return 0

def db_updcostumer(db,orid,id,name,tel,cname,ctel,cmail,crel,addr):
    cursor=db.cursor()
    exechead="update Costumer set "
    exectail=" where id ='"+orid+"';"
    try:
        if len(id):
            cursor.execute(exechead+"id = '"+id+"'"+exectail)
            exectail=" where id ='"+id+"';"
        if len(name):
            cursor.execute(exechead+"name = '"+name+"'"+exectail)
        if len(tel):
            cursor.execute(exechead+"tel = '"+tel+"'"+exectail)
        if len(cname):
            cursor.execute(exechead+"ContactName = '"+cname+"'"+exectail)
        if len(ctel):
            cursor.execute(exechead+"ContactTel = '"+ctel+"'"+exectail)
        if len(cmail):
            cursor.execute(exechead+"ContactEmail = '"+cmail+"'"+exectail)
        if len(crel):
            cursor.execute(exechead+"ContactRelationship = '"+crel+"'"+exectail)
        if len(addr):
            cursor.execute(exechead+"Address = '"+addr+"'"+exectail)
        db.commit()
        cursor.close()
        return 1
    except:
        db.rollback()
        cursor.close()
        return 0

def db_delcostumer(db,id):
    cursor=db.cursor()
    execstr="delete from Costumer where id = '" + id +"'"
    try:
        cursor.execute(execstr)
        db.commit()
        cursor.close()
        return 1
    except:
        db.rollback()
        cursor.close()
        return 0

# Saving Accounts Operations
def db_searchsavingaccount(key,type,db):
    cursor = db.cursor()
    execstr='SELECT SavingAccounts_ID, Savings, CoinType, Ratio, OpenDate, CheckinDate, name,Costumer_ID, SavingAccounts_Bank_name from Costumer,Costumer_has_SavingAccounts,SavingAccounts where Costumer.ID=Costumer_has_SavingAccounts.Costumer_ID and Costumer_has_SavingAccounts.SavingAccounts_ID=SavingAccounts.ID'
    if len(key) == 0:
        cursor.execute(execstr+' order by SavingAccounts_ID')
    else:
        cursor.execute(execstr+' and '+type+' like '+"'%"+key+"%'"+' order by SavingAccounts_ID')
    tabs = cursor.fetchall()
    cursor.close()
    return tabs
    
def db_addcossavingaccount(db,id,acid,bank):
    cursor=db.cursor()
    execstr="insert into Costumer_has_SavingAccounts value ('"+id+"','"+acid+"','"+bank+"')"
    try:
        print(execstr)
        cursor.execute(execstr)
        
        db.commit()
        cursor.close()
        return 1
    except:
        db.rollback()
        cursor.close()
        return 0

def db_updsavingaccounts(db,orid,balance,cointype,ratio,checkin,cosid,bankname):
    cursor=db.cursor()
    exechead="update SavingAccounts set "
    exectail=" where id ='"+orid+"';"
    try:
        if len(balance):
            cursor.execute(exechead+"savings = '"+balance+"'"+exectail)
        if len(cointype):
            cursor.execute(exechead+"cointype = '"+cointype+"'"+exectail)
        if len(ratio):
            cursor.execute(exechead+"ratio = '"+ratio+"'"+exectail)
        if len(checkin):
            cursor.execute(exechead+"checkindate = '"+checkin+"'"+exectail)
        db.commit()
        cursor.close()
        if len(cosid):
            res=db_addcossavingaccount(db,cosid,orid,bankname)
            if res == 0:
                return 0
        return 1
    except:
        db.rollback()
        cursor.close()
        return 0

def db_addsavingaccount(db,addid,savings,opendate,checkindate,ratio,cointype,cosid,bank):
    cursor=db.cursor()
    execstr1="insert into savingaccounts value(\""+addid+'\",'+savings+',\"'+opendate+'\",\"'+checkindate+'\",\"'+ratio+'\",\"'+cointype+'\",\"'+bank+'\");'
    execstr2="insert into costumer_has_savingaccounts value(\""+cosid+'\",\"'+addid+'\",\"'+bank+'\");'
    try:
        cursor.execute(execstr1)
        cursor.execute(execstr2)
        db.commit()
        cursor.close()
        return 1
    except:
        db.rollback()
        cursor.close()
        return 0

def db_delsavingaccount(db,id):
    cursor=db.cursor()
    execstr1="delete from Costumer_has_savingaccounts where SavingAccounts_id = '" + id +"'"
    execstr2="delete from savingaccounts where id = '" + id +"'"
    try:
        cursor.execute(execstr1)
        cursor.execute(execstr2)
        db.commit()
        cursor.close()
        return 1
    except:
        db.rollback()
        cursor.close()
        return 0

# Check Accounts Operations
def db_searchcheckaccount(key,type,db):
    cursor = db.cursor()
    execstr='SELECT CheckAccounts_ID, Savings, DrawLeft, OpenDate, CheckinDate, name,Costumer_ID, CheckAccounts_Bank_name from Costumer,Costumer_has_CheckAccounts,CheckAccounts where Costumer.ID=Costumer_has_CheckAccounts.Costumer_ID and Costumer_has_CheckAccounts.CheckAccounts_ID=CheckAccounts.ID'
    if len(key) == 0:
        cursor.execute(execstr+' order by CheckAccounts_ID')
    else:
        cursor.execute(execstr+' and '+type+' like '+"'%"+key+"%'"+' order by CheckAccounts_ID')
    tabs = cursor.fetchall()
    cursor.close()
    return tabs

def db_addcheckaccount(db,addid,savings,opendate,checkindate,drawleft,cosid,bank):
    cursor=db.cursor()
    execstr1="insert into checkaccounts value(\""+addid+'\",'+savings+',\"'+opendate+'\",\"'+checkindate+'\",\"'+drawleft+'\",\"'+bank+'\");'
    execstr2="insert into costumer_has_checkaccounts value(\""+cosid+'\",\"'+addid+'\",\"'+bank+'\");'
    try:
        cursor.execute(execstr1)
        cursor.execute(execstr2)
        db.commit()
        cursor.close()
        return 1
    except:
        db.rollback()
        cursor.close()
        return 0

def db_addcoscheckaccount(db,id,acid,bank):
    cursor=db.cursor()
    execstr="insert into Costumer_has_CheckAccounts value ('"+id+"','"+acid+"','"+bank+"')"
    try:
        print(execstr)
        cursor.execute(execstr)
        
        db.commit()
        cursor.close()
        return 1
    except:
        db.rollback()
        cursor.close()
        return 0

def db_updcheckaccounts(db,orid,balance,drawleft,checkin,cosid,bankname):
    cursor=db.cursor()
    exechead="update CheckAccounts set "
    exectail=" where id ='"+orid+"';"
    try:
        if len(balance):
            cursor.execute(exechead+"savings = '"+balance+"'"+exectail)
        if len(drawleft):
            cursor.execute(exechead+"drawleft = '"+drawleft+"'"+exectail)
        if len(checkin):
            cursor.execute(exechead+"checkindate = '"+checkin+"'"+exectail)
        db.commit()
        cursor.close()
        if len(cosid):
            res=db_addcoscheckaccount(db,cosid,orid,bankname)
            if res == 0:
                return 0
        return 1
    except:
        db.rollback()
        cursor.close()
        return 0

def db_delcheckaccount(db,id):
    cursor=db.cursor()
    execstr1="delete from Costumer_has_checkaccounts where CheckAccounts_id = '" + id +"'"
    execstr2="delete from checkaccounts where id = '" + id +"'"
    try:
        cursor.execute(execstr1)
        cursor.execute(execstr2)
        db.commit()
        cursor.close()
        return 1
    except:
        db.rollback()
        cursor.close()
        return 0

# Loans operations
def db_searchloan(key,type,db):
    cursor = db.cursor()
    exechead = 'select * from (SELECT cl.Loans_ID, amount, name, Costumer_ID, Bank_name from Costumer c,Costumer_has_Loans cl,loans where c.ID=cl.Costumer_ID and cl.loans_ID=loans.ID'
    exectail = ") as tb left join (select Loans_ID ,SUM(PayAmount) as sum from LoansDetail group by Loans_ID ) as sumtable on sumtable.Loans_ID=tb.Loans_ID order by tb.Loans_ID;"    
    if len(key) == 0:
        cursor.execute(exechead+exectail)
    else:
        cursor.execute(exechead+' and '+type+' like '+"'%"+key+"%'"+exectail)
    tabs = cursor.fetchall()
    cursor.close()
    return tabs

def db_loandetailsearch(db,id):
    cursor = db.cursor()
    execstr="select PaySeq, PayAmount, PayDay FROM LoansDetail where Loans_ID = '"+id+"' order by PaySeq"
    try:
        cursor.execute(execstr)
        tabs = cursor.fetchall()
        cursor.close()
        return tabs
    except:
        db.rollback()
        cursor.close()
        return 0

def db_addloan(db,addid,amount,cosid,bank):
    cursor=db.cursor()
    execstr1="insert into Loans value(\""+addid+'\",'+amount+',\"'+bank+'\");'
    execstr2="insert into costumer_has_loans value(\""+cosid+'\",\"'+addid+'\");'
    try:
        print(execstr1)
        print(execstr2)
        cursor.execute(execstr1)
        cursor.execute(execstr2)
        db.commit()
        cursor.close()
        return 1
    except:
        db.rollback()
        cursor.close()
        return 0

def db_delloan(db,id):
    cursor=db.cursor()
    execstr1="delete from LoansDetail where Loans_ID = '" + id +"';"
    execstr2="delete from Costumer_has_Loans where Loans_ID = '" + id + "';"
    execstr3="delete from Loans where id = '" + id +"';"
    try:
        print(execstr1)
        print(execstr2)
        print(execstr3)
        cursor.execute(execstr1)
        cursor.execute(execstr2)
        cursor.execute(execstr3)
        db.commit()
        cursor.close()
        return 1
    except:
        db.rollback()
        cursor.close()
        return 0

def db_addloandetail(db,id,amount,seq,date):
    cursor=db.cursor()
    execstr="insert into LoansDetail value(" + amount +",'"+date +"'," +seq+",'"+id+"')"
    try:
        print(execstr)
        cursor.execute(execstr)
        db.commit()
        cursor.close()
        return 1
    except:
        db.rollback()
        cursor.close()
        return 0

def db_updloantaker(db,id,cosid):
    cursor=db.cursor()
    execstr="insert into Costumer_has_loans value(" + cosid +",'"+id+"')"
    try:
        print(execstr)
        cursor.execute(execstr)
        db.commit()
        cursor.close()
        return 1
    except:
        db.rollback()
        cursor.close()
        return 0

# Property Count
def db_getoverall(db,start,end):
    banks=db_getbanks(db)
    lis={}
    for bank in banks:
        cs=db_getcoscount(db,bank[0])
        sa=db_getbanksavings(db,bank[0],start,end)
        ca=db_getbankcheck(db,bank[0],start,end)
        la=db_getloanall(db,bank[0])
        ladt=db_getloanout(db,bank[0],start,end)
        lis[bank[0]]=(bank,sa,ca,la,ladt,cs)
        #print(lis)
    return lis

def db_getcoscount(db,bank):
    cursor=db.cursor()
    exechead="select COUNT(c.Costumer_ID) from (select distinct Costumer_ID from Costumer_has_SavingAccounts where SavingAccounts_Bank_name ='"+bank
    exectail="' union select distinct Costumer_ID from Costumer_has_CheckAccounts where CheckAccounts_Bank_name ='"+bank+"') c;"
    cursor.execute(exechead+exectail)
    res=cursor.fetchall()
    cursor.close()
    return res

def db_getbanks(db):
    cursor=db.cursor()
    cursor.execute("select name from bank;")
    banks=cursor.fetchall()
    cursor.close()
    return banks

def db_getbanksavings(db,bank,start,end):
    cursor=db.cursor()
    cursor.execute("select COUNT(sa.ID),SUM(sa.savings) from savingaccounts sa "+"where bank_name = '"+bank+"' and opendate >= '"+start+"' and opendate <= '"+end+"';")
    banksavings=cursor.fetchall()
    cursor.close()
    return banksavings

def db_getbankcheck(db,bank,start,end):
    cursor=db.cursor()
    cursor.execute("select COUNT(ca.ID),SUM(ca.savings),SUM(ca.drawleft) from CheckAccounts ca "+"where bank_name = '"+bank+"' and opendate >= '"+start+"' and opendate <= '"+end+"';")
    bankcheck=cursor.fetchall()
    cursor.close()
    return bankcheck

def db_getloanall(db,bank):
    cursor=db.cursor()
    cursor.execute("select COUNT(ca.ID),SUM(ca.amount) from loans ca "+"where bank_name = '"+bank+"';")
    loan=cursor.fetchall()
    cursor.close()
    return loan

def db_getloanout(db,bank,start,end):
    cursor=db.cursor()
    cursor.execute("select SUM(ca.payamount) from LoansDetail ca,Loans l "+"where ID= Loans_ID and bank_name = '"+bank+"' and PayDay >= '"+start+"' and PayDay <= '"+end+"';")
    bankcheck=cursor.fetchall()
    cursor.close()
    return bankcheck

def db_close(db):
    if db is not None:
        db.close()

# if __name__ == "__main__":
#     db = db_login("mydb", "qpwoeiruty123", "127.0.0.1", "test")
#     tabs = db_showtable(db)
#     db_close(db)