
var $deluca,$body,isloading,$parallax, $parallaxContainer, $layers;


$(function(){
	
	
	
isLoading=false;	
$deluca=$("#deluca");	
$body=$("body");
$parallaxContainer=$("#parallaxcontainer");
$layers=$(".layer");
$parallax=$('#parallaxscene').parallax();
setLayout();
//loadNext();


$( window ).resize( function () {   
	
		
		
		setLayout();
		
});

function setLayout(){
	var _width=$(window).width();
		var _newH=((400*_width)/561);
		
		$parallaxContainer.height(_newH);
		
		$layers.each(function(index, element) {
		$(element).height(_newH);
		
        });
	
	}
$(window).bind('viewportready viewportchange', function() {
			//alert(viewporter.isLandscape())
			//$('#orientationlock').toggle(!viewporter.isLandscape());
		});	

});

function loadNext(){
	
	
	$deluca.fadeOut(function(){
		
		if(isLoading) return;
	isLoading=true;
	
	$body.addClass("loading");
	$.ajax({   type: "POST",
		   url: "/api/json/deluca/core.aspx",
		   dataType: "json",
		   success: function(msg){
		  
		    if(msg.values.error[0].errorId==0){
			$body.removeClass("loading");
			isLoading=false;
		      $deluca.html(msg.values.message[0].iSay).fadeIn()
		  		}
		  		else{
		  		
		  		if (msg.values.error[0].errorId==666){}
		  		
		  		}
		  		  
		   }
		 });
		
		
		});
	
	
	
	}
	
	
	

	

var dlg;
//------------------------------------------------------------------------------------------------------------
//init
//------------------------------------------------------------------------------------------------------------

	   
		$(function(){
		
	        dlg = new Phaser.Game("100%", "100%", Phaser.CANVAS, 'parallax-penguins',null,true,false);
			musicON = true;
			dlg.state.add('Boot',z89dlg.Boot);
			dlg.state.add('Preload',z89dlg.Preload);
			dlg.state.add('Main',z89dlg.Main);
			dlg.state.add('Pause',z89dlg.Pause);
			dlg.state.start('Boot');
			
	    });
	
		


//------------------------------------------------------------------------------------------------------------
//boot
//------------------------------------------------------------------------------------------------------------
var z89dlg={
	//local:"/zero89"
	local:""
	};
z89dlg.Boot=function(game){}
z89dlg.Boot.prototype={
	
	preload:function(){
			this.game.load.image('sprLoadingBar',z89dlg.local+'/core/core_sites/defaultSite/_css/_it/_deluca/_images/assets/loading.png');
	},
	
	create:function(){
		this.game.scale.scaleMode=Phaser.ScaleManager.RESIZE;
		this.game.stage.smoothed=false;
		this.game.state.start('Preload');
		}
		}
//------------------------------------------------------------------------------------------------------------
//preload
//------------------------------------------------------------------------------------------------------------
z89dlg.Preload=function(game){}
z89dlg.Preload.prototype={
	
	loadingBar:undefined,
	preload:function(){
		
		
		
		z89dlg.Preload.loadingBar=this.add.sprite(parseInt(this.game.scale.width/2),parseInt(this.game.scale.height/2),'sprLoadingBar');
		z89dlg.Preload.loadingBar.anchor.setTo(0.5,0.5);
		this.load.setPreloadSprite(z89dlg.Preload.loadingBar);
		this.game.load.spritesheet('penguins',z89dlg.local+'/core/core_sites/defaultSite/_css/_it/_deluca/_images/assets/penguins-160x40x4.png',40,40,4);
	
	
		},

	create:function(){ 
	this.game.state.start('Main');
	},
	update:function(){},
	resize:function(){ loadingBar.x=parseInt(this.game.scale.width/2); }
	
	
	}

//------------------------------------------------------------------------------------------------------------
//Main
//------------------------------------------------------------------------------------------------------------
z89dlg.Main=function(game){};
z89dlg.Main.prototype=
{
	INTRO_STARS_GROUP:undefined,
	
		create:function(){
			
		z89dlg.Main._Main=this;
		
		this.size=1;
		this.game.physics.startSystem(Phaser.Physics.ARCADE);
		this.penguin = this.game.add.sprite(this.game.scale.width/2, this.game.scale.height, "penguins", 5);
 		this.game.physics.enable(this.penguin, Phaser.Physics.ARCADE);
		this.penguin.checkWorldBounds=true;
		this.penguin.inputEnabled = true;
		this.penguin.input.useHandCursor = true;
		this.penguin.events.onInputDown.add(this.isay, this);
		continueAnim=this.penguin.animations.add('anim', [0,1,2,3] , 12, true, true);
		continueAnim.play();
		 
		  this.resize();
	this.throwPenguin();
			},
		
		update:function(){ },
		
	throwPenguin:function (pointer) {
		
	
		this.penguin.immovable = false;
    	this.penguin.collideWorldBounds = false;
	    this.penguin.body.velocity.y = this.game.rnd.integerInRange(this.y1, this.y2);
        this.penguin.body.velocity.x = this.game.rnd.integerInRange(-200, 200);
        this.penguin.body.acceleration.y = 1000*this.range;
		this.penguin.rotation+=10;
		this.penguin.events.onOutOfBounds.add(this.penguinOut, this);
	
},

  resize: function () {

this.size=(((this.game.scale.width*this.game.scale.height)*1) /(374*267));
if(this.size>5){this.size=5}
this.range=	this.size/2;

	//console.log(this.size);
	
	this.y1=(((this.game.scale.height*80)/100)+this.game.scale.height)*-1;
	this.y2=(((this.game.scale.height*90)/100)+this.game.scale.height)*-1;
	
	console.log(this.size,this.range,1000*this.range,this.y1,this.y2)  
	  this.penguin.scale.set(1*this.size);
	  

    },

penguinOut :function (_penguin) {

_penguin.reset(this.game.scale.width/2, this.game.scale.height);

this.throwPenguin();
},

isay: function(){
	
	loadNext();
	}
			
		
			
		
}

//------------------------------------------------------------------------------------------------------------
//pause
//------------------------------------------------------------------------------------------------------------
z89dlg.Pause=function(game){}
z89dlg.Pause.prototype={

	
	create:function(){},
	update:function(){},
	resize:function(){}
	
	
	}

	
			
