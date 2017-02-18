// JavaScript Document
var $rhw,$mRes;
//console.log("197")
$(function(){



$.ajax({url: "http://www.zero89.it/core/core_games/rhwonsale/game.js",
								  dataType: "script",
								  success: function( data, textStatus, jqxhr ) {
									  								  
									  


$rhw=$("#RHW");
$mRes=$("#mRes");

setTimeout(function(){
	rhwgame = new Phaser.Game(640, 480, Phaser.AUTO, 'RHW');
			rhwgame.state.add('Boot',rhwonsale.Boot);
			rhwgame.state.add('Preload',rhwonsale.Preload);
			rhwgame.state.add('Main',rhwonsale.Main);
			rhwgame.state.start('Boot');
			enquireUpdate()
			
},1000);
									  
									  
									  
									  
									  }
								});
								
});

function enquireUpdate(){
enquire.register("screen and (max-width: 740px)", {
	setup : function() {
		
		console.log("setuop enquire")
	},

	match : function() {
		
		$rhw.hide(); $mRes.show();
	},

	unmatch : function() {
		$rhw.show(); $mRes.hide();
	},
	deferSetup : true
});
}