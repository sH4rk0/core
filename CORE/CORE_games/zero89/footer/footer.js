var footerGame;

//------------------------------------------------------------------------------------------------------------
//init
//------------------------------------------------------------------------------------------------------------

	   
		$(function(){
		
	        footerGame = new Phaser.Game("100%", 188, Phaser.CANVAS, 'image-of-me',null,true,true);
			footerGame.state.add('Boot',z89Footer.Boot);
			footerGame.state.add('Preload',z89Footer.Preload);
			footerGame.state.add('Main',z89Footer.Main);
			footerGame.state.start('Boot');
		
		
	    });
	
		


//------------------------------------------------------------------------------------------------------------
//boot
//------------------------------------------------------------------------------------------------------------
var z89Footer={
	//local:"/zero89"
	local:""
	};
z89Footer.Boot=function(game){}
z89Footer.Boot.prototype={
	
	preload:function(){
		this.game.load.image('sprLoadingBar',z89Footer.local+'/core/core_games/zero89/footer/assets/loading.png');
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
z89Footer.Preload=function(game){}
z89Footer.Preload.prototype={
	preload:function(){
		
		loadingBar=this.add.sprite(parseInt(this.game.scale.width/2),parseInt(this.game.scale.height/2),'sprLoadingBar');
		loadingBar.anchor.setTo(0.5,0.5);
		this.load.setPreloadSprite(loadingBar);
		this.game.load.bitmapFont('carrier_command', z89Footer.local+'/core/core_games/zero89/footer/assets/carrier_command.png', z89Footer.local+'/core/core_games/zero89/header/assets/carrier_command.xml');
	
		this.game.load.spritesheet('francesco',z89Footer.local+'/core/core_games/zero89/footer/assets/me/francesco-raimondo-spritesheet2.png?sss=sss',211,200,27);
		
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


z89Footer.Main=function(game){
	
	
	};
z89Footer.Main.prototype=
{
	francesco:undefined,
	main:undefined,
	anims:undefined,
	animNose:undefined,
	animNose2:undefined
}
z89Footer.Main.prototype=
{
		create:function(){
			
			z89Footer.Main.anims=[];
			z89Footer.Main.main=this;
			z89Footer.Main.francesco = this.game.add.sprite(0, 0, 'francesco');
			
			z89Footer.Main.francesco.x = (this.game.scale.width / 2 - (z89Footer.Main.francesco.width / 2))
			z89Footer.Main.francesco.y = 0;
			
			z89Footer.Main.francesco.inputEnabled = true;
        	z89Footer.Main.francesco.events.onInputDown.add(function(){ 
			
			
			
			
			this.checkAnim();
			
			}, this);
			
			
			francescoAnim = new Phaser.AnimationManager(z89Footer.Main.francesco);
			
			z89Footer.Main.anims.push(z89Footer.Main.francesco.animations.add('idle',[0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1], 9, false, true));
			z89Footer.Main.anims[0].onComplete.add(function(){ this.randomAnim()}, this);
			
			z89Footer.Main.anims.push(z89Footer.Main.francesco.animations.add('barba',[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12,13,14,14,15,15,14,14,15,15,14,14,13,12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1], 9, false, true));
			z89Footer.Main.anims[1].onComplete.add(function(){ this.randomAnim()}, this);
			
			z89Footer.Main.anims.push(z89Footer.Main.francesco.animations.add('occhi',[0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,], 9, false, true));
			z89Footer.Main.anims[2].onComplete.add(function(){ this.randomAnim()}, this);
			
			z89Footer.Main.anims.push(z89Footer.Main.francesco.animations.add('gratta',[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,17,18,18,19,19,18,18,19,19,18,18,17,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1], 9, false, true));
			z89Footer.Main.anims[3].onComplete.add(function(){ this.randomAnim()}, this);
			
			z89Footer.Main.anims.push(z89Footer.Main.francesco.animations.add('smile',[0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1], 9, false, true));
			z89Footer.Main.anims[4].onComplete.add(function(){ this.randomAnim()}, this);
			
			z89Footer.Main.anims.push(z89Footer.Main.francesco.animations.add('sinistra',[0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,5,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,5,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1], 9, false, true));
			z89Footer.Main.anims[5].onComplete.add(function(){ this.randomAnim()}, this);
			
			z89Footer.Main.anims.push(z89Footer.Main.francesco.animations.add('sinistraLow',[0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,5,5,5,5,5,5,5,5,5,5,5,5,5,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1], 9, false, true));
			z89Footer.Main.anims[6].onComplete.add(function(){ this.randomAnim()}, this);
			
			z89Footer.Main.anims.push(z89Footer.Main.francesco.animations.add('destra',[0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,8,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,8,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1], 9, false, true));
			z89Footer.Main.anims[7].onComplete.add(function(){ this.randomAnim()}, this);
			
			z89Footer.Main.anims.push(z89Footer.Main.francesco.animations.add('destraLow',[0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,8,8,8,8,8,8,8,8,8,8,8,8,8,8,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1], 9, false, true));
			z89Footer.Main.anims[8].onComplete.add(function(){ this.randomAnim()}, this);
			
			z89Footer.Main.anims.push(z89Footer.Main.francesco.animations.add('nono',[0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,0,7,7,0,4,4,0,7,7,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1], 9, false, true));
			z89Footer.Main.anims[9].onComplete.add(function(){ this.randomAnim()}, this);
			
			z89Footer.Main.anims.push(z89Footer.Main.francesco.animations.add('darth1',[21,21,21,21,21,21], 3, false, true));
			z89Footer.Main.anims[10].onComplete.add(function(){ this.randomAnim()}, this);
			
			z89Footer.Main.anims.push(z89Footer.Main.francesco.animations.add('darth2',[22,22,22,21,21,21], 3, false, true));
			z89Footer.Main.anims[11].onComplete.add(function(){ this.randomAnim()}, this);
			
			z89Footer.Main.anims.push(z89Footer.Main.francesco.animations.add('darth3',[23,23,23,21,21,21], 3, false, true));
			z89Footer.Main.anims[12].onComplete.add(function(){ this.randomAnim()}, this);
			
			z89Footer.Main.anims.push(z89Footer.Main.francesco.animations.add('darth3',[24,24,25,25,25,25,25,24,24,21,21,21], 5, false, true));
			z89Footer.Main.anims[13].onComplete.add(function(){ this.randomAnim()}, this);
			
			
			
			z89Footer.Main.animNose=z89Footer.Main.francesco.animations.add('nose',[10,11,11,11,11,11,11,11,11,11,20,11,11,11,11,11,11,11,11,11,11],9,false,true);
			z89Footer.Main.animNose.onComplete.add(function(){z89Footer.Main.animNose2.play();}, this);
			z89Footer.Main.animNose2=z89Footer.Main.francesco.animations.add('nose2',[20,11,11,11,11,11,11,11,11,11,11],5,true,true);
			
			
			z89Footer.Main.animDarth=z89Footer.Main.francesco.animations.add('darthZoom',[25],4,false,true);
			
			this.randomAnim();
		
			},
			
		randomAnim:function(){
		
		z89Footer.Main.anims[this.game.rnd.integerInRange(0, 9)].play();
		//z89Footer.Main.anims[this.game.rnd.integerInRange(10, 13)].play();
		
		
		},
		
		update:function(){ 
		
		
			this.checkAnim();
			
			
			},
			
		checkAnim:function(distance){
			
			var distance = this.game.math.distance(this.game.scale.width / 2 , this.game.scale.height / 2,this.game.input._x, this.game.input._y);
			
			if(distance>30){ if(!z89Footer.Main.idle){this.randomAnim(); z89Footer.Main.idle=true;}}
			if(distance<30){ 
			
			if(z89Footer.Main.francesco.animations.currentAnim.name!="nose" && z89Footer.Main.francesco.animations.currentAnim.name!="nose2") { 
			z89Footer.Main.animNose2.play(); z89Footer.Main.idle=false;
			
			}
			//z89Footer.Main.animDarth.play(); z89Footer.Main.idle=false;
			
			}
			
			},
			
			
		
	resize:function(){
			
			
			z89Footer.Main.francesco.x=(this.game.scale.width / 2 - (z89Footer.Main.francesco.width / 2));
			
			
			 },
		
		
		
}
