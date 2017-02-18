
// JavaScript Document

isThread=true;
var homeApp={
	
$contentItems:undefined,
$contentItemsFilter:undefined,
$articleLinks:undefined,
$detail:undefined,
$contentTags:undefined,
$boxTag:undefined,
currentTag:".contentItem",
homeDataObj:[],
homeTagObj:[],
$homeDetailTitle:undefined,
$homeDetailContent:undefined,
$homeDetailCovers:undefined,
slickObj:undefined,

init:function(){
	
	$( document ).ajaxStart(function() { homeApp.startLoading();});
	$( document ).ajaxStop(function() { homeApp.stopLoading();});
	
	$contentItemsFilter=$(".contentItems");
	homeApp.$contentItems=$(".contentItems .contentItem");
	$boxTag=$("#box_2");
	$boxTag.hide();
	
	
	homeApp.$contentItems.each(function(i){
		var _obj={};
		_obj.title=$(this).find("h3")[0].innerText;
		_obj.description=$(this).find("p")[0].innerText;
		_obj.img=$(this).find("img")[0].src;
		_obj.link=$(this).find("h3 a")[0].href;
		
		
		homeApp.homeDataObj.push(_obj);
		});
		
	homeApp.$detail=$("#detail");
	homeApp.$articleLinks=$(".contentItems .contentItem h3 a");
	homeApp.$articleLinks.each(function(i){ 
	
			$(this).bind('click',function(event){ 
				event.preventDefault(); 
				event.stopImmediatePropagation();
				homeApp.loadContent($(this).attr("idKey"),$(this).attr("href")); 
				return false;
			});
	
	});
	
	
	$("#box_2 ul").prepend('<li><a class="filter selected" data-filter=".contentItem" href="#">All</a></li>');
	
		
	homeApp.$contentTags=$(".filter");
	homeApp.$contentTags.each(function(i){ 
		var _objTag={};
	    _objTag.title=$(this)[0].innerText;
		_objTag.link=$(this)[0].href;
		homeApp.homeTagObj.push(_objTag);
	
		$(this).bind('click',function(event){ event.preventDefault(); event.stopImmediatePropagation();homeApp.$contentTags.removeClass("selected"); $(this).addClass("selected");
		homeApp.currentTag=$(this)[0].dataset.filter;
		$contentItemsFilter.mixItUp('filter', $(this)[0].dataset.filter  ,function(){}); return false;}); 
	
	});

	$(".contentItems").prepend('<div id="homeDetail" class="mix detail"><div class="detailOptions"><div class="backArticles">Back</div><div class="addthis_sharing_toolbox"></div></div><div id="detailWrapper"><article class="contentDetail"><h2 id="homeDetailTitle"></h2><div id="homeDetailContent" class="contentDescription"></div></article><div id="homeCoversWrapper"><div id="homeDetailCovers" class="slick-slider"></div></div></div><div class="backArticles">Back</div><div class="addthis_sharing_toolbox"></div><div id="disqus_thread"></div></div>');
	
	
		homeApp.$homeDetailTitle=$("#homeDetailTitle");
		homeApp.$homeDetailContent=$("#homeDetailContent");
		homeApp.$homeDetailCovers=$("#homeDetailCovers");
		
		$(".backArticles").click(function(){
			
			window.history.replaceState({},"Home Page","/");
			document.title= "www.zero89.it - Home Page";
			$contentItemsFilter.mixItUp('filter', 'none'  ,function(){   
					$contentItemsFilter.mixItUp('filter', homeApp.currentTag ,function(){$boxTag.fadeIn();});
				});
			
			});
		
		$contentItemsFilter.mixItUp({load:{filter:".contentItem"}});
		$boxTag.fadeIn();
	
	
	},
startLoading:function(){ startLoading();},
stopLoading:function(){ stopLoading(); },

loadContent:function(_idKey,_link){
			closeNavMenu();
			
			if(homeApp.slickObj!=undefined){ console.log("remove"); homeApp.$homeDetailCovers.slick('unslick'); homeApp.$homeDetailCovers.html('');}
			$.ajax({
				  url: "http://www.zero89.it/api/jsonp/desktop/core.aspx",
				  data:{who:"getContent",idContent:_idKey,callback:"z89",jsPath:"/core/core_sites/defaultSite/_js/_it/_zero89/_contents/"},
				  crossDomain:true,
				  dataType:"jsonp",
				  async:true,
				  jsonpCallback: "z89"
				  
				}).success(function(_data){
					
					window.history.replaceState({}, _data.values.content[0].title, _link);
					
					
					$contentItemsFilter.mixItUp('filter', 'none'  ,function(){
						
						$boxTag.fadeOut();
						homeApp.$homeDetailTitle.html(_data.values.content[0].title);
				 		homeApp.$homeDetailContent.html(_data.values.content[0].value);
						
						
						
						setTimeout(function(){$boxTag.fadeOut();$contentItemsFilter.mixItUp('filter', '.detail');
						
						
			/*			setTimeout(function(){
homeApp.slickObj = homeApp.$homeDetailCovers.slick({
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

						if(_data.values.content[0].covers>0){
							
							
							for (var _c=0; _c<_data.values.content[0].covers; _c++){
								homeApp.$homeDetailCovers.slick('slickAdd','<div class="photoswipe"><a href="http://www.zero89.it/public/core_related/'+ _data.values.content[0].id_key +'/'+ _data.values.content[0].id_key +'_'+ (_c+1) +'.jpg"><img src="http://www.zero89.it/covers.aspx?img=/public/core_related/'+ _data.values.content[0].id_key +'/'+ _data.values.content[0].id_key +'_'+ (_c+1) +'.jpg&w=200" style="width:100%;"/></a></div>');
								}
							
							}
							
							
							
						
						},500);*/

var $contentImages =  $(".content-image a");
	if($contentImages.length>0) Code.photoSwipe($(".content-image a"), '#homeDetailContent');
	
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
						},500);
						
						addthis.update('share', 'url', _link);
						addthis.update('share', 'title', _data.values.content[0].title);  
						addthis.toolbox(".addthis_sharing_toolbox");
						document.title= "www.zero89.it - Articles - " + _data.values.content[0].title;
						
						DISQUS.reset({
								  reload: true,
								  config: function () {  
									this.page.identifier = _idKey;
									this.page.title= "www.zero89.it - Articles - " + _data.values.content[0].title;  
									this.page.url = _link;
								  }
								});
					
				  
						});
					
					
				 
					
				  if(_data.values.content[0].js_script)
				  
					 { $.ajax({
								  url: "http://www.zero89.it/core/core_sites/defaultSite/_js/_it/_zero89/_contents/"+ _data.values.content[0].id_key +".js",
								  dataType: "script",
								  success: function( data, textStatus, jqxhr ) {
									  
								
									  }
								});
					 }
				  
				});
	
	}	
	
	
	}
	

//init home
$(function(){ homeApp.init(); });