//------------------------------------------------------------------------------------------------------------
//game pixel ninja
//------------------------------------------------------------------------------------------------------------
	var _pn_good_objects=undefined;
	var _pn_bad_objects=undefined;
	var _pn_slashes;
	var _pn_line;
	var _GamePixelNinja;
	var _pn_points = [];
	var _pn_fireRate = 1000;
	var _pn_nextFire = 0;
	var _pn_contactPoint = new Phaser.Point(0,0);
	var _pn_isSlash=false;
	var _pn_isPlaying=false;
	var _pn_logoGroup, _pn_logo_pixel,_pn_logo_ninja,_pn_logoTween;
	var _pn_gameOverGroup, _pn_gameOverG,_pn_gameOverA,_pn_gameOverM,_pn_gameOverE,_pn_gameOverO,_pn_gameOverV,_pn_gameOverE2,_pn_gameOverR;
	var _pn_mainOptions;
	var _pn_missed=0;
	var _pn_infoGroup;
	var _pn_score=0;
	var _pn_recordGroup, _pn_record_close, _pn_record_del;
	var _pn_gameTimer;
	var _pn_gameTimerTotal=0;
	var _pn_raster, _pn_ninja, _pn_closeBtn, _pn_scoreBtn, _pn_infoBtn;
	

z89Header.GamePixelNinja=function(game){};
z89Header.GamePixelNinja.prototype =
{
	/*
	_pn_good_objects:undefined,
	_pn_bad_objects:undefined,
	_pn_slashes:undefined,
	_pn_line:undefined,
	_GamePixelNinja:undefined,
	_pn_points : [],
	_pn_fireRate : 1000,
	_pn_nextFire : 0,
	_pn_contactPoint : new Phaser.Point(0,0),
	_pn_isSlash:false,
	_pn_isPlaying:false,
	_pn_logoGroup:undefined, _pn_logo_pixel:undefined,_pn_logo_ninja:undefined,_pn_logoTween:undefined,
	_pn_gameOverGroup:undefined, _pn_gameOverG:undefined,_pn_gameOverA:undefined,_pn_gameOverM:undefined,_pn_gameOverE:undefined,_pn_gameOverO:undefined,_pn_gameOverV:undefined,_pn_gameOverE2:undefined,_pn_gameOverR:undefined,
	_pn_mainOptions:undefined,_pn_missed:0,
	_pn_infoGroup:undefined,
	_pn_score:0,
	_pn_recordGroup:undefined, _pn_record_close:undefined, _pn_record_del:undefined,
	_pn_gameTimer:undefined,_pn_gameTimerTotal:0,
	_pn_raster:undefined, _pn_ninja:undefined, _pn_closeBtn:undefined, _pn_scoreBtn:undefined, _pn_infoBtn:undefined,
	
	*/
	
	
	
    create: function () {

        _GamePixelNinja = this;

		_pn_raster = this.game.add.sprite(0, 0, 'pnRaster');
		_pn_ninja = this.game.add.sprite(0, 5, 'pnNinja');
		
		_pn_scoreBtn = this.game.add.sprite(0, 5, 'score');
		_pn_scoreBtn.inputEnabled = true;
        _pn_scoreBtn.events.onInputDown.add(this.displayScores, this);
		
		_pn_infoBtn = this.game.add.sprite(0, 40, 'info');
		_pn_infoBtn.inputEnabled = true;
        _pn_infoBtn.events.onInputDown.add(this.displayInfo, this);
		
		_pn_closeBtn = this.game.add.sprite(0, 5, 'close');
		_pn_closeBtn.inputEnabled = true;
        _pn_closeBtn.events.onInputDown.add(this.quitGame, this);


		_pn_recordGroup= this.game.add.group();
		
		_pn_record_screen = this.game.add.sprite(0, 0, 'pnScreen');
		_pn_recordGroup.add(_pn_record_screen);
		_pn_record_close = this.game.add.bitmapText(235, 20, 'carrier_command', 'skip', 12);
		_pn_record_close.inputEnabled = true;
		_pn_record_close.events.onInputDown.add(this.noSave, this);
		_pn_recordGroup.add(_pn_record_close)
		
		_pn_record_del = this.game.add.bitmapText(60, 100, 'carrier_command', 'del', 12);
		_pn_record_del.inputEnabled = true;
		_pn_record_del.events.onInputDown.add(this.delChar, this);
		_pn_recordGroup.add(_pn_record_del);
		
		_pn_record_save = this.game.add.bitmapText(195, 100, 'carrier_command', 'Save', 12);
		_pn_record_save.inputEnabled = true;
		_pn_record_save.events.onInputDown.add(this.saveRecord, this);
		_pn_recordGroup.add(_pn_record_save);
		
		
		var _x=0,_y=0;
		for (var k=0; k<keyboard.length; k++){
			if(k>12){_y=45;_x=k-13}else{_y=20}
			_pn_letter=this.game.add.bitmapText((20*_x)+35, _y+25, 'carrier_command', keyboard[k], 12);
			_pn_letter.inputEnabled = true;
        	_pn_letter.events.onInputDown.add(this.setChar, this);
			_pn_recordGroup.add(_pn_letter);
			_x+=1;
			
			}
		
		_pn_letter1=this.game.add.bitmapText(120, 95, 'carrier_command', "_" , 18);
		_pn_recordGroup.add(_pn_letter1);
		keyboardObj.push(_pn_letter1)
		_pn_letter2=this.game.add.bitmapText(140, 95, 'carrier_command', "_" , 18);
		_pn_recordGroup.add(_pn_letter2);
		keyboardObj.push(_pn_letter2)
		_pn_letter3=this.game.add.bitmapText(160, 95, 'carrier_command', "_" , 18);
		_pn_recordGroup.add(_pn_letter3);
		keyboardObj.push(_pn_letter3)
		
		_pn_recordGroup.y=-100;
		_pn_recordGroup.alpha=0;

		_pn_scoresGroup= this.game.add.group();
		
		
		_pn_screen = this.game.add.sprite(0, 0, 'pnScreen');
		
		//_pn_scoreX = this.game.add.bitmapText(200, 0, 'carrier_command', 'x', 12);
		_pn_scoreTitle = this.game.add.bitmapText(20, -5, 'carrier_command', 'highscores', 10);
		
		_pn_score1 = this.game.add.bitmapText(100, 20, 'carrier_command', '1', 12);
		highScoresObj.push(_pn_score1);
		_pn_score2 = this.game.add.bitmapText(100, 40, 'carrier_command', '2', 12);
		highScoresObj.push(_pn_score2);
		_pn_score3 = this.game.add.bitmapText(100, 60, 'carrier_command', '3', 12);
		highScoresObj.push(_pn_score3);
		_pn_score4 = this.game.add.bitmapText(100, 80, 'carrier_command', '4', 12);
		highScoresObj.push(_pn_score4);
		_pn_score5 = this.game.add.bitmapText(100, 100, 'carrier_command', '5', 12);
		highScoresObj.push(_pn_score5);
		
		_pn_scoresGroup.add(_pn_screen);
		//_pn_scoresGroup.add(_pn_scoreX);
		_pn_scoresGroup.add(_pn_scoreTitle);
		_pn_scoresGroup.add(_pn_score1);
		_pn_scoresGroup.add(_pn_score2);
		_pn_scoresGroup.add(_pn_score3);
		_pn_scoresGroup.add(_pn_score4);
		_pn_scoresGroup.add(_pn_score5);
		_pn_scoresGroup.y=-100;
		_pn_scoresGroup.alpha=0;
		
		_pn_screen.inputEnabled = true;
        _pn_screen.events.onInputDown.add(this.scoresOut, this);

		_pn_infoGroup= this.game.add.group();
		_pn_infoscreen = this.game.add.sprite(0, 0, 'pnScreen');
		_pn_infoTitle = this.game.add.bitmapText(20, -5, 'carrier_command', 'info', 10);
		_pn_infoLine1 = this.game.add.bitmapText(30, 30, 'carrier_command', 'Destroy all Blue blocks', 9);
		_pn_infoLine2 = this.game.add.bitmapText(30, 50, 'carrier_command', 'Avoid all Gray blocks', 9);
		_pn_infoLine3 = this.game.add.bitmapText(30, 70, 'carrier_command', 'Don\'t miss >2 Blue blocks', 9);
		_pn_infoGroup.add(_pn_infoscreen);
		_pn_infoGroup.add(_pn_infoLine1);
		_pn_infoGroup.add(_pn_infoLine2);
		_pn_infoGroup.add(_pn_infoLine3);
		_pn_infoGroup.add(_pn_infoTitle);
		
		_pn_infoGroup.y=-100;
		_pn_infoGroup.alpha=0;
		_pn_infoscreen.inputEnabled = true;
        _pn_infoscreen.events.onInputDown.add(this.infoOut, this);

        _pn_gameOverGroup = this.game.add.group();
        _pn_gameOverGroup.alpha = 0;
        _pn_gameOverG = this.game.add.bitmapText(0, 0, 'carrier_command', 'G', 30);
        _pn_gameOverA = this.game.add.bitmapText(35, 0, 'carrier_command', 'A', 30);
        _pn_gameOverM = this.game.add.bitmapText(70, 0, 'carrier_command', 'M', 30);
        _pn_gameOverE = this.game.add.bitmapText(105, 0, 'carrier_command', 'E', 30);
        _pn_gameOverO = this.game.add.bitmapText(140, 0, 'carrier_command', 'O', 30);
        _pn_gameOverV = this.game.add.bitmapText(175, 0, 'carrier_command', 'V', 30);
        _pn_gameOverE2 = this.game.add.bitmapText(210, 0, 'carrier_command', 'E', 30);
        _pn_gameOverR = this.game.add.bitmapText(245, 0, 'carrier_command', 'R', 30);

        _pn_gameOverGroup.add(_pn_gameOverG);
        _pn_gameOverGroup.add(_pn_gameOverA);
        _pn_gameOverGroup.add(_pn_gameOverM);
        _pn_gameOverGroup.add(_pn_gameOverE);
        _pn_gameOverGroup.add(_pn_gameOverO);
        _pn_gameOverGroup.add(_pn_gameOverV);
        _pn_gameOverGroup.add(_pn_gameOverE2);
        _pn_gameOverGroup.add(_pn_gameOverR);

        _pn_mainOptions = this.game.add.group();
		
		_menuPlay = this.game.add.bitmapText(0, 0, 'carrier_command', 'Play', 20);
        _menuPlay.inputEnabled = true;
        _menuPlay.events.onInputDown.add(this.playGame, this);
		
		_pn_mainOptions.add(_menuPlay);
       
		_pn_mainOptions.alpha=0;
		

        this.game.physics.startSystem(Phaser.Physics.ARCADE);
        this.game.physics.arcade.gravity.y = 250;

        _pn_good_objects = this.createGroup(4, this.game.cache.getBitmapData('good'));
        _pn_bad_objects = this.createGroup(4, this.game.cache.getBitmapData('bad'));
        _pn_slashes = this.game.add.graphics(0, 0);

        emitter = this.game.add.emitter(0, 0, 300);
        emitter.makeParticles(this.game.cache.getBitmapData('pixel'));
        emitter.gravity = 300;
        emitter.setYSpeed(-400, 400);

        bemitter = this.game.add.emitter(0, 0, 300);
        bemitter.makeParticles(this.game.cache.getBitmapData('pixelblack'));
        bemitter.gravity = 300;
        bemitter.setYSpeed(-400, 400);

        this.game.input.onDown.add(this.beginSlash, this);
        this.game.input.onUp.add(this.endSlash, this);

        _pn_line = new Phaser.Line(0, 0, 0, 0);


		_pn_logoGroup = this.game.add.group();
        _pn_logo_pixel = this.game.add.bitmapText(20, -30, 'carrier_command', 'PIXEL', 24);
        _pn_logo_pixel.tint = 0xffffff;

        _pn_logo_ninja = this.game.add.bitmapText(this.game.scale.width - 20, -30, 'carrier_command', 'NINJA', 24);
        _pn_logo_ninja.tint = 0xffffff;

        _pn_logoGroup.add(_pn_logo_pixel);
        _pn_logoGroup.add(_pn_logo_ninja);
        _pn_logoGroup.alpha = 0;

        _pn_logoTween = this.game.add.tween(_pn_logoGroup)
        _pn_logoTween.to({ y: 135, alpha: 1 }, 1000, "Bounce.easeOut", true, 0, 0);
        _pn_logoTween.onComplete.add(function () { _GamePixelNinja.menuIn()}, this);

        this.setPositions();
		
		//this.recordIn();
		
		loadHighscores("pixelninja");
		
		
    },
	
	setChar: function(_this){
		
		
		//console.log(_this.text)
		keyboardObj[keyboardCount].text=_this.text;
		keyboardCount+=1;
		if(keyboardCount==3) keyboardCount=2;
		
		
		},
		
	quitGame: function(){
		
		_pn_mainOptions.alpha=0;
		_pn_mainOptions.scale.set({x:0,y:0});
		_pn_logoGroup.alpha=0;
		
		_pn_closeBtn.alpha=0;
		_pn_infoBtn.alpha=0;
		_pn_scoreBtn.alpha=0;
		_pn_raster.alpha=0;
		_pn_ninja.alpha=0;
		
		
		startLoading();
		setTimeout(function(){ stopLoading();},1000);
		setTimeout(function(){ 
		
		$parallax.parallax('enable');
		$parallaxContainer.removeClass("game");
		
		z89Header.Main._Main.game.state.start('Main');
		z89HeaderStar.Main._Main.restartStars();
		
		},1200);
		
		},
		
	delChar: function(){
		
		
		//console.log(keyboardCount)
		keyboardObj[keyboardCount].text="_";
		keyboardCount-=1;
		if(keyboardCount<0) keyboardCount=0;
		
		},
	noSave:function(){
			this.recordOut();
	
		
		},	
	saveRecord: function(){
		
		saveScore("pixelninja");
		this.recordOut();
		
		
		},	
	
    playGame: function () { 
	
	console.log("playGame"); 
	
	this.menuOut(); 
	_pn_isPlaying = true; 
	
	_pn_gameTimer = this.game.time.create(false);
	_pn_gameTimer.loop(1000, function(){   _pn_gameTimerTotal++; }, this);
	_pn_gameTimer.start();
	
	
	},
    displayInfo: function () {  this.menuOut();this.infoIn(); },
    displayScores: function () {  this.menuOut();this.scoresIn();  },

    menuIn: function () {
		
		 if (_pn_isPlaying) return;
		
		_pn_mainOptions.setAll('inputEnabled', true);
        tweenmi = this.game.add.tween(_pn_mainOptions.scale).to({ x: 1, y: 1 }, 1000, "Bounce.easeOut", true, 0, 0);
        tweenmio = this.game.add.tween(_pn_mainOptions).to({ alpha: 1 }, 1000, "Bounce.easeOut", true, 0, 0);
		
		tween1=this.game.add.tween(_pn_closeBtn).to({ alpha: 1 }, 500, "Linear", true, 0, 0);
		tween2=this.game.add.tween(_pn_infoBtn).to({ alpha: 1 }, 500, "Linear", true, 0, 0);
		tween3=this.game.add.tween(_pn_scoreBtn).to({ alpha: 1 }, 500, "Linear", true, 0, 0);
		tween4=this.game.add.tween(_pn_logoGroup).to({ alpha: 1 }, 500, "Linear", true, 0, 0);
		tween5=this.game.add.tween(_pn_ninja).to({ alpha: 1 }, 500, "Linear", true, 0, 0);
		
		
		
    },

    menuOut: function () {

		_pn_mainOptions.setAll('inputEnabled', false);
        tweenmo = this.game.add.tween(_pn_mainOptions.scale).to({ x: 0.7, y: 0.7 }, 1000, "Bounce.easeOut", true, 0, 0);
        tweenmoo = this.game.add.tween(_pn_mainOptions).to({ alpha: 0 }, 1000, "Bounce.easeOut", true, 0, 0);
		
		tween1=this.game.add.tween(_pn_closeBtn).to({ alpha: 0 }, 500, "Linear", true, 0, 0);
		tween2=this.game.add.tween(_pn_infoBtn).to({ alpha: 0 }, 500, "Linear", true, 0, 0);
		tween3=this.game.add.tween(_pn_scoreBtn).to({ alpha: 0 }, 500, "Linear", true, 0, 0);
		tween4=this.game.add.tween(_pn_logoGroup).to({ alpha:0  }, 500, "Linear", true, 0, 0);
		tween5=this.game.add.tween(_pn_ninja).to({ alpha: 0 }, 500, "Linear", true, 0, 0);


    },
	
	infoIn: function () {
		if (_pn_isPlaying) return;
		_pn_infoGroup.alpha=1;
		
		 tweenmoo = this.game.add.tween(_pn_infoGroup).to({ y: 10 }, 1000, "Bounce.easeOut", true, 0, 0);
	   
    },

    infoOut: function () {

		tweenmoo = this.game.add.tween(_pn_infoGroup).to({ alpha: 0 }, 500, "Linear", true, 0, 0);
		tweenmoo.onComplete.add(function () { _GamePixelNinja.menuIn(); _pn_infoGroup.y=-100; }, this);
		
    },
	
	scoresIn: function () {
		if (_pn_isPlaying) return;
		_pn_scoresGroup.alpha=1;
		
		 tweenmoo = this.game.add.tween(_pn_scoresGroup).to({ y: 10 }, 1000, "Bounce.easeOut", true, 0, 0);
	   
    },

    scoresOut: function () {

		tweenmoo = this.game.add.tween(_pn_scoresGroup).to({ alpha: 0 }, 500, "Linear", true, 0, 0);
		tweenmoo.onComplete.add(function () { _GamePixelNinja.menuIn(); _pn_scoresGroup.y=-100; }, this);
		
    },

    gameOver: function () {
		
		_pn_missed=0;
		_pn_isPlaying=false;
		_pn_fireRate=1000;
		keyboardCount=0;
		_pn_gameTimer.destroy();
    	_pn_gameTimerTotal=0;
		
        _pn_gameOverGroup.x = this.game.scale.width / 2 - (_pn_gameOverGroup.width / 2);
        _pn_gameOverGroup.y = this.game.scale.height / 2 - (_pn_gameOverGroup.height / 2)+10;
        _pn_gameOverGroup.alpha = 1;
        _pn_gameOverGroup.forEach(function (item) {
		
            item.y = 0;
            item.alpha = 1;
            item.scale.setTo(0, 0);
            tweens = this.game.add.tween(item.scale).to({ x: 1, y: 1 }, 500, "Bounce.easeOut", true, (250 * item.z) - 250, 0);
            tweensa = this.game.add.tween(item).to({ y: 90, alpha: 0 }, 500, "Cubic.easeIn", true, ((250 * item.z) - 250) + 2000, 0);
            if (item.z == 8) { tweensa.onComplete.add(function () { _GamePixelNinja.recordIn(); }, this); }

        }, this, false);

    },
	

		
	recordIn:function(){ 
	if (_pn_isPlaying) return;
	
	_pn_recordGroup.alpha=1;
	tweenmoo = this.game.add.tween(_pn_recordGroup).to({ y: 10 }, 1000, "Bounce.easeOut", true, 0, 0);
	
	},
	
	recordOut:function(){ 	
		
		tweenmooo = this.game.add.tween(_pn_recordGroup).to({ alpha: 0 }, 500, "Linear", true, 0, 0);
		tweenmooo.onComplete.add(function () { 
		
		_GamePixelNinja.menuIn(); 
		_pn_recordGroup.y=-100;
		_pn_recordGroup.alpha=0;
		
		keyboardObj[0].text="_";
		keyboardObj[1].text="_";
		keyboardObj[2].text="_";
		
		 }, this);
		
		
		},


    resize: function () {

        this.setPositions();

    },

    setPositions: function () {

		_pn_raster.width=this.game.scale.width;
		_pn_ninja.x=(this.game.scale.width / 2 - (_pn_ninja.width / 2));
		
        _pn_mainOptions.x = (this.game.scale.width / 2 - (_pn_mainOptions.width / 2)) ;
        _pn_mainOptions.y = (this.game.scale.height / 2 - (_pn_mainOptions.height / 2)) + 10;
		
        _pn_gameOverGroup.x = this.game.scale.width / 2 - (_pn_gameOverGroup.width / 2);
        _pn_gameOverGroup.y = this.game.scale.height / 2 - (_pn_gameOverGroup.height / 2);
		
		_pn_infoGroup.x = this.game.scale.width / 2 - (_pn_infoGroup.width / 2);
		_pn_scoresGroup.x = this.game.scale.width / 2 - (_pn_scoresGroup.width / 2);
		_pn_recordGroup.x = this.game.scale.width / 2 - (_pn_recordGroup.width / 2);
        //_pn_infoGroup.y = this.game.scale.height / 2 - (_pn_infoGroup.height / 2);
		


        if (this.game.scale.width <= 480) {


            _pn_logo_pixel.x = 20;
			_pn_infoBtn.x=20;
			_pn_scoreBtn.x=20;
            _pn_logo_ninja.x = (this.game.scale.width - 20) - _pn_logo_ninja.width;
			_pn_closeBtn.x=(this.game.scale.width - 20) - _pn_closeBtn.width;


        } else if (this.game.scale.width >= 480 && this.game.scale.width < 1200) {


            _pn_logo_pixel.x = 40;
			_pn_infoBtn.x=40;
			_pn_scoreBtn.x=40;
            _pn_logo_ninja.x = (this.game.scale.width - 40) - _pn_logo_ninja.width;
			
			_pn_closeBtn.x=(this.game.scale.width - 40) - _pn_closeBtn.width;

        }
        else if (this.game.scale.width >= 1200) {

			_pn_infoBtn.x=80;
            _pn_logo_pixel.x = 80;
			_pn_scoreBtn.x=80;
            _pn_logo_ninja.x = (this.game.scale.width) - (_pn_logo_ninja.width + 80);
			_pn_closeBtn.x=(this.game.scale.width) - (_pn_closeBtn.width+80);

        }

    },

    beginSlash: function () {

        _pn_isSlash = true;
        return;

    },

    endSlash: function () {

        _pn_isSlash = false;
        _pn_slashes.clear();
        _pn_points = [];


    },

    update: function () {

        // start is playing
        if (_pn_isPlaying) {
			
			
			//console.log(parseInt(_pn_fireRate/(1+(0.00001*_pn_gameTimerTotal))));
			_pn_fireRate=parseInt(_pn_fireRate/(1+(0.00001*_pn_gameTimerTotal)));
			
            this.throwObject();
            _pn_good_objects.forEachExists(function (obj) { 
			
			obj.rotation += obj.rot;
			
			if(obj.y<90 && obj.checkWorldBounds==false ){
		
				obj.events.onKilled.add(_GamePixelNinja.killed, this);
				obj.checkWorldBounds=true;
				obj.outOfBoundsKill=true;
				}
			
			 });
           
		    if (_pn_isSlash) {

                _pn_points.push({
                    x: this.game.input.x,
                    y: this.game.input.y
                });

                _pn_points = _pn_points.splice(_pn_points.length - 10, _pn_points.length);

                if (_pn_points.length < 1 || _pn_points[0].x == 0) { return; }

                _pn_slashes.clear();
                _pn_slashes.beginFill(0xFFFFFF);
                _pn_slashes.alpha = .5;
                _pn_slashes.moveTo(_pn_points[0].x, _pn_points[0].y);

                for (var i = 1; i < _pn_points.length; i++) {
                    _pn_slashes.lineTo(_pn_points[i].x, _pn_points[i].y);
                }

                _pn_slashes.endFill();

                for (var i = 1; i < _pn_points.length; i++) {
                    _pn_line = new Phaser.Line(_pn_points[i].x, _pn_points[i].y, _pn_points[i - 1].x, _pn_points[i - 1].y);

                    _pn_good_objects.forEachExists(this.checkIntersects);
                    _pn_bad_objects.forEachExists(this.checkIntersects);
                }

            }

        }
        // end is playing


    },

    createGroup: function (numItems, sprite) {
		//console.log(sprite)
        var group = this.game.add.group();
        group.enableBody = true;
        group.physicsBodyType = Phaser.Physics.ARCADE;
        group.createMultiple(numItems, sprite);
		if(sprite.key=="bad"){
			
        group.setAll('checkWorldBounds', true);
        group.setAll('outOfBoundsKill', true);
		}else{
			
		group.setAll('health', 1);
			}
        return group;
    },

    throwObject: function () {
		
		
		
        if (this.game.time.now > _pn_nextFire && _pn_good_objects.countDead() > 0 && _pn_bad_objects.countDead() > 0) {
            _pn_nextFire = this.game.time.now + _pn_fireRate;
           this.throwGoodObject();
            if (Math.random() > .5) {
                this.throwBadObject();
            }
        }
    },

    throwGoodObject: function () {
  
		var obj=_pn_good_objects.getFirstDead();

        if (this.game.rnd.integerInRange(0, 1)) {
            obj.rot = this.game.rnd.realInRange(0.05, 0.01);
        } else {
            obj.rot = this.game.rnd.realInRange(-0.05, -0.01);
        }
		obj.events.onKilled.remove(_GamePixelNinja.killed, this);
		obj.checkWorldBounds=false;
		obj.outOfBoundsKill=false;
		
        obj.reset(this.game.world.centerX + Math.random() * 100 - Math.random() * 100, 600);
        obj.anchor.setTo(0.5, 0.5);

        this.game.physics.arcade.moveToXY(obj, this.game.world.centerX, this.game.world.centerY, 530);
    },

	killed: function(_sprite){
		
			
		if(_pn_isPlaying &&  _sprite.parent == _pn_good_objects){
		
		
				_GamePixelNinja.incMissed();
			
			}
			
		},
		
	incMissed: function(){
		
		_pn_missed+=1;
			
			if(_pn_missed==3){ this.gameOver(); this.killAll();}
		
		
		},
		
	killAll: function(){
		
		  _pn_good_objects.forEachExists(function (obj) {  _GamePixelNinja.killSprite(obj,true); });
		  _pn_bad_objects.forEachExists(function (obj) {  _GamePixelNinja.killBomb(obj,true); });
		
		},	

    throwBadObject: function () {
        var obj = _pn_bad_objects.getFirstDead();
        obj.reset(this.game.world.centerX + Math.random() * 100 - Math.random() * 100, 600);
        obj.anchor.setTo(0.5, 0.5);
        this.game.physics.arcade.moveToXY(obj, this.game.world.centerX, this.game.world.centerY, 530);
    },


    checkIntersects: function (_sprite) {

        var l1 = new Phaser.Line(_sprite.body.right - _sprite.width, _sprite.body.bottom - _sprite.height, _sprite.body.right, _sprite.body.bottom);
        var l2 = new Phaser.Line(_sprite.body.right - _sprite.width, _sprite.body.bottom, _sprite.body.right, _sprite.body.bottom - _sprite.height);
        l2.angle = 90;


        if (Phaser.Line.intersects(_pn_line, l1, true) || Phaser.Line.intersects(_pn_line, l2, true)) {

            _pn_contactPoint.x = headerGame.input.x;
            _pn_contactPoint.y = headerGame.input.y;
            var distance = Phaser.Point.distance(_pn_contactPoint, new Phaser.Point(_sprite.x, _sprite.y));

            if (distance > 110) {
                return;
            }

            if (_sprite.parent == _pn_good_objects) {
				_sprite.events.onKilled.remove(_GamePixelNinja.killed, this);
                _GamePixelNinja.killSprite(_sprite);
				
            } else {
				_sprite.events.onKilled.remove(_GamePixelNinja.killed, this);
                _GamePixelNinja.killBomb(_sprite);
				
            }
        }

    },

    killSprite: function (_sprite,_noscore) {

        emitter.x = _sprite.x;
        emitter.y = _sprite.y;
        emitter.start(true, 2000, null, 32);
        _sprite.kill();
        _pn_points = [];
		if(_noscore==undefined){globalScore+=1;}

    },

    killBomb: function (_sprite,_noscore) {

        bemitter.x = _sprite.x;
        bemitter.y = _sprite.y;
        bemitter.start(true, 2000, null, 16);
        _sprite.kill();
        _pn_points = [];
		if(_noscore==undefined){globalScore-=1;_GamePixelNinja.incMissed();}

    },




    render: function () {

        //this.game.debug.lineInfo(line, 32, 32);
        //this.game.debug.geom(line);
    },

    musicONOFF: function () {
        if (musicON) {
            click.play();
            musicON = false;
            soundButton.frame = 1;
        }
        else {
            click.play();
            musicON = true;
            soundButton.frame = 0;
        }

    }
}
