
var modalContent = false;

function clearSearch(who){

switch (who){


case 0:
contentSearchObj.sites=[];
$("#searchSitesContents").val("");
$(".searchSiteTr").remove();
break;

case 1:
contentSearchObj.users=[];
$("#searchUsersContents").val("");
$(".searchUserTr").remove();
break;

case 2:
contentSearchObj.relateds=[];
$("#searchRelatedsContents").val("");
$(".searchRelatedTr").remove();
break;

case 3:
contentSearchObj.contexts=[];
$("#searchContextsContents").val("");
$(".searchContextTr").remove();
break;

case 4:
contentSearchObj.trees=[];
$("#searchTreesContents").val("");
$(".searchTreeTr").remove();
break;

}
checkSearchValues();

}

/*
-----------------------------------------------------------------------------------------------------------------------------*/
function setSearchStatus(status)
{
if (status ==1){return imgPath+'searchActive.gif';}else{return imgPath+'searchInactive.gif';}
}

/*
-----------------------------------------------------------------------------------------------------------------------------*/
function deleteContentsSelected(contents)
{

if (contentSelected.length==0){return false;}

		if(confirm('Delete contents??')){
		
		mydata="who=deleteContents&contents="+ contents;
		
				
		$.ajax({
		   type: "POST",
		   url: engineContent,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
		   
		     if(msg.values.error[0].errorId==0){
		   
		 		  		closeLayer('#contentSelectedMenu');  
		 		  		openDialog ('Contents removed',200,100,2000);
		 		  		removeContentSelected()
		 		  		contentsGet(currentTree,currentOrder,1)
		 		  }else
		 		  {
		 		  if (msg.values.error[0].errorId==666){ displayActionForbidden()}
		 		  }		
		 		  		
		   }
		 });}
		 
		 else{return false;}
}
	
/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function selectedContentsSerialize()
	
	{
	
	var contentkeys = new Array()
for (i=0; i<contentSelected.length; i++)
{
contentkeys[i]=contentSelected[i].id_key
}

return contentkeys.join("|")
	
	}
	
	
/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function getContent(id_content)
{
resetContentForm()

			mydata="who=getContent&id_content="+ id_content + "&language_id="+ languageId;
		
		$.ajax({
		   type: "POST",
		   url: engineContent,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
		  
		    if(msg.values.error[0].errorId==0){
		   currentContent=id_content;
		   contentValue=msg;
		 
		   getRelatedValues(id_content)
		   getContextsValues(id_content)
		   getTreesRelated(id_content)
		   displayCovers()
		   getPosts(id_content,1,1)
		   postSelected=[];
		   displayContent()
		  		}
		  		else{
		  		
		  		if (msg.values.error[0].errorId==666){ displayActionForbidden();}
		  		
		  		}
		  		  
		   }
		 });
}


/*
-----------------------------------------------------------------------------------------------------------------------------*/

function displayContent()
{

	if(modalContent){
	
	//alert('>' + contentValue.values.content[0].value + '<')
	var oEditor = FCKeditorAPI.GetInstance('content_description')
	if (contentValue.values.content[0].value!=undefined){oEditor.SetData(contentValue.values.content[0].value)}else{oEditor.SetData("")}
		
		
}
	
		$("#contentForm").dialog({resizable: true, draggable: true, width: 800 , modal: false, autoOpen: true, title: contentValue.values.content[0].title , minWidth: 600,  open: function(event, ui) {modalContent=true;
		$("#content_description").val(contentValue.values.content[0].value);
		oFCKeditor.ReplaceTextarea();
		},buttons: { "Close": function() { $(this).dialog("close");modalContent=false; }, "Update & Close": function() {updateContent(); $(this).dialog("close"); }, "Update":function() {updateContent(); } } })
		
		
		$("#content_title").val(contentValue.values.content[0].title);
		$("#content_type").val(contentValue.values.content[0].type);
		$("#content_abstract").val(contentValue.values.content[0].abstract);
		$("#post_option").val(contentValue.values.content[0].postOption);
		$("#content_publication").val(contentValue.values.content[0].date_publication);
		if (contentValue.values.content[0].enabled=="True"){$("#content_enabled").attr("checked","checked")}else{$("#content_enabled").attr("checked","")}
		
		
		
	
		setUpImageUpload();
		setUpMacroUpload(2);
		
		
		
		
}
	
/*
-----------------------------------------------------------------------------------------------------------------------------*/

function newContent(idTree)
{
		//showForm('contentFormNew')
		
		openLayer("#contentFormNew",500);
		resetContentForm()
		//currentTree=idTree
}
/*
-----------------------------------------------------------------------------------------------------------------------------*/
function resetContentForm(){
        $("#content_title_new").val("")
		$("#content_title").val("")
		$("#content_abstract").val("")
		$("#content_publication").val("")
		$("#content_enabled").attr("checked","")
		$("#content_description").val("")
		$("#post_option").val(0)
		
	
	}
	
/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function insertContent()
{
	_title=$("#content_title_new");
	
	if(!checkContentTitle(_title.val())){alert('Insert a valid Title!');_title.focus();return false; }
	
	//if (_title.val()==""){alert('Insert title');_title.focus();return false; }
	
	closeLayer("#contentFormNew");
		mydata="who=insertContent&id_site="+ currentKeySite +"&id_user="+ id_user + "&id_tree="+ currentKeyTree +"&language_id="+ languageId + "&content_title="+_title.val() +"&content_type="+ $("#content_type_new").val();
			
							
		$.ajax({
		   type: "POST",
		   url: engineContent,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
	
		 if(msg.values.error[0].errorId==0){
			   
				getContent(msg.values.content[0].contentId)
		        openDialog("New content created.",200,100,2000);
			   
			   }else
			   {
			   if (msg.values.error[0].errorId==666){ displayActionForbidden();}
			    openDialog("No content created.",200,100,2000);
	
		
		  }
		  
		   }
		 });
		
}
/*
-----------------------------------------------------------------------------------------------------------------------------*/
function updateContent()
{

	//if ($("#content_title").val()==""){alert('Insert title');$("#content_title").focus();return false; }
	
	_title=$("#content_title");
	
	if(!checkContentTitle(_title.val())){alert('Insert a valid Title!');_title.focus();return false; }
	
	
	
	if ( $("#tr_"+contentValue.values.content[0].id_key).length ){
		var sequence=parseInt($("#tr_"+contentValue.values.content[0].id_key).attr("sequence"));
		contentsValues.values.value[sequence].title=_title.val();
		if ($("#content_enabled").is(":checked")){contentsValues.values.value[sequence].enabled="True"}else{contentsValues.values.value[sequence].enabled="False"}
		
		}

		var oEditor = FCKeditorAPI.GetInstance('content_description');
		var content_description=oEditor.GetData();
		
		mydata="who=updateContent&id_content="+ contentValue.values.content[0].id_key + "&language_id="+ languageId + "&" + $(".serialize").serialize() +"&content_description="+escape(content_description);
			
		//showForm('processing')
			
		$.ajax({
		   type: "POST",
		   url: engineContent,
		   data: mydata,
		    dataType: "json",
		   success: function(msg){
	
	
	$("#processing").hide()
	
		   if(msg.values.error[0].errorId==0){
			   			   
			   openDialog ("Data Updated",200,100,2000);
			   contentsGet(currentTree,currentOrder,currentPage)
										   
			   }else
			   {
			    if (msg.values.error[0].errorId==666){ displayActionForbidden();}
			   openDialog (msg.values.error[0].errorLabel,200,100,2000);
			   
			   showForm()
		  }
		  
		   }
		 });
		
}
/*
-----------------------------------------------------------------------------------------------------------------------------*/
function updateContentSelectedList(id,title)
{
	for (i=0; i<contentSelected.length; i++)
		{
	        if (contentSelected[i].id_key==id){contentSelected[i].title=title;displaySelectedContent(); break;}
		}
	
}
/*
-----------------------------------------------------------------------------------------------------------------------------*/
function updateArchive(id_key,sequence){
	$(".items").removeClass("selected")
	$("#tr_"+id_key).addClass("selected")

	var selected =	contentIsSelected(sequence,id_key);
	
		$("#tr_"+id_key).html("<td>"+  selected +"</td><td>"+contentsValues.values.value[sequence].id_key+"</td><td class='tdChecks'>"+ isEnabled(sequence)+"</td><td><a href='javascript:getContent("+contentsValues.values.value[sequence].id_key+");'>"+contentsValues.values.value[sequence].title+"</a></td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>")	
	
		
	}
/*
-----------------------------------------------------------------------------------------------------------------------------*/
function checkContentOptions()
{

if (contentSelected.length>0){
$("#contentOptionDelete").removeClass("option-disabled")

}else
{
$("#contentOptionDelete").addClass("option-disabled")

}

}	
/*
-----------------------------------------------------------------------------------------------------------------------------*/	
	
	function clearSearchValues()
	{
	$(".searchContentSerialize").val("");
	
	}
	
	
/*
-----------------------------------------------------------------------------------------------------------------------------*/	
	
	function checkSearchValues()
	{
	if(contentSearchObj.sites.length==0){$("#searchSiteMenu").hide();$("#searchContentImg0").hide();}else{$("#searchContentImg0").show();}
	if(contentSearchObj.users.length==0){$("#searchUserMenu").hide();$("#searchContentImg1").hide();}else{$("#searchContentImg1").show();}
	if(contentSearchObj.relateds.length==0){$("#searchRelatedMenu").hide();$("#searchContentImg2").hide();}else{$("#searchContentImg2").show();}
	if(contentSearchObj.contexts.length==0){$("#searchContextMenu").hide();$("#searchContentImg3").hide();}else{$("#searchContentImg3").show();}
	if(contentSearchObj.trees.length==0){$("#searchTreeMenu").hide();$("#searchContentImg4").hide();}else{$("#searchContentImg4").show();}
	}
	
/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function contentsGet(id_tree,orderBy,page){
checkSearchValues()
if(id_tree==undefined){id_tree=currentTree;}
if(id_tree>0){clearSearchValues();$("#searchTreesContents").val(id_tree);checkSearchValues();}
if(orderBy==undefined){orderBy=currentOrder;}
if(page==undefined){page=currentPage;}

checkContentOptions()
var selected="";
var mypage=0;
var start=1
var end=0;
currentTree=id_tree;
currentOrder=orderBy;
currentPage=page;
 
mydata="who=getContentsValues&language_id="+ languageId + "&rows="+ display +"&page=" + page + "&orderBy="+orderBy+"&" + $(".searchContentSerialize").serialize();
		
		
	//alert(mydata)
		 
		 $.ajax({
		   type: "POST",
		   url: engineContent,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
		   
		   if(msg.values.error[0].errorId==0){
		   
$(".pages").html("");		   
$(".items").remove();
		   			   if (msg.values.contents[0].count>0){
			   
			  		 records=msg.values.contents[0].count;  
				    if (records<display){$(".pagers").hide()}else{$(".pagers").show()}
				     
			 	    pages=parseInt(records/display);
			        if ((pages*display)<records){pages++;}
			        


if (parseInt(page/numP)==0){start=1}
if (parseInt(page/numP)>0){start=page-parseInt(numP/2); $(".pages").prepend("<a href='#' onclick='contentsGet("+ currentTree +","+ orderBy +","+(page-+parseInt(numP/2)-1)+");return false;' class='page'>...</a>")}

if ((page+(numP/2))>=pages){start=pages-(numP-1)}
end = start+numP
if (end > pages){end=pages}
if(start<1){start=1;}

for (i=start; i<=end; i++){
if (i==page){selected=" selected";}
$(".pages").append("<a href='#' onclick='contentsGet("+ currentTree +","+ orderBy +","+i+");return false;' class='page"+ selected +"'>"+i+"</a>")
selected="";
}

if (page+parseInt(numP/2)<pages){
mypage=page+numP;
if ((page+numP)>=pages){mypage=pages}
$(".pages").append("<a href='#' onclick='contentsGet("+ currentTree +","+ orderBy +","+ mypage +");return false;' class='page'>...</a>")
}
			       
		  contentsValues=msg;
		  displayContents();  
		  
			   
		        }
		        showForm('archive');
		        
		        
		       }else{
		         if (msg.values.error[0].errorId==666){ displayActionForbidden();}
		       
		       }
		   
		    }

		 });
		 
}
	

/*
-----------------------------------------------------------------------------------------------------------------------------*/
function displayContents()
{

	var selected="";
			
		if (contentsValues.values.value!=undefined){
		for (i=0; i<contentsValues.values.value.length; i++)
		{
			
		selected =	contentIsSelected(i,contentsValues.values.value[i].id_key);
			
		
		$("#grid").append("<tr class='items' id='tr_"+ contentsValues.values.value[i].id_key +"' sequence='"+ i +"'><td class='tdChecks'>"+  selected +"</td><td>"+contentsValues.values.value[i].id_key+"</td><td>"+ isEnabled(i) +"</td><td>"+ getContentType(contentsValues.values.value[i].type) +"</td><td>"+ contentsValues.values.value[i].dateCreation +"</td><td>"+ contentsValues.values.value[i].date +"</td><td><a href='javascript:getContent("+contentsValues.values.value[i].id_key+");'>"+contentsValues.values.value[i].title+"</a></td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>")	
			
			}
			}
		
}

function getContentType(type){

switch (type)
{
case 1:
return "Content"
break;
case 2:
return "Related"
break;
case 3:
return "Event"
break;
case 4:
return "Location"
break;
case 5:
return "Post"
break;
case 6:
return "Blog"
break;
case 7:
return "News"
break;
case 8:
return "Album"
break;
case 9:
return "Static"
break;
case 10:
return "Book"
break;
}


}

/*
-----------------------------------------------------------------------------------------------------------------------------*/
function isEnabled(i)
{

if(contentsValues.values.value[i].enabled=="True")
{
return "<a href='#' id='linkStatus"+ i +"' onclick='setStatus("+i+")' rel='False'><img  src='"+ imgPath + "enabled.gif' alt=''/></a>"
}else
{
return "<a href='#' id='linkStatus"+ i +"' onclick='setStatus("+i+")' rel='True'><img id='imgStatus"+ i +"' src='"+ imgPath + "disabled.gif' alt=''/></a>"
}
}

/*
-----------------------------------------------------------------------------------------------------------------------------*/
function updateContentField(i,field,value,callback)
{

mydata="who=updateContentField&id_content="+ contentsValues.values.value[i].id_key + "&field="+ field + "&value="+ value;
		
		$.ajax({
		   type: "POST",
		   url: engineContent,
		   data: mydata,
		    dataType: "json",
		   success: function(msg){
		   
		   
		   if(msg.values.error[0].errorId==0){
			   			   
			 
			   }else
			   {
			    if (msg.values.error[0].errorId==666){ displayActionForbidden();}
			  
		  }
		   
		   }
		 });

}
/*
-----------------------------------------------------------------------------------------------------------------------------*/
function setStatus(i)
{

if ($("#linkStatus"+i).attr("rel")=="True")
{
$("#linkStatus"+i+" img").attr("src",imgPath + "enabled.gif");
$("#linkStatus"+i).attr("rel","False")
updateContentField(i,"content_enabled","1")
}
else
{
$("#linkStatus"+i+" img").attr("src",imgPath + "disabled.gif")
$("#linkStatus"+i).attr("rel","True")
updateContentField(i,"content_enabled","0")
}


}

/*
-----------------------------------------------------------------------------------------------------------------------------*/
function contentIsSelected(x,id_key){
var exist=false;
var i=0;
for (i=0; i<contentSelected.length; i++)
		{
		if (contentSelected[i].id_key==id_key){exist=true; break;}
		}
		
if(exist==true){

return "<img src='"+imgPath+"checkedOn.gif' alt='' class='checked' onclick='javascript:contentCheckUncheck("+ x +")' id='contentCheck"+x+"'/>"

}else{


return "<img src='"+imgPath+"checkedOff.gif' alt='' onclick='javascript:contentCheckUncheck("+ x +")' id='contentCheck"+x+"'/>"
}


}

/*
-----------------------------------------------------------------------------------------------------------------------------*/
function contentCheckUncheck(x)
{

var newSel=contentsValues.values.value[x].id_key
var exist=false;

if ($("#contentCheck"+x).hasClass("checked"))
{
$("#contentCheck"+x).removeClass("checked")
$("#contentCheck"+x).attr("src",imgPath+"checkedOff.gif")
for (i=0; i<contentSelected.length; i++)
		{
		    if (contentSelected[i].id_key==newSel)
		    {
		    contentSelected.splice(i,1);
		    $("#contentSelected span").text(contentSelected.length);
    		}
		}
}
else{
$("#contentCheck"+x).addClass("checked")
$("#contentCheck"+x).attr("src",imgPath+"checkedOn.gif").addClass("checked");
	for (i=0; i<contentSelected.length; i++)
		{
		if (contentSelected[i].id_key==newSel){exist=true; break;}
		}
		if (exist==false){contentSelected.push(contentsValues.values.value[x]);$("#contentSelected span").text(contentSelected.length);}
}
 
checkContentOptions()
if(contentSelected.length>0){$("#contentSelected").fadeIn();}else{$("#contentSelected").fadeOut();}
displaySelectedContent()
}
/*
-----------------------------------------------------------------------------------------------------------------------------*/
function displaySelectedContent(){

$("#contentSelectedList").html("");
var _class=""
for (i=0; i<contentSelected.length; i++)
		{
		_class=""
		if(i==0){_class="first-nav-item"}
		if(i+1==contentSelected.length){_class="last-nav-item"}
		
		$("#contentSelectedList").append("<li class='"+ _class +"'><a href='javascript:getContent("+ contentSelected[i].id_key +")' title='"+contentSelected[i].title + "'> " + displayMax(contentSelected[i].title,20) +"</a></li>") 
		}
}
/*
-----------------------------------------------------------------------------------------------------------------------------*/
function removeContentSelected(){
contentSelected=[];
$("#contentSelectedList").html("");
$("#contentSelected").fadeOut();
$(".checked").each(function(){
$(this).removeClass("checked").attr("src",imgPath+"checkedOff.gif")

})

}
/*
-----------------------------------------------------------------------------------------------------------------------------*/
function goPage(Go)
{
if (Go=="first") {contentsGet(currentTree,currentOrder,1);return;}
if (Go=="prev" && (currentPage-1)>=1) {contentsGet(currentTree,currentOrder,currentPage-1);return;}
if (Go=="next" && (currentPage+1)<=pages) {contentsGet(currentTree,currentOrder,currentPage+1);return;}
if (Go=="last") {contentsGet(currentTree,currentOrder,pages);return;}
}
	
	


		
	
	