// start slider
$(document).ready(function(){
if($("#flashcontent").length==1){
swfobject.embedSWF("/core/core_flash/carousel/carousel.swf", "flashcontent", "960", "300", "9.0.0", false, {xmlfile:"/core/core_xml/carousel.xml", loaderColor:"0x666666"}, {wmode: "opaque",bgcolor: "#FFFFFF"});
$("#flashcontent").show();
}
})