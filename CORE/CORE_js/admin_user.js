var yearLimit=0;

$(document).ready(function(){

var d = new Date();
yearLimit=d.getFullYear()

for (i=yearLimit; i>=1900; i--){
$("#userBornYear").append("<option value='"+ i +"'>"+ i +"</option>");
}

$(".addProfileBtn").live("mouseover",function(){

statusIdSite=$(this).attr("idKey");
statusIdUser=$(this).attr("idUser");
	
	$('#userProfiles').position({
                of: $('#hostBtnProfile'+$(this).attr("idKey")),
                my: 'left top',
                at: 'left bottom'
            });
	
	$("#userProfiles").show().css("z-index","10000000000");
	$(".profileToUser").remove();
	if (profiles!=undefined){
		for (i=0; i<profiles.length; i++)
		{
		$("#profileSelector").append("<tr class='profileToUser'><td><a href='#' onclick='javascript:addProfileToUser("+ profiles[i].id +","+ statusIdSite +","+ statusIdUser +")' title='Add "+ profiles[i].label +" profile to user?'><strong>"+ profiles[i].label +"</strong></a></td></tr>")
		
		}
		
		}
		
		
	})

$(".addProfileBtn").live("mouseout",function(){$("#userProfiles").hide()})
$("#userProfiles").mouseover(function(){ $(this).show();})
$("#userProfiles").mouseout(function(){ $(this).hide();})



$(".statusIco").live("mouseover",function(){

    statusIdSite=$(this).attr("idKey");
	statusIdUser=$(this).attr("idUser");
	statusCurrent=$(this).attr("status");
	$("#hostSiteName").text($(this).attr("siteName"));
	 $('#userStatusSelector').position({
                of: $('#hostIco'+statusIdSite),
                my: 'left center',
                at: 'right top'
            });
	
	$("#userStatusSelector").show().css("z-index","10000000000");

	})

$(".statusIco").live("mouseout",function(){setTimeout($("#userStatusSelector").hide(),500);})
$("#userStatusSelector").mouseover(function(){ $(this).show();})
$("#userStatusSelector").mouseout(function(){ $(this).hide();})

})


/*
------------------------------------------------------------------------------------------------------------------------------*/
function userTabs(which)
	{
	
	
	}
/*
------------------------------------------------------------------------------------------------------------------------------*/
function newUser()
	{
	userClear()
	openLayer("#userForm",700,undefined,true,true,false,"Insert new User");
	$("#userInsertBtn").show();
	$("#userUpdateBtn").hide();
	}
	
	/*
------------------------------------------------------------------------------------------------------------------------------*/
function checkUserData()
	{
	
	if (!checkName($("#userName").val()) || $("#userName").val()==''){alert('Invalid Name'); $("#userName").val("").focus(); return false;}
	if (!checkName($("#userSurname").val()) || $("#userSurname").val()==''){alert('Invalid Surname'); $("#userSurname").val("").focus(); return false;}
	if (!checkName($("#userUsername").val()) || $("#userUsername").val()==''){alert('Invalid Username'); $("#userUsername").val("").focus(); return false;}
	if (!checkEmail($("#userEmail").val())){alert('Invalid E-mail'); $("#userEmail").val("").focus(); return false;}
	
	
	if ( $("#userPassword").val()!='' && $("#userPassword").val().length<8){alert('Password must be at leat 8 characters');  $("#userPassword").val("").focus();  return false;}
	
	if ($("#userPassword").val()!='' &&  $("#userPassword").val().length>16){alert('Password must be max 16 characters');  $("#userPassword").val("").focus();  return false;}
	
	if($("#userPassword").val()!='' && $("#userPasswordConfirm").val()==''){alert('Insert Confirm password!');  $("#userPasswordConfirm").focus();  return false;}
	
	if($("#userPassword").val()=='' && $("#userPasswordConfirm").val()!=''){alert('Insert Password!');  $("#userPassword").focus();  return false;}
	
	
	
	
	if($("#userPassword").val()!=$("#userPasswordConfirm").val()){alert('Password and Confirm Password E-mail must be equal!'); $("#userPassword, #userPasswordConfirm").val("");  $("#userPassword").focus();  return false;}
	
	
	if(!checkNickname($("#userNickname").val()) || $("#userNickname").val()=='' ){alert('Invalid Nickname'); $("#userNickname").val("").focus(); return false;}
	
	if(!checkUrl($("#userHomepage").val()) && $("#userHomepage").val()!=""){alert('Invalid Homepage'); $("#userHomepage").val("").focus(); return false;}
	
	
	if(!checkDate($("#userBornDay").val()+"/"+ $("#userBornMonth").val() +"/"+ $("#userBornYear").val()) && $("#userBornDay").val()!="" && $("#userBornMonth").val()!=""  && $("#userBornYear").val()!=""   ){alert('Invalid Born Date'); $("#userBornDay,#userBornMonth,#userBornYear").val(""); return false;}else{}
	
	return true;
	}
	
	
/*
------------------------------------------------------------------------------------------------------------------------------*/
	function userClear()
	{
	userTabs(0)
	$(".userSerialize").val("");
	$("#userTab1").html("");
	}
	
	/*
------------------------------------------------------------------------------------------------------------------------------*/
function getUserStatus(id_user){
	
	mydata="who=userStatus&idUser="+ id_user;
    $.ajax({
   type: "POST",
   url: engineUser,
   data: mydata,
   dataType: "json",
   success: function(msg){
    
    if(msg.values.error!=undefined)
{

 if (msg.values.error[0].errorId==0)
 {
   userStatus=msg;
  displayUserStatus(id_user);
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
------------------------------------------------------------------------------------------------------------------------------*/
	
	function displayUserStatus(id_user){
	$("#userTab1").html("");
	  if (userStatus.values.error!=undefined){

        if(userStatus.values.error[0].errorId==0){
  
        for (i=0; i<userStatus.values.site.length; i++)
		{
				$("#userTab1").append("<tr id='trHosts"+userStatus.values.site[i].id_key+"'><td style='width:20px;'><a href='#changeUserStatus'  idKey='"+userStatus.values.site[i].id_key+"' idUser='"+id_user+"' status='"+userStatus.values.site[i].status+"' title='Change Status' id='hostIco"+userStatus.values.site[i].id_key+"' siteName='"+ userStatus.values.site[i].site_label +"' class='statusIco'><img src='"+ imgPath +"user_status_"+ userStatus.values.site[i].status +".gif' style='border:none;border:2px solid #fff;' ></a></td><td ><strong>"+ userStatus.values.site[i].site_label +"</strong></td><td style='text-align:right;'><input  class='buttonGray addProfileBtn' idKey='"+ userStatus.values.site[i].id_key +"' idUSer='"+id_user+"'  id='hostBtnProfile"+userStatus.values.site[i].id_key+"' value='Add Profile' /></td></tr>")
				
				if (userStatus.values.site[i].profile!=undefined){
				$("#userTab1").append("<tr id='trHostsProfiles"+userStatus.values.site[i].id_key+"'><td colspan='3' style='padding-left:25px;'></td></tr>")
				             
				             
				            var user2profile='';	 
				            if (userStatus.values.site[i].profile!=undefined){	
				             for (z=0; z<userStatus.values.site[i].profile.length; z++)
		                                {
		                       user2profile=user2profile+"<a href='#' onclick='removeProfileFromUser("+userStatus.values.site[i].profile[z].id+","+userStatus.values.site[i].id_key+","+id_user+")' title='Remove "+ userStatus.values.site[i].profile[z].label +" profile from current user?'>"+userStatus.values.site[i].profile[z].label+"</a>"
		                       if (z<userStatus.values.site[i].profile.length-1){user2profile=user2profile+', '}
		                         
		                                }
		                                
		                                $("#trHostsProfiles"+userStatus.values.site[i].id_key+ " td").append("Profiles: " + user2profile) 
		                                
		                                }
		                                
		                                
		                    }
				
		}
         
         }
   }
	
	}
	

	/*
------------------------------------------------------------------------------------------------------------------------------*/
	
	function addProfileToUser(idProfile,idSite,idUser)
	{
	if(!confirm("Add this profile to user?")){return false;}
	
	mydata="who=profileToUserInsert&users="+ idUser+"&id_site="+idSite+"&id_profile="+idProfile;
    $.ajax({
   type: "POST",
   url: engineProfile,
   data: mydata,
   dataType: "json",
   success: function(msg){
   
   if(msg.values.error!=undefined)
{

 if (msg.values.error[0].errorId==0)
 {
  getUserStatus(idUser)
        $("#userProfiles").hide()
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
------------------------------------------------------------------------------------------------------------------------------*/
	
	function removeProfileFromUser(idProfile,idSite,idUser){
	
	if(!confirm("Remove this profile from user?")){return false;}
		
	mydata="who=profileToUserDelete&users="+ idUser+"&id_site="+idSite+"&id_profile="+idProfile;
    $.ajax({
   type: "POST",
   url: engineProfile,
   data: mydata,
   dataType: "json",
   success: function(msg){
   if(msg.values.error!=undefined)
{

 if (msg.values.error[0].errorId==0)
 { getUserStatus(idUser)
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
------------------------------------------------------------------------------------------------------------------------------*/	
function setUserStatusTo(toStatus)
{


$("#userStatusSelector").hide();
if (statusCurrent==toStatus) return false;
if (toStatus==3){

mydata="who=deleteUserStatus&idUser="+ statusIdUser+"&idSite="+statusIdSite;
    $.ajax({
   type: "POST",
   url: engineUser,
   data: mydata,
   dataType: "json",
   success: function(msg){
   
   if(msg.values.error!=undefined)
{

 if (msg.values.error[0].errorId==0)
 {
   getUserStatus(statusIdUser)
 }
 else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
 
}
  
          
   }
 });


}else{




var who;
if (statusCurrent==3){who='insertUserStatus'}else{who='updateUserStatus'}


mydata="who="+who+"&idUser="+ statusIdUser+"&idSite="+statusIdSite+"&status="+toStatus;
    $.ajax({
   type: "POST",
   url: engineUser,
   data: mydata,
   dataType: "json",
   success: function(msg){
   
   if(msg.values.error!=undefined)
{

 if (msg.values.error[0].errorId==0)
 {
 getUserStatus(statusIdUser)
 }
 else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
 
}
  
            
   }
 });
}
}
	

/*
------------------------------------------------------------------------------------------------------------------------------*/
	function updateUser(){
	if (!checkUserData()){ return false;}
	closeLayer("#userForm");
	mydata="who=userUpdate&" + $(".userSerialize").serialize();
    $.ajax({
   type: "POST",
   url: engineUser,
   data: mydata,
   dataType: "json",
   success: function(msg){
  
   if (msg.values.error!=undefined){

                if(msg.values.error[0].errorId==0){
         openDialog ('User Data Updated',200,100,2000);
         
         $("#userArchiveEmail"+currentUser).text($("#userEmail").val());
          $("#userArchiveNickname"+currentUser).text($("#userNickname").val());
           $("#userArchiveName"+currentUser).text($("#userName").val());
            $("#userArchiveSurname"+currentUser).text($("#userSurname").val());
         
         
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
------------------------------------------------------------------------------------------------------------------------------*/
	function insertUser(){
	if (!checkUserData()){ return false;}
	closeLayer("#userForm");
	mydata="who=userInsert&idSite="+currentKeySite+"&" + $(".userSerialize").serialize();
    $.ajax({
   type: "POST",
   url: engineUser,
   data: mydata,
   dataType: "json",
   success: function(msg){
  
   if (msg.values.error!=undefined){

                if(msg.values.error[0].errorId==0){
         openDialog ('User created correctly',200,100,2000);
         
getUsers(1,currentUserOrder,0)

         } else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
         }
         
   }
 });
	}
	
	
/*
------------------------------------------------------------------------------------------------------------------------------*/
	
function getUsers(page,orderBy,id_content)
{
checkUserOptions()
$(".itemsUser").remove();
 if(orderBy==undefined){orderBy=0;}
 if(id_content==undefined){id_content=0;}
  
		 mydata="who=getUserValues&id_content="+ id_content + "&page="+ page + "&orderBy=" + orderBy + "&rows=" + userDisplay; 
		 
		 $.ajax({
		   type: "POST",
		   url: engineUser,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
		   
		   
	if(msg.values.error!=undefined)
{

 if (msg.values.error[0].errorId==0)
 {
    
		   
		   
		   
		   usersValues=msg;
			  if (msg.values.count[0].count>0){
			   
			   $("#userGridHeader").show()
				 userRecords=msg.values.count[0].count;   
				 
				 
				if (userRecords<userDisplay){$(".userPagers").hide()}else{$(".userPagers").show()}  
		
			 	userPages=parseInt(userRecords/userDisplay);
			   if ((userPages*userDisplay)<userRecords){userPages++;}
			 				   			   
		  

var selected="";
var mypage=0;
var start=1
var end=0;
currentUserPage=page;
currentUserOrder=orderBy;


$(".userPages").html("");
$(".userItems").remove();

if (parseInt(page/userNumP)==0){start=1}
if (parseInt(page/userNumP)>0){start=page-parseInt(userNumP/2); $(".userPages").prepend("<a href='#' onclick='getUsers("+(page-+parseInt(userNumP/2)-1)+","+ orderBy +");return false;' class='page'>...</a>")}

if ((page+(userNumP/2))>=userPages){start=userPages-(userNumP-1)}
end = start+userNumP
if (end > userPages){end=userPages}
if(start<1){start=1;}

for (i=start; i<=end; i++){
if (i==page){selected=" selected";}
$(".userPages").append("<a href='#' onclick='getUsers("+i+","+ orderBy +");return false;' class='page"+ selected +"'>"+i+"</a>")
selected="";
}

if (page+parseInt(userNumP/2)<userPages){
mypage=page+userNumP;
if ((page+userNumP)>=userPages){mypage=userPages}
$(".userPages").append("<a href='#' onclick='getUserss("+ mypage +","+ orderBy +");return false;' class='page'>...</a>")
}
			  
			  
			  displayUsers()
		  
				}
				else{
				$(".userItems").remove()
				$(".userPagers,#userGridHeader").hide()
				
				
				}
				
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
------------------------------------------------------------------------------------------------------------------------------*/
function displayUsers()
{

showForm('userArchive');
 $(".userItems").remove();
	var selected="";
	
		if (usersValues.values.value!=undefined){
		
		for (i=0; i<usersValues.values.value.length; i++)
		{
			
		selected =	isUserSelected(i,usersValues.values.value[i].id_user);
			
		
		$("#userGrid").append("<tr class='userItems' id='tr_user_"+ usersValues.values.value[i].id_user +"' sequence='"+ i +"'><td valign='top' class='tdChecks'>"+  selected +"</td><td valign='top'>"+usersValues.values.value[i].id_user+"</td><td valign='top'></td><td valign='top'><a href='javascript:getUser("+usersValues.values.value[i].id_user+");' id='userArchiveEmail"+usersValues.values.value[i].id_user+"' >"+usersValues.values.value[i].email +"</a></td><td valign='top'><a href='javascript:getUser("+usersValues.values.value[i].id_user+");' id='userArchiveNickname"+usersValues.values.value[i].id_user+"'>"+usersValues.values.value[i].nickname +"</a></td><td><a href='javascript:getUser("+ usersValues.values.value[i].id_user + ");' id='userArchiveName"+usersValues.values.value[i].id_user+"'>"+usersValues.values.value[i].name +"</a></td><td><a href='javascript:getUser("+ usersValues.values.value[i].id_user + ");' id='userArchiveSurname"+usersValues.values.value[i].id_user+"'>"+usersValues.values.value[i].surname +"</a></td><td valign='top'>"+usersValues.values.value[i].date +"</td></tr>")	
			
			}
			}
		
}
/*
------------------------------------------------------------------------------------------------------------------------------*/
function isUserSelected(x,id_key){
var exist=false;
var i=0;
for (i=0; i<userSelected.length; i++)
		{
		if (userSelected[i].id_user==id_key){exist=true; break;}
		}
		
if(exist==true){

return "<img src='"+imgPath+"checkedOn.gif' alt='' class='userChecked' onclick='javascript:userCheckUncheck("+ x +")' id='userCheck"+x+"'/>"

}else{


return "<img src='"+imgPath+"checkedOff.gif' alt='' onclick='javascript:userCheckUncheck("+ x +")' id='userCheck"+x+"'/>"
}


}
/*
------------------------------------------------------------------------------------------------------------------------------*/
function isUserEnabled(i)
{

if(usersValues.values.value[i].enabled=="True")
{
return "<a href='#' id='linkUserStatus"+ i +"' onclick='setUserStatus("+i+");return false;' rel='False'><img  id='imgUserStatus"+ i +"' src='"+ imgPath + "enabled.gif' alt=''/></a>"
}else
{
return "<a href='#' id='linkUserStatus"+ i +"' onclick='setUserStatus("+i+");return false;' rel='True'><img id='imgUserStatus"+ i +"' src='"+ imgPath + "disabled.gif' alt=''/></a>"
}
}

/*
------------------------------------------------------------------------------------------------------------------------------*/
function goUserPage(Go)
{
if (Go=="first") {getUsers(1,currentUserOrder);return;}
if (Go=="prev" && (currentUserPage-1)>=1) {getUsers(currentUserPage-1,currentUserOrder);return;}
if (Go=="next" && (currentUserPage+1)<=userPages) {getUsers(currentUserPage+1,currentUserOrder);return;}
if (Go=="last") {getUsers(userPages,currentUserOrder);return;}
}
/*
------------------------------------------------------------------------------------------------------------------------------*/	
		
function userCheckUncheck(x)
{
var newSel=usersValues.values.value[x].id_user
var exist=false;

if ($("#userCheck"+x).hasClass("userChecked"))
{
$("#userCheck"+x).removeClass("userChecked")
$("#userCheck"+x).attr("src",imgPath+"checkedOff.gif")
for (i=0; i<userSelected.length; i++)
		{
		    if (userSelected[i].id_user==newSel)
		    {
		    userSelected.splice(i,1);
		    $("#userSelected span").text(userSelected.length);
    		}
		}


}
else{
$("#userCheck"+x).addClass("userChecked")
$("#userCheck"+x).attr("src",imgPath+"checkedOn.gif").addClass("userChecked");
	for (i=0; i<userSelected.length; i++)
		{
		if (userSelected[i].id_user==newSel){exist=true; break;}
		}
		
		if (exist==false){userSelected.push(usersValues.values.value[x]);$("#userSelected span").text(userSelected.length);}

}
checkUserOptions()
if(userSelected.length>0){$("#userSelected").fadeIn();}else{$("#userSelected").fadeOut();}
displaySelectedUser()
}

/*
------------------------------------------------------------------------------------------------------------------------------*/
function setUserStatus(i)
{

if ($("#linkUserStatus"+i).attr("rel")=="True")
{
$("#linkUserStatus"+i+" img").attr("src",imgPath + "enabled.gif");
$("#linkUserStatus"+i).attr("rel","False")
updateUserField(i,"user_enabled","1")
return false;
}
else
{
$("#linkUserStatus"+i+" img").attr("src",imgPath + "disabled.gif")
$("#linkUserStatus"+i).attr("rel","True")
updateUserField(i,"user_enabled","0")
return false;
}


}
/*
------------------------------------------------------------------------------------------------------------------------------*/
		
function updateUserField(i,field,value,callback)
{

mydata="who=updateUserField&idUser="+ usersValues.values.value[i].id_user + "&field="+ field + "&value="+ value;
		
		$.ajax({
		   type: "POST",
		   url: engineUser,
		   data: mydata,
		    dataType: "json",
		   success: function(msg){
		   if(msg.values.error!=undefined)
{

 if (msg.values.error[0].errorId==0)
 {
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
------------------------------------------------------------------------------------------------------------------------------*/
function checkUserOptions()
{

if (userSelected.length>0){
$("#userOptionDelete").removeClass("option-disabled")

}else
{
$("#userOptionDelete").addClass("option-disabled")
}

if (userSelected.length>0 && contentSelected.length>0){$("#userOptionAdd").removeClass("option-disabled")}else{$("#userOptionAdd").addClass("option-disabled")}

}	
/*
------------------------------------------------------------------------------------------------------------------------------*/
function displaySelectedUser(){

$("#userSelectedList").html("");
var _class=""
for (i=0; i<userSelected.length; i++)
		{
		_class=""
		if(i==0){_class="first-nav-item"}
		if(i+1==userSelected.length){_class="last-nav-item"}
		$("#userSelectedList").append("<li class='"+_class+"'><a href='javascript:getUser("+userSelected[i].id_user+",1)' title='"+userSelected[i].email+"'>"+ userSelected[i].name + ' ' + userSelected[i].surname +"</a></li>")
	
		}
		attachProfileOptions();
	}
	
/*
------------------------------------------------------------------------------------------------------------------------------*/	
function getUser(id_user)
	{
	
	userClear()
	mydata="who=getUser&idUser=" + id_user;
	
$.ajax({
   type: "POST",
   url: engineUser,
   data: mydata,
   dataType: "json",
   success: function(msg){
  
        if (msg.values.error!=undefined){

                if(msg.values.error[0].errorId==0)
                  {
                  getUserStatus(id_user)
                  
                  $("#userInsertBtn").hide();
                  $("#userUpdateBtn").show();
                  openLayer("#userForm",700,undefined,true,true,false,"User: " + msg.values.value[0].name + " " + msg.values.value[0].surname );
                  currentUser=id_user;
                  $("#idUser").val(id_user);
                  $("#userName").val(msg.values.value[0].name);
                  $("#userSurname").val(msg.values.value[0].surname);
                  $("#userNickname").val(msg.values.value[0].nickname);
                  $("#userUsername").val(msg.values.value[0].username);
                  $("#userEmail").val(msg.values.value[0].email);
                  $("#userGender").val(msg.values.value[0].gender);
                  $("#userHomepage").val(msg.values.value[0].homepage);
              
              
                  var bornDate=msg.values.value[0].birthDate+'';
                  if (bornDate>0){
                  
                  $("#userBornDay").val(bornDate.substring(6,8))
                  $("#userBornMonth").val(bornDate.substring(4,6))
                  $("#userBornYear").val(bornDate.substring(0,4))
                                }
                  
                  } else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
                  
          }
  
   }
 });

	}
	
/*
------------------------------------------------------------------------------------------------------------------------------*/	
function removeUserSelected(){
userSelected=[];
$(".userChecked").each(function(){

$(this).removeClass("userChecked").attr("src",imgPath+"checkedOff.gif")

})
$("#userSelected").fadeOut();
attachProfileOptions();
}
/*
------------------------------------------------------------------------------------------------------------------------------*/
function selectedUsersSerialize()
{
    var myarr = new Array()
    for (i=0; i<userSelected.length; i++)
    {
        myarr[i]=userSelected[i].id_user
    }
    return myarr.join(",")
}

/*
------------------------------------------------------------------------------------------------------------------------------*/