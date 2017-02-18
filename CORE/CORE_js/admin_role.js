
/*
------------------------------------------------------------------------------------------------------------------*/
function roleGetAll(){
		
		mydata="who=roleGetAll";
	
		$.ajax({
		   type: "POST",
		   url: engineRole,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
			   if(msg.values.error!=undefined)
		     {
				 	 if (msg.values.error[0].errorId==0){
			                            roles=msg.values.role
		  		                            displayRoles()
				                                        } else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
		    }
		   }
		 });
}
/*
------------------------------------------------------------------------------------------------------------------*/
function roleToProfileInsert()
{
    if(!confirm('Insert roles to selected profiles?')){return false;}
		mydata="who=roleToProfileInsert&roles="+selectedRolesSerialize()+"&profiles="+selectedProfilesSerialize();
		
		$.ajax({
		   type: "POST",
		   url: engineRole,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
			   if(msg.values.error!=undefined)
		     {
				 	 if (msg.values.error[0].errorId==0){
			  	                          profileGetAll();
			  	                           openDialog("Roles added to selected profiles.",200,100,2000);
		                                                } else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
		     }
		   }
		 });

}
/*
------------------------------------------------------------------------------------------------------------------*/
function removeRole(idRole,idProfile)
{
    if(!confirm('Remove this role?')){return false;}
		mydata="who=roleToProfileDelete&roles="+idRole+"&profiles="+idProfile;
		
		$.ajax({
		   type: "POST",
		   url: engineRole,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
			   if(msg.values.error!=undefined)
		     {
				 	 if (msg.values.error[0].errorId==0){
			  	                          profileGetAll();
			  	                          openDialog("Role removed.",200,100,2000);
		                                                } else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
		     }
		   }
		 });

}
/*
------------------------------------------------------------------------------------------------------------------*/
function roleDelete(idRole)
{

if(!confirm('Delete this role?')){return false;}

		mydata="who=roleDelete&id_role="+idRole;
		
		$.ajax({
		   type: "POST",
		   url: engineRole,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
			   if(msg.values.error!=undefined)
		     {
				 	 if (msg.values.error[0].errorId==0){
			  	                          profileGetAll();
			  	                          roleGetAll();
			  	                           openDialog("Role deleted.",200,100,2000);
		                                                } else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
		     }
		   }
		 });

}
/*
------------------------------------------------------------------------------------------------------------------*/

function newRole(){

$("#roleForm").show();
$("#newRoleBtn").hide();
$("#RoleName").val("");
}

/*
------------------------------------------------------------------------------------------------------------------*/

function closeRole(){

$("#roleForm").hide();
$("#newRoleBtn").show();
$("#RoleName").val("");
}
/*
------------------------------------------------------------------------------------------------------------------*/
function insertRole()
{
if(!confirm('Insert new role?')){return false;}
if($("#roleName").val()==''){alert('Insert role name!');$("#roleName").focus();return false;}

mydata="who=roleInsert&role_label="+ $("#roleName").val();
		
		$.ajax({
		   type: "POST",
		   url: engineRole,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
			   if(msg.values.error!=undefined)
		     {
				 	 if (msg.values.error[0].errorId==0){
			  	                            roleGetAll();
			  	                            closeRole();
			  	                             openDialog("Role added.",200,100,2000);
		                                                } else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
		     }
		   }
		 });
}

/*
------------------------------------------------------------------------------------------------------------------*/
function displayRoles()
{
 $(".rolesItems").remove();
	var selected="";
	
		if (roles!=undefined){
		for (i=0; i<roles.length; i++)
		{
			
		selected =	isRoleSelected(i,roles[i].id);
		
		$("#roleGrid").append("<tr class='rolesItems' id='trRole_"+ roles[i].id +"' sequence='"+ i +"'><td valign='top'>"+  selected +"</td><td valign='top'><a href='#' onclick='javascript:roleDelete("+ roles[i].id +")' title='Delete this role?'>"+ roles[i].label+"</a> </td></tr>")	
			
			}
			}
}
/*
------------------------------------------------------------------------------------------------------------------*/
function isRoleSelected(x,id_key){
var exist=false;
var i=0;
for (i=0; i<roleSelected.length; i++)
		{
		if (roleSelected[i].id==id_key){exist=true; break;}
		}
		
if(exist==true){

return "<img src='"+imgPath+"checkedOn.gif' alt='' class='roleChecked' onclick='javascript:roleCheckUncheck("+ x +")' id='roleCheck"+x+"'/>"

}else{


return "<img src='"+imgPath+"checkedOff.gif' alt='' onclick='javascript:roleCheckUncheck("+ x +")' id='roleCheck"+x+"'/>"
}


}

/*
------------------------------------------------------------------------------------------------------------------*/
function roleCheckUncheck(x)
{
var newSel=roles[x].id
var exist=false;

if ($("#roleCheck"+x).hasClass("roleChecked"))
{
$("#roleCheck"+x).removeClass("roleChecked")
$("#roleCheck"+x).attr("src",imgPath+"checkedOff.gif")
for (i=0; i<roleSelected.length; i++)
		{
		    if (roleSelected[i].id==newSel)
		    {
		   roleSelected.splice(i,1);
		    $("#roleSelected span").text(roleSelected.length);
    		}
		}


}
else{
$("#roleCheck"+x).addClass("roleChecked")
$("#roleCheck"+x).attr("src",imgPath+"checkedOn.gif").addClass("roleChecked");
	for (i=0; i<roleSelected.length; i++)
		{
		if (roleSelected[i].id==newSel){exist=true; break;}
		}
		
		if (exist==false){roleSelected.push(roles[x]);$("#roleSelected span").text(roleSelected.length);}
}
if(roleSelected.length>0){$("#roleSelected").fadeIn();}else{$("#roleSelected").fadeOut();}
displaySelectedRole()
}

/*
------------------------------------------------------------------------------------------------------------------*/
function displaySelectedRole(){

$("#roleSelectedList").html("");
var _class=""
for (i=0; i<roleSelected.length; i++)
		{
		_class="first-nav-item"
		if(i==0){_class="first-nav-item"}
		
		$("#roleSelectedList").append("<li class='"+_class+"'><a href='#'>"+ roleSelected[i].label +"</a></li>")
	
		}
		$("#roleSelectedList").append("<li class='first-nav-item' id='roleToProfileOption' style='display:none;'><a href='#' onclick='javascript:roleToProfileInsert();return false;'><strong>Add to selected Profiles</strong></a></li>");

    	$("#roleSelectedList").append("<li class='last-nav-item'><a href='#' onclick='javascript:removeRoleSelected();return false;'><strong>Clear selected roles</strong></a></li>");
		attachRoleOptions();
	}
/*
------------------------------------------------------------------------------------------------------------------*/
	function attachRoleOptions()
	{
		
	if (roleSelected.length!=0){$("#roleToProfileOption").show()}else{$("#roleToProfileOption").hide();}
		
	}


/*
------------------------------------------------------------------------------------------------------------------*/
function removeRoleSelected(){
roleSelected=[];
$(".roleChecked").each(function(){
$(this).removeClass("roleChecked").attr("src",imgPath+"checkedOff.gif")
})
$("#roleSelected").fadeOut();
attachRoleOptions();
}

/*
------------------------------------------------------------------------------------------------------------------*/
function selectedRolesSerialize()
	
	{
	
	var myarr = new Array()
for (i=0; i<roleSelected.length; i++)
{
myarr[i]=roleSelected[i].id
}

return myarr.join(",")
	
	}
