




function setUpImageUpload()
{
	if (swfi!=undefined){swfi.destroy();}
	
	
	var settings_default = {
			
			    upload_url: "/core/core_modules/admin/uploadImages.aspx?idContent="+ currentContent,
				file_upload_limit : "1",
				
				file_queue_error_handler : imagefileQueueError,
				file_dialog_complete_handler : imagefileDialogComplete,
				upload_start_handler : imageuploadStartEventHandler,
				upload_progress_handler : imageuploadProgress,
				upload_error_handler : imageuploadError,
				upload_complete_handler : imageuploadComplete,
				file_queued_handler : imagefileQueuedFunction, 
				file_complete_handler : imagefileComplete,
				upload_success_handler : imageupload_success_function, 
				flash_url : "/core/core_js/swfupload.swf",
				debug: false,
				// Button settings
				button_image_url : imgPath+"upload_NoText_160x22.png",	// Relative to the SWF file
				button_placeholder_id : "imageContent",
				button_text_style : '.button { font-family: "Lucida Sans Unicode", "Lucida Sans", verdana, arial, helvetica; font-size: 11px;  color:#555555;  } .buttonSmall { font-size: 10px; color:#555555; }',
				button_width: 160,
				button_height: 22,
				file_size_limit:"20480",
				file_types : "*.jpg;",
				file_types_description : "Images",
				button_window_mode: SWFUpload.WINDOW_MODE.OPAQUE
				
			}; 
		

	settings_default.button_text = '<span class="button">Add Cover <span class="buttonSmall">(jpg 2 MB Max)</span></span>';
		
					
		swfi = new SWFUpload(settings_default); 
		swfi.customSettings.upload_target = "divFileImageProgressContainer";
	
	
	}


function displayCovers()

{
$("#gridCovers li").remove();

for (i=1; i<=contentValue.values.content[0].covers; i++){
$("#gridCovers").append("<li style='float:left;'><img src='/core/core_modules/admin/image.aspx?img="+ coversPath + currentContent + "/" + currentContent + "_" + i + ".jpg&w=70&h=70&refresh="+ uniqueKey() +"' alt='"+ coversPath + currentContent + "/" + currentContent + "_" + i + ".jpg' style='margin:3px' /></li>")
}


}











	
	