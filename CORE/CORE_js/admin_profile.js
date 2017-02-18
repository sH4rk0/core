

/*
---------------------------------------------------------------------------------*/
function profileGetAll(){
	
		mydata="who=profileGetAll";
		
		$.ajax({
		   type: "POST",
		   url: engineProfile,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
			   if(msg.values.error!=undefined)
		     {
				 	 if (msg.values.error[0].errorId==0){
			  	                            profiles=msg.values.profile
		  		                            displayProfiles() 
		  		                            
		  		                            
		                                                }
		                                                 else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
		     }
		   }
		 });
}
/*
---------------------------------------------------------------------------------*/
function profileToUserInsert()
{

    if(!confirm('Insert profile to selected users?')){return false;}
		mydata="who=profileToUserInsert&id_site="+currentKeySite+"&users="+selectedUsersSerialize()+"&profiles="+selectedProfilesSerialize();
		
		$.ajax({
		   type: "POST",
		   url: engineProfile,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
			   if(msg.values.error!=undefined)
		     {
				 	 if (msg.values.error[0].errorId==0){
			  	                          openDialog("Profiles added to selected users.",200,100,2000);
		                                                } else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
		     }
		   }
		 });

}
/*
---------------------------------------------------------------------------------*/
function profileToTreeInsert()
{

    if(!confirm('Insert profile to selected tree?')){return false;}
		mydata="who=profileToTreeInsert&trees="+selectedTreesSerialize()+"&profiles="+selectedProfilesSerialize();
		
		$.ajax({
		   type: "POST",
		   url: engineProfile,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
			   if(msg.values.error!=undefined)
		     {
				 	 if (msg.values.error[0].errorId==0){
			  	                          openDialog("Profiles added to selected trees.",200,100,2000);
		                                                } else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
		     }
		   }
		 });

}

/*
---------------------------------------------------------------------------------*/
function newProfile(){

$("#profileForm").show();
$("#newProfileBtn").hide();
$("#profileName").val("");
}

/*
---------------------------------------------------------------------------------*/
function closeProfile(){

$("#profileForm").hide();
$("#newProfileBtn").show();
$("#profileName").val("");
}
/*
---------------------------------------------------------------------------------*/
function profileDelete(idProfile)
{

if(!confirm('Delete this profile?')){return false;}

		mydata="who=profileDelete&id_profile="+idProfile;
		
		$.ajax({
		   type: "POST",
		   url: engineProfile,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
			   if(msg.values.error!=undefined)
		     {
				 	 if (msg.values.error[0].errorId==0){
			  	                          profileGetAll();
			  	                            openDialog("Profile deleted.",200,100,2000);
			  	                                        } else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
		     }
		   }
		 });

}
/*
---------------------------------------------------------------------------------*/
function insertProfile()
{
if(!confirm('Insert new profile?')){return false;}
if($("#profileName").val()==''){alert('Insert profile name!');$("#profileName").focus();return false;}

mydata="who=profileInsert&profile_label="+ $("#profileName").val();
		
		$.ajax({
		   type: "POST",
		   url: engineProfile,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
			   if(msg.values.error!=undefined)
		     {
				 	 if (msg.values.error[0].errorId==0){
			  	                            profileGetAll();
			  	                            $("#profileForm").hide();
                                            $("#newProfileBtn").show();
			  	                              openDialog("New profile added.",200,100,2000);
		                                                } else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
		     }
		   }
		 });
}

/*
---------------------------------------------------------------------------------*/
function displayProfiles()
{
 $(".profileItems, .roleItems").remove();
	var selected="";
	
		if (profiles!=undefined){
		for (i=0; i<profiles.length; i++)
		{
			
		selected =	isProfileSelected(i,profiles[i].id);
		
		$("#profileGrid").append("<tr class='profileItems' id='trProfile_"+ profiles[i].id +"' sequence='"+ i +"'><td valign='top'>"+  selected +"</td><td valign='top'><a href='#' onclick='javascript:profileDelete("+ profiles[i].id +")' title='Delete this Profile?'><strong>"+ profiles[i].label+"</strong></a></td></tr>")
			
			
		var roles2profile='';	
		if (profiles[i].role!=undefined){	
		
		
		for (x=0; x<profiles[i].role.length; x++)
		{
	
		roles2profile=roles2profile+"<span roleId='"+profiles[i].role[x].id+"' class='roles'><a href='#' onclick='javascript:removeRole("+ profiles[i].role[x].id +","+ profiles[i].id +"); return false;' title='Remove "+ profiles[i].role[x].label +" role from "+ profiles[i].label +" profile'>"+profiles[i].role[x].label+"</a></span>"
	if (x<profiles[i].role.length-1){roles2profile=roles2profile+', '}
		}
	$("#profileGrid").append("<tr class='roleItems' id='trRoles_"+ profiles[i].id +"'><td valign='top'></td><td valign='top'>"+roles2profile+"</td></tr>")
		
		
		
		}
			
			
			}
			}
}


/*
---------------------------------------------------------------------------------*/
function isProfileSelected(x,id_key){
var exist=false;
var i=0;
for (i=0; i<profileSelected.length; i++)
		{
		if (profileSelected[i].id==id_key){exist=true; break;}
		}
		
if(exist==true){

return "<img src='"+imgPath+"checkedOn.gif' alt='' class='profileChecked' onclick='javascript:profileCheckUncheck("+ x +")' id='profileCheck"+x+"'/>"

}else{


return "<img src='"+imgPath+"checkedOff.gif' alt='' onclick='javascript:profileCheckUncheck("+ x +")' id='profileCheck"+x+"'/>"
}


}

/*
---------------------------------------------------------------------------------*/
function profileCheckUncheck(x)
{
var newSel=profiles[x].id
var exist=false;

if ($("#profileCheck"+x).hasClass("profileChecked"))
{
$("#profileCheck"+x).removeClass("profileChecked")
$("#profileCheck"+x).attr("src",imgPath+"checkedOff.gif")
for (i=0; i<profileSelected.length; i++)
		{
		    if (profileSelected[i].id==newSel)
		    {
		    profileSelected.splice(i,1);
		    $("#profileSelected span").text(profileSelected.length);
    		}
		}


}
else{
$("#profileCheck"+x).addClass("profileChecked")
$("#profileCheck"+x).attr("src",imgPath+"checkedOn.gif").addClass("profileChecked");
	for (i=0; i<profileSelected.length; i++)
		{
		if (profileSelected[i].id==newSel){exist=true; break;}
		}
		
		if (exist==false){profileSelected.push(profiles[x]);$("#profileSelected span").text(profileSelected.length);}

}

if(profileSelected.length>0){$("#profileSelected").fadeIn();}else{$("#profileSelected").fadeOut();}
displaySelectedProfile()
}

/*
---------------------------------------------------------------------------------*/
function displaySelectedProfile(){

$("#profileSelectedList").html("");
var _class=""
for (i=0; i<profileSelected.length; i++)
		{
		_class="first-nav-item"
		if(i==0){_class="first-nav-item"}
		//if(i+1==profileSelected.length){_class="last-nav-item"}
		$("#profileSelectedList").append("<li class='"+_class+"'><a href='#'>"+ profileSelected[i].label +"</a></li>")
	
		}
		$("#profileSelectedList").append("<li class='first-nav-item' id='profileToUserOption' style='display:none;'><a href='#profileToUserInsert' onclick='javascript:profileToUserInsert();return false;'><strong>Add to selected User</strong></a></li>");
    	$("#profileSelectedList").append("<li class='first-nav-item' id='profileTotreeOption' style='display:none;'><a href='#profileToTreeInsert' onclick='javascript:profileToTreeInsert();return false;'><strong>Add to selected Tree</strong></a></li>");
    	
    	$("#profileSelectedList").append("<li class='last-nav-item'><a href='#Clear selected profiles' onclick='javascript:removeProfileSelected();return false;'><strong>Clear selected profiles</strong></a></li>");
		attachProfileOptions();
	}
	
	function attachProfileOptions()
	{
		
	if (userSelected.length!=0){$("#profileToUserOption").show()}else{$("#profileToUserOption").hide();}
	if (treeSelected.length!=0){$("#profileTotreeOption").show()}else{$("#profileTotreeOption").hide();}
	
	}


/*
---------------------------------------------------------------------------------*/
function removeProfileSelected(){
profileSelected=[];
$(".profileChecked").each(function(){

$(this).removeClass("profileChecked").attr("src",imgPath+"checkedOff.gif")

})
$("#profileSelected").fadeOut();
attachProfileOptions();
}
/*
---------------------------------------------------------------------------------*/
function selectedProfilesSerialize()
	
	{
	
	var myarr = new Array()
for (i=0; i<profileSelected.length; i++)
{
myarr[i]=profileSelected[i].id
}

return myarr.join(",")
	
	}
