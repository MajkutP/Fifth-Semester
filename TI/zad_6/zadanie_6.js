var xmlHttp;
  function getRequestObject(){
    if ( window.ActiveXObject)  {
      return ( new ActiveXObject("Microsoft.XMLHTTP")) ;
    } else if (window.XMLHttpRequest)  {
      return (new XMLHttpRequest())  ;
    } else {
      return (null) ;
    }   
  }
    
  function AddBook()
  {
    var chooseDiv  = document.getElementById("TitleAuthor");
    var code = `<div id="DataInsert">\
    <fieldset>\
    <p style="font-size:115%;">Insert Data</p>\
      <form action="#" method="post" id="writeData">\
        <div class="opis">
          <p>Author</p>\
            <input type = "text" name = "author" id = "author">\
        </div>\
        <div class="opis">\
          <p>Title</p> 
            <input type = "text" name = "title" id = "title">\
        </div>\
            <input type="button" value="Submit" id="_SendBook" onclick="SendBook()">\
      </form>\
    </fieldset>\
  </div>`;
    
    chooseDiv.innerHTML = code;
  }
 
 	function SendBook()
  {
	  xmlHttp = getRequestObject() ;
	  form = document.getElementById("writeData")
       if (xmlHttp) {
         try {
           var author = form.author.value;
		       var title = form.title.value;
		       var controller = "WriteToFile";
           var url = "../cgi-bin/pycgiscript_2.py" ;
           var dataToTransfer = "author=" + encodeURIComponent(author) + "&title=" + encodeURIComponent(title) +  "&controller=" + encodeURIComponent(controller);
           
           xmlHttp.onreadystatechange = handleResponse ;
           xmlHttp.open("POST", url, true);
           xmlHttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded") ;
           xmlHttp.send(dataToTransfer);
           
       	   document.getElementById('author').value = "";
	         document.getElementById('title').value = "";
         }
         catch (e) {
           alert ("Error occured while connecting to the server " + e.toString()) ;
         }
       } 
	   else {
         alert ("Error") ;
       }
  }    
  
  function ShowAll()     
 {
       xmlHttp = getRequestObject() ;
       if (xmlHttp){
         try {
		       var controller = "ReadFromFile";
           var url = "../cgi-bin/pycgiscript_2.py" ;
           var dataToTransfer = "controller=" + encodeURIComponent(controller);
           xmlHttp.onreadystatechange = handleResponse;
           xmlHttp.open("POST", url, true);
           xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded") ;
           xmlHttp.send(dataToTransfer);
         }
         catch (e) {
           alert ("Error occured while connecting to the server " + e.toString()) ;
         }
       } 
	   else {
         alert ("Error") ;
       }
  }
  
  function handleResponse()      
{
    chooseDive = document.getElementById("TitleAuthor");
    if (xmlHttp.readyState == 4) {
         if ( xmlHttp.status == 200 ){
             response = xmlHttp.responseText;;
             chooseDive.innerHTML = response;
         }
    }  
}
