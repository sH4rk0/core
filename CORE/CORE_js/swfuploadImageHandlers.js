


function imagefileQueuedFunction(fileObj)
{
		try {
				 		 
				 
	} catch (ex) {
		this.debug(ex);
	}
	
}

function imageuploadStartEventHandler(fileObj)
{
		try {
		
		 $("#ajaxOverlay,#ajaxUpLoading").show();
	
	} catch (ex) {
		this.debug(ex);
	}
	
	}

function imagefileQueueError(fileObj, error_code, message) {
	try {
		var error_name = "";
		
		if (error_name !== "") {
			alert('errorName:' + error_name );
			return;
		}
		
		switch(error_code) {
			case SWFUpload.ERROR_CODE_QUEUE_LIMIT_EXCEEDED:
				alert('ERROR_CODE_QUEUE_LIMIT_EXCEEDED:' +message);
			break;
		
			case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
				alert('ZERO_BYTE_FILE:' +message);
			break;
			
			case SWFUpload.QUEUE_ERROR.FILE_EXCEEDS_SIZE_LIMIT:
				alert('FILE_EXCEEDS_SIZE_LIMIT:' +message);
			break;
			
			case SWFUpload.QUEUE_ERROR.INVALID_FILETYPE:
				alert('INVALID_FILETYPE:' +message);
			break;
			
			default:
				alert('Default:' +message);
				
			break;
		}

	
	} catch (ex) { this.debug(ex); }

}

function imagefileDialogComplete(num_files_queued) {
	try {
		
		
			this.startUpload();
				
		
	} catch (ex) {
		this.debug(ex);
	}
}

function imageuploadProgress(fileObj, bytesLoaded) {

	try {
				
		var percent = Math.ceil((bytesLoaded / fileObj.size) * 100)
		$("#ajaxUpLoadingProgress").css("width",percent +'%')
		
		
	} catch (ex) { this.debug(ex); }
}



function imageupload_success_function(fileObj, server_data) {
	try {
	
			
		
	} catch (ex) { this.debug(ex); }
}



function imageuploadComplete(fileObj) {
	try {
					
	} catch (ex) { this.debug(ex); }
}



function imagecoveruploadComplete(fileObj) {
	try {
	contentValue.values.content[0].covers++;
	if (this.getStats().files_queued > 0) {
	        
			this.startUpload();
		} else {
			
		 $("#ajaxOverlay,#ajaxUpLoading").hide();
		 displayCovers()			
		}
	
				
	} catch (ex) { this.debug(ex); }
}



function imageutreeploadComplete(fileObj) {
	try {
		 $("#ajaxOverlay,#ajaxUpLoading").hide();
				treeImageExist()
	} catch (ex) { this.debug(ex); }
}


function imageurelatedploadComplete(fileObj) {
	try {
		 $("#ajaxOverlay,#ajaxUpLoading").hide();
				relatedImageExist()
	} catch (ex) { this.debug(ex); }
}




function imagefileComplete(fileObj) {
	try {
		/*  I want the next upload to continue automatically so I'll call startUpload here */
		/*if (this.getStats().files_queued > 0) {
			this.startUpload();
		} else {
			
					
		}*/
	} catch (ex) { this.debug(ex); }
}




function imageuploadError(fileObj, error_code, message) {
	try {
		switch(error_code) {
			case SWFUpload.UPLOAD_ERROR.FILE_CANCELLED:
				try {
					
				}
				catch (ex) { this.debug(ex); }
			    break;
			case SWFUpload.UPLOAD_ERROR.UPLOAD_STOPPED:
				try {
					
				}
				catch (ex) { this.debug(ex); }
				break;
			case SWFUpload.UPLOAD_ERROR.UPLOAD_LIMIT_EXCEEDED:
				try {
					
				}
				catch (ex) { this.debug(ex); }
			    break;
			default:
				try {
					
				}
				catch (ex) { this.debug(ex); }
			    break;
		}

	} catch (ex) { this.debug(ex); }

}
