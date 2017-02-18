
var $klingon,$body,isloading;
$(function(){
isLoading=false;	
$klingon=$("#klingon");	
$body=$("body");
loadNext();
});

function loadNext(){
	
	
	$klingon.fadeOut(function(){
		
		if(isLoading) return;
	isLoading=true;
	
	$body.addClass("loading");
	$.ajax({   type: "POST",
		   url: "/api/json/klingon/core.aspx",
		   dataType: "json",
		   success: function(msg){
		  
		    if(msg.values.error[0].errorId==0){
			$body.removeClass("loading");
			isLoading=false;
		      $klingon.text(msg.values.message[0].iSay).fadeIn()
		  		}
		  		else{
		  		
		  		if (msg.values.error[0].errorId==666){}
		  		
		  		}
		  		  
		   }
		 });
		
		
		});
	
	
	
	}
