


var headerGame;
var highScores;
var highScoresObj=[];
var globalScore=0;
var keyboard=["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"];
var keyboardObj=[];
var keyboardCount=0;

function loadHighscores(game){
	
$.ajax({
  url: "/api/json/scores/core.aspx",
  data:{who:"loadTopFive",game:game},
  dataType:"json",
  context: document.body
}).done(function(data) {
	
  highScores=data.Root.Scores;
  for (var i=0; i<highScoresObj.length; i++){
	  
	  if(highScores[i]!=undefined) {
		  
		  		highScoresObj[i].text=(i+1)+". " + highScores[i].name + " " + highScores[i].score
		  } else {
			  	highScoresObj[i].text=i+1 +" 0000"
			  
			   }
	  
	  }
  
  
});
	
	}
	
function saveScore(game){
	
	name=keyboardObj[0].text+""+keyboardObj[1].text+""+keyboardObj[2].text;
	
			$.ajax({
		 	url: "/api/json/scores/core.aspx",
		 	data:{who:"save", game:game, name:name, score:globalScore},
		 	dataType:"json",
		  	context: document.body
				}).done(function(data) {  
				globalScore=0;
				loadHighscores(game); });
	
	
	}	


//------------------------------------------------------------------------------------------------------------
//init
//------------------------------------------------------------------------------------------------------------

	   
		$(function(){
		
	        headerGame = new Phaser.Game("100%", 150, Phaser.CANVAS, 'headerGame',null,true,true);
			musicON = true;
			headerGame.state.add('Boot',z89Header.Boot);
			headerGame.state.add('Preload',z89Header.Preload);
			headerGame.state.add('GamePixelNinja',z89Header.GamePixelNinja);
			headerGame.state.add('Main',z89Header.Main);
			
			headerGame.state.start('Boot');
		
	    });
	
		


//------------------------------------------------------------------------------------------------------------
//boot
//------------------------------------------------------------------------------------------------------------
var z89Header={
	//local:"/zero89"
	local:""
	};
z89Header.Boot=function(game){}
z89Header.Boot.prototype={
	
	preload:function(){
	
		this.game.load.image('sprLoadingBar',z89Header.local+'/core/core_games/zero89/header/assets/loading.png');
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
z89Header.Preload=function(game){}
z89Header.Preload.prototype={
	
	loadingBar:undefined,
	preload:function(){
	
		
	z89Header.Preload.loadingBar=this.add.sprite(parseInt(this.game.scale.width/2),parseInt(this.game.scale.height/2),'sprLoadingBar');
	z89Header.Preload.loadingBar.anchor.setTo(0.5,0.5);
	this.load.setPreloadSprite(z89Header.Preload.loadingBar);
	
		this.game.load.image('btnMenu',z89Header.local+'/core/core_games/zero89/header/assets/menu3.png');
		this.game.load.image('close',z89Header.local+'/core/core_games/zero89/header/assets/close.png');
		this.game.load.image('score',z89Header.local+'/core/core_games/zero89/header/assets/scores.png');
		this.game.load.image('info',z89Header.local+'/core/core_games/zero89/header/assets/info.png');
		this.game.load.image('pnRaster',z89Header.local+'/core/core_games/zero89/header/assets/ninja-raster.png');
		this.game.load.image('pnNinja',z89Header.local+'/core/core_games/zero89/header/assets/ninja2.png');
		this.game.load.image('pnScreen',z89Header.local+'/core/core_games/zero89/header/assets/screen.png');
		this.game.load.bitmapFont('carrier_command', z89Header.local+'/core/core_games/zero89/header/assets/carrier_command.png', z89Header.local+'/core/core_games/zero89/header/assets/carrier_command.xml');
	
		var raster = this.game.add.bitmapData(20,50);
		raster.ctx.fillStyle = '#ffffff';
		raster.ctx.beginPath();
		raster.ctx.rect(0, 0, 20, 50);
		raster.ctx.fill();
		this.game.cache.addBitmapData('raster', raster);
	
		var bmd = this.game.add.bitmapData(32,32);
		bmd.ctx.fillStyle = '#3932a2';
		bmd.ctx.beginPath();
		bmd.ctx.rect(0, 0, 32, 32);
		bmd.ctx.fill();
		this.game.cache.addBitmapData('good', bmd);
	
		bmd = this.game.add.bitmapData(18,18);
		bmd.ctx.fillStyle = '#333333';
		bmd.ctx.beginPath();
		bmd.ctx.rect(0, 0, 18, 18);
		bmd.ctx.fill();
		this.game.cache.addBitmapData('bad', bmd);
		
		bmd = this.game.add.bitmapData(4,4);
		bmd.ctx.fillStyle = '#3932a2';
		bmd.ctx.beginPath();
		bmd.ctx.rect(0, 0, 4, 4);
		bmd.ctx.fill();
		this.game.cache.addBitmapData('pixel', bmd);
		
		bmd = this.game.add.bitmapData(4,4);
		bmd.ctx.fillStyle = '#000000';
		bmd.ctx.beginPath();
		bmd.ctx.rect(0, 0, 4, 4);
		bmd.ctx.fill();
		this.game.cache.addBitmapData('pixelblack', bmd);
	
	var star = this.game.add.bitmapData(2,2);
		star.ctx.fillStyle = '#ffffff';
		star.ctx.beginPath();
		star.ctx.rect(0, 0, 2, 2);
		star.ctx.fill();
		this.game.cache.addBitmapData('star', star);
		
		},

	create:function(){ 
	
	
		
	this.game.state.start('Main');
	},
	update:function(){},
	resize:function(){ z89Header.Preload.loadingBar.x=parseInt(this.game.scale.width/2); }
	
	
	}

//------------------------------------------------------------------------------------------------------------
//Main
//------------------------------------------------------------------------------------------------------------

z89Header.Main=function(game){};
z89Header.Main.prototype=
{
	_counter:undefined,
	_step:undefined,
	logoText:undefined,
	navBtn:undefined,
	_Main:undefined,
	gameToPlay:undefined,
	btnTween:undefined,
	logoTween:undefined,
	
	
		create:function(){
			
			z89Header.Main._counter=0;
			z89Header.Main._step=Math.PI * 2 / 270;
			
		z89Header.Main._Main=this;
		//this.game.state.start('GamePixelNinja');
		
		
	    activeParallax();
		z89Header.Main.logoText = this.game.add.bitmapText(80, 14, 'carrier_command', 'zero89.it', 20);
		z89Header.Main.logoText.tint=0xffffff;
		
		
		z89Header.Main.navBtn = this.game.add.sprite(40, 10, 'btnMenu');
		
		z89Header.Main.navBtn.anchor.x = z89Header.Main.navBtn.anchor.y = 0.5 ;
		z89Header.Main.navBtn.inputEnabled = true;
		z89Header.Main.navBtn.events.onInputDown.add(this.menu, this);
		z89Header.Main.navBtn.tint=0xffffff;
		
		this.setLogoSize();
		
		
	
			},
		
		update:function(){
			
	var tStep = Math.cos(z89Header.Main._counter ) ;
    z89Header.Main.navBtn.y = 35 + tStep * 7 ;
    z89Header.Main.navBtn.rotation += Phaser.Math.degToRad( -0.25 * tStep ) ;
	
	z89Header.Main.logoText.y = 35 + tStep * 7 ;
    z89Header.Main.logoText.rotation += Phaser.Math.degToRad( 0.15 * tStep ) ;
	
	
   z89Header.Main._counter += z89Header.Main._step ;	
			
	s = "Game size: " + this.game.width + " x " + this.game.height + "\n";
	s = s.concat("Actual size: " + this.game.scale.width + " x " + this.game.scale.height + "\n");
	s = s.concat("bounds x: " + this.game.scale.bounds.x + " y: " + this.game.scale.bounds.y + " width:\
	" + this.game.scale.bounds.width + " height: " + this.game.scale.bounds.height + "\n");
	//info.text = s;
	
	if (z89Header.Main.gameToPlay!=undefined) this.headerOut();
			
			},
		resize:function(){
			
			this.setLogoSize();
			
			 },
		
		menu:function(){
			
			openNavMenu();
			
			},
		
		headerOut:function(){
			
			btnTween= this.game.add.tween(z89Header.Main.navBtn)
			btnTween.to( { alpha: 0 }, 100, "Linear",true,0,0);
			
			logoTween= this.game.add.tween(z89Header.Main.logoText)
			logoTween.to( { alpha: 0 }, 100, "Linear",true,0,0);
			
			logoTween.onComplete.add(this.playGame, this);
			
			},
			
	
		
		
			
		playGame:function(){
				
				switch (z89Header.Main.gameToPlay){
				
				case 0:
				
				z89Header.Main.gameToPlay=undefined;
				
		
				//console.log(z89Header.Main._Main)
				
				
				startLoading();
				setTimeout(function(){ stopLoading();},1000);
				setTimeout(function(){ 
				//this.game.state.start('Main');
				z89Header.Main._Main.game.state.start('GamePixelNinja');
				
				},1200);
				break;
				
				
				}
				
				
				},
			
		setLogoSize:function(){
			
			
			if(this.game.scale.width<=480){ 
			//console.log("setlogo")
			z89Header.Main.logoText.fontSize=20;
			z89Header.Main.logoText.y=14;
			z89Header.Main.logoText.x=80;
			z89Header.Main.navBtn.x=40;
			
			}else if(this.game.scale.width>=480 && this.game.scale.width<1200){
				
			z89Header.Main.logoText.fontSize=20;
			z89Header.Main.logoText.y=14;	
			z89Header.Main.logoText.x=80;
			z89Header.Main.navBtn.x=40;
			
				}
			else if(this.game.scale.width>=1200){
				
			z89Header.Main.logoText.fontSize=20;
			z89Header.Main.logoText.y=14;	
			z89Header.Main.logoText.x=80;
			z89Header.Main.navBtn.x=40;
			
				}	
			
			}
}
