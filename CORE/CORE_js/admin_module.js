
/*
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*/

function resetModulesValues()
{
$("#moduleName").val("")
$("#modulePath").val("/core_modules/modules_parts/core/")
$("#moduleLabel").val("")
$("#moduleIdKey").val("")
$("#moduleId").val("")
$("#moduleDefinition").val("")
$("#moduleDescription").val("")
$("#moduleType").val("")
}

/*
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*/

function displayModules()
{
openLayer("#moduleForm",500,350);
}
/*
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*/

function moduleNew()
{
resetModulesValues()
$("#moduleFields").show()
$("#btnModuleInsert").show()
$("#btnModuleUpdate").hide()
}

/*
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*/

function moduleModify(index)
{

$("#moduleName").val($(".modulesList").eq(index).attr("moduleName"))
$("#modulePath").val($(".modulesList").eq(index).attr("modulePath"))
$("#moduleLabel").val($(".modulesList").eq(index).attr("moduleLabel"))
$("#moduleIdKey").val($(".modulesList").eq(index).attr("moduleIdKey"))
$("#moduleId").val($(".modulesList").eq(index).attr("moduleId"))
$("#moduleDefinition").val($(".modulesList").eq(index).attr("moduleDefinition"))
$("#moduleDescription").val($(".modulesList").eq(index).attr("moduleDescription"))
$("#moduleType").val($(".modulesList").eq(index).attr("moduleType"))

$("#moduleFields").show()
$("#btnModuleInsert").hide()
$("#btnModuleUpdate").show()
}


/*
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*/

function moduleInsert()
{
if ($("#moduleName").val()=="") { alert("Insert Module Name");$("#moduleName").focus(); return false;}
if ($("#modulePath").val()=="") { alert("Select Module Path");$("#modulePath").focus(); return false;}
if ($("#moduleLabel").val()=="") { alert("Select Module Label");$("#moduleLabel").focus(); return false;}
mydata="who=moduleInsert&" + $(".moduleSerialize").serialize()

$.ajax({
   type: "POST",
   url: engineModule,
   data: mydata,
   dataType:"json",
   success: function(msg){
   
       if(msg.values!=undefined){
            if(msg.values.error[0].errorId==0){
				
				getModules()
				$("#moduleFields").hide()
          	} else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
       }
   }
 });

}

/*
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*/

function moduleUpdate()
{
if ($("#moduleName").val()=="") { alert("Insert Module Name");$("#moduleName").focus(); return false;}
if ($("#modulePath").val()=="") { alert("Select Module Path");$("#modulePath").focus(); return false;}
if ($("#moduleLabel").val()=="") { alert("Select Module Label");$("#moduleLabel").focus(); return false;}
mydata="who=moduleUpdate&" + $(".moduleSerialize").serialize();


$.ajax({
   type: "POST",
   url: engineModule,
   data: mydata,
   dataType:"json",
   success: function(msg){
   
       if(msg.values!=undefined){
            if(msg.values.error[0].errorId==0){
				
				getModules()
				$("#moduleFields").hide()
            } else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
       }
   }
 });

}

/*
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*/

function getModules()
{
	
mydata="who=moduleList"
	
$.ajax({
   type: "POST",
   url: engineModule,
   data: mydata,
   dataType: "json",
   success: function(msg){
  
		  if(msg.values!=undefined){
		  
						if(msg.values.error[0].errorId==0){
					
					$(".modulesList").remove()
					$(".modulesOptions").remove()
					if (msg.values.module!=undefined){
							for (i=0; i<msg.values.module.length; i++){
							   
							   						   
							  $("<li class='modulesList' ModuleIdKey='"+ msg.values.module[i].idKey +"' moduleLabel='"+ msg.values.module[i].label +"' moduleId='"+ msg.values.module[i].idModule +"' moduelType='"+ msg.values.module[i].typr +"' moduelDefinition='"+ msg.values.module[i].definition +"' moduleDescription='"+ msg.values.module[i].description +"' moduleName='"+ msg.values.module[i].name +"' modulePath='"+ msg.values.module[i].path +"'><a href='#' onclick='moduleModify("+  i +")'>"+ msg.values.module[i].label +"</a></li>").appendTo("#moduleList");
							  $("<option class='modulesOptions boxSerialize' value='"+ msg.values.module[i].idKey +"'>"+ msg.values.module[i].label +"</option>").appendTo("#boxIdModule");
							  
							  
							  }
					  }
					  
					  } else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
		 }  
     },
     error:function(msg){
     
     alert(msg)
     }
 });
	
	
	}



/*
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*/



