$(document).ready(function(){


$("#searchContentImg2").mouseover(function(){
	$("#searchRelatedMenu").show().css("z-index","10000000000");

	})

$("#searchContentImg2").mouseout(function(){$("#searchRelatedMenu").hide();})
$("#searchRelatedMenu").mouseover(function(){ $(this).show();})
$("#searchRelatedMenu").mouseout(function(){ $(this).hide();})


})



/*
-----------------------------------------------------------------------------------------------------------------------------*/	

function relatedToggle()
{
if($("#relatedMaterials").is(":hidden")){$("#relatedMaterials").fadeIn();$("#relatedSpan").text("-")}else{$("#relatedMaterials").fadeOut();$("#relatedSpan").text("+")}

}
/*
-----------------------------------------------------------------------------------------------------------------------------*/	


function changeCurrentQueue(){
		swfu.cancelUpload();
		$("#divFileDetails").html("");
		$("#btnBrowse").show();
	}

/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function setUpUpload(mytype)
{
	if (swfu!=undefined){$("#relatedPlaceholder").html("<div id='spanButtonPlaceholder' ></div>"); $("#divFileProgressContainer").text(""); $("#btnBrowse").show()}
	setNewFile=false;
	
	var settings_default = {
			
			    upload_url: "/core/core_modules/admin/upload.aspx?type="+ mytype,
				file_upload_limit : "1",
				
				file_queue_error_handler : fileQueueError,
				file_dialog_complete_handler : fileDialogComplete,
				upload_start_handler : uploadStartEventHandler,
				upload_progress_handler : uploadProgress,
				upload_error_handler : uploadError,
				upload_complete_handler : uploadComplete,
				file_queued_handler : fileQueuedFunction, 
				file_complete_handler : fileComplete,
				upload_success_handler : upload_success_function, 
				flash_url : "/core/core_js/swfupload.swf",
				debug: false,
				// Button settings
				button_image_url : imgPath+"upload_NoText_160x22.png",	// Relative to the SWF file
				button_placeholder_id : "spanButtonPlaceholder",
				button_text_style : '.button { font-family: "Lucida Sans Unicode", "Lucida Sans", verdana, arial, helvetica; font-size: 11px; color:#555555; text-align:center;  } .buttonSmall { font-size: 10px; color:#555555; }',
				button_width: 160,
				button_height: 22,
				file_size_limit:"",
				file_types : "",
				file_types_description : "",
				button_window_mode: SWFUpload.WINDOW_MODE.OPAQUE
				
			}; 
		
			
	switch (mytype) {
	
	case 2:
	settings_default.file_size_limit="20480";
	settings_default.file_types="*.jpg;*.gif;*.bmp;*.png";
	settings_default.file_types_description="Images";
	settings_default.button_text = '<span class="button">Select Image <span class="buttonSmall">(2 MB Max)</span></span>';
	break;
	
	case 3:
	settings_default.file_size_limit="20480";
	settings_default.file_types="*.doc;*.pdf;*.rar;*.zip;*.txt;*.ppt;*.xls;*.rtf";
	settings_default.file_types_description="Documents";
	settings_default.button_text = '<span class="button">Select Document <span class="buttonSmall">(20 MB Max)</span></span>';
	break;
	
	case 4:
	settings_default.file_size_limit="5120";
	settings_default.file_types="*.mp3;*.wav;*.wma";
	settings_default.file_types_description="Audio";
	settings_default.button_text = '<span class="button">Select Audio <span class="buttonSmall">(5 MB Max)</span></span>';
	break;
	
	case 5:
	settings_default.file_size_limit="10240";
	settings_default.file_types="*.flv;*.wmv;*.avi";
	settings_default.file_types_description="Video";
	settings_default.button_text = '<span class="button">Select Video <span class="buttonSmall">( 10 MB Max)</span></span>';
	break;
	
	case 6:
	settings_default.file_size_limit="2048";
	settings_default.file_types="*.swf";
	settings_default.file_types_description="Swf";
	settings_default.button_text = '<span class="button">Select Swf <span class="buttonSmall">(2 MB Max)</span></span>';
	break;
	
	}
				
		swfu = new SWFUpload(settings_default); 
		swfu.customSettings.upload_target = "divFileProgressContainer";
	
	
	}


/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function resetRelated()
{	currentRelated=0;
	switchValue=0;

$("#btnBrowse,#tr_related_type").show();
$(".relatedExtra").hide();
$("#related_type").val(0);
$("#related_title,#related_link,#related_duration,#related_width,#related_height").val("");
$("#related_enabled,#relatedTarget1,#relatedTarget0").attr("checked","");
	
}
	/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function newRelated(from)
{
if (from!=undefined){relatedFromArchive=true;}else{relatedFromArchive=false}
resetRelated()
openLayer("#relatedMaterialsForm",500,undefined,true,true,true,"Realted Material");
		setNewFile=true;

}

/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function modRelated(id_related,from)
{
if (from!=undefined){relatedFromArchive=true;}else{relatedFromArchive=false}

	currentRelated=id_related
	var index=parseInt($("#tr_related_"+id_related).attr("sequence"))
	setRelated(relatedsValues.values.value[index].type);
	relatedValue=relatedsValues.values.value[index];
	openLayer("#relatedMaterialsForm",500,undefined,true,true,true,"Realted Material");
	
	$("#related_title").val(relatedsValues.values.value[index].title);
	$("#related_link").val(relatedsValues.values.value[index].link);
	if (relatedsValues.values.value[index].enabled=="True"){$("#related_enabled").attr("checked","checked");}
	if (relatedsValues.values.value[index].target=="True"){$("#relatedTarget1").attr("checked","checked");}else{$("#relatedTarget0").attr("checked","checked");}
	
	
	if (relatedsValues.values.value[index].size>0){
		 currentFilename=relatedsValues.values.value[index].link;
		 currentFileSize=relatedsValues.values.value[index].size;
		 $("#related_size").val(relatedsValues.values.value[index].size);
		 $("#related_width").val(relatedsValues.values.value[index].width);
		 $("#related_height").val(relatedsValues.values.value[index].height);
		 $("#related_duration").val(relatedsValues.values.value[index].duration);
		 $("#divFileDetails").html('Filename: <strong>'+currentFilename +'</strong> Filesize: <strong>' + currentFileSize +' Kb</strong> - <a href="#" onclick="javascript:removeRelatedFile();return false;">Remove File</a>')
		 $("#btnBrowse").hide();
	}
	
	relatedImageExist();
	
}

/*
-----------------------------------------------------------------------------------------------------------------------------*/
function relatedImageExist()
	{
			$("#tr_related_cover").show();
			
		mydata="who=relatedImageExist&id_site="+ currentKeySite + "&language_id="+ languageId + "&imgPath=/public/core_related/" + currentRelated + "/" + currentRelated + ".jpg"
		
		$.ajax({
		   type: "POST",
		   url: engineRelated,
		   data: mydata,
		   dataType: "json",
		     success: function(msg){
	
	 if(msg.values.error[0].errorId==0){
			   
			   if(msg.values.image[0].exist==true)
			   {
			   $("#relatedImage").attr("src","/covers.aspx?img=/public/core_related/" + currentRelated + "/" + currentRelated + ".jpg&time="+ new Date() );
			   $("#relatedImage").attr("path","/public/core_related/" + currentRelated + "/" + currentRelated + ".jpg")
			   $("#relatedImageOptions").show();
			   $("#relatedImage").parent().addClass("imageCropResize");
			   $("#imageRelatedPlaceholder").html("<div id='relatedImageUpload'></div>");
			   
			   }
			   else
			   {
			   $("#relatedImage").attr("alt","No Image").attr("src","");
			   $("#relatedImage").removeAttr("path");
			   $("#relatedImage").parent().removeClass("imageCropResize");
			   
			   $("#relatedImageOptions").hide();
			   setUpImageRelatedUpload();
			   }
			   
			   }else{
			   
			    if (msg.values.error[0].errorId==666){ displayActionForbidden()}
			   }
			   
			   
	   }
		 });
		return false;
		}
	/*
-----------------------------------------------------------------------------------------------------------------------------*/		
function relatedImageRemove()
	{
			
			if (confirm('Remove this Image??')){
			
			
		mydata="who=relatedImageRemove&id_site="+ currentKeySite +"&idRelated="+ currentRelated + "&language_id="+ languageId + "&imgPath=/public/core_related/" + currentRelated + "/"
		
		$.ajax({
		   type: "POST",
		   url: engineRelated,
		   data: mydata,
		   dataType: "json",
		     success: function(msg){
if(msg.values.error!=undefined)
{
	
	 if(msg.values.error[0].errorId==0){
	 relatedImageExist()
	 
	   openDialog("Related image removed correctly.",200,100,2000);
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
		else{return false;}
		
		
		}	
/*
-----------------------------------------------------------------------------------------------------------------------------*/
function setUpImageRelatedUpload()
{
	if (swfr!=undefined){ $("#imageRelatedPlaceholder").html("<div id='relatedImageUpload' ></div>");}
	
	
	var settings_default_image = {
			
			    upload_url: "/core/core_modules/admin/uploadRelatedImages.aspx?idRelated="+ currentRelated,
				file_upload_limit : "0",
				
				file_queue_error_handler : imagefileQueueError,
				file_dialog_complete_handler : imagefileDialogComplete,
				upload_start_handler : imageuploadStartEventHandler,
				upload_progress_handler : imageuploadProgress,
				upload_error_handler : imageuploadError,
				upload_complete_handler : imageurelatedploadComplete,
				file_queued_handler : imagefileQueuedFunction, 
				file_complete_handler : imagefileComplete,
				upload_success_handler : imageupload_success_function, 
				flash_url : "/core/core_js/swfupload.swf",
				debug: false,
				// Button settings
				button_image_url : imgPath+"upload_NoText_160x22.png",	// Relative to the SWF file
				button_placeholder_id : "relatedImageUpload",
				button_text_style : '.button { font-family: Helvetica, Arial, sans-serif; font-size: 12pt; } .buttonSmall { font-size: 10pt; }',
				button_width: 160,
				button_height: 22,
				file_size_limit:"20480",
				file_types : "*.jpg;",
				file_types_description : "Images",
				button_window_mode: SWFUpload.WINDOW_MODE.OPAQUE,
				button_text : '<span class="button">Add Image <span class="buttonSmall">(jpg 2 MB Max)</span></span>'
			}; 
			
					
		
		swfr = new SWFUpload(settings_default_image); 
		swfr.customSettings.upload_target = "div";
		
	
	}
/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function removeRelatedFile(){
	
	if (confirm('This operation will remove current file from server. Are you sure?')){
		
		mydata="who=removeRelatedFile&idRelated="+ currentRelated;
		
		
		//alert(mydata)
		$.ajax({
		   type: "POST",
		   url: engineRelated,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
			   if(msg.values.error!=undefined)
		     {
				 	 if (msg.values.error[0].errorId==0){
			  
				                    swfu.cancelUpload();
				                    $("#divFileDetails").html("");
				                    $("#btnBrowse").show();
	                                var index=parseInt($("#tr_related_"+currentRelated).attr("sequence"))
	                                relatedsValues.values.value[index].link="";
	                                relatedsValues.values.value[index].size=0;
	                                $("#related_link").val("");
	                                $("#related_size").val("");
		  		  
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
function setRelated(type)
{
	
	if (type!=undefined){switchValue=type;$("#tr_related_type").hide();} else{switchValue=parseInt($("#related_type").val());$("#tr_related_type").show();}
	 $("#divFileDetails").html("");
	
	
	
	switch (switchValue) {
	
	case 0:
	$(".relatedExtra").hide()
	break;
	
	case 1: //url
	$(".relatedExtra").hide()
	$("#tr_related_link,#tr_related_target,#tr_related_enabled").show()
	break;
		
	case 2://Image: gif, jpg, bmp
	$(".relatedExtra").hide()
	$("#tr_related_file,#tr_related_target,#tr_related_enabled").show()
	setUpUpload(switchValue);
	break;
	
	case 3://Document: doc, pdf, rar, zip, txt, ppt, xls, mpeg, rtf
	$(".relatedExtra").hide()
	$("#tr_related_file,#tr_related_target,#tr_related_enabled").show()
	setUpUpload(switchValue);
	break;
	
	case 4://Audio: mp3, wav, wma
	$(".relatedExtra").hide()
	$("#tr_related_file,#tr_related_target,#tr_related_enabled").show()
	setUpUpload(switchValue);
	break;
	
	case 5://Video: flv, wmv
	$(".relatedExtra").hide()
	$("#tr_related_file,#tr_related_target,#tr_related_size,#tr_related_duration,#tr_related_enabled").show()
	setUpUpload(switchValue);
	break;
	
	case 6://Flash: swf
	$(".relatedExtra").hide()
	$("#tr_related_file,#tr_related_target,#tr_related_size,#tr_related_enabled").show()
	setUpUpload(switchValue);
	break;
	
	}
	
	}

/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function removeAllRelated(){
if (confirm('This operation will remove only the relations. Are you sure?')){
mydata="who=removeAllRelated&idContent="+ currentContent;
		
		$.ajax({
		   type: "POST",
		   url: engineRelated,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
		     if(msg.values.error!=undefined)
		     {
				 	 if (msg.values.error[0].errorId==0){
		 getRelatedValues(currentContent)
						}
						 else
		            {
		            if (msg.values.error[0].errorId==666){ displayActionForbidden()}
		            }
			 }
		   
		  		  
		   }
		 });
		 }else{return false;}


}
	
/*
-----------------------------------------------------------------------------------------------------------------------------*/		
function getRelatedValues(id_content)
{
	
	
	currentContent=id_content;
		mydata="who=getRelatedValues&idContent="+ id_content;
		
		$.ajax({
		   type: "POST",
		   url: engineRelated,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
		     if(msg.values.error!=undefined)
		     {
				 	 if (msg.values.error[0].errorId==0){
		   relatedsValues=msg
		   displayRelatedValues()
		   //getContextsValues(currentContent)
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
function displayRelatedValues()
{
$(".itemsRelated").remove()
	
	if(relatedsValues.values.value!=undefined){
	
	
		for (i=0; i<relatedsValues.values.value.length; i++)
		{
			
			selected =	isRelatedSelected(i,relatedsValues.values.value[i].id_related);
			
		$("#gridRelated").append("<tr class='itemsRelated' id='tr_related_"+ relatedsValues.values.value[i].id_related +"' sequence='"+ i +"'><td valign='top' style='width:20px'>"+  selected +"</td><td valign='top'  style='width:20px'><a href='#' onclick='javascript:preview("+ relatedsValues.values.value[i].id_related  +");' ><img src='/core/core_images/admin/related/"+ relatedsValues.values.value[i].type +".gif' alt='' border='0'/></a></td><td valign='top'><a href='#' onclick='modRelated("+ relatedsValues.values.value[i].id_related  +");return false;' title='"+ relatedsValues.values.value[i].title +"'> "+ displayMax(relatedsValues.values.value[i].title,30) +"</a></td><td valign='top'  style='width:20px'><a href='#' onclick='remRelatedMaterial("+ relatedsValues.values.value[i].id_related  +");return false;' title='Remove relation'><img src='"+imgPath+"relation_delete.gif' alt='' border='0'/></a></td><td valign='top'  style='width:20px'><a href='#' onclick='delRelatedMaterial("+ relatedsValues.values.value[i].id_related  +");return false;' title='Delete material'><img src='"+imgPath+"delete.gif' alt='' border='0'/></a></td></tr>")	
			
			}
			$("#removeAllRelated").show();
			
			}else{
			$("#removeAllRelated").hide();
			}

}
/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function selectRelated(x)
{

var newSel=relatedsValues.values.value[x].id_related

var exist=false;

	for (i=0; i<relatedSelected.length; i++)
		{
		if (relatedSelected[i].id_related==newSel){exist=true}
		}
		
		if (exist==false){relatedSelected.push(relatedsValues.values.value[x]);$("#relatedSelected span").text(relatedSelected.length);}
		

	if(relatedSelected.length>0){$("#relatedSelected").fadeIn();}else{$("#relatedSelected").fadeOut();}

}



/*
-----------------------------------------------------------------------------------------------------------------------------*/	


function selectedRelatedsSerialize()
	
	{
	
var relatedkeys = new Array()
for (i=0; i<relatedSelected.length; i++)
{
relatedkeys[i]=relatedSelected[i].id_related
}

return relatedkeys.join("|")
	
	}
	
/*
-----------------------------------------------------------------------------------------------------------------------------*/		

function addRelatedToContents (){

if(contentSelected.length==0 || relatedSelected.length==0){alert("No contents or related selected!");return false;}

mydata="who=addRelations&relatedKeys="+ selectedRelatedsSerialize() +"&contentKeys="+ selectedContentsSerialize();
		
					
					
		$.ajax({
		   type: "POST",
		   url: engineRelated,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
		         if(msg.values.error!=undefined)
		         {
		          if (msg.values.error[0].errorId==0){
    				    closeLayer("#relatedSelectedMenu");
		                openDialog ('Relations added',200,100,2000);	
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
function removeRelatedSelected(){
relatedSelected=[];
$(".relatedChecked").each(function(){

$(this).removeClass("relatedChecked").attr("src",imgPath+"checkedOff.gif")

})

$("#relatedSelected").fadeOut();



}
/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function preview(id_related)
{
	
	var index=parseInt($("#tr_related_"+id_related).attr("sequence"));
	var mylink=relatedsValues.values.value[index].link;
	var mytype=relatedsValues.values.value[index].type;
	
	openLayer("#relatedPreview",500,500,false,true,true,"Related Preview");
	if (mytype>1){mylink='/public/core_related/'+ id_related+"/"+ mylink}
	
	
	$("#relatedPreview iframe").attr("src",mylink);
	
	}

/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function remRelatedMaterial(idrelated){
	
	if (confirm('This operation will remove only the relation with current content. Are you sure?')){
	
	mydata="who=removeRelated&idRelated="+  idrelated +"&idContent="+ currentContent;
		
		$.ajax({
		   type: "POST",
		   url: engineRelated,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
		  if(msg.values.error!=undefined)
		     {
				 	 if (msg.values.error[0].errorId==0){ 
		  $("#tr_related_"+ idrelated).remove();
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
function checkRelatedOptions()
{

if (relatedSelected.length>0){
$("#relatedOptionDelete").removeClass("option-disabled")

}else
{
$("#relatedOptionDelete").addClass("option-disabled")
}

if (relatedSelected.length>0 && contentSelected.length>0){$("#relatedOptionAdd").removeClass("option-disabled")}else{$("#relatedOptionAdd").addClass("option-disabled")}

}	
/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function deleteRelatedsSelected()
{

if (relatedSelected.length==0){return false;}

		if(confirm('Delete materials??')){
		
		mydata="who=deleteRelateds&relateds="+ selectedRelatedsSerialize();
	
				
		$.ajax({
		   type: "POST",
		   url: engineRelated,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
		    if(msg.values.error!=undefined)
		     {
		   
		    if (msg.values.error[0].errorId==0){
		 		  		closeLayer('#relatedSelectedMenu');  
		 		  		openDialog ('Related Materials removed',200,100,2000);
		 		  		removeRelatedSelected()
		 		  		getRelateds(1,currentRelatedOrder)
		 		  		}
		            else
		            {
		            if (msg.values.error[0].errorId==666){ displayActionForbidden()}
		            }
		 		  		
		 		  		
		 		 }
		 		  		
		   }
		 });}
		 
		 else{return false;}
}
/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function delRelatedMaterial(idrelated){
	
if (relatedSelected.length==0){return false;}
	
	if (confirm('This operation will DELETE selected Material. Are you sure?')){
	
	mydata="who=deleteRelated&idRelated="+ idrelated 
		
		$.ajax({
		   type: "POST",
		   url: engineRelated,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
		   if(msg.values.error!=undefined)
		     {
				 	 if (msg.values.error[0].errorId==0){
		  $("#tr_related_"+ idrelated).remove();
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

function manageRelated(){
	
	
	if($("#related_title").val()==""){alert('Title field must be filled!');$("#related_title").focus();return false;}
	
	if (currentRelated==0){
		if($("#related_type").val()=="0"){alert('Select File Tipology');$("#related_type").focus();return false;}
		}
	
	
	switch (switchValue) {
	
	case 1:
	
	
	if($("#related_link").val()==""){alert('Link field must be filled!');$("#related_link").focus();return false;}
	break;
	
	case 2:
	break;
	
	case 3:
	break;
	
	case 4:
	break;
	
	case 5:
	break;
	
	case 6:
	break;
	}
	
	$(".relatedButtons").hide()
	
	mydata="who=manageRelated&idSite="+ currentKeySite +"&idLanguage="+ languageId +"&idUser="+ id_user +"&idContent="+ currentContent + "&idRelated="+ currentRelated + "&" + $(".relatedserialize").serialize();
					
		$.ajax({
		   type: "POST",
		   url: engineRelated,
		   data: mydata,
		   dataType: "json",
		   success: function(msg)
		   {
			
	              if(msg.values.error[0].errorId!=0)
	              {
            	         if (msg.values.error[0].errorId==666){ displayActionForbidden()}
            	  }
	              else
	              {
            		
		                        if (parseInt(msg.values.related[0].id)>0){currentRelated=msg.values.related[0].id}
            			
		                        if (switchValue>=2)
		                        {
			                                if (setNewFile==true)
			                                {
			                               
					                            swfu.addPostParam("relatedId", currentRelated);
			                                    swfu.startUpload();
			                                }
			                                else
			                                {
			                                    if (relatedFromArchive==false){getRelatedValues(currentContent);}else{getRelated(currentRelated)}
			                                    updateRelatedSelectedList(currentRelated,$("#related_title").val())
			                                    
			                                    closeRelated()
			                                    $(".relatedButtons").show()
					                        }
			                    }
		                        else
		                        {
                    			    if (relatedFromArchive==false){getRelatedValues(currentContent);}else{ 
                    			    
                    			   
                    			    if (setNewFile==true){getRelateds(1,currentRelatedOrder);}else{getRelated(currentRelated)}
                    			    
                    			    }
                    			     closeRelated()
			                        $(".relatedButtons").show()
                    			}
		            }
		  
		   }
		 });
		
	}
	
/*
-----------------------------------------------------------------------------------------------------------------------------*/		
function updateRelatedSelectedList(id,title)
{
	for (i=0; i<relatedSelected.length; i++)
		{
	        if (relatedSelected[i].id_related==id){relatedSelected[i].title=title;displaySelectedRelated(); break;}
		}
	
}
/*
-----------------------------------------------------------------------------------------------------------------------------*/		
function closeRelated()
	{
		    closeLayer('#relatedMaterialsForm');
			openDialog ('Material Data Saved',200,100,2000);	 
	}
	
/*
-----------------------------------------------------------------------------------------------------------------------------*/		
	function getRelated(id_related)
{
			mydata="who=getRelated&idRelated="+ id_related ;
		
		$.ajax({
		   type: "POST",
		   url: engineRelated,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
		   
		   relatedValue=msg;
		 
				
				if(msg.values.error!=undefined)
		     {
 if (msg.values.error[0].errorId==0)
 {
   updateRelatedArchive(currentRelated,parseInt($("#tr_related_"+id_related).attr("sequence")))
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
function updateRelatedArchive(id_key,sequence){
	$(".postItems").removeClass("selected")
	$("#tr_related_"+id_key).addClass("selected")
	
	var selected =	isRelatedSelected(sequence,id_key);
			
		$("#tr_related_"+id_key).html("<td valign='top'>"+  selected +"</td><td valign='top'>"+relatedValue.values.value[0].id_related+"</td><td valign='top'>"+ isRelatedEnabled(sequence)+"</td><td valign='top'>"+relatedValue.values.value[0].date+"</td><td valign='top'><a href='javascript:modRelated("+relatedValue.values.value[0].id_related+",1);'>"+relatedValue.values.value[0].title+"</a></td>")	
	
	relatedsValues.values.value[sequence]=relatedValue.values.value[0]
	
	displaySelectedRelated()
	}



/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function displaySelectedRelated(){

$("#relatedSelectedList").html("");
var _class=""
for (i=0; i<relatedSelected.length; i++)
		{
		_class=""
		if(i==0){_class="first-nav-item"}
		//if(i+1==relatedSelected.length){_class="last-nav-item"}
		$("#relatedSelectedList").append("<li class='"+_class+"'><a href='javascript:modRelated("+relatedSelected[i].id_related+",1)' title='"+relatedSelected[i].title+"'>"+ displayMax(relatedSelected[i].title,20) +"</a></li>")
	
		}
		
	$("#relatedSelectedList").append("<li class='last-nav-item'><a href='javascript:addSelectedRelatedToSearch();' title='Add Selected to content search'><strong>Add to content search</strong></a></li>")	
		
		
	}
/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function addSelectedRelatedToSearch(){
var exist=false;
for (i=0; i<relatedSelected.length; i++)
{
		exist=false;
		if (contentSearchObj.relateds!=undefined){
		
		    for (z=0; z<contentSearchObj.relateds.length; z++)
		    {
		   		    
    		if (relatedSelected[i].id_related==contentSearchObj.relateds[z].id_related){exist=true; break;}
    		
		    }
		}
		
		if (exist==false){contentSearchObj.relateds.push(relatedSelected[i]);contentSearchObj.relateds[contentSearchObj.relateds.length-1].status=1;  }
}
	
	printSelectedRelatedToSearch()
	openDialog ('Filter Added',200,100,2000);	
}

/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function printSelectedRelatedToSearch(){
    myArr=new Array;
	if (contentSearchObj.relateds!=undefined){
	$(".searchRelatedTr").remove();
	 for (z=0; z<contentSearchObj.relateds.length; z++)
		    {
		    if(contentSearchObj.relateds[z].status==1){myArr.push(contentSearchObj.relateds[z].id_related)}
		    
		    $("#searchRelatedMenu table").append("<tr class='searchRelatedTr' id='searchRelatedTr"+z+"' index='"+z+"'><td colspan='2'><a href='#' onclick='javascript:removeRelatedSearch("+z+");' style='border:none;'><img src='"+imgPath+"searchRemove.gif' alt=''/></a> <a href='#'  onclick='javascript:changeRelatedStatusSearch("+z+");'><img src='"+setSearchStatus(contentSearchObj.relateds[z].status)+"' alt='' style='border:none;'/></a> <a href='javascript:modRelated("+contentSearchObj.relateds[z].id_related+",1);'>"+ displayMax(contentSearchObj.relateds[z].title,30) +"</a></td></tr>")
		    }
	$("#searchRelatedsContents").val(myArr.join("|")) 
	checkSearchValues()
	 
	}

}

/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function removeRelatedSearch(index){
$("#searchRelatedTr"+index).remove();
contentSearchObj.relateds.splice(index,1);
printSelectedRelatedToSearch()
}	

/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function changeRelatedStatusSearch(index){

if (contentSearchObj.relateds[index].status==0){contentSearchObj.relateds[index].status=1}else{contentSearchObj.relateds[index].status=0};
printSelectedRelatedToSearch();

}