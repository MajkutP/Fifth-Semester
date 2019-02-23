#!/usr/bin/env python
import cgi
import os
import datetime

form = cgi.FieldStorage()
title_ = form.getvalue("title", "")
author_ = form.getvalue("author", "")
date_ = datetime.datetime.now()
date_ = date_.strftime("%Y/%m/%d %X")
ip_ = cgi.escape(os.environ['REMOTE_ADDR'])  
fileName_ = os.path.basename('serverData.txt')
with open(fileName_,'a+') as file:
	file.write('___'.join((title_, author_ ,ip_ ,date_)))
	file.write('\n')
 
print "Content-type: text/html"
print 
print " <!DOCTYPE html>"
print"<head>"
print"<meta charset=\"UTF-8\">"
print"<style type=\"text/css\">"
print"table{"
print"  margin: auto;"
print"  border: 5px;"
print"  border-style: double"
print"  box-shadow: 2px 2px 7px 1px #0095B3;"
print"}"
print"tr{"
print"  background-color: #6B828A;"
print"  text-align: center;"
print"}"
print"tr:nth-child(2n){"
print"  background-color: #DEE0E0;"
print"  text-align: center;"
print"}"
print"</style>"
print"</head>"
print"<body>"
print"<table>"
print "<tr>"
print "<th>Title</th>"
print "<th>Author</th>"
print "<th>IP</th>"
print "<th>Time</th>"
print "</tr>"
with open(fileName_ ,"r") as fileRead:
	for eachLine in fileRead:
		Data_  = eachLine.split('___')
		print "<tr>"
		print "<td>" + Data_[0] + "</td>"
		print "<td>" + Data_[1] + "</td>"
		print "<td>" + Data_[2] + "</td>"
		print "<td>" + Data_[3] + "</td>"
		print "</tr>"
print "</table>"
print "</body>"
print "</html>"
