
var engineMain="/api/json/clm/core.aspx"

var imgPath="/CORE/CORE_images/admin/"
var loadingCircle="<img src='"+ imgPath +"loading_circle.gif' alt='Loading...' />"
var loadingIndicator="<img src='"+ imgPath +"indicator_blue_large.gif' alt='Loading...' />"
var actionForbidden='Sorry, you have no privileges to accomplish this operation';
var firstAjax=false;
/*
-----------------------------------------------------------------------------------------------------------------------------*/	
$(document).ready(function() {

$("#trace").ajaxStart(function(){$("#ajaxOverlay,#ajaxLoading").show();});

$("#trace").ajaxStop(function(){
   $("#ajaxOverlay,#ajaxLoading").hide();
   if (firstAjax==false){$("#topMenu").fadeIn();firstAjax=true;}
 });

});



/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function openDialog(message,TB_WIDTH,TB_HEIGHT,timeout,callback)
{
	
	$("#dialog h3").text(message);
	$("#dialog").animate({right:"50px", opacity: 1}, 300, "swing", function(){setTimeout("closeDialog("+callback+")",timeout);} );

}
/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function closeDialog(callback)
{
	$("#dialog").animate({right:"100px", opacity: 0}, 300, "swing", function(){if(callback!=undefined){eval(callback);} $("#dialog").css({"right":"0px"}) });
	
}



/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function loadData(mydata,callback)
	{

		
		$.ajax({
		   type: "POST",
		   url: engineMain,
		   data: mydata,
		   dataType: "json",
		     success: function(data){
		    
		     if(data.data.error!=undefined)
		     {
		     
		   
		         if (data.data.error[0].errorId==0){
		               
		                eval(callback);
		               
		                }
		                else		
		                {
		                
		                openDialog ( data.data.error[0].errorLabel + ' Error code: '+ data.data.error[0].errorid,200,100,2000);
		              
		                }
				
		    }
		  }
		 });

		return false;
		}

/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function displayActionForbidden(){
 openDialog(actionForbidden,200,100,2000);
}

/*
-----------------------------------------------------------------------------------------------------------------------------*/



