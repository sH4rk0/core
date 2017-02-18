// start slider
$(document).ready(function() {


Cufon.replace('.contentTitle');
Cufon.replace('h3');

var covers=$(".homeImages .cover").length;
 if(covers>0) initHomeCovers(covers)

if ($(".gallery a[rel^='prettyPhoto']").length>0) $(".gallery a[rel^='prettyPhoto']").prettyPhoto({theme:'light_square'});

})


function initHomeCovers(covers){

$(".contentItems").after("<div id='coverContainer'></div>")

var startCovers = new Array;
var endCovers = new Array;
        for (i=0; i<covers; i++){
        startCovers.push(i)
        } 
        
var ran;
for (i=0; i<covers; i++){
ran=Math.floor(Math.random() * startCovers.length);
endCovers.push(startCovers[ran])
startCovers.splice(ran,1);
}

for (i=0; i<endCovers.length; i++){ 
$(".homeImages .cover").eq(endCovers[i]).clone().appendTo("#coverContainer").css("opacity",0.5)
}

$(".contentItems a").remove()
$("#coverContainer").fadeIn();

$(".homeImages .cover").hover(function(){$(this).css("opacity",1)},function(){$(this).css("opacity",0.5)})
}



