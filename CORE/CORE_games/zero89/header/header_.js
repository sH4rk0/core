
var headerGame;
//var local="/zero89";
var local="";
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


//var local="";
//------------------------------------------------------------------------------------------------------------
//init
//------------------------------------------------------------------------------------------------------------

	   
		$(function(){
		
	        headerGame = new Phaser.Game("100%", 150, Phaser.AUTO, 'headerGame',null,true,true);
			musicON = true;
			headerGame.state.add('Boot',z89Header.Boot);
			headerGame.state.add('Preload',z89Header.Preload);
			//headerGame.state.add('GamePixelNinja',z89Header.GamePixelNinja);
			headerGame.state.add('Main',z89Header.Main);
			headerGame.state.start('Boot');
		
	    });
	
		


//------------------------------------------------------------------------------------------------------------
//boot
//------------------------------------------------------------------------------------------------------------
var z89Header={};
z89Header.Boot=function(game){}
z89Header.Boot.prototype={
	
	preload:function(){
		this.game.load.image('sprLoadingBar',local+'/core/core_games/zero89/header/assets/loading.png');
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
var loadingBar;
z89Header.Preload=function(game){}
z89Header.Preload.prototype={
	preload:function(){
		
		
		
		loadingBar=this.add.sprite(parseInt(this.game.scale.width/2),parseInt(this.game.scale.height/2),'sprLoadingBar');
		loadingBar.anchor.setTo(0.5,0.5);
		this.load.setPreloadSprite(loadingBar);
		this.game.load.image('btnMenu',local+'/core/core_games/zero89/header/assets/menu3.png');
		this.game.load.image('close',local+'/core/core_games/zero89/header/assets/close.png');
		this.game.load.image('score',local+'/core/core_games/zero89/header/assets/scores.png');
		this.game.load.image('info',local+'/core/core_games/zero89/header/assets/info.png');
		this.game.load.image('raster2',local+'/core/core_games/zero89/header/assets/raster2.png');
		this.game.load.image('pnRaster',local+'/core/core_games/zero89/header/assets/ninja-raster.png');
		this.game.load.image('pnNinja',local+'/core/core_games/zero89/header/assets/ninja2.png');
		this.game.load.image('pnScreen',local+'/core/core_games/zero89/header/assets/screen.png');
		this.game.load.bitmapFont('carrier_command', local+'/core/core_games/zero89/header/assets/carrier_command.png', local+'/core/core_games/zero89/header/assets/carrier_command.xml');
	
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
	resize:function(){ loadingBar.x=parseInt(this.game.scale.width/2); }
	
	
	}

//------------------------------------------------------------------------------------------------------------
//Main
//------------------------------------------------------------------------------------------------------------
var _Main, logoText, navBtn, gameToPlay, btnTween, logoTween, raster, raster2, raster3, raster4;
var counter = 0 ;
var step = Math.PI * 2 / 270 ;

z89Header.Main=function(game){};
z89Header.Main.prototype=
{
		create:function(){
			
		_Main=this;
		//this.game.state.start('GamePixelNinja');
		
	    activeParallax();
		logoText = this.game.add.bitmapText(80, 14, 'carrier_command', 'zero89.it', 20);
		logoText.tint=0xffffff;
		
		
		navBtn = this.game.add.sprite(40, 10, 'btnMenu');
		
		navBtn.anchor.x = navBtn.anchor.y = 0.5 ;
		navBtn.inputEnabled = true;
		navBtn.events.onInputDown.add(this.menu, this);
		navBtn.tint=0xffffff;
		
		//navBtn.alpha = 0;
		//logoText.alpha = 0;
		/*
        btnTween= this.game.add.tween(navBtn)
		btnTween.stop(true).to( { alpha: 1 }, 500, "Linear",true,0,0,false);
		
		logoTween= this.game.add.tween(logoText)
		logoTween.stop(true).to( { alpha: 1 }, 500, "Linear",true,0,0,false);
		*/
		this.setLogoSize();
		
		
	
			},
		
		update:function(){
			

			
	var tStep = Math.cos( counter ) ;
    navBtn.y = 35 + tStep * 7 ;
    navBtn.rotation += Phaser.Math.degToRad( -0.25 * tStep ) ;
	
	logoText.y = 35 + tStep * 7 ;
    logoText.rotation += Phaser.Math.degToRad( 0.15 * tStep ) ;
	
	
    counter += step ;	
			
	s = "Game size: " + this.game.width + " x " + this.game.height + "\n";
	s = s.concat("Actual size: " + this.game.scale.width + " x " + this.game.scale.height + "\n");
	s = s.concat("bounds x: " + this.game.scale.bounds.x + " y: " + this.game.scale.bounds.y + " width:\
	" + this.game.scale.bounds.width + " height: " + this.game.scale.bounds.height + "\n");
	//info.text = s;
	
	if (gameToPlay!=undefined) this.headerOut();
			
			},
		resize:function(){
			
			this.setLogoSize();
			
			 },
		
		menu:function(){
			
			openNavMenu();
			
			},
		
		headerOut:function(){
			
			btnTween= this.game.add.tween(navBtn)
			btnTween.to( { alpha: 0 }, 100, "Linear",true,0,0);
			
			
			logoTween= this.game.add.tween(logoText)
			logoTween.to( { alpha: 0 }, 100, "Linear",true,0,0);
			
			logoTween.onComplete.add(this.playGame, this);
			/*
			rasterTween= this.game.add.tween(raster)
			rasterTween.to( { alpha: 0 }, 100, "Linear",true,0,0);
			
			rasterTween2= this.game.add.tween(raster2)
			rasterTween2.to( { alpha: 0 }, 100, "Linear",true,0,0);
			
			rasterTween3= this.game.add.tween(raster3)
			rasterTween3.to( { alpha: 0 }, 100, "Linear",true,0,0);
			
			rasterTween4= this.game.add.tween(raster4)
			rasterTween4.to( { alpha: 0 }, 100, "Linear",true,0,0);
			*/
			
			},
			
	
		
		
			
		playGame:function(){
				
				switch (gameToPlay){
				
				case 0:
				console.log("game")
				gameToPlay=undefined;
				startLoading();
				setTimeout(function(){ stopLoading();},1000);
				setTimeout(function(){ _Main.game.state.start('GamePixelNinja');},1200);
				break;
				
				
				}
				
				
				},
			
		setLogoSize:function(){
			
			//raster.width=this.game.scale.width;
			//raster2.width=this.game.scale.width;
			//raster3.width=this.game.scale.width;
			//raster4.width=this.game.scale.width;
		
			if(this.game.scale.width<=480){ 
			//console.log("setlogo")
			logoText.fontSize=20;
			logoText.y=14;
			logoText.x=80;
			navBtn.x=40;
			
			}else if(this.game.scale.width>=480 && this.game.scale.width<1200){
				
			logoText.fontSize=20;
			logoText.y=14;	
			logoText.x=80;
			navBtn.x=40;
			
				}
			else if(this.game.scale.width>=1200){
				
			logoText.fontSize=20;
			logoText.y=14;	
			logoText.x=80;
			navBtn.x=40;
			
				}	
			
			}
}
