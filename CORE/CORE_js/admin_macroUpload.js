



function setUpMacroUpload(mytype)
{


	if (swfi!=undefined){ $("#macroImagePlaceholder").html("<div id='macroImageContent' ></div>");}
	
	var settings_default = {
			
			    upload_url: "/core/core_modules/admin/uploadMacro.aspx?type="+ mytype +"&idContent="+currentContent+"&idSite="+ currentKeySite +"&idLanguage="+ languageId +"&idUser="+ id_user ,
				file_upload_limit : "100",
				file_queue_error_handler : macrofileQueueError,
				file_dialog_complete_handler : macrofileDialogComplete,
				upload_start_handler : macrouploadStartEventHandler,
				upload_progress_handler : macrouploadProgress,
				upload_error_handler : macrouploadError,
				upload_complete_handler : macrouploadComplete,
				file_queued_handler : macrofileQueuedFunction, 
				file_complete_handler : macrofileComplete,
				upload_success_handler : macroupload_success_function, 
				flash_url : "/core/core_js/swfupload.swf",
				debug: false,
				// Button settings
				button_image_url : imgPath+"upload_multiple.png",	// Relative to the SWF file
				button_placeholder_id : "macroImageContent",
				//button_text_style : '.button { font-family: "Lucida Sans Unicode", "Lucida Sans", verdana, arial, helvetica; font-size: 11px; text-align:center; color:#555555;}',
				button_width: 123,
				button_height: 16,
				file_size_limit:"",
				file_types : "",
				file_types_description : "",
				button_window_mode: SWFUpload.WINDOW_MODE.OPAQUE
				
			}; 
		
	
	settings_default.file_size_limit="30720";
	settings_default.file_types="*.jpg;*.gif;*.bmp;*.png";
	settings_default.file_types_description="Images";
	//settings_default.button_text = '<span class="button">Add Multiple Images</span>';
					
		swfu = new SWFUpload(settings_default); 
		swfu.customSettings.upload_target = "div";
	
	
	}









	
	