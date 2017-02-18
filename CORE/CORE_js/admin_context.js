var txtsearch = '';
var found= false;
var delTag = 0;



/*
-----------------------------------------------------------------------------------------------------------------------------*/
$(document).ready(function() {
	
$("#searchContentImg3").mouseover(function(){$('#searchContextMenu').show().css("z-index","10000000000");})
$("#searchContentImg3").mouseout(function(){$("#searchContextMenu").hide();})
$("#searchContextMenu").mouseover(function(){$(this).show(); })
$("#searchContextMenu").mouseout(function(){ $(this).hide();})
		
		$("#context_title").keyup(function(e){ 
															  
				txtsearch = jQuery.trim($("#context_title").val().toLowerCase())
																				
					    if 	(e.keyCode==8 && txtsearch==''){
							
						var tagsLength=$("#selectedTagsContainer span").length
							if (tagsLength>0){
								
								var tagsSelectedLength=$("#selectedTagsContainer span.selected").length
								
								
								if (tagsSelectedLength==0)
								{
								$("#selectedTagsContainer span").eq(tagsLength-1).addClass("selected")
								delTag=tagsLength;	
								setTimeout("bindel()",50)
								$("#context_title").blur();
								}
							
							}
							
						}
						
						else
						{
						
							if 	(e.keyCode==188){
										
										txtsearch=txtsearch.substring(0,txtsearch.length-1)	
										cicleTag(txtsearch)
						
								
								}else{
										checkContext();
												
								}
											
						}
											
				
									
		});
						   
	
	$("#context_title").focus(function(e){ $("#selectedTagsContainer span").removeClass("selected");delTag=0;$(document).unbind("keyup");})
	
	$("#context_title").blur(function(e){ setTimeout("checkBlur()",50)})
		
							   
});

/*
-----------------------------------------------------------------------------------------------------------------------------*/
function tagsToggle()
{
if($("#relatedTags").is(":hidden")){$("#relatedTags").fadeIn();$("#tagsSpan").text("-")}else{$("#relatedTags").fadeOut();$("#tagsSpan").text("+")}

}

/*
-----------------------------------------------------------------------------------------------------------------------------*/
function getContexts()
{

$(".contextItems").remove();


	var selected="";
		
		if (contextsValues.value!=undefined){
		
		for (i=0; i<contextsValues.value.length; i++)
		{
			
		selected =	isContextSelected(i,contextsValues.value[i].id_key);
			
		if (contextsValues.value[i].type==0){
		$("#contextGrid").append("<li class='contextItems ui-corner-all' style='display:inline;' id='li_context_"+ contextsValues.value[i].id_key +"' sequence='"+ i +"'><span class='tdChecks'>"+  selected +"</span><span><a href='javascript:modContext("+contextsValues.value[i].id_key+","+i+");'><span>"+contextsValues.value[i].title + "</span> ("+ contextsValues.value[i].tot +")</a></span></li>")	
			}
			if (contextsValues.value[i].type==1){
			$("#contextGroupGrid").append("<li class='contextItems ui-corner-all' style='display:inline;' id='li_context_"+ contextsValues.value[i].id_key +"' sequence='"+ i +"'><span class='tdChecks'>"+  selected +"</span><span><a href='javascript:modContext("+contextsValues.value[i].id_key+","+i+");'><span>"+contextsValues.value[i].title + "</span> ("+ contextsValues.value[i].tot +")</a></span></li>")
			
			}
			
			
			}
			
			}
		
}
/*
-----------------------------------------------------------------------------------------------------------------------------*/

function modContext(idKey,i)
{
currentContext=idKey;
currentContextIndex=i;
$("#contextTitle").val(contextsValues.value[i].title);



if(contextsValues.value[i].type==0)
{
openLayer("#tagFormModify",400,undefined,false,true,true,"Modify Tag: " + contextsValues.value[i].title)
$("#tagsTabs").tabs("select",0);$("#tagsTabs ul").eq(0).find("li a").eq(0).text("Tag");  $("#tagsTabs ul").eq(0).find("li").eq(2).hide(); $("#tagsTabs ul").eq(0).find("li").eq(1).show();

}
else
{
openLayer("#tagFormModify",400,undefined,false,true,true,"Modify Group: " + contextsValues.value[i].title)
$("#tagsTabs").tabs("select",0);$("#tagsTabs ul").eq(0).find("li a").eq(0).text("Group");  $("#tagsTabs ul").eq(0).find("li").eq(1).hide(); $("#tagsTabs ul").eq(0).find("li").eq(2).show();
getGroupContext();
}

}
/*
-----------------------------------------------------------------------------------------------------------------------------*/
function getGroupContext()
{
mydata="who=contextGetContexts&context="+ currentContext;
		
		$.ajax({
		   type: "POST",
		   url: engineContext,
		   data: mydata,
		   dataType: "json",
		     success: function(msg){
		
if(msg.values.error!=undefined)
{

 if (msg.values.error[0].errorId==0)
 {
 $("#groupContexts").html("");
 
if(msg.values.value!=undefined){
for (i=0; i<msg.values.value.length; i++)
		{
$("#groupContexts").append("<li class='contextItems ui-corner-all' style='display:inline;'><a href='#' onclick='javascript:removeFromGroup("+ msg.values.value[i].id_key +")' title='Remove relation'><img src='"+imgPath+"relation_delete.gif' alt='' style='vertical-align:middle'/></a><span><span>"+msg.values.value[i].title + "</span> ("+ msg.values.value[i].tot +")</span> </li>")	
}
}
 }
 else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
 
}
}
});
return false;

}
/*
-----------------------------------------------------------------------------------------------------------------------------*/
function removeFromGroup(key)
{
if(!confirm('Remove this context from group?')){return false;}
mydata="who=removeFromGroup&group="+ currentContext +"&context="+key;
		
		$.ajax({
		   type: "POST",
		   url: engineContext,
		   data: mydata,
		   dataType: "json",
		     success: function(msg){
		
if(msg.values.error!=undefined)
{

 if (msg.values.error[0].errorId==0)
 {
getGroupContext();
 }
 else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
 
}
}
});
return false;

}
/*
-----------------------------------------------------------------------------------------------------------------------------*/
function contextUpdate()
{
if ($("#contextTitle").val()==""){alert("Insert a text!"); return false;}
mydata="who=contextUpdate&idContext="+ currentContext + "&contextTitle="+$("#contextTitle").val();
		
		$.ajax({
		   type: "POST",
		   url: engineContext,
		   data: mydata,
		   dataType: "json",
		     success: function(msg){
		
if(msg.values.error!=undefined)
{

 if (msg.values.error[0].errorId==0)
 {
$("#li_context_"+ currentContext +" a span").text($("#contextTitle").val());
$("#selectedContext"+currentContext).text($("#contextTitle").val())
contextsValues.value[currentContextIndex].title=$("#contextTitle").val();
closeLayer("#tagFormModify");

 }
 else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
 
}
}
});
return false;
}


/*
-----------------------------------------------------------------------------------------------------------------------------*/
function isContextSelected(x,id_key){
var exist=false;
var i=0;
for (i=0; i<contextSelected.length; i++)
		{
		if (contextSelected[i].id_context==id_key){exist=true; break;}
		}
		
if(exist==true){

return "<img src='"+imgPath+"checkedOn.gif' alt='' class='contextChecked' onclick='javascript:contextCheckUncheck("+ x +")' id='contextCheck"+x+"' style='vertical-align:middle'/>"

}else{


return "<img src='"+imgPath+"checkedOff.gif' alt='' onclick='javascript:contextCheckUncheck("+ x +")' id='contextCheck"+x+"'/>"
}
}
/*
-----------------------------------------------------------------------------------------------------------------------------*/
function contextCheckUncheck(x)
{
var newSel=contextsValues.value[x].id_key
var exist=false;

if ($("#contextCheck"+x).hasClass("contextChecked"))
{
$("#contextCheck"+x).removeClass("contextChecked")
$("#contextCheck"+x).attr("src",imgPath+"checkedOff.gif")
for (i=0; i<contextSelected.length; i++)
		{
		    if (contextSelected[i].id_key==newSel)
		    {
		    contextSelected.splice(i,1);
		    $("#contextSelected span").text(contextSelected.length);
    		}
		}


}
else{
$("#contextCheck"+x).addClass("contextChecked")
$("#contextCheck"+x).attr("src",imgPath+"checkedOn.gif").addClass("contextChecked");
	for (i=0; i<contextSelected.length; i++)
		{
		if (contextSelected[i].id_key==newSel){exist=true; break;}
		}
		
		if (exist==false){contextsValues.value[x].index=i;contextSelected.push(contextsValues.value[x]);$("#contextSelected span").text(contextSelected.length);}

}

if(contextSelected.length>0){$("#contextSelected").fadeIn();}else{$("#contextSelected").fadeOut();}

displaySelectedContext()
}
/*
-----------------------------------------------------------------------------------------------------------------------------*/
function displaySelectedContext(){


		
		$("#contextSelectedList").html("");
var _class=""
for (i=0; i<contextSelected.length; i++)
		{
		_class="first-nav-item"
		if(i==0){_class="first-nav-item"}
		
		$("#contextSelectedList").append("<li class='"+_class+"'><a href='#' onclick='modContext("+ contextSelected[i].id_key +","+  getContextIndex(contextSelected[i].id_key) +")' id='selectedContext"+contextSelected[i].id_key+"'>"+ contextSelected[i].title +"</a></li>");
	
		}
		$("#contextSelectedList").append("<li class='first-nav-item'><a href='#' onclick='javascript:deleteContexts();return false;'><strong>Delete selected contexts</strong></a></li>");
		
		$("#contextSelectedList").append("<li class='first-nav-item'><a href='#' onclick='javascript:addTagToGroups();return false;'><strong>Add Tags to Groups</strong></a></li>");

    	$("#contextSelectedList").append("<li class='first-nav-item'><a href='#' onclick='javascript:removeContextSelected();return false;'><strong>Clear selected Contexts</strong></a></li>");
    	
    	$("#contextSelectedList").append("<li class='last-nav-item'><a href='javascript:addSelectedContextToSearch();' title='Add Selected to content search'><strong>Add to content search</strong></a></li>")	
		
	
}

/*
-----------------------------------------------------------------------------------------------------------------------------*/
function deleteContexts()
{

if(!confirm('Delete selected contexts?')){return false;}

mydata="who=deleteContexts&contexts="+ selectedContextsSerialize()

		$.ajax({
		   type: "POST",
		   url: engineContext,
		   data: mydata,
		   dataType: "json",
		     success: function(msg){
		
if(msg.values.error!=undefined)
{

 if (msg.values.error[0].errorId==0)
 {
removeContextSelected(true);

 }
 else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
 
}
}
});
return false;
}
/*
-----------------------------------------------------------------------------------------------------------------------------*/
function addTagToGroups()
{

if(!confirm('Add tags to selected Groups?')){return false;}

mydata="who=contextsToGroups&contexts="+ selectedContextsSerialize(false) + "&groups="+ selectedContextsSerialize(true)

		$.ajax({
		   type: "POST",
		   url: engineContext,
		   data: mydata,
		   dataType: "json",
		     success: function(msg){
		
if(msg.values.error!=undefined)
{

 if (msg.values.error[0].errorId==0)
 {
removeContextSelected(true);
openDialog ('Tag Inserted');
 }
 else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
 
}
}
});
return false;
}
/*
------------------------------------------------------------------------------------------------------------------*/
function removeContextSelected(remove){

if (remove!=undefined){
loadContexts(languageId);
}
else
{
$(".contextChecked").each(function(){
$(this).removeClass("contextChecked").attr("src",imgPath+"checkedOff.gif")
})
}
contextSelected=[];
$("#contextSelected").fadeOut();
}


/*
-----------------------------------------------------------------------------------------------------------------------------*/
function selectedContextsSerialize(group)
{
var contextkeys = new Array()
for (i=0; i<contextSelected.length; i++)
{
if (group!=undefined)
{

        if (group==true && contextSelected[i].type==1)
        {
        contextkeys.push(contextSelected[i].id_key)
        }
        
        if (group==false && contextSelected[i].type==0)
        {
        contextkeys.push(contextSelected[i].id_key)
        }

}
else
{
contextkeys.push(contextSelected[i].id_key)
}

}
return contextkeys.join("|")
	
	}
	
	
/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function selectContext(contextVal)
{
var exist=false;

	for (i=0; i<contextSelected.length; i++)
		{
		if (treeSelected[i].id_context==treeVal){exist=true}
		}
		
		if (exist==false){treeSelected.push(treeVal);
		$("#treeSelected span").text(treeSelected.length);
		}
	if(treeSelected.length>0){$("#treeSelected").fadeIn();}else{$("#treeSelected").fadeOut();}
}

/*
-----------------------------------------------------------------------------------------------------------------------------*/
function bindel(tag){

$(document).bind("keyup",function(e){

if (tag!=undefined){delTag=tag}
//alert(e.keyCode + ' ' + delTag + ' ' + tag)
if 	((e.keyCode==8 || e.keyCode==46) && delTag>0){$("#selectedTagsContainer span").eq(delTag-1).remove();delTag=0;$("#context_title").focus();
$(document).unbind("keyup");
}
})

}
/*
-----------------------------------------------------------------------------------------------------------------------------*/

function bindClick(){
	
	$("#selectedTagsContainer span").click(function(){
		
		$("#selectedTagsContainer span").removeClass("selected")							
		$(this).addClass("selected")							
		var delTag = parseInt($("#selectedTagsContainer span").index(this))+1;
		$(document).unbind("keyup");
	$("#context_title").blur();
	setTimeout("bindel("+ delTag +")",50)
													
													})
	
	}
/*
-----------------------------------------------------------------------------------------------------------------------------*/


function checkBlur(){
	
	if ($("#context_title").val()=="" ){return true;}
	
	if ($(".helpers").length>0){			
								$(".helpers").eq(0).trigger("click");
								$("#context_title").focus();
								return false;
								}
											
											
	if ($("#context_title").val()!="" ){
				cicleTag(jQuery.trim($("#context_title").val().toLowerCase()))													  
				$("#context_title").focus();
				return false;
	}
	
	}

/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function cicleTag(txtsearch)
{									
									if(contextsValues.value==undefined){addTag(0,txtsearch); return; }
									var re = new RegExp("^"+txtsearch+"$");
									found= false;
									for (i=0; i<contextsValues.value.length; i++){
											var myval = contextsValues.value[i].title+'';
											if (myval.toLowerCase().match(re)) {             
												addTag(contextsValues.value[i].id_context,contextsValues.value[i].title.toLowerCase())
												found=true;
												break;
											}
								 
										}
						
										if (found==false){addTag(0,txtsearch);}
	
	}	
/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function clearTags(){
	$("#selectedTagsContainer").html("");
	$("#context_title").focus();
	}
		
/*
-----------------------------------------------------------------------------------------------------------------------------*/		
function checkContext(){

_themes_helper=[];
$("#context_helper").html("");
$('#context_helper_container').hide();
   
if(contextsValues.value==undefined){return}

   
    var re = new RegExp('^'+jQuery.trim($("#context_title").val().toLowerCase()));


        for (i=0; i<contextsValues.value.length; i++){
		
		var myval = contextsValues.value[i].title+'';
                if (myval.toLowerCase().match(re)) {             
                _themes_helper.push(i)
                }
         
        }

        if (_themes_helper.length>0){
        $('#context_helper_container').show();
      
        for (i=0; i<_themes_helper.length; i++){
             
          myval=contextsValues.value[_themes_helper[i]].title+'';     
        $("#context_helper").append("<li><span id='li_"+ contextsValues.value[_themes_helper[i]].id_context +"' rel='"+ contextsValues.value[_themes_helper[i]].id_key +"' class='helpers' ><a href='#' onclick='recoverTagValues("+ i +")'>"+ myval.toLowerCase() + "</a></span></li>")
                      
        
        
        
        }
        
  
   
        }

    

}
/*
-----------------------------------------------------------------------------------------------------------------------------*/
function recoverTagValues(i)
{
addTag($(".helpers").eq(i).attr("rel"),$(".helpers").eq(i).text())

}
/*
-----------------------------------------------------------------------------------------------------------------------------*/
function tagExist(tag){
	
	var exist=false;
	if (tag==0 || currentContextsValues.value==undefined){return exist}
	
	
	for (i=0; i<currentContextsValues.value.length; i++){
	
    if (parseInt(currentContextsValues.value[i].id_context)==parseInt(tag)){exist=true; break;}
    }
	
	return exist
	
	}
/*
-----------------------------------------------------------------------------------------------------------------------------*/
function addTag(tag,text)
{

	var randomKey=randomString('123456789',10)
	var group=''
	if ($(".tagSerialize[value='"+ tag +"_"+ text +"']").length==0 && tagExist(tag)==false){
   	bindClick();
   	if (currentContextType==1){group="groups";}
	$("#selectedTagsContainer").append("<span class='"+ group +" ui-corner-all'><input type='hidden' name='tagsValues' value='" + tag + "_"+ text +"' class='tagSerialize' />" + text +"<a href='#' id='tagC_"+ randomKey +"'  onclick='javascript:removeTag("+ randomKey +");return false;'><img src='/core/core_images/admin/minus.gif' width='7px' heigth='7px'></a></span> " )
	$("#selectedTagsContainer span").unbind("click");
	bindClick();
	
	}
		
   $('#context_helper_container').hide();
   $("#context_title").val("");
   $("#context_title").focus();
   
}

/*
-----------------------------------------------------------------------------------------------------------------------------*/

function removeTag(randomKey)
{  
	$("#tagC_"+randomKey).parent().remove();
	$("#context_title").focus();
	$("#context_helper").html("");
	
}


/*
-----------------------------------------------------------------------------------------------------------------------------*/
function newTags()
{
currentContextType=0;
$("#content_tags").val("");
openLayer("#tagsForm",500,undefined,true,true,true,"New Common Tags");
$("#selectedTagsContainer").html("");
$("#context_title").focus();
}
/*
-----------------------------------------------------------------------------------------------------------------------------*/
function newGroupTags()
{
currentContextType=1;
$("#content_tags").val("");
openLayer("#tagsForm",500,undefined,true,true,true,"New Group Tags");
$("#selectedTagsContainer").html("");
$("#context_title").focus();
}
/*
-----------------------------------------------------------------------------------------------------------------------------*/
function loadContexts(languageId)
	{
	
	
		mydata="who=getContextsAll&idLanguage="+ languageId;
		
		$.ajax({
		   type: "POST",
		   url: engineContext,
		   data: mydata,
		   dataType: "json",
		     success: function(msg){
		
		
		if(msg.values.error!=undefined)
{

 if (msg.values.error[0].errorId==0)
 {
 contextsValues=msg.values;
 getContexts();
 }
 else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
 
}
	   }
		 });

		return false;
		}

/*
-----------------------------------------------------------------------------------------------------------------------------*/

function manageTags(){
		
	
	if ($(".tagSerialize").length==0){alert('Insert almost a Tag!');$("#context_title").focus();return false;}
	
	
	mydata="who=manageTags&contextType="+ currentContextType +"&idContent="+ currentContent +"&idLanguage="+ languageId +"&"+ $(".tagSerialize").serialize();
	
		$.ajax({
		   type: "POST",
		   url: engineContext,
		   data: mydata,
		    dataType: "json",
		       success: function(msg){
		       
		       if(msg.values.error!=undefined)
{

 if (msg.values.error[0].errorId==0)
 {
  
				loadContexts(languageId);
				if (currentContent >0) {getContextsValues(currentContent);}
				closeContext();
				getContexts();
 }
 else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
 
}
		      
		   }
		 });

		return false;
		

	
	
	}
/*
-----------------------------------------------------------------------------------------------------------------------------*/	
	function closeContext()
	{
		    closeLayer('#tagsForm');
			openDialog ('Tag saved');
	     	setTimeout("closeDialog()",2000)
		
		}
/*
-----------------------------------------------------------------------------------------------------------------------------*/	
	
function getContextsValues(id_content)
{
	
	
	currentContent=id_content;
		mydata="who=getContextsValues&idLanguage="+ languageId +"&idContent="+ id_content;
		
		$.ajax({
		   type: "POST",
		   url: engineContext,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
		   
		   if(msg.values.error!=undefined)
{

 if (msg.values.error[0].errorId==0)
 {
  currentContextsValues=msg.values;
		   displayContextsValues()
		   //getTreesRelated(currentContent)
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
-----------------------------------------------------------------------------------------------------------------------------*/
function displayContextsValues()
{
$(".itemsContexts").remove()
	
	
	if (currentContextsValues.value==undefined){return}
		for (i=0; i<currentContextsValues.value.length; i++)
		{
			
		$("#gridTags").append("<li class='itemsContexts' id='tr_context_"+ currentContextsValues.value[i].id_key +"' sequence='"+ i +"'><td valign='top'>"+currentContextsValues.value[i].title+"<a href='#' onclick='remRelated("+ currentContextsValues.value[i].id_key  +","+ currentContent +");return false;' title='Remove relation'><img src='/core/core_images/admin/relation_delete.gif' alt='' border='0'/></a></li>")	
}

}
/*
-----------------------------------------------------------------------------------------------------------------------------*/
function remRelated(idkey,idcontent){
	
	if (confirm('This operation will remove the relation with this Tag. Are you sure?')){
	
	mydata="who=removeContext&idKey="+  idkey + "&idContent="+ idcontent;
		
		$.ajax({
		   type: "POST",
		   url: engineContext,
		   data: mydata,  
		   dataType: "json",
		   
		   success: function(msg){
		  
		  if(msg.values.error!=undefined)
{

 if (msg.values.error[0].errorId==0)
 {$("#tr_context_"+ idkey).remove();
		  getContextsValues(currentContent)
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
-----------------------------------------------------------------------------------------------------------------------------*/
function remAllRelated(idcontext){
	
	if (confirm('This operation will remove the relation with this Tag. Are you sure?')){
	
	mydata="who=removeAllContext&idContent="+ currentContent;
		
		$.ajax({
		   type: "POST",
		   url: engineContext,
		   data: mydata,
		     dataType: "json",
		   success: function(msg){
		  
		  if(msg.values.error!=undefined)
{

 if (msg.values.error[0].errorId==0)
 {
   $(".itemsContexts").remove();
		  getContextsValues(currentContent)
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
-----------------------------------------------------------------------------------------------------------------------------*/
function getContextIndex(idKey){

for (n=0; n<contextsValues.value.length; n++)
{
if(idKey==contextsValues.value[n].id_key){return n}
}


}


	/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function addSelectedContextToSearch(){
var exist=false;
for (i=0; i<contextSelected.length; i++)
{
		exist=false;
		if (contentSearchObj.contexts!=undefined){
		
		    for (z=0; z<contentSearchObj.contexts.length; z++)
		    {
		   		    
    		if (contextSelected[i].id_key==contentSearchObj.contexts[z].id_key){exist=true; break;}
    		
		    }
		}
		
		if (exist==false){contentSearchObj.contexts.push(contextSelected[i]);contentSearchObj.contexts[contentSearchObj.contexts.length-1].status=1;  }
}
	
	printSelectedContextToSearch()
	openDialog ('Filter Added',200,100,2000);	
}

/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function printSelectedContextToSearch(){


    myArr=new Array;
	if (contentSearchObj.contexts!=undefined){
	
	$(".searchContextTr").remove();
	 for (z=0; z<contentSearchObj.contexts.length; z++)
		    {
		  
		    if(contentSearchObj.contexts[z].status==1){myArr.push(contentSearchObj.contexts[z].id_key)}
		    
		    $("#searchContextMenu table").append("<tr class='searchContextTr' id='searchContextTr"+z+"' index='"+z+"'><td colspan='2'><a href='#' onclick='javascript:removeContextSearch("+z+");' style='border:none;'><img src='"+imgPath+"searchRemove.gif' alt=''/></a> <a href='#'  onclick='javascript:changeContextStatusSearch("+z+");'><img src='"+setSearchStatus(contentSearchObj.contexts[z].status)+"' alt='' style='border:none;'/></a> <a href='javascript:mod_context("+contentSearchObj.contexts[z].id_key+",1);'>"+ displayMax(contentSearchObj.contexts[z].title,30) +"</a></td></tr>")
		    }
	$("#searchContextsContents").val(myArr.join("|")) 
	checkSearchValues()
	 
	}

}

/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function removeContextSearch(index){
$("#searchContextTr"+index).remove();
contentSearchObj.contexts.splice(index,1);
printSelectedContextToSearch()
}	

/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function changeContextStatusSearch(index){

if (contentSearchObj.contexts[index].status==0){contentSearchObj.contexts[index].status=1}else{contentSearchObj.contexts[index].status=0};
printSelectedContextToSearch();

}



