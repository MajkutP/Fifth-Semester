#!/usr/bin/python
from os import environ
import cgi
import cgitb; cgitb.enable()
form = cgi.FieldStorage()    #pobiera wszystkie informacje wyslane za pomoca formularza
info = eval(form.getvalue("info", "(no info)"))   
 
print "Content-Type: text/html"
print
print """\
<p>Wynik: %.2f</p>
""" % (info)
