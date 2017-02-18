
var $salvini,$body,isloading,$parallax, $parallaxContainer, $layers;


$(function(){
	
	
	
isLoading=false;	
$salvini=$("#salvini");	
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
	
	
	$salvini.fadeOut(function(){
		
		if(isLoading) return;
	isLoading=true;
	
	$body.addClass("loading");
	$.ajax({   type: "POST",
		   url: "/api/json/salvini/core.aspx",
		   dataType: "json",
		   success: function(msg){
		  
		    if(msg.values.error[0].errorId==0){
			$body.removeClass("loading");
			isLoading=false;
		      $salvini.html(msg.values.message[0].iSay).fadeIn()
		  		}
		  		else{
		  		
		  		if (msg.values.error[0].errorId==666){}
		  		
		  		}
		  		  
		   }
		 });
		
		
		});
	
	
	
	}
	
	
	

	

var sal;
//------------------------------------------------------------------------------------------------------------
//init
//------------------------------------------------------------------------------------------------------------

	   
		$(function(){
		
	        sal = new Phaser.Game("100%", "100%", Phaser.CANVAS, 'parallax-tombins',null,true,false);
			musicON = true;
			sal.state.add('Boot',z89sal.Boot);
			sal.state.add('Preload',z89sal.Preload);
			sal.state.add('Main',z89sal.Main);
			sal.state.add('Pause',z89sal.Pause);
			sal.state.start('Boot');
			
	    });
	
		


//------------------------------------------------------------------------------------------------------------
//boot
//------------------------------------------------------------------------------------------------------------
var z89sal={
	//local:"/zero89"
	local:""
	};
z89sal.Boot=function(game){}
z89sal.Boot.prototype={
	
	preload:function(){
			this.game.load.image('sprLoadingBar',z89sal.local+'/core/core_sites/defaultSite/_css/_it/_deluca/_images/assets/loading.png');
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
z89sal.Preload=function(game){}
z89sal.Preload.prototype={
	
	loadingBar:undefined,
	preload:function(){
		
		
		
		z89sal.Preload.loadingBar=this.add.sprite(parseInt(this.game.scale.width/2),parseInt(this.game.scale.height/2),'sprLoadingBar');
		z89sal.Preload.loadingBar.anchor.setTo(0.5,0.5);
		this.load.setPreloadSprite(z89sal.Preload.loadingBar);
		this.game.load.image('tombino',z89sal.local+'/core/core_sites/defaultSite/_css/_it/_salvini/_images/assets/tombino-di-ghisa.png');
	
	
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
z89sal.Main=function(game){};
z89sal.Main.prototype=
{
	
		create:function(){
			
		z89sal.Main._Main=this;
		
		this.size=1;
		this.game.physics.startSystem(Phaser.Physics.ARCADE);
		this.tombino = this.game.add.sprite(this.game.scale.width/2, this.game.scale.height, "tombino", 5);
 		this.game.physics.enable(this.tombino, Phaser.Physics.ARCADE);
		this.tombino.checkWorldBounds=true;
		this.tombino.inputEnabled = true;
		this.tombino.input.useHandCursor = true;
		this.tombino.events.onInputDown.add(this.isay, this);
	
		 
		  this.resize();
	this.throwTombino();
			},
		
		update:function(){ },
		
	throwTombino:function (pointer) {
		
	
		this.tombino.immovable = false;
    	this.tombino.collideWorldBounds = false;
	    this.tombino.body.velocity.y = this.game.rnd.integerInRange(this.y1, this.y2);
        this.tombino.body.velocity.x = this.game.rnd.integerInRange(-200, 200);
        this.tombino.body.acceleration.y = 1000*this.range;
		this.tombino.rotation+=10;
		this.tombino.events.onOutOfBounds.add(this.tombinoOut, this);
	
},

  resize: function () {

this.size=(((this.game.scale.width*this.game.scale.height)*1) /(374*267));
if(this.size>5){this.size=5}
this.range=	this.size/2;

	//console.log(this.size);
	
	this.y1=(((this.game.scale.height*80)/100)+this.game.scale.height)*-1;
	this.y2=(((this.game.scale.height*90)/100)+this.game.scale.height)*-1;
	
	//console.log(this.size,this.range,1000*this.range,this.y1,this.y2)  
	  this.tombino.scale.set(1*this.size);
	  

    },

tombinoOut :function (_tombin) {

_tombin.reset(this.game.scale.width/2, this.game.scale.height);

this.throwTombino();
},

isay: function(){
	
	loadNext();
	}
			
		
			
		
}

//------------------------------------------------------------------------------------------------------------
//pause
//------------------------------------------------------------------------------------------------------------
z89sal.Pause=function(game){}
z89sal.Pause.prototype={

	
	create:function(){},
	update:function(){},
	resize:function(){}
	
	
	}

	
			
