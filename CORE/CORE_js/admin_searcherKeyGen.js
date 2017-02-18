
function searcherKeyGen(){
 openLayer('#searcherKey',400,undefined,false,true,true,'Seracher Key Generator');

}

/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function generateSearcherKey()
	{
	
		mydata="who=generateSearcherKey&"+ $(".tokenSerialize").serialize();
		
		$.ajax({
		   type: "POST",
		   url: engineMain,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
		   
		     if(msg.values.error!=undefined)
		     {
		    
		         if (msg.values.error[0].errorId==0){
		         
		        		      	        
		             		               $("#resultKey").val(msg.values.searcher[0].key);
		             		              


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
