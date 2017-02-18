var oEditor
var engineMain="/api/json/main/core.aspx"
var engineContent="/api/json/content/core.aspx"
var engineContext="/api/json/context/core.aspx"
var engineTree="/api/json/tree/core.aspx"
var engineSite="/api/json/site/core.aspx"
var engineRelated="/api/json/contentRelated/core.aspx"
var engineLayout="/api/json/layout/core.aspx"
var engineModule="/api/json/module/core.aspx"
var engineCover="/api/json/cover/core.aspx"
var enginePost="/api/json/post/core.aspx"
var engineImage="/api/json/image/core.aspx"
var engineUser="/api/json/user/core.aspx"
var engineProfile="/api/json/profile/core.aspx"
var engineRole="/api/json/role/core.aspx"

var imgPath="/CORE/CORE_images/admin/"
var loadingCircle="<img src='"+ imgPath +"loading_circle.gif' alt='Loading...' />"
var loadingIndicator="<img src='"+ imgPath +"indicator_blue_large.gif' alt='Loading...' />"
var actionForbidden='Sorry, you have no privileges to accomplish this operation';
var languageId = 2;
var siteValues = new Array();
var _themes_helper= new Array();
var clipBoard = new Array();

var roles = new Array();
var profiles = new Array();
var profileSelected = new Array();
var roleSelected = new Array();

//content vars
var currentContent=0;
var contentValue = new Array();
var contentsValues = new Array();
var contentSelected = new Array();
var contentSearchObj = {sites:new Array(),users:new Array(),relateds:new Array(),contexts:new Array(),trees:new Array()}
var records=0;
var display=10;
var numP=10;
var pages=0;
var currentPage=1;
var currentOrder=0;

//post vars
var currentPost=0;
var postValue = new Array();
var postsValues = new Array();
var postSelected = new Array();
var postRecords=0;
var postDisplay=10;
var postNumP=10;
var postPages=0;
var currentPostPage=1;
var currentPostOrder;

//message vars
var currentMessage=0;
var messageValue = new Array();
var messagesValues = new Array();
var messageSelected = new Array();
var messageRecords=0;
var messageDisplay=10;
var messageNumP=10;
var messagePages=0;
var currentMessagePage=1;
var currentMessageOrder;

//related vars
var currentRelated=0;
var relatedValue = new Array();
var relatedsValues = new Array();
var relatedSelected = new Array();
var relatedRecords=0;
var relatedDisplay=10;
var relatedNumP=10;
var relatedPages=0;
var currentRelatedPage=1;
var currentRelatedOrder;
var relatedFromArchive=false;

//user vars
var currentUser=0;
var userValue = new Array();
var usersValues = new Array();
var userSelected = new Array();
var userRecords=0;
var userDisplay=10;
var userNumP=10;
var userPages=0;
var currentUserPage=1;
var currentUserOrder;
var userStatus = new Array();
var statusIdSite=0;
var statusIdUser=0;
var statusCurrent=0;

//tree vars
var currentTree=0;
var treeSelected = new Array();
var treesRelatedsValues = new Array();
var treeValue=new Array();
var treeOrder= new Array();
var currentContextTree = new Array;

//context vars
var currentContext = 0;
var currentContextType = 0;
var currentContextIndex;
var contextsValues = new Array();
var currentContextsValues = new Array();
var contextSelected = new Array();
var contextGroupSelected = new Array();

//vars
var swfu;
var swfi;
var swfr;
var currentFilename='';
var currentFileSize=0;

var currentKeySite=1;
var currentKeyTree=0;
var currentIdTree=0;
var currentIdEvent=0;

var switchValue=0;
var setNewFile=false;

var childOf = 0;
var siteWho='';
var firstAjax=false;
var oFCKeditor 
var pFCKeditor
var jcrop_api;

var toolImageElement;
var	toolImageRefresh;
var	toolImagePath;
var	toolImageInfo = new Array();

var simpleTree;
var treeDrag=false;

var selectedLayout=new Array();
/*
-----------------------------------------------------------------------------------------------------------------------------*/	
$(document).ready(function() {

$("#modalContentTabs").tabs()
$("#toolTabs").tabs( {select: function(event, ui) {switchTool(ui.index)}})
$("#tagsTabs").tabs();
$("#userTabs").tabs();
$("#modalTreeTabs").tabs();
$("#modalSiteTabs").tabs();
$("#logTabs").tabs();
$("#exportTabs").tabs();
$("#searcherKey").tabs();

$(".gridOptions").hover(
function(){$(this).addClass("option-selected");},
function(){$(this).removeClass("option-selected");}
)


$("#trace").ajaxStart(function(){$("#ajaxOverlay,#ajaxLoading").show();});

$("#trace").ajaxStop(function(){
   $("#ajaxOverlay,#ajaxLoading").hide();
   if (firstAjax==false){$("#topMenu").fadeIn();firstAjax=true;}
 });

							oFCKeditor = new FCKeditor( 'content_description' ) ;
							oFCKeditor.BasePath = "/fckeditor/" ;
							oFCKeditor.Height = '250' ; 
						    
						    
						    
						    pFCKeditor = new FCKeditor( 'post_description' ) ;
							pFCKeditor.BasePath = "/fckeditor/" ;
							pFCKeditor.Height = '250' ; 
						    pFCKeditor.ReplaceTextarea();
						
			
  						$("#language_"+languageId).addClass("selected");
							
							
                           loadContexts(languageId);
                           roleGetAll();
                           startUpSites();
                           profileGetAll();
                           getModules()

						   $(".flags").click(function(){
						   
						   $(".flags").removeClass("selected");
						   $(this).addClass("selected");
						   $("#menu").html(loadingCircle); 
						   languageId=parseInt($(this).attr("language"));
						   loadTree(languageId);
						   
						   
						   showForm()
						   });
	

$(".contentOrder").toggle(function(){
$(".contentOrder").removeClass("selectedDown").removeClass("selectedUp")
$(this).addClass("selectedUp")
contentsGet(currentTree,$(this).attr("asc"),1)

},
function(){
$(".contentOrder").removeClass("selectedDown").removeClass("selectedUp")
$(this).addClass("selectedDown")
contentsGet(currentTree,$(this).attr("desc"),1)
}
)


});


/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function startUpTrees(){
loadTree(languageId);
}
/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function startUpContents(){
$("#section").text("Content Manager")
var filter=false;

	$(".searchContentSerialize").each(function(i){
	
	if($(this).val()!=''){filter=true;}
	
	})
	
	
	
if(filter==true){

if (confirm('Mantain current search content filter?')){contentsGet();}else{clearSearchValues();contentsGet(0);}

}	
else
{
contentsGet(0)
}

}
/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function startUpRelateds(){
$("#section").text("Related Manager")
getRelateds(1)
}
/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function startUpContexts(){
$("#section").text("Context Manager");
showForm('contextArchive');
}
/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function startUpUsers(){
$("#section").text("User Manager")
getUsers(1)
}
/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function startUpProfiles(){
$("#section").text("Roles & Profile Manager")
showForm('profileArchive');
if (profiles.length>0){displayProfiles()}else{profileGetAll()}

}
/*
-----------------------------------------------------------------------------------------------------------------------------*/	

function openLayer(htmlElement,TB_WIDTH,TB_HEIGHT,_modal,_draggable,_resizable,_title)
{
if(_modal==undefined) _modal=true;
if(_draggable==undefined) _draggable=true;
if(_resizable==undefined) _resizable=true;
if(_title==undefined) _title='';
$(htmlElement).dialog({resizable: _resizable, draggable: _draggable, width:TB_WIDTH, modal: _modal, autoOpen: true, title: _title ,  open: function(event, ui) {
//$('select#boxIdTemplate').selectmenu();
 }
 })

}
/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function closeLayer(htmlElement,callback)
{

$(htmlElement).dialog('close');
if (callback!=undefined){eval(callback);}
}
/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function openDialog(message,TB_WIDTH,TB_HEIGHT,timeout,callback)
{
	//$("#dialog").addClass("Dialog");
	$("#dialog h3").text(message);
	$("#dialog").animate({right:"50px", opacity: 1}, 300, "swing", function(){setTimeout("closeDialog("+callback+")",timeout);} );

}
/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function closeDialog(callback)
{
	$("#dialog").animate({right:"100px", opacity: 0}, 300, "swing", function(){if(callback!=undefined){eval(callback);} $("#dialog").css({"right":"0px"}) });
	
}
/*
-----------------------------------------------------------------------------------------------------------------------------*/	

function absolutePosition(htmlElement,TB_WIDTH,TB_HEIGHT) {

$(htmlElement).css({width: TB_WIDTH +'px', height: TB_HEIGHT +'px' ,marginLeft: '-' + parseInt((TB_WIDTH / 2),10) + 'px', width: TB_WIDTH + 'px'});
  if ( !(jQuery.browser.msie && jQuery.browser.version < 7)) { // take away IE6
  if(!TB_HEIGHT==undefined){ $(htmlElement).css({marginTop: '-' + parseInt((TB_HEIGHT / 2),10) + 'px'});} else {$(htmlElement).css({marginTop: '-100px'});}
  }

}


/*
-----------------------------------------------------------------------------------------------------------------------------*/	

		
function normalizeXml(myString)
	{
		
		if (myString==undefined) return ""
		return myString.replace(/#lt#/g,"<").replace(/#gt#/g,">")
		
		}

/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function cacheRemove(cache)
	{
	
		mydata="who=cacheRemove&cache="+ cache;
		
		$.ajax({
		   type: "POST",
		   url: engineMain,
		   data: mydata,
		   dataType: "json",
		     success: function(msg){
		     
		     if(msg.values.error!=undefined)
		     {
		     
		         if (msg.values.error[0].errorId==0){
		                
		                openDialog ('Cache removed',200,100,2000);
		               
		                }
		                else		
		                {
		                
		                openDialog ( msg.values.error.errorLabel + ' Error code: '+ msg.values.error.errorid,200,100,2000);
		              
		                }
				
		    }
		  }
		 });

		return false;
		}
		
/*
-----------------------------------------------------------------------------------------------------------------------------*/			
		
function showForm(form,callback)
{
	
	if (form!='contentForm'){$(".toTree").hide();}else{$(".toTree").show();}
	
	
	$(".Forms").hide()
	if (form!=undefined){$("#"+form).fadeIn(function(){
	
	
	if (callback!=undefined){eval(callback)}
	
	})}
	}
	
/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function randomString(sChrs,iLen) {
var sRnd = '';
for (var i=0; i<=iLen; i++){
var randomPoz = Math.floor(Math.random() * sChrs.length);
sRnd += sChrs.substring(randomPoz,randomPoz+1);
}
return sRnd;
}
/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function uniqueKey()
{
var currentTime = new Date()
var uniqueKey = currentTime.getFullYear() +''+ currentTime.getMonth() +''+ currentTime.getDay() +''+ currentTime.getHours() +''+ currentTime.getMinutes() +''+ currentTime.getSeconds() +''+ currentTime.getMilliseconds()
return(uniqueKey)
}

/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function displayMax(value,max){
if (value.length >= max){
value=value.substring(0,(max/2)-3) + '(...)' + value.substring(value.length-((max/2)-2),value.length)
}
return value
}

/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function displayActionForbidden(){
 openDialog(actionForbidden,200,100,2000);
}

/*
-----------------------------------------------------------------------------------------------------------------------------*/	
var objString='';

function iterateObj(myobj){$.each(myobj, function(key, val) { recursiveFunction(key, val);  }); alert('obj:' + objString);}

function recursiveFunction(key, val) {
        actualFunction(key, val);
        var value = val;
        if (value instanceof Object) {
            $.each(value, function(key, val) {
                recursiveFunction(key, val)
            });
        }
    }
/*
-----------------------------------------------------------------------------------------------------------------------------*/	function actualFunction(key, val) {
objString += '"'+key+'":'+ '"'+val+'",\n'  
}

/*
-----------------------------------------------------------------------------------------------------------------------------*/	

function copyToClipboard(title,text){

openLayer("#clipboard",400,300,false,true,true,"ClipBoard")
$("#clipboardText").val(text);
}
	