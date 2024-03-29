/*!
 * Close Pixelate v2.0.00 beta
 * http://desandro.com/resources/close-pixelate/
 * 
 * Developed by
 * - David DeSandro  http://desandro.com
 * - John Schulz  http://twitter.com/jfsiii
 * 
 * Licensed under MIT license
 */

/*jshint asi: true, browser: true, eqeqeq: true, forin: false, immed: false, newcap: true, noempty: true, strict: true, undef: true */
var c64palette=["000000","ffffff","68372b","70A4B2","6f3d86","588d43","352879","b8c76f","6f4f25","433900","9a6759","444444","6c6c6c","9ad284","6c5eb5","959595"];

( function( window, undefined ) {

//
'use strict';

// util vars
var TWO_PI = Math.PI * 2
var QUARTER_PI = Math.PI * 0.25

// utility functions
function isArray( obj ) {
  return Object.prototype.toString.call( obj ) === "[object Array]"
}

function isObject( obj ) {
  return Object.prototype.toString.call( obj ) === "[object Object]"
}

var console = window.console

// check for canvas support
var canvas = document.createElement('canvas')
var isCanvasSupported = canvas.getContext && canvas.getContext('2d')

// don't proceed if canvas is no supported
if ( !isCanvasSupported ) {
  return
}


function ClosePixelation( img, options ) {
	
	//console.log(img.width)
	
  this.img = img
  
  //console.log(this.img.width)
  // creat canvas
  var canvas = this.canvas = document.createElement('canvas')
  this.ctx = canvas.getContext('2d')
  // copy attributes from img to canvas
  canvas.className = img.className
  canvas.id = img.id
  
  canvas.imgSrc= this.img;
  canvas.addEventListener('mouseenter', function(e) {
				//console.log("enter")
				this.style.opacity=0;
				
				$('#'+this.id).transition({ scale: 1.5,opacity:0});
				
			});
   
  canvas.addEventListener('mouseleave', function(e) {
				//console.log("leave")
				$.cssEase['bounce'] =
  'cubic-bezier(0,1,0.5,1.3)';
$('#'+this.id).transition({ scale: 1,opacity:1 }, 500,
  'bounce');
				
				
			});

  this.render( options )

  // replace image with canvas
  //img.parentNode.replaceChild( canvas, img )
  img.parentNode.insertBefore(canvas, img);

}

ClosePixelation.prototype.render = function( options ) {
  this.options = options
  // set size
  
  //console.log(this.img.width)
  
  var w = this.width = this.canvas.width = this.img.width
  var h = this.height = this.canvas.height = this.img.height
  
  // draw image on canvas
 this.ctx.drawImage( this.img, 0, 0 )
  // get imageData

  try {
    this.imgData = this.ctx.getImageData( 0, 0, w, h ).data
  } catch ( error ) {
    if ( console ) {
      console.error( error )
    }
    return
  }

  this.ctx.clearRect( 0, 0, w, h )

  for ( var i=0, len = options.length; i < len; i++ ) {
    this.renderClosePixels( options[i] )
  }

}

ClosePixelation.prototype.renderClosePixels = function( opts ) {
  var w = this.width
  var h = this.height
  var ctx = this.ctx
  var imgData = this.imgData

  // option defaults
  var res = opts.resolution || 16
  var size = opts.size || res
  var alpha = opts.alpha || 1
  var offset = opts.offset || 0
  var offsetX = 0
  var offsetY = 0
  var cols = w / res + 1
  var rows = h / res + 1
  var halfSize = size / 2
  var diamondSize = size / Math.SQRT2
  var halfDiamondSize = diamondSize / 2

  if ( isObject( offset ) ){ 
    offsetX = offset.x || 0
    offsetY = offset.y || 0
  } else if ( isArray( offset) ){
    offsetX = offset[0] || 0
    offsetY = offset[1] || 0
  } else {
    offsetX = offsetY = offset
  }

  var row, col, x, y, pixelY, pixelX, pixelIndex, red, green, blue, pixelAlpha,_red, _green, _blue, _hex

  for ( row = 0; row < rows; row++ ) {
    y = ( row - 0.5 ) * res + offsetY
    // normalize y so shapes around edges get color
    pixelY = Math.max( Math.min( y, h-1), 0)

    for ( col = 0; col < cols; col++ ) {
		
		
      x = ( col - 0.5 ) * res + offsetX
      // normalize y so shapes around edges get color
      pixelX = Math.max( Math.min( x, w-1), 0)
      pixelIndex = ( pixelX + pixelY * w ) * 4
      red   = imgData[ pixelIndex + 0 ]
      green = imgData[ pixelIndex + 1 ]
      blue  = imgData[ pixelIndex + 2 ]
      pixelAlpha = alpha * ( imgData[ pixelIndex + 3 ] / 255)

/*
	_red=red.toString(16);
	_green=green.toString(16);
	_blue=blue.toString(16);
	if (_red.length<2) _red="0"+_red;
	if (_green.length<2) _green="0"+_green;
	if (_blue.length<2) _blue="0"+_blue;
	_hex="#"+_red.toString(16)+_green.toString(16)+_blue.toString(16)
	ctx.fillStyle='#'+this.getSimilarColors (_hex)	
*/

	
	 //console.log(this.getSimilarColors (_hex));
	 
     ctx.fillStyle = 'rgba(' + red +','+ green +','+ blue +','+ pixelAlpha + ')'

      switch ( opts.shape ) {
        case 'circle' :
          ctx.beginPath()
            ctx.arc ( x, y, halfSize, 0, TWO_PI, true )
            ctx.fill()
          ctx.closePath()
          break
        case 'diamond' :
          ctx.save()
            ctx.translate( x, y )
            ctx.rotate( QUARTER_PI )
            ctx.fillRect( -halfDiamondSize, -halfDiamondSize, diamondSize, diamondSize )
          ctx.restore()
          break
        default :
          // square
          ctx.fillRect( x - halfSize, y - halfSize, size, size )
      } // switch
    } // col
  } // row
  
 
  this.img.className="imageCover fullwidth"

}

ClosePixelation.prototype.getSimilarColors=function(color){
	
	 var base_colors=["000000","ffffff","68372b","70A4B2","6f3d86","588d43","352879","b8c76f","6f4f25","433900","9a6759","444444","6c6c6c","9ad284","6c5eb5","959595"];
        
        //Convert to RGB, then R, G, B
        var color_rgb = hex2rgb(color);
        var color_r = color_rgb.split(',')[0];
        var color_g = color_rgb.split(',')[1];
        var color_b = color_rgb.split(',')[2];
        
        //Create an emtyp array for the difference betwwen the colors
        var differenceArray=[];
        
        //Function to find the smallest value in an array
        Array.min = function( array ){
               return Math.min.apply( Math, array );
        };
        
        
        //Convert the HEX color in the array to RGB colors, split them up to R-G-B, then find out the difference between the "color" and the colors in the array
        $.each(base_colors, function(index, value) { 
            var base_color_rgb = hex2rgb(value);
            var base_colors_r = base_color_rgb.split(',')[0];
            var base_colors_g = base_color_rgb.split(',')[1];
            var base_colors_b = base_color_rgb.split(',')[2];
        
            //Add the difference to the differenceArray
            differenceArray.push(Math.sqrt((color_r-base_colors_r)*(color_r-base_colors_r)+(color_g-base_colors_g)*(color_g-base_colors_g)+(color_b-base_colors_b)*(color_b-base_colors_b)));
        });
        
        //Get the lowest number from the differenceArray
        var lowest = Array.min(differenceArray);
        
        //Get the index for that lowest number
        var index = differenceArray.indexOf(lowest);
                        
        //Function to convert HEX to RGB
        function hex2rgb( colour ) {
            var r,g,b;
            if ( colour.charAt(0) == '#' ) {
                colour = colour.substr(1);
            }
        
            r = colour.charAt(0) + colour.charAt(1);
            g = colour.charAt(2) + colour.charAt(3);
            b = colour.charAt(4) + colour.charAt(5);
            
            r = parseInt( r,16 );
            g = parseInt( g,16 );
            b = parseInt( b ,16);
            return r+','+g+','+b;
        }
        
        //Return the HEX code
        return base_colors[index];
	
	
	}


// enable img.closePixelate
HTMLImageElement.prototype.closePixelate = function ( options ) {

  return new ClosePixelation( this, options );
  
}

// put in global namespace
window.ClosePixelation = ClosePixelation

})( window );

