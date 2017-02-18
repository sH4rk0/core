
var currentIndex;
var currentCoverInfo= new Array();

/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function coverToggle()
{
if($("#relatedCovers").is(":hidden")){$("#relatedCovers").fadeIn();$("#coverSpan").text("-")}else{$("#relatedCovers").fadeOut();$("#coverSpan").text("+")}
}
/*
-----------------------------------------------------------------------------------------------------------------------------*/	

function setUpImageUpload()
{
	if (swfi!=undefined){ $("#coverPlaceholder").html("<div id='imageContent' ></div>");}
	
	
	var settings_default_image = {
			
			    upload_url: "/core/core_modules/admin/uploadImages.aspx?idContent="+ currentContent,
				file_upload_limit : "64",
				
				file_queue_error_handler : imagefileQueueError,
				file_dialog_complete_handler : imagefileDialogComplete,
				upload_start_handler : imageuploadStartEventHandler,
				upload_progress_handler : imageuploadProgress,
				upload_error_handler : imageuploadError,
				upload_complete_handler : imagecoveruploadComplete,
				file_queued_handler : imagefileQueuedFunction, 
				file_complete_handler : imagefileComplete,
				upload_success_handler : imageupload_success_function, 
				flash_url : "/core/core_js/swfupload.swf",
				debug: false,
				// Button settings
				button_image_url : imgPath+"upload_new.png",	// Relative to the SWF file
				button_placeholder_id : "imageContent",
				//button_text_style : '.button { font-family: "Lucida Sans Unicode", "Lucida Sans", verdana, arial, helvetica; font-size: 11px; color:#555555; text-align:center; font-weight:normal;  }',
				button_width: 30,
				button_height: 16,
				file_size_limit:"20480",
				file_types : "*.jpg;",
				file_types_description : "Images",
				button_window_mode: SWFUpload.WINDOW_MODE.OPAQUE//,
				//button_text : '<span class="button" style="text-align:center;">New Covers</span>'
			}; 
			
					
		
		swfi = new SWFUpload(settings_default_image); 
		swfi.customSettings.upload_target = "div";
		
	
	}
/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function displayCovers()

{
currentIndex=0;

$("#gridCovers li").remove();
var defCover='';

for (i=1; i<=contentValue.values.content[0].covers; i++){

if(contentValue.values.content[0].defaultCover==i){defCover="selected"}else{defCover='';}
$("#gridCovers").append("<li style='float:left;position:relative;' class='liCovers' index='"+ i +"'><img src='/core/core_modules/admin/image.aspx?img="+ coversPath + currentContent + "/" + currentContent + "_" + i + ".jpg&w=70&h=70&now="+ uniqueKey() +"' width='70' height='70' class='imgCovers' index='"+ i +"' /><div class='coverOptions'><a href='#' onclick='removeCover("+ i +")' title='Remove Cover'><img src='/core/core_images/admin/delete.gif' border='0'/></a> <a href='#' onclick='coversInfo("+ i +");return false;' title='Cover Info'><img src='/core/CORE_images/admin/informationBig.gif' /></a> <a onclick='coverTools("+ i +");return false;' path='"+ coversPath + currentContent + "/"  + currentContent + "_" + i + ".jpg' href='#' id='coverTool"+ i +"' title='Image Tools'><img src='/core/CORE_images/admin/wrench.png' /></a></div></li>")

}

if(contentValue.values.content[0].covers==0){$("#removeAllCovers").hide()}else{$("#removeAllCovers").show()}

$(".imgCovers").bind("click",function(){
 var myindex=$(this).attr("index");
 $(".imgCovers").removeClass("selected");
 $(this).addClass("selected");
 contentValue.values.content[0].defaultCover=myindex; 
setDefaultCover(myindex);
})


}
/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function coverTools(i){

imageTools($('#coverTool'+i).attr('path'));

}

/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function removeCover(index){
	
	
	if (confirm('Remove this cover?')){
	
	mydata="who=removeCover&coverIndex="+  index +"&idContent="+ currentContent + "&covers=" + contentValue.values.content[0].covers;
		
		$.ajax({
		   type: "POST",
		   url: engineCover,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
		  if(msg.values.error!=undefined)
		     {
				 	if (msg.values.error[0].errorId==0){ 
		                contentValue.values.content[0].covers=msg.values.cover[0].covers
                        contentValue.values.content[0].defaultCover=msg.values.cover[0].defaultCover
		                displayCovers()
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
function setDefaultCover(index){
	
	mydata="who=setDefaultCover&coverIndex="+  index +"&idContent="+ currentContent;
		
		$.ajax({
		   type: "POST",
		   url: engineCover,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
		  if(msg.values.error!=undefined)
		     {
				 	if (msg.values.error[0].errorId==0){ 
		                
 
		                
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
function coversInfo(index){
	currentIndex=index;
	mydata="who=coversInfo&coverIndex="+  index +"&idContent="+ currentContent;
		
		$.ajax({
		   type: "POST",
		   url: engineCover,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
		  if(msg.values.error!=undefined)
		     {
				 	if (msg.values.error[0].errorId==0){ 
		                
                       currentCoverInfo=msg.values.coverInfo
                        displayCoverInfo(currentCoverInfo)
		                
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
function displayCoverInfo(info)

{
$("#coverInfoItems").html("");

if(info!=undefined){

for (i=0; i<info.length; i++){
$("#coverInfoItems").append("<li index='"+ i +"' style='margin-bottom:5px;'><a href='"+ coversPath + currentContent + "/" + info[i].name +"' target='_blank'><img src='/core/CORE_images/admin/zoom.gif' style='vertical-align:middle;margin-right:5px;'></a> <a href='#' onclick='javascript:coverToClipboard("+ i +");'><img src='/core/CORE_images/admin/copy_to_description.gif' alt='' style='vertical-align:middle;margin-right:5px;'/></a> Name: "+ info[i].name +" <strong>Width:</strong> "+ info[i].width +"px <strong>Height:</strong> "+info[i].height+"px <strong>Size:</strong> "+ info[i].size +"bytes</li>")
}
$("#removeCoversBtn").show();
}
else
{
$("#coverInfoItems").append("<li index='"+ i +"'>No Temp Covers</li>");
$("#removeCoversBtn").hide();
}

openLayer("#coversInfo",500,undefined,true,true,true,"Cover Info");
}
/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function coverToClipboard(index){

copyToClipboard("Cover:" + currentCoverInfo[index].name ,"<cover src='" +coversPath + currentContent + "/" + currentCoverInfo[index].name +"'></cover>")

}
	


/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function removeCovers(){
	
	mydata="who=removeCovers&coverIndex="+  currentIndex +"&idContent="+ currentContent;
		
		$.ajax({
		   type: "POST",
		   url: engineCover,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
		  if(msg.values.error!=undefined)
		     {
				 	if (msg.values.error[0].errorId==0){ 
		                
                       closeLayer("#coversInfo");                       		                
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
function removeAllCovers(){
	if (confirm('Remove all Covers?')){
	mydata="who=removeAllCovers&idContent="+ currentContent;
		
		$.ajax({
		   type: "POST",
		   url: engineCover,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
		  if(msg.values.error!=undefined)
		     {
				 	if (msg.values.error[0].errorId==0){ 
		                contentValue.values.content[0].covers=0
                        contentValue.values.content[0].defaultCover=0
		                displayCovers()                		                
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
function removeAllResizedCovers(){
	if (confirm('Remove all resized Covers?')){
	mydata="who=removeAllResizedCovers&idContent="+ currentContent;
		
		$.ajax({
		   type: "POST",
		   url: engineCover,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
		  if(msg.values.error!=undefined)
		     {
				 	if (msg.values.error[0].errorId==0){ 
		                         		                
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

