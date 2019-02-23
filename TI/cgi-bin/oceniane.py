#!/usr/bin/env python
import cgi
import os
import cgitb; 
cgitb.enable()

form = cgi.FieldStorage()
switch_ = form.getvalue("controller", "(no Controller)");
fileName_ = os.path.basename('serwerOceniane.txt')

if switch_ == "WriteToFile":
	wspx = form.getvalue("wspx", "(no wspx)")
	wspy = form.getvalue("wspy", "(no wspy")
	radius = form.getvalue("radius", "(no radius)")
	kolor = form.getvalue("kolor", "(no kolor)")
	with open(fileName_,'a+') as file:
		file.write('___'.join((wspx, wspy, radius, kolor)))
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
	print "<th>WspX</th>"
	print "<th>WspY</th>"
	print "<th>Promien</th>"
	print "<th>Kolor</th>"
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
	fileHandle = open (fileName_, "r" )
	lineList = fileHandle.readlines()
	last = lineList[len(lineList)-1]
	ll  = last.split('___')
	x = ll[0]
	y = ll[1]
	r = ll[2]
	kolor = ll[3]
	a = '''<div style = "border: 5px inset; width: 800px; height: 400px; float: left; margin: auto;">  
	<form name = "form" id = "parameters">
	<input type = "button" value = "Draw last circle" onclick = "Draw()">
	</form>	
	<canvas id = "empty" width = "800" height = "400">
	</canvas>
	Canvas
	</div>
	<script> 
	 	function Draw(){
	 		var form = document.getElementById("parameters");
	 		var x = 
			var y = 
			var r = 

			var canEmpty = document.getElementById("empty");
			var canFilled = document.getElementById("filled");
		
			var w = canEmpty.width;
			var h = canEmpty.height;

			if (x > w)
				{x = w - r;}
			if (x < 0) 
				{x = 0;}
			if(x - r < 0 ) 
				{r = x;}
		    	if(x + r > w)
				{r = w - x;}
			if (y < 0) 
				{y = 0;}
			if (y > h)
				{y = h - r;}
			if(y - r < 0) 
				{r = y;}
			if(y + r > h) 
				{r = h - y;}

			var contextEmpty = canEmpty.getContext("2d");
			contextEmpty.beginPath();
			contextEmpty.arc(x, y, r, 0, 2 * Math.PI, false);
			contextEmpty.strokeStyle = '#B2CFC4';
			contextEmpty.lineWidth = 2.5;
			contextEmpty.stroke();
	 	}
	 </script>
	'''
	print (a)
	print "</body>"
	print "</html>" 
