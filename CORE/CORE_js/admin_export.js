var logErrors = new Array;

function exportDatabase(){
 openLayer('#exports',600,undefined,false,true,true,'Export tools');

}

/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function generateInsertScript()
	{
	
		mydata="who=generateInsertScript";
		
		$.ajax({
		   type: "POST",
		   url: engineMain,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
		   
		     if(msg.values.error!=undefined)
		     {
		    
		         if (msg.values.error[0].errorId==0){
		         
		      	        
		             		               $("#insertScriptValue").val(msg.values.is[0].data);
		             		              


		             		 		                }
		                else		
		                {
		                
		                openDialog ( msg.values.error.errorLabel + ' Error code: '+ msg.values.error.errorid,200,100,2000);
		              
		                }
				
		    }
		  },    error: function(XMLHttpRequest, textStatus, errorThrown){alert(textStatus + " " + errorThrown)}
		 });

		return false;
		}
