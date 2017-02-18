var $menu;

$(function(){
	
setupNavMenu();
		
});

function setupNavMenu(){
	
	$menu=$("#menuContainer");
	
	$("#lvl1").clone().appendTo( "#menuList" );
	
	$($menu).on('click tap', function(e) {
		if((e.target.nodeName=="DIV" || e.target.nodeName=="LI") && $menu.hasClass("opened")) closeNavMenu()
   	});
	
	}

function openNavMenu(){ 

console.log("open")
$menu.transition({ x: '320px' },function(){  $menu.css("pointer-events","auto").addClass("opened")} );}

function closeNavMenu(){ $menu.transition({ x: '-320px' },function(){ $menu.css("pointer-events","none").removeClass("opened") });}
