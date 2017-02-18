
var $treeSite, $body, $parallax, $parallaxContainer, $tagTitle, $tagContent;
var isThread=false;

$(function(){
	
$(window).bind('viewportready viewportchange', function() {
			//alert(viewporter.isLandscape())
			//$('#orientationlock').toggle(!viewporter.isLandscape());
		});	
	
$body=$("body");

$tagTitle=$("#box_2 .box-title");
$tagContent=$("#box_2 .box-content");

$tagTitle.click(function(){ $tagTitle.hide(); $tagContent.fadeIn(); });

$parallaxContainer=$("#parallaxcontainer");
	
enquire.register("screen and (max-width: 479px)", {
	setup : function() {
		
		$tagTitle.show();
		$tagContent.hide();
		
	},

	match : function() {
		$tagTitle.show();
		$tagContent.hide();
	},

	unmatch : function() {
		closeNavMenu();
	},
	deferSetup : true
})

enquire.register("screen and (min-width: 480px) and (max-width: 767px)", {
	setup : function() {
		$tagTitle.show();
		$tagContent.hide();
	},

	match : function() {
		$tagTitle.show();
		$tagContent.hide();
	},

	unmatch : function() {
		closeNavMenu();
	},
	deferSetup : true
})

enquire.register("screen and (min-width: 768px)  and (max-width: 1023px)", {
	setup : function() {
		$tagTitle.hide();
		$tagContent.show();
	},

	match : function() {
		$tagTitle.hide();
		$tagContent.show();
	},

	unmatch : function() {
		closeNavMenu();
	},
	deferSetup : true
})
enquire.register("screen and (min-width: 1024px)  and (max-width: 1199px)", {
	setup : function() {
		$tagTitle.hide();
		$tagContent.show();
	},

	match : function() {
		$tagTitle.hide();
		$tagContent.show();
	},

	unmatch : function() {
		closeNavMenu();
	},
	deferSetup : true
})

enquire.register("screen and (min-width: 1200px)", {
	setup : function() {
		$tagTitle.hide();
		$tagContent.show();
	},

	match : function() {
		$tagTitle.hide();
		$tagContent.show();
	},

	unmatch : function() {
		closeNavMenu();
	},
	deferSetup : true
})


$parallaxContainer.hide();
setupNavMenu();

$(".coverImage").one("load", function() {
 
  $(this)[0].closePixelate([{ resolution : 10 },{ shape : 'square', resolution : 10, alpha: 1 }]);
  
}).each(function(i) {
	
  $(this)[0].id="cover"+i;
  if(this.complete) $(this).load();
});

var headerMin = new Headhesive('.headerMin', {offset: 150});

$(".menuBtn").click(function(){ openNavMenu(); });
$(".goTop").click(function(){   $('html, body').animate({ scrollTop: 0}, 800); });

});


function setupNavMenu(){
	
	$treeSite=$("#treeSite");
	
	$($treeSite).on('click tap', function(e) {
		if((e.target.nodeName=="DIV" || e.target.nodeName=="LI") && $treeSite.hasClass("opened")) closeNavMenu()
   	});
	
	}

function openNavMenu(){ $treeSite.transition({ x: '320px' },function(){  $treeSite.css("pointer-events","auto").addClass("opened")} );}
function closeNavMenu(){ $treeSite.transition({ x: '-320px' },function(){ $treeSite.css("pointer-events","none").removeClass("opened") });}
function startLoading(){ $body.addClass("loading");}
function stopLoading(){ $body.removeClass("loading");}
function activeParallax(){ $parallax=$('#parallaxscene').parallax(); $parallaxContainer.fadeIn(); $("#headerMinWrapper").addClass("display");}
function deactiveParallax(){ $parallax.parallax('disable'); $parallaxContainer.addClass("game");}

function playNinja(){
	deactiveParallax();
	z89Header.Main.gameToPlay=0;
	z89HeaderStar.Main._Main.stopStars();
	closeNavMenu();
	return false;
	
	}