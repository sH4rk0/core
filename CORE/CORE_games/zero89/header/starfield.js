
var starGame;
//------------------------------------------------------------------------------------------------------------
//init
//------------------------------------------------------------------------------------------------------------

	   
		$(function(){
		
	        starGame = new Phaser.Game("100%", 150, Phaser.CANVAS, 'starsGame',null,true,false);
			musicON = true;
			starGame.state.add('Boot',z89HeaderStar.Boot);
			starGame.state.add('Preload',z89HeaderStar.Preload);
			starGame.state.add('Main',z89HeaderStar.Main);
			starGame.state.add('Pause',z89HeaderStar.Pause);
			starGame.state.start('Boot');
			
	    });
	
		


//------------------------------------------------------------------------------------------------------------
//boot
//------------------------------------------------------------------------------------------------------------
var z89HeaderStar={
	//local:"/zero89"
	local:""
	};
z89HeaderStar.Boot=function(game){}
z89HeaderStar.Boot.prototype={
	
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
z89HeaderStar.Preload=function(game){}
z89HeaderStar.Preload.prototype={
	
	loadingBar:undefined,
	preload:function(){
		
		
		
		z89HeaderStar.Preload.loadingBar=this.add.sprite(parseInt(this.game.scale.width/2),parseInt(this.game.scale.height/2),'sprLoadingBar');
		z89HeaderStar.Preload.loadingBar.anchor.setTo(0.5,0.5);
		this.load.setPreloadSprite(z89HeaderStar.Preload.loadingBar);
	
	
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
z89HeaderStar.Main=function(game){};
z89HeaderStar.Main.prototype=
{
	INTRO_STARS_GROUP:undefined,
	
		create:function(){
			
		z89HeaderStar.Main._Main=this;
		
		z89HeaderStar.Main.INTRO_STARS_GROUP= this.game.add.group();
		z89HeaderStar.Main.INTRO_STARS_GROUP.enableBody = true;
    	z89HeaderStar.Main.INTRO_STARS_GROUP.physicsBodyType = Phaser.Physics.ARCADE;
		
		this.makeStars(0,7,0,80);
	
			},
		
		update:function(){ },
			
		makeStars:function(_index,_max,_startY,_endY){
			
			if(_index==_max) return;
			
			 var star = z89HeaderStar.Main.INTRO_STARS_GROUP.getFirstDead();
	
					if (star  === null) {
						

						 star = z89HeaderStar.Main.INTRO_STARS_GROUP.create(this.game.scale.width,this.game.rnd.integerInRange(_startY, _endY),this.game.cache.getBitmapData('star'))
							
							star.checkWorldBounds = true;
						    star.events.onOutOfBounds.add(this.starOut, this);
							star.body.velocity.x = (50 + (Math.random() * 200))*-1;		
							
							z89HeaderStar.Main.INTRO_STARS_GROUP.add(star);
							_index++;
							this.game.time.events.add(this.game.rnd.integerInRange(0, 1000), function(){ this.makeStars(_index, _max, _startY, _endY)}, this);
						
						
							}
		
			
			},	
			
		starOut:function(star){
		
    			star.reset(this.game.scale.width, this.game.rnd.integerInRange(0, 80));
				star.body.velocity.x = (50 + (Math.random() * 200))*-1;	
			
			},
			
		stopStars:function(){
			
			z89HeaderStar.Main._Main.game.state.start('Pause');
			
			},
		restartStars:function(){
			
			z89HeaderStar.Main._Main.game.state.start('Main');
			
			}	
	
}

//------------------------------------------------------------------------------------------------------------
//pause
//------------------------------------------------------------------------------------------------------------
z89HeaderStar.Pause=function(game){}
z89HeaderStar.Pause.prototype={

	
	create:function(){},
	update:function(){},
	resize:function(){}
	
	
	}

