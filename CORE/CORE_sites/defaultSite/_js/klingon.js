

$(document).ready(function(){
intervalKlingon=setInterval("changeKlingon()",20000);
})

function changeKlingon(){
var mydate= new Date();

$.ajax({   type: "POST",
		   url: "/api/json/klingon/core.aspx?new="+ mydate ,
		   dataType: "json",
		   cache: false,
		   success: function(msg){
		  
		    if(msg.values.error[0].errorId==0){
		      $("#klingons").fadeOut(function(){ $(this).html(msg.values.message[0].iSay) }).fadeIn()
		  		}
		  		else{
		  		
		  		if (msg.values.error[0].errorId==666){}
		  		
		  		}
		  		  
		   }
		 });






}
