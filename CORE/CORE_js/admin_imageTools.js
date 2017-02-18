$(document).ready(function () {

	
/* @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ */
	
		
getBoxList()



		
/* @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ */

	
	}
);

/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function imageInfo(path,callback)
{

mydata="who=imageInfo&imagePath="+ path;
$.ajax({

		   type: "POST",
		   url: engineImage,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
		 
		 if(msg.values.error!=undefined)
		     {
		     
		         if (msg.values.error[0].errorId==0){
		         toolImageInfo=msg.values;
		         
		          $("#infoName").text(msg.values.imageInfo[0].name);
		         $("#infoPath").text(msg.values.imageInfo[0].path);
		         $("#infoWidth").text(msg.values.imageInfo[0].width);
		         $("#infoHeight").text(msg.values.imageInfo[0].height);
		         $("#infoSize").text(msg.values.imageInfo[0].size);
		         openLayer("#imageTools",toolImageInfo.imageInfo[0].width+30, toolImageInfo.imageInfo[0].height+30,false,true,true,"Current Image")
	             if(callback!=undefined){eval(callback);}
	
		         }
		         
		         }
		         
		         
		   }
		 });

}

/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function setupTools()
{
    
	$("#imageToolsSource").attr("src",toolImagePath + "?refresh="+ uniqueKey() );
	openLayer("#toolForm",350,200,false,true,false,"Image Tools")
}

/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function imageTools(path,refresh)
{
toolImageElement="#imageToolsSource";
toolImageRefresh=refresh;
toolImagePath=path;
removeCrop()
imageInfo(path,"setupTools()")


}

/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function switchTool(index){

switch (index){

 case 0:
 removeCrop()
 break;
 case 1:
 removeCrop()
  jQuery('#cropX').val(0);
				jQuery('#cropY').val(0);
				jQuery('#cropX2').val(0);
				jQuery('#cropY2').val(0);
				jQuery('#cropW').val(0);
				jQuery('#cropH').val(0);
	
	
	jQuery('#imageToolsSource').val(toolImagePath);
	jcrop_api=[];
	jcrop_api = $.Jcrop(toolImageElement)
    jQuery(toolImageElement).Jcrop({onChange: showCoords,onSelect: showCoords});
 break;
 case 2:
  removeCrop()
 break;
}


}

	
	
/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function showCoords(c)
			{
				jQuery('#cropX').val(c.x);
				jQuery('#cropY').val(c.y);
				jQuery('#cropX2').val(c.x2);
				jQuery('#cropY2').val(c.y2);
				jQuery('#cropW').val(c.w);
				jQuery('#cropH').val(c.h);
			};
			
/*
-----------------------------------------------------------------------------------------------------------------------------*/			
function crop()
{
	
	if (confirm('Crop the Image. Are you sure?')){
	
	$("#imageToolsSource").attr("src",imgPath +'loading_circle.gif');
    openLayer("#imageTools",32, 32);
    
	mydata="who=cropImage&imagePath="+ toolImagePath + "&" +$(".cropSerialize").serialize();
		
		$.ajax({
		   type: "POST",
		   url: engineImage,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
		 
		 removeCrop()
		 
		 $("#imageTools").fadeOut(function(){
		 var newPath=toolImagePath + "?refresh="+ uniqueKey()
		 $("#imageToolsSource").attr("src",newPath);
		  if (toolImageRefresh!=undefined){$('#'+toolImageRefresh).attr("src",newPath)}
			 
			 imageInfo(toolImagePath)
			}); 
			 
		   }
		 });
		
	}
}
/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function resize()
{
	
	if (confirm('Resize the Image. Are you sure?')){
	
	$("#imageToolsSource").attr("src",imgPath +'loading_circle.gif');
    openLayer("#imageTools",32, 32);
	
	mydata="who=resizeImage&imagePath="+ toolImagePath + "&" + $(".resizeSerialize").serialize();
		
		$.ajax({
		   type: "POST",
		   url: engineImage,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
	$("#imageTools").fadeOut(function(){
	
	 var newPath=toolImagePath + "?refresh="+ uniqueKey()
		 $("#imageToolsSource").attr("src",newPath);
		  if (toolImageRefresh!=undefined){$('#'+toolImageRefresh).attr("src",newPath)}
		imageInfo(toolImagePath)
	})
		
			 
			 
		   }
		 });
		
	}
}		
/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function removeCrop()
{
if (jcrop_api != undefined){jcrop_api.destroy()}
}

