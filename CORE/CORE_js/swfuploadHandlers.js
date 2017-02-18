


function fileQueuedFunction(fileObj)
{
		try {
		
		 currentFilename=fileObj.name;
		 currentFileSize=fileObj.size;
		 $("#related_size").val(fileObj.size);
		 $("#divFileDetails").html('Filename: <strong>'+fileObj.name +'</strong> Filesize: <strong>' + parseInt(fileObj.size/1024) +' Kb</strong> - <a href="#" onclick="javascript:changeCurrentQueue();return false;">Remove File</a>')
		 $("#btnBrowse").hide();
		 
				 
	} catch (ex) {
		this.debug(ex);
	}
	
}

function uploadStartEventHandler(fileObj)
{
		try {
		//$("#progressBar").show()
				//alert('uploadStartEventHandler')
				$("#ajaxOverlay,#ajaxUpLoading").show();
	} catch (ex) {
		this.debug(ex);
	}
	
	}

function fileQueueError(fileObj, error_code, message) {
	try {
		var error_name = "";
		
		if (error_name !== "") {
			alert('errorName:' + error_name );
			return;
		}
		
		switch(error_code) {
			case SWFUpload.ERROR_CODE_QUEUE_LIMIT_EXCEEDED:
				alert('ERROR_CODE_QUEUE_LIMIT_EXCEEDED:' + message + ' - ' + error_code);
			break;
		
			case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
				alert('ZERO_BYTE_FILE:' + message + ' - ' + error_code);
			break;
			
			case SWFUpload.QUEUE_ERROR.FILE_EXCEEDS_SIZE_LIMIT:
				alert('FILE_EXCEEDS_SIZE_LIMIT:' + message + ' - ' + error_code);
			break;
			
			case SWFUpload.QUEUE_ERROR.INVALID_FILETYPE:
				alert('INVALID_FILETYPE:' + message + ' - ' + error_code);
			break;
			
			default:
				alert('Else:' + message + ' - ' + error_code);
				
			break;
		}

	
	} catch (ex) { this.debug(ex); }

}

function fileDialogComplete(num_files_queued) {
	try {
		
		setNewFile=true;
		/*if (num_files_queued > 0) {
			this.startUpload();
		}*/
		//alert('fileDialogComplete')
		
		
	} catch (ex) {
		this.debug(ex);
	}
}

function uploadProgress(fileObj, bytesLoaded) {

	try {
		
		var percent = Math.ceil((bytesLoaded / fileObj.size) * 100)
		$("#ajaxUpLoadingProgress").css("width",percent +'%')

		
		
	} catch (ex) { this.debug(ex); }
}



function upload_success_function(fileObj, server_data) {
	try {
	$("#ajaxOverlay,#ajaxUpLoading").hide();
	
	console.log(fileObj,server_data)
	
	if (relatedFromArchive==false){getRelatedValues(currentContent);}else{getRelateds(1,currentRelatedOrder);}
		
		$(".relatedButtons").show();
		closeRelated();
		
		
	} catch (ex) { this.debug(ex); }
}



function uploadComplete(fileObj) {
	try {
		
		//alert('uploadComplete')
				
	} catch (ex) { this.debug(ex); }
}




function fileComplete(fileObj) {
	try {
		/*  I want the next upload to continue automatically so I'll call startUpload here */
		if (this.getStats().files_queued > 0) {
			this.startUpload();
		} else {
			
					
		}
	} catch (ex) { this.debug(ex); }
}




function uploadError(fileObj, error_code, message) {
	try {
		switch(error_code) {
			case SWFUpload.UPLOAD_ERROR.FILE_CANCELLED:
				try {alert(message +'-'+ error_code);} catch (ex) { this.debug(ex); }
			break;
			
			case SWFUpload.UPLOAD_ERROR.UPLOAD_STOPPED:
				try {alert(message +'-'+ error_code);} catch (ex) { this.debug(ex); }
			break;
			
			case SWFUpload.UPLOAD_ERROR.UPLOAD_LIMIT_EXCEEDED:
				try {alert(message +'-'+ error_code);} catch (ex) { this.debug(ex); }
			break;
			
			default:
			    try {alert(message +'-'+ error_code);} catch (ex) { this.debug(ex); }
			break;
		}

	} catch (ex) { this.debug(ex); }

}
