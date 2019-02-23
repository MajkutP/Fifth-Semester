#!/usr/bin/python
from os import environ
import cgi
import cgitb; cgitb.enable()
form = cgi.FieldStorage()    #pobiera wszystkie informacje wyslane za pomoca formularza
info = form.getvalue("info", "(no info)")   
 
print "Content-Type: text/html"
print
print """\
<p>Env:</p>
<table >
<tr><td>REQUEST_METHOD: </td><td>%s</td></tr>
<tr><td>QUERY_STRING: </td><td>%s</td></tr>
</table>
<p>Wartosc zmiennej 'info': %s</p>
""" %  (environ['REQUEST_METHOD'], environ['QUERY_STRING'], cgi.escape(info))
