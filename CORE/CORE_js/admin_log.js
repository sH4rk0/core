var logErrors = new Array;

/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function getLogList()
	{
	
	clearLogs()
		mydata="who=getLogList";
		
		$.ajax({
		   type: "POST",
		   url: engineMain,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
		   
		     if(msg.values.error!=undefined)
		     {
		    
		         if (msg.values.error[0].errorId==0){
		             
		             logErrors=msg
		              displayLogList()

                        openLayer('#logs',600,undefined,false,true,true,'Logs');

		               
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

function displayLogList()
{
$("#logList").html("")

if (logErrors.values.log!=undefined)
{

for (i=0;i<logErrors.values.log.length; i++)
{
$("#logList").append("<li><a href='' onclick='javascript:removeLog("+ i +");return false;'>[x]</a><a href='#' onclick='javascript:displayLogErrors("+ i +")'>" + logErrors.values.log[i].name + "</a></li>");
}

}

}

function displayLogErrors(i)
{
$("#logTabs").tabs( "select" , 1 )
for (x=0;x<logErrors.values.log[i].Errors[0].Error_info.length; x++)
{
$("#logErrors").append("<li><a href='#' onclick='javascript:displayLogDetail("+ i +","+ x +")'>" + logErrors.values.log[i].Errors[0].Error_info[x].Error_host + ": " + logErrors.values.log[i].Errors[0].Error_info[x].Error_at + "</a></li>");
}

}

function displayLogDetail(i,x)
{
$("#logTabs").tabs( "select" , 2 )
$("#logDate").val(logErrors.values.log[i].Errors[0].Error_info[x].Error_at)
$("#logHost").val(logErrors.values.log[i].Errors[0].Error_info[x].Error_host)
$("#logUrl").val(logErrors.values.log[i].Errors[0].Error_info[x].Error_url)
$("#logAgent").val(logErrors.values.log[i].Errors[0].Error_info[x].User_agent)
$("#logIp").val(logErrors.values.log[i].Errors[0].Error_info[x].Ip)
$("#logValue").val(logErrors.values.log[i].Errors[0].Error_info[x].value)
}


/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function removeLog(i)
	{
	
		mydata="who=removeLog&logname="+ logErrors.values.log[i].name;
		
		$.ajax({
		   type: "POST",
		   url: engineMain,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
		   
		     if(msg.values.error!=undefined)
		     {
		    
		         if (msg.values.error[0].errorId==0){
		             
		            getLogList()

		               
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
		
		
		
		function clearLogs(){
		$("#logTabs").tabs( "select" , 0 )
		$("#logList").html("")
		$("#logErrors").html("")
		$("#logDate").val("")
        $("#logHost").val("")
        $("#logUrl").val("")
        $("#logAgent").val("")
        $("#logIp").val("")
        $("#logValue").val("")
		
		}