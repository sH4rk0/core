isThread=true;
var $gallery;
 $(function(){
	 
	 /* 
	  $gallery = $(".gallery");
	  
	  if($gallery.length>0){
	 
     $(".gallery").slick({
  dots: false,
  infinite: true,
  speed: 300,
  slidesToShow: 4,
  slidesToScroll: 4,
  adaptiveHeight: true,
  responsive: [
    {
      breakpoint: 1024,
      settings: {
        slidesToShow: 3,
        slidesToScroll: 3,
        infinite: true
	
        
      }
    },
    {
      breakpoint: 600,
      settings: {
        slidesToShow: 2,
        slidesToScroll: 2
      }
    },
    {
      breakpoint: 480,
      settings: {
        slidesToShow: 1,
        slidesToScroll: 1
      }
    }
    
  ]
});

	  
	  
	
	  
	  }*/
	  
	var $contentImages =  $(".content-image a");
	if($contentImages.length>0) Code.photoSwipe($(".content-image a"), '.contentDescription');
	
	var $contentLinks = $(".contentDescription a.linkBtn");
	  
	  
	  if($contentLinks.length>0) {
		  
		  
		  $contentLinks.each(function(index, element) {
			  
			  $(this).bind("click",function(){
            		window.open($(this).attr("href"),$(this).attr("target"));
					event.preventDefault();
					event.stopPropagation();
			
			});
			
			
        });
		  
		  }
	  
	hljs.configure({useBR:true});	
	$('pre code').each(function(i, block) { hljs.highlightBlock(block); });
	  
    });
	
	

