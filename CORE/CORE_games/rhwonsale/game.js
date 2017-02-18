
var rhwgame;
//var local="/zero89/";

var local="";
//------------------------------------------------------------------------------------------------------------
//init
//------------------------------------------------------------------------------------------------------------

	    window.onload = function() {
		
	        
		
	    };


//------------------------------------------------------------------------------------------------------------
//boot
//------------------------------------------------------------------------------------------------------------
var rhwonsale={};
rhwonsale.Boot=function(game){}
rhwonsale.Boot.prototype={
	
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
rhwonsale.Preload=function(game){}
rhwonsale.Preload.prototype={
	preload:function(){
		
		loadingBar=this.add.sprite(parseInt(this.game.scale.width/2),parseInt(this.game.scale.height/2),'sprLoadingBar');
		loadingBar.anchor.setTo(0.5,0.5);
		this.load.setPreloadSprite(loadingBar);
		
		this.game.load.image('bg1',local+'/core/core_games/rhwonsale/assets/bg2.jpg');
		this.game.load.image('green',local+'/core/core_games/rhwonsale/assets/green.png');
		this.game.load.image('monitor',local+'/core/core_games/rhwonsale/assets/monitor.png');
		this.game.load.image('levynium',local+'/core/core_games/rhwonsale/assets/levynium.png');
		this.game.load.spritesheet('enemy1', local+'/core/core_games/rhwonsale/assets/enemy1.png', 25, 25, 5);
		this.game.load.spritesheet('enemy2', local+'/core/core_games/rhwonsale/assets/enemy2.png', 25, 25, 5);
		this.game.load.spritesheet('enemy3', local+'/core/core_games/rhwonsale/assets/enemy3.png', 30, 30, 5);
		this.game.load.spritesheet('enemy4', local+'/core/core_games/rhwonsale/assets/enemy4.png', 30, 30, 5);
		this.game.load.spritesheet('enemy5', local+'/core/core_games/rhwonsale/assets/enemy5.png', 30, 30, 5);
		this.game.load.spritesheet('enemy6', local+'/core/core_games/rhwonsale/assets/enemy6.png', 30, 30, 5);
		this.game.load.spritesheet('shield', local+'/core/core_games/rhwonsale/assets/shield2.png', 72, 72, 8);
		this.game.load.spritesheet('explosion1', local+'/core/core_games/rhwonsale/assets/explosion1.png', 17, 16, 10);
		this.game.load.spritesheet('explosion2', local+'/core/core_games/rhwonsale/assets/explosion2.png', 33, 32, 12);
		this.game.load.spritesheet('explosion3', local+'/core/core_games/rhwonsale/assets/explosion3.png', 65, 65, 12);
		this.game.load.spritesheet('font', local+'/core/core_games/rhwonsale/assets/font.png', 32, 32, 100);
		this.game.load.spritesheet('levy', local+'/core/core_games/rhwonsale/assets/lev2.png', 192, 192, 20);
		
		this.game.load.spritesheet('armadaShip', local+'/core/core_games/rhwonsale/assets/armada-ship.png', 144, 80, 3);
		this.game.load.image('armadaDestroyer',local+'/core/core_games/rhwonsale/assets/armada-destroyer.png');
		
		this.game.load.bitmapFont('carrier_command', local+'/core/core_games/zero89/header/assets/carrier_command.png', local+'/core/core_games/zero89/header/assets/carrier_command.xml');
		this.game.load.image('rocket', local+'/core/core_games/rhwonsale/assets/rocket.png');
		this.game.load.image('phaser', local+'/core/core_games/rhwonsale/assets/phaser.png');
		this.game.load.image('smoke', local+'/core/core_games/rhwonsale/assets/smoke.png');
		this.game.load.image('planet', local+'/core/core_games/rhwonsale/assets/planet.png');
		
		this.game.load.image('trantor', local+'/core/core_games/rhwonsale/assets/trantor2.png');
		
		var star = this.game.add.bitmapData(2,2);
		star.ctx.fillStyle = '#ffffff';
		star.ctx.beginPath();
		star.ctx.rect(0, 0, 2, 2);
		star.ctx.fill();
		this.game.cache.addBitmapData('star', star);
		
		
		var bgWhite = this.game.add.bitmapData(640,480);
		bgWhite.ctx.fillStyle = '#ffffff';
		bgWhite.ctx.beginPath();
		bgWhite.ctx.rect(0, 0, 640, 480);
		bgWhite.ctx.fill();
		this.game.cache.addBitmapData('bgWhite', bgWhite);
		
		
		/*
		
		this.game.load.bitmapFont('carrier_command', local+'/core/core_games/zero89/header/assets/carrier_command.png', local+'/core/core_games/zero89/header/assets/carrier_command.xml');
		*/
	
		
	
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

TextWriter=[

//0
{	
	callback:function(_this){ 
	
	
	
	},
	sizey:44,
	sizex:32,
	size:0.5,
	text:[
		{startx:30,starty:30,line:"11,988TH YEAR OF THE GALACTIC ERA ", delayNext:2000, callback:function(_this){ 
		
						TRANTOR=_this.game.add.sprite(700, 300, "trantor");
						INTRO_OBJECTS_GROUP.add(TRANTOR)
						TRANTOR_TWEEN=_this.game.add.tween(TRANTOR)
            			.to({ x:-130}, 8000, Phaser.Easing.Linear.None, false, 0, 0, false)
						.start();
						TRANTOR_TWEEN.onComplete.add(function(){_this.writeText(3,0,0,false);},_this);
		
		}},
		{startx:30,starty:30,line:" ", delayNext:10},
		{startx:30,starty:30,line:"THE EMPEROR MAURICE III DECIDED ", delayNext:100},
		{startx:30,starty:30,line:"TO STOP TRADE OF LEVYNIUM ", delayNext:100},
		{startx:30,starty:30,line:"TO THE PLANETS OF THE OUTER BORDER, ", delayNext:100},
		{startx:30,starty:30,line:"LEAVING TO THEIR FATE ALL THE ", delayNext:100},
		{startx:30,starty:30,line:"HIDDEN WORLDS THAT HAD ", delayNext:100},
		{startx:30,starty:30,line:"CONTRIBUTED TO THE GROWTH OF ", delayNext:100},
		{startx:30,starty:30,line:"THE EMPIRE. ", delayNext:1000},
		
	]
	
},
//1
{	
	callback:function(_this){ 
	
		
			continueBtn=_this.game.add.sprite(580, 300, "font");
			continueBtn.tint=0x00ff00;
			continueAnim=continueBtn.animations.add('continueAnim', [60,0] , 2, true, true);
			continueAnim.play();
			
			continueBtn.alpha=0;
			continueBtn_TWEEN=_this.game.add.tween(continueBtn)
            			.to({ alpha:1}, 1000, Phaser.Easing.Linear.None, false, 0, 0, false)
						.start();
			INTRO_LETTER_GROUP.add(continueBtn);
			continueBtn.inputEnabled = true;
			continueBtn.events.onInputDown.add(function(){
				_this.clearLetters(); 
				_this.writeText(2,0,0,true);}, _this); 
			
	 },
	sizey:44,
	sizex:32,
	size:0.5,
	text:[		
		{startx:30,starty:30,line:"THE LEVYNIUM IS ESSENTIAL FOR ", delayNext:100},
		{startx:30,starty:30,line:"THE PRODUCTION OF CLEAN ENERGY ", delayNext:100},
		{startx:30,starty:30,line:"NECESSARY TO THE LIFE OF THE ", delayNext:100 ,
				callback:function(_this){
			
			 	LEVYNIUM=_this.game.add.sprite(300,390,'levy');
				LEVYNIUM.anchor.setTo(0.5, 0.5);
				LEVYNIUM.scale.setTo(2, 2);
				LEVYNIUM.alpha=1;
				LEVYAnim=LEVYNIUM.animations.add('levyanim',[0,1,2,3,4,5,6,7,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8], 10, true, true);
				LEVYAnim.play();
				
				LEVYNIUMineral=_this.game.add.sprite(300,390,'levynium');
				LEVYNIUMineral.anchor.setTo(-0.15, 0.85);
				LEVYNIUMineral.alpha=0;
				
				_this.game.add.tween(LEVYNIUMineral)
				.to({alpha: 1 }, 1000, Phaser.Easing.Sinusoidal.InOut, false, 200, 0, false)
				.start();
				
				INTRO_OBJECTS_GROUP.add(LEVYNIUM);
				INTRO_OBJECTS_GROUP.add(LEVYNIUMineral);
			
			
			}},
		{startx:30,starty:30,line:"OUTER PLANETS. ", delayNext:2000, callback:function(_this){
			
			_this.writeText(4,0,0,false);
			
			}},
		{startx:30,starty:30,line:" ", delayNext:100},
		{startx:30,starty:30,line:"FEW REBEL WORLDS DECIDED TO ", delayNext:100},
		{startx:30,starty:30,line:"ATTACK THE NEW TRADE ROUTES ", delayNext:100},
		{startx:30,starty:30,line:"RECOVERING AS MUCH LEVYNIUM ", delayNext:100},
		{startx:30,starty:30,line:"POSSIBLE. ", delayNext:1000}
		
	]
	
},
//2
{	
	callback:function(_this){ 
	
	
				CANNON=_this.game.add.sprite(265,405,'levy');
				INTRO_OBJECTS_GROUP.add(CANNON)
				CANNON.anchor.setTo(0.5, 0.5);
				CANNON.scale.setTo(2, 2);
				CANNON.alpha=1;
				CANNONANIM=CANNON.animations.add('cannonAnim',[0,1,2,3,4,5,6,7,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8,9,10,11,12,13,12,11,10,9,8], 10, true, true);
				CANNONANIM.play();
				
				CANNON_TWEEN=_this.game.add.tween(CANNON)
            			.to({ x:700}, 500, Phaser.Easing.Linear.None, false, 2000, 0, false)
						.start();
				//CANNON_TWEEN.onComplete.add(function(){_this.endIntro()},_this);
				
				_this.game.time.events.add(2200, function(){ _this.endIntro()}, _this);
						
						
								
				
	
	/**/  
	
	
	},
	sizey:44,
	sizex:32,
	size:0.5,
	text:[
		{startx:30,starty:30,line:"THE EMPIRE SEVERANCE ARMADA LED ", delayNext:100,callback:function(_this){
			
			
			
			DESTROYER=_this.game.add.sprite(-600, 200, "armadaDestroyer");
			INTRO_OBJECTS_GROUP.add(DESTROYER)
			DESTROYER_TWEEN=_this.game.add.tween(DESTROYER)
            			.to({ x:-250}, 4000, Phaser.Easing.Circular.Out, false, 0, 0, false)
						.start();
						
			SHIP1=_this.game.add.sprite(-200, 200, "armadaShip");
			INTRO_OBJECTS_GROUP.add(SHIP1)
			SHIP1_TWEEN=_this.game.add.tween(SHIP1)
            			.to({ x:100}, 2000, Phaser.Easing.Circular.Out, false, 0, 0, false)
						.to({ y:250}, 3000, Phaser.Easing.Linear.None, true, 0, -1, true)
						.start();	
			SHIP1Anim=SHIP1.animations.add('ship1anim');
			SHIP1Anim.play(10,true,true);	
			
			SHIP2=_this.game.add.sprite(-200, 300, "armadaShip");
			INTRO_OBJECTS_GROUP.add(SHIP2)	
			SHIP2_TWEEN=_this.game.add.tween(SHIP2)
            			.to({ x:50}, 2500, Phaser.Easing.Circular.Out, false, 0, 0, false)
						.to({ y:370}, 2000, Phaser.Easing.Linear.None, true, 0, -1, true)
						.start();	
			SHIP2Anim=SHIP2.animations.add('ship2anim');
			SHIP2Anim.play(10,true,true);
			
			
			}},
		{startx:30,starty:30,line:"BY GENERAL COLUX BEGIN A MILITARY ", delayNext:100},
		{startx:30,starty:30,line:"OFFENSIVE AIMED TO DEFEAT ", delayNext:100},
		{startx:30,starty:30,line:"THE REBEL WORLDS. ", delayNext:2000},
		{startx:30,starty:30,line:" ", delayNext:10},
		{startx:30,starty:30,line:"THE WAR BEGAN. ", delayNext:1000},
		{startx:30,starty:30,line:" ", delayNext:10},
		{startx:250,starty:20,line:"ENCYCLOPEDIA GALACTICA ", delayNext:1000}
		
	]
	
},
//3
{	
	callback:function(_this){
		
		
			continueBtn=_this.game.add.sprite(580, 300, "font");
			continueBtn.tint=0x00ff00;
			continueAnim=continueBtn.animations.add('continueAnim', [60,0] , 2, true, true);
			continueAnim.play();
			
			continueBtn.alpha=0;
			continueBtn_TWEEN=_this.game.add.tween(continueBtn)
            			.to({ alpha:1}, 1000, Phaser.Easing.Linear.None, false, 0, 0, false)
						.start();
			INTRO_LETTER_GROUP.add(continueBtn);
			continueBtn.inputEnabled = true;
			continueBtn.events.onInputDown.add(function(){
				_this.clearLetters(); 
				_this.writeText(1,0,0,true);}, _this); 
			
			
			},
	sizey:44,
	sizex:32,
	size:0.25,
	text:[
		{startx:50,starty:250,line:"TRANTOR, CENTER OF THE GALAXY ", delayNext:100},
		{startx:50,starty:250,line:"LIFE, ORGANIC CARBON BASED", delayNext:100},
		{startx:50,starty:250,line:"MASS, 0.69471M", delayNext:100},
		{startx:50,starty:250,line:"DIAMETER, 12.618KM", delayNext:100},
		{startx:50,starty:250,line:"GRAVITY, 0.71G", delayNext:100},
		{startx:50,starty:250,line:"TEMPERATURE, 291.7K", delayNext:100},
		{startx:50,starty:250,line:"POPULATION, 1.2434.332", delayNext:100},
	]
}
,
//4
{	
	callback:function(_this){ },
	sizey:44,
	sizex:32,
	size:0.25,
	text:[
		{startx:50,starty:270,line:"LEVYNIUM MINERAL", delayNext:100},
		{startx:50,starty:270,line:"ORIGIN, TRANTOR", delayNext:100},
		{startx:50,starty:270,line:"ENERGY, 4.000.000.000 MMJ/MG", delayNext:100},
		{startx:50,starty:270,line:"RADIOACTIVITY, NONE", delayNext:100},
		{startx:50,starty:270,line:"WASTE, NONE", delayNext:100}
		
	]
	
},
//5
{	
	callback:function(_this){ },
	sizey:44,
	sizex:32,
	size:0.5,
	text:[
		{startx:120,starty:210,line:"REBELS FROM HIDDEN WORLDS ", delayNext:1000},
		{startx:120,starty:210,line:"     COOMING SOON... ", delayNext:100}
		
	]
	
},
//6
{	
	callback:function(_this){ },
	sizey:44,
	sizex:32,
	size:0.5,
	text:[
		{startx:30,starty:30,line:"****  COMMODORE 64 BASIC V300  ****", delayNext:0},
		{startx:30,starty:30,line:" ", delayNext:0},
		{startx:30,starty:30,line:"6TB RAM SYSTEM 3TB BASIC BYTES FREE", delayNext:0},
		{startx:30,starty:30,line:" ", delayNext:0},
		{startx:30,starty:30,line:"READY. ", delayNext:0},
		{startx:30,starty:30,line:" ", delayNext:3000},
		{startx:30,starty:30,line:"LOAD 'RHW',8,1 ", delayNext:0},
		{startx:30,starty:30,line:" ", delayNext:0},
		{startx:30,starty:30,line:"SEARCHING FOR RHW ", delayNext:0},
		{startx:30,starty:30,line:"LOADING ", delayNext:4000},
		{startx:30,starty:30,line:"READY. ", delayNext:0},
		{startx:30,starty:30,line:"RUN ", delayNext:0},
	]
	
}



]


EnemiesObj=[

{type:"enemy1",frames:5,health:1,velocity:0.0012625,play:4,phaserRate:1100},
{type:"enemy2",frames:5,health:1,velocity:0.0014625,play:4,phaserRate:500},
{type:"enemy3",frames:5,health:1,velocity:0.0009625,play:5,phaserRate:2000},
{type:"enemy4",frames:5,health:1,velocity:0.0010625,play:5,phaserRate:1700},
{type:"enemy5",frames:5,health:1,velocity:0.0011625,play:5,phaserRate:1400},
{type:"enemy6",frames:5,health:1,velocity:0.0013625,play:5,phaserRate:800}
]

EnemiesOrbit=[
		{
            'x': [ -35,81,183,322,441,529,584,609,591,519,406,264,155,90,81,109,176,262,398,494,538,533,481,385,283,166,73,-28 ],
            'y': [ 102,85,68,59,66,105,177,266,363,431,459,457,421,343,257,189,136,116,120,170,237,316,365,393,395,383,361,330 ]
        },
		{
            'x': [ 207,72,16,85,324,562,624,566,400 ],
 			'y': [ -25,222,360,453,476,454,358,212,-22 ]
        },
		
		{
            'x': [681,267,80,95,285,501,592,534,245  ],
            'y': [ 134,115,217,392,461,420,304,165,-17 ]
        },
		{
			"x":[677,321,81,48,285,501,592,534,388,210,140,257,473,673],
			"y":[46,33,105,341,461,420,304,165,122,130,258,366,367,333]	
			
			},
			{
			"x":[52,128,217,426,512,683],"y":[516,286,107,156,35,329]	
			
			},
			{
			"x":[-51,128,215,384,512,610,606.5,495.5,369.5,250.5,133.5,38.5],"y":[419,247,57,141,32,124,365,471,376,363,423,531]
			
			},
			{
			"x":[53,80,198,160,231,424,509.5,477.5,550.5,608.5,589.5,461.5,422.5],"y":[525,93,59,253,385,387,300,99,77,250,394,461,521]
			
			},
			{
			"x":[387,96,142,328,536,603,521.5,480.5,327.5,194.5,124.5,72.5,119.5],"y":[518,260,124,143,132,235,321,436,386,421,393,449,543]
			
			},
			{
			"x":[318,161,260,425,478,566,534.5,387.5,226.5,93.5,33.5,84.5,252.5,422.5,574.5,669.5],"y":[542,339,90,131,236,305,400,406,462,409,317,186,129,170,169,325]
			
			}
];
  
var GAMESTATE;
var GAMESTATE_MAINMENU = 'GAMESTATE_MAINMENU';
var GAMESTATE_STORY = 'GAMESTATE_STORY';
var GAMESTATE_PLANET_SELECTION= 'GAMESTATE_PLANET_SELECTION';
var GAMESTATE_NOTSTARTED = 'GAMESTATE_NOTSTARTED';
var GAMESTATE_PLAYING = 'GAMESTATE_PLAYING';
var GAMESTATE_GAMEOVER = 'GAMESTATE_GAMEOVER';

var GAME_GROUP;
var ENEMY_WAVE_GROUP;
var MISSILE_GROUP;
var PHASER_GROUP;
var PLANET;
var SHIELD;
var SHIELD_ANIM;
var PLANET_SHIELD_ENERGY=100;
var PLANET_SHIELD_ALPHA=0.2;
var PLANET_ENERGY=100;
var BG;
var BGINTRO;
var BGGREENINTRO;
var BG_TWEEN;
var GAMEOVER=false;
var INTRO_LETTER_GROUP;
var INTRO_OBJECTS_GROUP;
var INTRO_MENU_GROUP;
var CURSOR;
var INTRO_STARS_GROUP;


var bmd;
rhwonsale.Main=function(game){};
rhwonsale.Main.prototype=
{
		create:function(){
			
						GAMESTATE = GAMESTATE_STORY;
						//	GAMESTATE = GAMESTATE_PLAYING
						this.game.physics.startSystem(Phaser.Physics.ARCADE);
			
			
			
			//++++++++++++++++++++++++++++
			// GAME SETUP
			//++++++++++++++++++++++++++++
						BGINTRO=this.game.add.tileSprite(0, 0,1200,480, "bg1");
						
						
						
						PLANET=this.game.add.sprite(this.game.width/2, this.game.height/2, 'planet');
						PLANET.anchor.setTo(0.5, 0.52);
						this.game.physics.enable(PLANET, Phaser.Physics.ARCADE);
						PLANET.alpha=0;
						
						SHIELD = this.game.add.sprite(this.game.width/2, this.game.height/2, 'shield');
						SHIELD.anchor.setTo(0.5, 0.5);
						SHIELD.alpha=0;
						
						SHIELD_ANIM = SHIELD.animations.add('shieldanim', [0,1,2,3,4,5,6,7], 20, true, true);
						SHIELD_ANIM.play();
						
						MISSILE_GROUP = this.game.add.group();
						
						
						
						INTRO_STARS_GROUP= this.game.add.group();
						INTRO_STARS_GROUP.enableBody = true;
    					INTRO_STARS_GROUP.physicsBodyType = Phaser.Physics.ARCADE;
						
						
						PHASER_GROUP= this.game.add.group();
						PHASER_GROUP.enableBody = true;
						PHASER_GROUP.physicsBodyType = Phaser.Physics.ARCADE;
						PHASER_GROUP.createMultiple(100, 'phaser');
						PHASER_GROUP.setAll('anchor.x', 0.5);
						PHASER_GROUP.setAll('anchor.y', 0.5);
						PHASER_GROUP.setAll('outOfBoundsKill', true);
						PHASER_GROUP.setAll('checkWorldBounds', true);
						
						ENEMY_WAVE_GROUP= this.game.add.group();
			
				//this.launchEnemyWave()
				
				
				CURSOR=this.game.add.sprite(0,0,'font');
				CURSOR.tint=0x00ff00;
				CURSORAnim=CURSOR.animations.add('cursoranim', [63,0] , 2, true, true);
				CURSORAnim.play();
				
				
				this.makeStars(0,7,0,480);
				INTRO_OBJECTS_GROUP = this.game.add.group();
				BGGREENINTRO=this.game.add.tileSprite(0, 0,640,480, "green");
				BGGREENINTRO.alpha=0.7;
				INTRO_LETTER_GROUP = this.game.add.group();
				
				//this.writeText(6,0,0,true);
				this.writeText(0,0,0,true);
				INTRO_MENU_GROUP = this.game.add.group();
				
				BGMONITORINTRO=this.game.add.sprite(0, 0,"monitor");
				
				
				
				
			},
			
		makeStars:function(_index,_max,_startY,_endY){
			
			if(_index==_max) return;
			
			 var star = INTRO_STARS_GROUP.getFirstDead();
	
					if (star  === null) {
						
					  
						 star = INTRO_STARS_GROUP.create(640,this.game.rnd.integerInRange(_startY, _endY),this.game.cache.getBitmapData('star'))
							
							star.checkWorldBounds = true;
						    star.events.onOutOfBounds.add(this.starOut, this);
							star.body.velocity.x = (50 + (Math.random() * 200))*-1;		
							
							INTRO_STARS_GROUP.add(star);
							_index++;
							this.game.time.events.add(this.game.rnd.integerInRange(0, 1000), function(){ this.makeStars(_index, _max, _startY, _endY)}, this);
						
						
							}
		
			
			},	
			
		starOut:function(star){
		
    			star.reset(640, this.game.rnd.integerInRange(0, 480));
				star.body.velocity.x = (50 + (Math.random() * 200))*-1;	
			
			},
			
			
		endIntro:function(){
			
			 bgWhite = INTRO_MENU_GROUP.create(0,0,this.game.cache.getBitmapData('bgWhite'))
			 bgWhite.alpha=0;
			 bgWhite.z=100;
			 bgWhite_TWEEN=this.game.add.tween(bgWhite)
            			.to({ alpha:1}, 500, Phaser.Easing.Linear.None, false, 0, 0, false)
						.start();
						
						bgWhite_TWEEN.onComplete.add(function(){
							
							     INTRO_MENU_GROUP.add(bgWhite);
								 INTRO_LETTER_GROUP.forEachAlive(function(e) { e.kill(); })
								 INTRO_OBJECTS_GROUP.forEachAlive(function(e) { e.kill(); })
								 INTRO_STARS_GROUP.forEachAlive(function(e) { e.kill(); })
								// CURSOR.kill();
								CURSOR.alpha=0;
								 //BGINTRO.destroy();
								 BGINTRO.alpha=0;
								 //GAMESTATE=GAMESTATE_MAINMENU;
								  bgWhite_TWEEN2=this.game.add.tween(bgWhite)
								 .to({ alpha:0}, 1500, Phaser.Easing.Linear.None, false, 0, 0, false)
								 .start();
								 bgWhite_TWEEN2.onComplete.add(function(){
									 CURSOR.alpha=1;
									 this.writeText(5,0,0,true);
									  
									 },this);
								 
								
							
							},this);
						
						
			 
			  /*bgWhite_TWEEN2=this.game.add.tween(bgWhite)
            			.to({ alpha:0}, 2000, Phaser.Easing.Linear.None, false, 1500, 0, false)
						.start();
						*/
			 
			
			
			},	
			
		writeText:function(_index,_line,_column,_cursor){
			
		if(_cursor){
						CURSOR.x=0+(_column*(TextWriter[_index].sizex*TextWriter[_index].size))+TextWriter[_index].text[_line].startx;
						CURSOR.y=0+(_line*(TextWriter[_index].sizey*TextWriter[_index].size))+TextWriter[_index].text[_line].starty;
						CURSOR.scale.set(TextWriter[_index].size);
		}
						letter=this.game.add.sprite((_column*(TextWriter[_index].sizex*TextWriter[_index].size))+TextWriter[_index].text[_line].startx, (_line*(TextWriter[_index].sizey*TextWriter[_index].size))+TextWriter[_index].text[_line].starty, 'font');
						
						INTRO_LETTER_GROUP.add(letter);
						
						letter.scale.set(TextWriter[_index].size);
						letter.tint=0x00ff00;
						
						var randomChars=[];
						if(TextWriter[_index].text[_line].line.charCodeAt(_column)==32){
							
							randomChars=[0,0,0,0,0,0];
							
							}else{
								
								randomChars=[this.game.rnd.integerInRange(33, 58),this.game.rnd.integerInRange(33, 58),this.game.rnd.integerInRange(33, 58),this.game.rnd.integerInRange(33, 58),this.game.rnd.integerInRange(33, 58),this.game.rnd.integerInRange(33, 58),this.game.rnd.integerInRange(33, 58),TextWriter[_index].text[_line].line.charCodeAt(_column)-32]
								}
						
						letterAnim=letter.animations.add('letteranim', randomChars , 20, false, true);
						letter.alpha=0;						
						letterAnim.play();
						
						
						this.game.add.tween(letter)
            			.to({ alpha:1}, 200,  Phaser.Easing.Linear.None, false, 0, 0, false)
            			.start();
						  
							if(_column<TextWriter[_index].text[_line].line.length-1){
								_column++;
								 this.game.time.events.add(this.game.rnd.integerInRange(10, 50), function(){ this.writeText(_index,_line,_column,_cursor)}, this);
						
							}else{
								
								if(TextWriter[_index].text[_line].callback!=undefined){ TextWriter[_index].text[_line].callback(this); }
								
								
								if(_line<TextWriter[_index].text.length-1){
									
									
								_column=0;
								_line++;
								prevLine=_line-1;
								 this.game.time.events.add(TextWriter[_index].text[prevLine].delayNext, function(){ this.writeText(_index,_line,_column,_cursor)}, this);
								}
								else{
									
									 this.game.time.events.add(TextWriter[_index].text[_line].delayNext, function(){ TextWriter[_index].callback(this); }, this);
									
									}
								
								}
								
				
			},
			
		clearLetters:function(){
			
			 INTRO_LETTER_GROUP.forEachAlive(function(e) { e.kill(); })
			  INTRO_OBJECTS_GROUP.forEachAlive(function(e) { e.kill(); })
				
			
			},	
			
		launchEnemyWave:function(){
			
			
						for(var enem=0; enem<5; enem++){
							
							this.launchEnemy(this.game);
							
						}
			
			},	
		
		
		GAMESTATE_MAINMENU_SETUP:function(){},
		GAMESTATE_STORY_SETUP:function(){},
		GAMESTATE_PLANET_SELECTION_SETUP:function(){},
		GAMESTATE_NOTSTARTED_SETUP:function(){},
		GAMESTATE_PLAYINGSETUP:function(){},
		GAMESTATE_PLAYING_SETUP:function(){},
		
		update:function(){
			
			
						switch (GAMESTATE){
							
						case GAMESTATE_MAINMENU:
						
						break;
						
						case GAMESTATE_STORY:
						
						BGINTRO.tilePosition.x-= 0.25;
						BGGREENINTRO.tilePosition.y-=1;
						
						break;
						
						case GAMESTATE_PLANET_SELECTION:
						
						break;
						
						case GAMESTATE_NOTSTARTED:
						
						break;
						
						case GAMESTATE_PLAYING:
						
						
						if(PLANET_ENERGY==0 && !GAMEOVER) {
							GAMEOVER=!GAMEOVER;
							PLANET.alpha=0;
							SHIELD.alpha=0;
							explosion = this.game.add.sprite(this.game.width/2,this.game.height/2, 'explosion3');
							explosion.anchor.setTo(0.5, 0.5);
							explosion.alpha=0.8;
							anim = explosion.animations.add('explosionPlanet', [0,1,2,3,4,5,6,7,8,9,10,11], 20, false,true);
							//anim.onComplete.add(function(sprite,animation){sprite.kill()}, this);
							anim.play(20,false,true);
							}
			
			
							 ENEMY_WAVE_GROUP.forEachAlive(function(e) {      
							 
							 var distance = this.game.math.distance(e.x, e.y,(this.game.width/2), (this.game.height/2));
							 
							 if (distance < 200) {  
							 
							  if (this.game.time.now > e.firingTimer)
										{
											if(PLANET_ENERGY>0 || PLANET_SHIELD_ENERGY>0) e.firePhaser();
										}
						}
							 
							 if (distance > 300) {  
							 
							 if (this.game.time.now > e.firingMissileTimer) {if(PLANET_ENERGY>0 || PLANET_SHIELD_ENERGY>0) e.fireMissile(); 
							 
							 }
							 
							 }
							 
							 },this);
						
							
							
							 MISSILE_GROUP.forEachAlive(function(m) {
								var distance = this.game.math.distance(m.x, m.y,this.game.width/2, this.game.height/2);
								
								if (distance < 40) { 
							
							/*BG.y = 0;
							this.game.add.tween(BG)
							.to({ y: this.game.rnd.integerInRange(-5, 0),x: this.game.rnd.integerInRange(0, 5) }, 40, Phaser.Easing.Sinusoidal.InOut, false, 0, 5, true)
							.start();
							*/
								
								m.kill();
								
								if(PLANET_SHIELD_ENERGY>0){
								 
								 PLANET_SHIELD_ENERGY-=this.game.rnd.integerInRange(5,10);
								 if(PLANET_SHIELD_ENERGY<0)PLANET_SHIELD_ENERGY=0;
								 }else{
								 PLANET_ENERGY-=this.game.rnd.integerInRange(10,15)	 
									 if(PLANET_ENERGY<0)PLANET_ENERGY=0;
									 }
								
								 
								this.getExplosion(m.x, m.y); 
								}
								}, this);
								
								
								
								this.game.physics.arcade.overlap(PHASER_GROUP, PLANET, this.PHASER_HIT_PLANET, null, this);
								//this.game.physics.arcade.overlap(MISSILE_GROUP, PLANET, this.MISSILE_HIT_PLANET, null, this);
										
						
						
						
						break;
						
						case GAMESTATE_GAMEOVER:
						
						break;
						
						}
			
			},
			
		resize:function(){},
		
		getExplosion:function(x,y){
			
			explosion = this.game.add.sprite(x,y, 'explosion1');
    		explosion.anchor.setTo(0.5, 0.5);
			explosion.alpha=0.8;
			anim = explosion.animations.add('explosion', [0,1,2,3,4,5,6,7,8,9], 20, false,true);
			anim.onComplete.add(function(sprite,animation){sprite.kill()}, this);
			anim.play();
			
			this.game.add.tween(SHIELD)
            .to({ alpha:0.5}, 100, Phaser.Easing.Sinusoidal.InOut, false, 0, 1, false)
			.to({ alpha:0.2}, 100, Phaser.Easing.Sinusoidal.InOut, false, 0, 1, false)
            .start();
			
			},
		
		PHASER_HIT_PLANET:function(PLANET,bullet){
			
			 bullet.kill();
			 
			 if(PLANET_SHIELD_ENERGY>0){
				 
				 PLANET_SHIELD_ENERGY-=this.game.rnd.integerInRange(1,4)
				 	if(PLANET_SHIELD_ENERGY<0)PLANET_SHIELD_ENERGY=0;
				 }else{
				 PLANET_ENERGY-=this.game.rnd.integerInRange(5,10)	 
					if(PLANET_ENERGY<0)PLANET_ENERGY=0;
					 }
			 
			 this.game.add.tween(SHIELD)
            .to({ alpha:0.5}, 20, Phaser.Easing.Sinusoidal.InOut, false, 0, 1, false)
			.to({ alpha:0.2}, 20, Phaser.Easing.Sinusoidal.InOut, false, 0, 1, false)
            .start();
			
			},
			
		MISSILE_HIT_PLANET:function(PLANET,bullet){
			
			 
			
			},
		
		launchEnemy:function(_game) {
			
				
					var enemy = ENEMY_WAVE_GROUP.getFirstDead();
				
					if (enemy === null) {
						
						enemy = new Enemy(0,_game);
						ENEMY_WAVE_GROUP.add(enemy);
					}
				
				
					enemy.revive();
					return enemy;
				
				}
		
		}

//-----------------------------------------------------------------------
//ENEMY LOGIC
//-----------------------------------------------------------------------


var Enemy = function (index, game) {
	
	var _enemy=EnemiesObj[game.rnd.integerInRange(0, EnemiesObj.length-1)];

	Phaser.Sprite.call(this, game, 0, 0, _enemy.type, _enemy.frames);
	
	anim = this.animations.add('shipanim', [0,1,2,3,4,3,2,1], _enemy.play, true, true);
	anim.play();
	
    this.health = _enemy.health;
    this.alive = true;
	this.points=[];
	this.path = [];
	this.pi=0;
	this.phaserRate=_enemy.phaserRate;
    this.anchor.set(0.5);
	this.firingTimer=0;
	this.firingMissileTimer=0;
	this.calculatePath();
	this.velocity=_enemy.velocity;
	this.x = this.path[0].x;
    this.y = this.path[0].y;
	
};

Enemy.prototype = Object.create(Phaser.Sprite.prototype);
Enemy.prototype.constructor = Enemy;

Enemy.prototype.damage = function() {}

Enemy.prototype.calculatePath = function() { 
			
			this.path=[];
			this.points=JSON.parse(JSON.stringify( EnemiesOrbit[this.game.rnd.integerInRange(0, EnemiesOrbit.length-1)] ) );
			
            var ix = 0;
            var x = 1 / this.game.width;
			
			x=this.velocity;
			
			
			for (var _p=0; _p<this.points.x.length; _p++){
				
				this.points.x[_p]=((this.points.x[_p]*this.game.width)/640)+this.game.rnd.integerInRange(-10, 10) ;
				this.points.y[_p]=((this.points.y[_p]*this.game.height)/480)+this.game.rnd.integerInRange(-10, 10);
				
				}
			
			

            for (var i = 0; i <= 1; i += x)
            {
               
				var px = this.game.math.catmullRomInterpolation(this.points.x, i);
                var py = this.game.math.catmullRomInterpolation(this.points.y, i);
               

                var node = { x: px, y: py, angle: 0 };

                if (ix > 0)
                {
                    node.angle = this.game.math.angleBetweenPoints(this.path[ix - 1], node);
                }

                this.path.push(node);

                ix++;

              //  bmd.rect(px, py, 1, 1, 'rgba(255, 255, 255, 1)');
            }

            
		  /* for (var p = 0; p < this.points.x.length; p++)
            {
                bmd.rect(this.points.x[p]-3, this.points.y[p]-3, 6, 6, 'rgba(255, 0, 0, 1)');
            }
			*/
			
			
			};

Enemy.prototype.update = function() {
	
if (this.pi >= this.path.length && PLANET_ENERGY==0) {this.kill(); return;}
	
			this.x = this.path[this.pi].x;
            this.y = this.path[this.pi].y;
            this.rotation = this.path[this.pi].angle+91;

            this.pi++;

            if (this.pi >= this.path.length)
            {
                //this.enemy.destroy();
				if(PLANET_ENERGY>0){
					
				this.calculatePath();
				this.pi = 0;
				}
            }
		
	
	};
	
	
Enemy.prototype.firePhaser=function(){ 

//console.log("fire phaser!")

 		enemyBullet = PHASER_GROUP.getFirstExists(false);
        enemyBullet.reset(this.x, this.y);
		this.game.physics.arcade.moveToObject(enemyBullet,PLANET,400);
        this.firingTimer = this.game.time.now + this.phaserRate;
   
};

/*

Enemy.prototype.fireMissile=function(){ 
console.log("fire missile!")

		enemyBullet = MISSILE_GROUP.getFirstExists(false);
        this.launchMissile(this.x,this.y)
		this.firingMissileTimer = this.game.time.now + 4000;
		

};
*/
	
Enemy.prototype.fireMissile = function() {
    // // Get the first dead missile from the missileGroup
    var missile = MISSILE_GROUP.getFirstDead();
	console.log("fire m")
    // If there aren't any available, create a new one
    if (missile === null) {
        missile = new Missile(this.game);
        MISSILE_GROUP.add(missile);
    }

    // Revive the missile (set it's alive property to true)
    // You can also define a onRevived event handler in your explosion objects
    // to do stuff when they are revived.
    missile.revive();

    // Move the missile to the given coordinates
    missile.x = this.x;
    missile.y = this.y;

	this.firingMissileTimer = this.game.time.now + 4000;
    return missile;
};






var Missile = function(game, x, y) {
    Phaser.Sprite.call(this, game, x, y, 'rocket');
	//console.log("new m")
    // Set the pivot point for this sprite to the center
    this.anchor.setTo(0.1, 0.45);

    // Enable physics on the missile
    this.game.physics.enable(this, Phaser.Physics.ARCADE);

    // Define constants that affect motion
    this.SPEED = 70; // missile speed pixels/second
    this.TURN_RATE = 5; // turn rate in degrees/frame
    this.WOBBLE_LIMIT = 15; // degrees
    this.WOBBLE_SPEED = 500; // milliseconds
    this.SMOKE_LIFETIME = 1500; // milliseconds
    this.AVOID_DISTANCE = 20; // pixels

    // Create a variable called wobble that tweens back and forth between
    // -this.WOBBLE_LIMIT and +this.WOBBLE_LIMIT forever
    this.wobble = this.WOBBLE_LIMIT;
    this.game.add.tween(this)
        .to(
            { wobble: -this.WOBBLE_LIMIT },
            this.WOBBLE_SPEED, Phaser.Easing.Sinusoidal.InOut, true, 0,
            Number.POSITIVE_INFINITY, true
        );

    // Add a smoke emitter with 100 particles positioned relative to the
    // bottom center of this missile
    this.smokeEmitter = this.game.add.emitter(0, 0, 0);

    // Set motion parameters for the emitted particles
    this.smokeEmitter.gravity = 0;
    this.smokeEmitter.setXSpeed(0, 0);
    this.smokeEmitter.setYSpeed(-20, 0); // make smoke drift upwards

    // Make particles fade out after 1000ms
    this.smokeEmitter.setAlpha(0.7, 0, this.SMOKE_LIFETIME, Phaser.Easing.Linear.InOut);

    // Create the actual particles
    this.smokeEmitter.makeParticles('smoke');

    // Start emitting smoke particles one at a time (explode=false) with a
    // lifespan of this.SMOKE_LIFETIME at 50ms intervals
    this.smokeEmitter.start(false, this.SMOKE_LIFETIME, 50);
};

// Missiles are a type of Phaser.Sprite
Missile.prototype = Object.create(Phaser.Sprite.prototype);
Missile.prototype.constructor = Missile;

Missile.prototype.update = function() {
    // If this missile is dead, don't do any of these calculations
    // Also, turn off the smoke emitter
    if (!this.alive) {
        this.smokeEmitter.on = false;
        return;
    } else {
        this.smokeEmitter.on = true;
    }

    // Position the smoke emitter at the center of the missile
    this.smokeEmitter.x = this.x;
    this.smokeEmitter.y = this.y;

    // Calculate the angle from the missile to the mouse cursor game.input.x
    // and game.input.y are the mouse position; substitute with whatever
    // target coordinates you need.
    var targetAngle = this.game.math.angleBetween(this.x, this.y,this.game.width/2,this.game.height/2);

    // Add our "wobble" factor to the targetAngle to make the missile wobble
    // Remember that this.wobble is tweening (above)
    targetAngle += this.game.math.degToRad(this.wobble);


    // Make each missile steer away from other missiles.
    // Each missile knows the group that it belongs to (missileGroup).
    // It can calculate its distance from all other missiles in the group and
    // steer away from any that are too close. This avoidance behavior prevents
    // all of the missiles from bunching up too tightly and following the
    // same track.
    var avoidAngle = 0;
    this.parent.forEachAlive(function(m) {
        // Don't calculate anything if the other missile is me
        if (this == m) return;

        // Already found an avoidAngle so skip the rest
        if (avoidAngle !== 0) return;

        // Calculate the distance between me and the other missile
        var distance = this.game.math.distance(this.x, this.y, m.x, m.y);

        // If the missile is too close...
        if (distance < this.AVOID_DISTANCE) {
            // Chose an avoidance angle of 90 or -90 (in radians)
            avoidAngle = Math.PI/2; // zig
            if (this.game.math.chanceRoll(50)) avoidAngle *= -1; // zag
        }
    }, this);

    // Add the avoidance angle to steer clear of other missiles
    targetAngle += avoidAngle;

    // Gradually (this.TURN_RATE) aim the missile towards the target angle
    if (this.rotation !== targetAngle) {
        // Calculate difference between the current angle and targetAngle
        var delta = targetAngle - this.rotation;

        // Keep it in range from -180 to 180 to make the most efficient turns.
        if (delta > Math.PI) delta -= Math.PI * 2;
        if (delta < -Math.PI) delta += Math.PI * 2;

        if (delta > 0) {
            // Turn clockwise
            this.angle += this.TURN_RATE;
        } else {
            // Turn counter-clockwise
            this.angle -= this.TURN_RATE;
        }

        // Just set angle to target angle if they are close
        if (Math.abs(delta) < this.game.math.degToRad(this.TURN_RATE)) {
            this.rotation = targetAngle;
        }
    }

    // Calculate velocity vector based on this.rotation and this.SPEED
    this.body.velocity.x = Math.cos(this.rotation) * this.SPEED;
    this.body.velocity.y = Math.sin(this.rotation) * this.SPEED;
};
	
/*

			rhwgame = new Phaser.Game(640, 480, Phaser.AUTO, 'RHW');
			rhwgame.state.add('Boot',rhwonsale.Boot);
			rhwgame.state.add('Preload',rhwonsale.Preload);
			rhwgame.state.add('Main',rhwonsale.Main);
			rhwgame.state.start('Boot');
*/			