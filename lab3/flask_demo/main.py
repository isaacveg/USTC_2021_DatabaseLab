#-*- coding: UTF-8 -*-
import functools

from flask import Flask, session
from flask import redirect
from flask import request, make_response
from flask import render_template
from flask import url_for

from db import *

# 生成一个app
app = Flask(__name__, instance_relative_config=True)
app.secret_key = 'lab3'

# 对app执行请求页面地址到函数的绑定
@app.route("/", methods=("GET", "POST"))
def firstpage():
    return redirect(url_for("login"))
@app.route("/login", methods=("GET", "POST"))
def login():
    """Log in a registered user by adding the user id to the session."""
    if request.method == "POST":
        # 客户端在login页面发起的POST请求
        username = request.form["username"]
        password = request.form["password"]
        ipaddr   = request.form["ipaddr"]
        database = request.form["database"]

        db = db_login(username, password, ipaddr, database)

        if db == None:
            return render_template("login.html",loginres=0)
        else:
            session['username'] = username
            session['password'] = password
            session['ipaddr'] = ipaddr
            session['database'] = database

            return redirect(url_for("mainpage"))
    else :
        # 客户端GET 请求login页面时
        return render_template("login.html")

@app.route("/mainpage", methods = (["GET", "POST"]))
def mainpage():
    if request.method == "GET":
        return render_template("mainpage.html")
    else:
        if 'costumer' in request.form:
            return redirect(url_for("CostumerServ"))
        elif 'normalAccount' in request.form: 
            return redirect(url_for("normAccountServ"))
        elif 'checkAccount' in request.form:
            return redirect(url_for("checkAccountServ"))
        elif 'loan' in request.form:
            return redirect(url_for("loansServ"))
        elif 'property' in request.form:
            return redirect(url_for("property"))

@app.route("/mainpage/costumer", methods = (["GET", "POST"]))
def CostumerServ():
    if request.method == "GET":
        return render_template("costumer.html")
    else:
        if 'username' in session:
            db = db_login(session['username'], session['password'], 
                        session['ipaddr'], session['database'])
            if 'SEARCH' in request.form:
                searchkey=request.form.get('SearchText')
                searchtype=request.form.get('searchtype')
                searchresult = db_searchcostumer(searchkey,searchtype,db)
                return render_template("costumer.html",rows=searchresult,searchtext=searchkey)
            elif 'ADD' in request.form:
                addid=request.form.get('ADDid')
                if len(addid) == 0:
                    return render_template("costumer.html",addres=0)
                addname=request.form.get('ADDname')
                addtel=request.form.get('ADDtel')
                addcname=request.form.get('ADDcname')
                addctel=request.form.get('ADDctel')
                addcmail=request.form.get('ADDcmail')
                addrel=request.form.get('ADDrel')
                addaddr=request.form.get('ADDaddr')
                res=db_addcostumer(db,addid,addname,addtel,addcname,addctel,addcmail,addrel,addaddr)
                return render_template("costumer.html",addres=res)
            elif 'CHANGE' in request.form:
                orid = request.form.get('orid')
                id = request.form.get('cgid')
                name = request.form.get('cgname')
                tel = request.form.get('cgtel')
                cname = request.form.get('cgcname')
                ctel = request.form.get('cgctel')
                cmail = request.form.get('cgcmail')
                crel = request.form.get('cgcrel')
                addr=request.form.get('cgaddr')
                updres = db_updcostumer(db,orid,id,name,tel,cname,ctel,cmail,crel,addr)
                return render_template("costumer.html",updres=updres)
            elif 'DEL' in request.form:
                id=request.form.get('orid')
                res = db_delcostumer(db,id)
                return render_template("costumer.html",delres=res)

        else: return redirect(url_for("login"))
    
@app.route("/mainpage/savingaccounts", methods = (["GET", "POST"]))
def normAccountServ():
    if request.method == "GET":
        return render_template("normaccount.html")
    else:
        if 'username' in session:
            db = db_login(session['username'], session['password'], 
                        session['ipaddr'], session['database'])
            if 'SEARCH' in request.form:
                searchkey=request.form.get('SearchText')
                searchtype=request.form.get('searchtype')
                searchresult = db_searchsavingaccount(searchkey,searchtype,db)
                return render_template("normaccount.html",rows=searchresult,searchtext=searchkey)
            elif 'ADD' in request.form:
                addid=request.form.get('ADDid')
                if len(addid) == 0:
                    return render_template("normaccount.html",addres=0)
                savings=request.form.get('ADDsavings')
                opendate=request.form.get('ADDopendate')
                checkindate=request.form.get('ADDcheckindate')
                ratio=request.form.get('ADDratio')
                cointype=request.form.get('ADDct')
                cosid=request.form.get('ADDCosid')
                bank=request.form.get('bankname')
                res=db_addsavingaccount(db,addid,savings,opendate,checkindate,ratio,cointype,cosid,bank)
                return render_template("normaccount.html",addres=res)
            elif 'CHANGE' in request.form:
                orid = request.form.get('orid')
                balance = request.form.get('cgbalance')
                cointype = request.form.get('cgcointype')
                ratio = request.form.get('cgratio')
                checkin = request.form.get('cgcheckin')
                cosid=request.form.get('addcossa')
                orbc=request.form.get('orbc')
                res = db_updsavingaccounts(db,orid,balance,cointype,ratio,checkin,cosid,orbc)
                print(orbc,cosid,res)
                return render_template("normaccount.html",updres=res)
            elif 'DEL' in request.form:
                id=request.form.get('orid')
                res = db_delsavingaccount(db,id)
                return render_template("normaccount.html",delres=res)
        else: return redirect(url_for("login"))
    
@app.route("/mainpage/checkaccounts", methods = (["GET", "POST"]))
def checkAccountServ():
    if request.method == "GET":
        return render_template("checkaccount.html")
    else:
        if 'username' in session:
            db = db_login(session['username'], session['password'], 
                        session['ipaddr'], session['database'])
            if 'SEARCH' in request.form:
                searchkey=request.form.get('SearchText')
                searchtype=request.form.get('searchtype')
                searchresult = db_searchcheckaccount(searchkey,searchtype,db)
                return render_template("checkaccount.html",rows=searchresult,searchtext=searchkey)
            elif 'ADD' in request.form:
                addid=request.form.get('ADDid')
                if len(addid) == 0:
                    return render_template("checkaccount.html",addres=0)
                savings=request.form.get('ADDsavings')
                opendate=request.form.get('ADDopendate')
                checkindate=request.form.get('ADDcheckindate')
                Drawleft=request.form.get('ADDdrawleft')
                cosid=request.form.get('ADDCosid')
                bank=request.form.get('bankname')
                res=db_addcheckaccount(db,addid,savings,opendate,checkindate,Drawleft,cosid,bank)
                return render_template("checkaccount.html",addres=res)
            elif 'CHANGE' in request.form:
                orid = request.form.get('orid')
                balance = request.form.get('cgbalance')
                Drawleft = request.form.get('cgdrawleft')
                checkin = request.form.get('cgcheckin')
                cosid=request.form.get('addcossa')
                orbc=request.form.get('orbc')
                res = db_updcheckaccounts(db,orid,balance,Drawleft,checkin,cosid,orbc)
                return render_template("checkaccount.html",updres=res)
            elif 'DEL' in request.form:
                id=request.form.get('orid')
                res = db_delcheckaccount(db,id)
                return render_template("checkaccount.html",delres=res)
        else: return redirect(url_for("login"))

@app.route("/mainpage/loans", methods = (["GET", "POST"]))
def loansServ():
    if request.method == "GET":
        return render_template("loans.html")
    else:
        if 'username' in session:
            db = db_login(session['username'], session['password'], 
                        session['ipaddr'], session['database'])
            if 'SEARCH' in request.form:
                searchkey=request.form.get('SearchText')
                searchtype=request.form.get('searchtype')
                searchresult = db_searchloan(searchkey,searchtype,db)
                return render_template("loans.html",rows=searchresult,searchtext=searchkey)
            elif 'ADD' in request.form:
                addid=request.form.get('ADDid')
                if len(addid) == 0:
                    return render_template("loans.html",addres=0)
                amount=request.form.get('ADDamount')
                cosid=request.form.get('ADDCosid')
                bank=request.form.get('bankname')
                res=db_addloan(db,addid,amount,cosid,bank)
                return render_template("loans.html",addres=res)
            elif 'DEL' in request.form:
                id=request.form.get('orid')
                res = db_delloan(db,id)
                return render_template("loans.html",delres=res)
        else: return redirect(url_for("login"))

@app.route("/mainpage/loans/<id>", methods = (["GET", "POST"]))
def loandetail(id):
    if request.method == "GET":
        if 'username' in session:
            db = db_login(session['username'], session['password'], 
                        session['ipaddr'], session['database'])
            rows=db_loandetailsearch(db,id)
            tabs=db_searchloan(id,"Loans_ID",db)
            return render_template('loandetail.html',rows=rows,loanid=id,tabs=tabs)
        else: return redirect(url_for("login"))
    else:
        if 'username' in session:
            db = db_login(session['username'], session['password'], 
                        session['ipaddr'], session['database'])
            if 'ADD' in request.form:
                amount=request.form.get('ADDamount')
                seq=request.form.get('ADDid')
                date=request.form.get('ADDdate')
                res=db_addloandetail(db,id,amount,seq,date)
                rows=db_loandetailsearch(db,id)
                tabs=db_searchloan(id,"Loans_ID",db)
                return render_template('loandetail.html',rows=rows,loanid=id,tabs=tabs,addres=res)
            elif 'ADDcosid' in request.form:
                cosid=request.form.get('ADDcosid')
                res=db_updloantaker(db,id,cosid)
                rows=db_loandetailsearch(db,id)
                tabs=db_searchloan(id,"Loans_ID",db)
                return render_template('loandetail.html',rows=rows,loanid=id,tabs=tabs,updres=res)
        else: return redirect(url_for("login"))

@app.route("/mainpage/property", methods = (["GET","POST"]))
def property():
    if request.method=='GET':
        if 'username' in session:
            db = db_login(session['username'], session['password'], 
                        session['ipaddr'], session['database'])
            rows=db_getoverall(db,'1990/1/1','2100/12/31')
            print(rows)
            return render_template('property.html',banks=rows)
        else: return redirect(url_for("login"))
    else:
        if 'username' in session:
            db = db_login(session['username'], session['password'], 
                        session['ipaddr'], session['database'])
            head=request.form.get('st')
            tail=request.form.get('ed')
            rows=db_getoverall(db,head,tail)
            print(rows)
            return render_template('property.html',banks=rows)
        else: return redirect(url_for("login"))

@app.route("/debug", methods = (["GET", "POST"]))
def debugpage():
    return "success!"
@app.route("/failed", methods = (["GET", "POST"]))
def failed():
    return "Failed!"


# 测试URL下返回html page
@app.route("/hello")
def hello():
    return "hello world!"

#返回不存在页面的处理
@app.errorhandler(404)
def not_found(e):
    return render_template("404.html")

if __name__ == "__main__":
    app.run(host = "127.0.0.1", debug=True)