// JavaScript Document


 // Once the video is ready
 $(function(){

 
$.ajax({url: "http://vjs.zencdn.net/c/video.js",
								  dataType: "script",
								  success: function( data, textStatus, jqxhr ) { 
 
 									setupVideo()
 
 
								  }
								  
								  
								  
								  });
								  
								  
function setupVideo(){
	 
  _V_("my-video").ready(function(){

    var myPlayer = this;    // Store the video object
    var aspectRatio = 3/4; // Make up an aspect ratio

    function resizeVideoJS(){
      // Get the parent element's actual width
      var width = document.getElementById(myPlayer.id).parentElement.offsetWidth;
      // Set width to fill parent element, Set height
      myPlayer.width(width).height( width * aspectRatio );
    }

    resizeVideoJS(); // Initialize the function
    window.onresize = resizeVideoJS; // Call the function on resize
  });
  
 }	
 
 
 });