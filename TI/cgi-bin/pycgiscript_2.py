#!/usr/bin/env python
import cgi
import os
import cgitb; 
cgitb.enable()

form = cgi.FieldStorage()
switch_ = form.getvalue("controller", "(no Controller)");
fileName_ = os.path.basename('serverData_2.txt')

if switch_ == "WriteToFile":
	author = form.getvalue("author", "(no author)")
	title = form.getvalue("title", "(no title")
	with open(fileName_,'a+') as file:
		file.write('___'.join((author, title)))
		file.write('\n')
	print "Content-type: text/html"
	print

elif switch_ == "ReadFromFile":
	print "Content-type: text/html"
	print 
	print"<!DOCTYPE html>"
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
	print "<th>Author</th>"
	print "<th>Title</th>"
	print "</tr>"
	with open(fileName_ ,"r") as fileRead:
		for eachLine in fileRead:
			Data_  = eachLine.split('___')
			print "<tr>"
			print "<td>" + Data_[0] + "</td>"
			print "<td>" + Data_[1] + "</td>"
			print "</tr>"
	print "</table>"
	print "</body>"
	print "</html>" 
