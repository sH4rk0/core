isThread=false;
 $(function(){
	  
	var $contentImages =  $(".content-image a");
	if($contentImages.length>0) Code.photoSwipe($(".content-image a"), '.contentDescription');
	
	
	  
	
				
				
	hljs.configure({useBR:true});	
	$('pre code').each(function(i, block) { hljs.highlightBlock(block); });
	  
    });
	
	

