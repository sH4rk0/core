var id_event_main=1;
var id_event_copy=1;
var tab=1;
var box_copy=0;
var force_insert=0;
var events=new Array();
var currentBox=0;
var currentLayout;


/*
		var addressFormatting = function(text){
			var newText = text;
		
			var findreps = [
				{find:/^([^\-]+) \- /g, rep: '<span class="ui-selectmenu-item-header">$1</span>'},
				{find:/([^\|><]+) \| /g, rep: '<span class="ui-selectmenu-item-content">$1</span>'},
				{find:/([^\|><\(\)]+) (\()/g, rep: '<span class="ui-selectmenu-item-content">$1</span>$2'},
				{find:/([^\|><\(\)]+)$/g, rep: '<span class="ui-selectmenu-item-content">$1</span>'},
				{find:/(\([^\|><]+\))$/g, rep: '<span class="ui-selectmenu-item-footer">$1</span>'}
			];
			
			for(var i in findreps){
				newText = newText.replace(findreps[i].find, findreps[i].rep);
			}
			return newText;
		}
*/

$(document).ready(function () {

	$("#boxListTabs").tabs();


	
	}
);

/*
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*/

function myBoxUpdate()
{
if ($("#boxTitle").val()=="") { alert("Insert Title");$("#boxTitle").focus(); return false;}
if ($("#boxIdModule").val()=="") { alert("Select Module");$("#boxIdModule").focus(); return false;}
mydata="who=boxUpdate&boxId="+ currentBox +"&treeId=" + currentKeyTree + "&" + $(".boxSerialize").serialize();
closeLayer("#box_form");

$.ajax({
   type: "POST",
   url: engineLayout,
   data: mydata,
   dataType:"json",
   success: function(msg){
   
       if(msg.values!=undefined){
            if(msg.values.error[0].errorId==0){
                getBoxList();
                getBoxListCustom(currentKeySite);
                getBoxData(currentIdEvent);
                
            }
             else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
       }
   }
 });

}

function getSelectedContents(){$('#boxContents').val(selectedContentsSerialize());return false;}
function getSelectedContenxs(){$('#boxContenxs').val(selectedContenxsSerialize());return false;}
function getSelectedTrees(){$('#boxTrees').val(selectedTreesSerialize());return false;}
function getSelectedRelateds(){$('#boxRelateds').val(selectedRelatedsSerialize());return false;}


/*
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*/

function displayBox()
{

$(".hidable").show();
$("#boxInsert").show();
$("#boxUpdate").hide();
setupBoxLayout({"module":true, "dimension":false, "cache":false, "description":false, "style":false, "dates":false, "rows":false, "contents":false, "relateds":false,"contexts":false, "trees":false, "users":false, "contentTypes":false})
openLayer("#box_form",700);

}

/*
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*/

function myBoxInsert()
{
if ($("#boxTitle").val()=="") { alert("Insert Title");$("#boxTitle").focus(); return false;}
if ($("#boxIdModule").val()=="") { alert("Select Module");$("#boxIdModule").focus(); return false;}
mydata="who=boxInsert&" + $(".boxSerialize").serialize()

$.ajax({
   type: "POST",
   url: engineLayout,
   data: mydata,
   dataType:"json",
   success: function(msg){
   
       if(msg.values!=undefined){
            if(msg.values.error[0].errorId==0){
                getBoxList(); 
                getBoxListCustom(currentKeySite);
                //displayBox();
                closeLayer("#box_form");
               
            }
             else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
       }
   }
 });

}
/*
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*/
function boxModify(boxId)
{
currentBox=boxId;
mydata="who=getBox&boxId=" + boxId;
$.ajax({
   type: "POST",
   url: engineLayout,
   data: mydata,
   dataType:"json",
   success: function(msg){
   
       if(msg.values!=undefined){ 
            if(msg.values.error[0].errorId==0){
            
            
            
            $(".hidable").show();
            $("#boxTemplates").hide();
            $("#boxIdTemplate").html("");
            $("#boxTitle").val(msg.values.box[0].boxTitle);
            $("#boxDescription").val(msg.values.box[0].boxDescription);
            $("#boxIdModule").val(msg.values.box[0].idModule);
            $("#boxWidth").val(msg.values.box[0].width);
            $("#boxHeight").val(msg.values.box[0].height);
            $("#boxCache").val(msg.values.box[0].cache);
            $("#boxStyle").val(msg.values.box[0].style);
            $("#boxIdSite").val(msg.values.box[0].idSite);
             $("#boxRows").val(msg.values.box[0].rows);
            
            $("#boxContents").val(msg.values.box[0].contents);
            $("#boxTrees").val(msg.values.box[0].trees);
            $("#boxContexts").val(msg.values.box[0].contexts);
            $("#boxRelateds").val(msg.values.box[0].relateds);
            $("#boxUsers").val(msg.values.box[0].users);
            
            
           
           if (parseInt(msg.values.box[0].contentTypes) || msg.values.box[0].contentTypes==0) {
           $("#boxContentTypes option").eq(msg.values.box[0].contentTypes).attr("selected","selected")
           }
           else
           {
            var myTypes = new Array()
            myTypes=msg.values.box[0].contentTypes.split("|");
            
               for (i=0; i<myTypes.length; i++){
               $("#boxContentTypes option").eq(myTypes[i]).attr("selected","selected")
               }
           }
         
        if (msg.values.box[0].templateData!=undefined){  
          
           if (msg.values.box[0].templateData[0].templates!=undefined){
          for (t=0; t<msg.values.box[0].templateData[0].templates[0].template.length; t++){
             
              $("select#boxIdTemplate").append("<option value="+ msg.values.box[0].templateData[0].templates[0].template[t].id +">"+  msg.values.box[0].templateData[0].templates[0].template[t].label +"</option>")
               }
                 $("#boxTemplates").show();
                 $("#boxIdTemplate").val(msg.values.box[0].template);
               
               }
                    
          
            
         }   
         
         
            $("#boxDateStart").val(msg.values.box[0].boxDateStart);
            $("#boxDateEnd").val(msg.values.box[0].boxDateEnd);
            if (msg.values.box[0].boxEnabled=="True"){$("#boxEnabled").attr("checked","checked")}else{$("#boxEnabled").attr("checked","")}
            $("#boxInsert").hide();
            $("#boxUpdate").show();
            
             if (msg.values.box[0].templateData[0].config!=undefined){
           
           setupBoxLayout(msg.values.box[0].templateData[0].config[0])
           
           }
            openLayer("#box_form",600,undefined,undefined,undefined,undefined,"Box Options");
              
            }
             else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
       }
   }
 });


}

function setupBoxLayout(boxObj)
{

if (boxObj.description==false){$("#boxLDescription").hide();}
if (boxObj.style==false){$("#boxLStyle").hide();}
if (boxObj.rows==false){$("#boxLRows").hide();}
if (boxObj.dates==false){$("#boxLDates").hide();}
if (boxObj.contents==false){$("#boxLContents").hide();}
if (boxObj.contexts==false){$("#boxLContexts").hide();}
if (boxObj.relateds==false){$("#boxLRelateds").hide();}
if (boxObj.users==false){$("#boxLUsers").hide();}
if (boxObj.trees==false){$("#boxLTrees").hide();}
if (boxObj.contentTypes==false){$("#boxLContentTypes").hide();}
if (boxObj.module==false){$("#boxLModule").hide();}
if (boxObj.dimension==false){$("#boxLDimension").hide();}
if (boxObj.cache==false){$("#boxLCache").hide();}
}

/*
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*/

function getBoxList()
{


$("#box_list").html("");

$('#box_list .newItems').draggable("destroy");
		mydata="who=getBoxList&id_key_site=0";

$.ajax({
   type: "POST",
   url: engineLayout,
   data: mydata,
   dataType: "json",
   success: function(msg){
  
  if(msg.values!=undefined){
  
    if(msg.values.error[0].errorId==0 && msg.values.box!=undefined){
 
    for (i=0; i<msg.values.box.length; i++){
   
   
   var append = "<div id='NewItem' class='newItems'><div id='module_0_random' id_box='"+ msg.values.box[i].id +"' class='groupItem'><div class='itemHeader'>"+ msg.values.box[i].title +"<div class='itemOptions'><a href='#' class='btn_enabled'><img src='/core/core_images/admin/window_enabled_off.jpg' /></a><a href='#' class='btn_options' ><img src='/core/core_images/admin/window_max.jpg' /></a><a href='#' class='btn_close' ><img src='/core/core_images/admin/window_close.jpg' /></a></div></div><div class='itemContent'>"+ msg.values.box[i].description +"</div></div></div>"
   
   
  $(append).appendTo("#box_list");
  
  }
  
 $('#box_list .newItems').draggable(
			{
			cancel: 'img',
			containment: "*",
	        revert: true,
	        start: function(e,ui){ },
	        stop: function(e,ui){ },
	        helper: "clone",
	        appendTo: "#layout",
	        zIndex: 1000000
				
				
			}
		);
  
  } else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
 }  
     },
     error:function(msg){
     
     alert(msg)
     }
 });
	
	
	}
/*
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*/
function deleteBox(id_box)
{
	
	
	
	mydata="who=deleteBox&id_box="+ id_box +"&id_tree="+ currentKeyTree +"&id_site="+ currentKeySite +"&id_event="+currentIdEvent+ "&id_layout=&id_language="+ languageId;

$.ajax({
   type: "POST",
   url: engineLayout,
   data: mydata,
   dataType: "json",
   success: function(msg){
   
   if(msg.values!=undefined){
  
    if(msg.values.error[0].errorId==0){
  
 
    getBoxListCustom(currentKeySite)
   changeLayout(currentLayout)
   }
   }
   }
 });
}
/*
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*/

function getBoxListCustom(id_key_site)
{


$("#box_list_custom").html("");

$('#box_list_custom .newItems').draggable("destroy");
	mydata="who=getBoxList&id_key_site="+id_key_site;

$.ajax({
   type: "POST",
   url: engineLayout,
   data: mydata,
   dataType: "json",
   success: function(msg){
  
  $("#customListSite").text($("#treeSelector option:selected").text())
  
  if(msg.values!=undefined){
  
    if(msg.values.error[0].errorId==0 && msg.values.box!=undefined){
 
    for (i=0; i<msg.values.box.length; i++){
   
   
   var append = "<div id='NewItem' class='newItems'><div id='module_0_random' id_box='"+ msg.values.box[i].id +"' class='groupItem'><div class='itemHeader'><div style='display:inline;text-align:right;' class='boxDelete'><a href='#' onclick='deleteBox("+ msg.values.box[i].id +")' class='btn_delete' ><img src='/core/core_images/admin/window_close.jpg' /></a></div>"+ msg.values.box[i].title +"<div class='itemOptions'><a href='#' class='btn_enabled'><img src='/core/core_images/admin/window_enabled_off.jpg' /></a><a href='#' class='btn_options' ><img src='/core/core_images/admin/window_max.jpg' /></a><a href='#' class='btn_close' ><img src='/core/core_images/admin/window_close.jpg' /></a></div></div><div class='itemContent'>"+ msg.values.box[i].description +"</div></div></div>"
   
   
  $(append).appendTo("#box_list_custom");
  
  }
  
 $('#box_list_custom .newItems').draggable(
			{
			cancel: 'img',
			containment: "*",
	        revert: true,
	        start: function(e,ui){ },
	        stop: function(e,ui){ },
	        helper: "clone",
	        appendTo: "#layout",
	        zIndex: 1000000
				
				
			}
		);
		
		
  
  } else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
 }  
     },
     error:function(msg){
     
     alert(msg)
     }
 });
	
	
	}
/*
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*/

function changeEvent()
{
currentIdEvent=$("#eventList").val();
getBoxData($("#eventList").val());
}

/*
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*/

function changeLayout(idLayout)
{
currentLayout=idLayout
getBoxData(currentIdEvent,idLayout)
}
/*
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*/
function getBoxData(idEvent,idLayout)
{
$("#section").text("Layout Manager: " + $("#eventList option").eq(idEvent).text())

	currentIdEvent=idEvent;
	if (idEvent==undefined){idEvent=0}
	if (idLayout==undefined){idLayout=''}
	
	$("#layout").html(loadingIndicator)
	mydata="who=getTreeModules&id_tree="+ currentKeyTree +"&id_site="+ currentKeySite +"&id_event="+idEvent+ "&id_layout="+idLayout+ "&id_language="+ languageId;

$.ajax({
   type: "POST",
   url: engineLayout,
   data: mydata,
   dataType: "json",
   success: function(msg){
   
   if(msg.values!=undefined){
  
    if(msg.values.error[0].errorId==0 && msg.values.layout!=undefined){
   $("#layout").html(msg.values.layout[0].html)
   //$("#imgCurrentLayout").attr("src","/core/CORE_layout/"+ msg.values.layout[0].layout +"/layout.gif");
   $(".imgLayout").removeClass("selected").eq(msg.values.layout[0].layout).addClass("selected");
   
   resort();
   reLayout();
   }
   }
   }
 });
}

/*
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*/
function box_delete(id,id_key)
{

if (confirm('Elimino questo box?'))
{

var url="&id_key="+ id_key +"&id_event="+ currentIdEvent +"&id_site="+ currentKeySite + "&id_tree="+ currentKeyTree+ "&id_language="+ languageId + "&position="+ $("#"+id).attr("position");

					$.ajax({ 
  type: "POST", 
  url: engineLayout, 
  data: "who=deleteBox2Tree" + url, 
  dataType: "json",
  error: function(msg){alert( msg);} ,
  success: function(msg){ 
  

 
 if(msg.values.error!=undefined)
{

 if (msg.values.error[0].errorId==0)
 {
 
 
   $("#" + id).fadeOut("slow",function(){ $("#" + id).remove();});
 }
 else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
 
}
 
 
  } 
});	
}else
 {return false;}


}

/*
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*/
function box_enable(id,id_key)

{
var url="&id_key="+ id_key +"&id_event="+ currentIdEvent +"&id_site="+ currentKeySite + "&id_tree="+ currentKeyTree+ "&id_language="+ languageId + "&position="+ $("#"+id).attr("position");

$.ajax({ 
  type: "POST", 
  url: engineLayout, 
  data: "who=enableBox2Tree" +  url, 
  dataType: "json",
    error: function(msg){alert( msg);} ,
  success: function(msg){ 
  
 if(msg.values.error!=undefined)
{

 if (msg.values.error[0].errorId==0)
 {
 
  if ($('#'+id+ ' a.btn_enabled img').attr("src")=="/core/core_images/admin/window_enabled_on.jpg")
{
$('#'+id+ ' a.btn_enabled img').attr("src","/core/core_images/admin/window_enabled_off.jpg");}
else
{
$('#'+id+ ' a.btn_enabled img').attr("src","/core/core_images/admin/window_enabled_on.jpg");}
 }
 else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
 
}
 
  } 
});	
}

/*
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*/
function reLayout()
{
		$('#layout p').droppable(
			{
				accept :		'.newItems', 
				activeClass:	'.dropactive', 
				hoverClass:		'drophover',
				tolerance:		'intersect',
				drop : function(event,ui)
				{
								
				
					var temp=$("#"+$(ui.draggable).attr('id') + " div").attr("id");
					var id_box=$("#"+$(ui.draggable).attr('id') + " div").attr("id_box");
					var newitem=$("#"+$(ui.draggable).attr('id')).html();
					
                    var i = Math.round(10000*Math.random())
					
					newitem = newitem.replace("random",i + '-value');
					temp = temp.replace("random",i + '-value');
                    $(this).before(newitem);
				
		url="who=insertBox2Tree&id_event="+ currentIdEvent +"&id_box="+ id_box +"&id_site="+ currentKeySite +"&id_tree=" + currentKeyTree +"&position=" + $(this).attr("position")+ "&id_language="+ languageId;

$.ajax({ 
  type: "POST", 
  dataType: "json",
  url: engineLayout, 
  data: url , 
  error: function(msg){alert( "Si è verificato un errore");} ,
  success: function(msg){
  
 if(msg.values.error!=undefined)
{

 if (msg.values.error[0].errorId==0)
 {
  
  
 var boxidkey=(msg.values.box[0].id_key);
 newitem=$("#"+temp);
 temp=temp.replace("_0_","_"+boxidkey+"_");
 newitem.attr("id",""+temp+"");
 newitem.attr("id_key",""+boxidkey+"");
 $('#'+temp).attr("position",msg.values.box[0].boxPosition)
 
 $('#'+temp+ ' .boxDelete').remove()
 $('#'+temp+ ' a.btn_close').attr("onclick","javascript:box_delete('"+ temp + "','" + boxidkey + "');");
 $('#'+temp+ ' a.btn_enabled').attr("onclick","javascript:box_enable('"+ temp + "','" + boxidkey + "');");
 $('#'+temp+ ' a.btn_options').attr("onclick","javascript:boxModify(" + msg.values.box[0].id_box + ");");
  
    openDialog("Layout Updated.",200,100,2000);
 }
 else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
 
}
  
  } 
});	
					
					$('#layoutBox1').sortable("refresh");
					$('#layoutBox2').sortable("refresh");
					$('#layoutBox3').sortable("refresh");
					$('#layoutBox4').sortable("refresh");
					$('#layoutBox5').sortable("refresh");
					$('#layoutBox6').sortable("refresh");
					$('#layoutBox7').sortable("refresh");
				}
			});

}

/*
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*/
var sortableChange = function(e, ui){
 if(ui.sender){
var w = ui.sender.width();
ui.placeholder.width(200);
ui.helper.css("width",200);
 //var w = ui.element.width();
 //ui.placeholder.width(w);
 //ui.helper.css("width",ui.element.children().width());
 }
 };

function resort()
{

	$(".groupWrapper").sortable({
		
		cancel: "p,img",
		containment: "*",
		connectWith: ["#layoutBox1","#layoutBox2","#layoutBox3","#layoutBox4","#layoutBox5","#layoutBox6","#layoutBox7"],
		distance: 10,
		scroll: false,
		placeholder: "placeholder",
		cursor: "move",
		opacity: 0.5,
		start: function(e,ui) {ui.helper.css("width", ui.item.width());},
		change: sortableChange,
		stop:function(e,ui){
		
		$("#"+ ui.item[0].id).attr("position",$("#"+ ui.item[0].id).parent().attr("position"))
		setTimeout("serialize();",100)

		}
		
		 }); 


}

/*
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*/
function serialize(s)
{
var url="who=updateLayout&id_event="+ currentIdEvent +"&id_site="+ currentKeySite + "&id_tree="+ currentKeyTree + "&id_language="+ languageId

	var serial=''
	var layout_area=''
	var _firstAmp =''
	
	layout_area=$('#layoutBox1').sortable('serialize',{attribute:'id',expression:'(.+)[-](.+)',key:'layoutBox1'})
	if (layout_area!=''){serial+= '' + layout_area; _firstAmp="&"}
	
	layout_area=$('#layoutBox2').sortable('serialize',{attribute:'id',expression:'(.+)[-](.+)',key:'layoutBox2'})
	if (layout_area!=''){serial+= '&'+layout_area}
		
	layout_area=$('#layoutBox3').sortable('serialize',{attribute:'id',expression:'(.+)[-](.+)',key:'layoutBox3'})
	if (layout_area!=''){serial+= '&'+layout_area}
	
	layout_area=$('#layoutBox4').sortable('serialize',{attribute:'id',expression:'(.+)[-](.+)',key:'layoutBox4'})
	if (layout_area!=''){serial+= '&'+layout_area}
	
	layout_area=$('#layoutBox5').sortable('serialize',{attribute:'id',expression:'(.+)[-](.+)',key:'layoutBox5'})
	if (layout_area!=''){serial+= '&'+layout_area}
	
	layout_area=$('#layoutBox6').sortable('serialize',{attribute:'id',expression:'(.+)[-](.+)',key:'layoutBox6'})
	if (layout_area!=''){serial+= '&'+layout_area}
	
	layout_area=$('#layoutBox7').sortable('serialize',{attribute:'id',expression:'(.+)[-](.+)',key:'layoutBox7'})
	if (layout_area!=''){serial+= '&'+layout_area}

	if (serial!=''){
	
		while (serial.indexOf("[]")!=-1)
		{
		serial=serial.replace("[]","");
		}
		url= url +"&" + serial
		
	
	}else{url= url +"&clear=all"}
		
//$("#values").text(url)
//$("#Overlay").show();

$.ajax({ 
  type: "POST", 
  url: engineLayout, 
  dataType: "json",
  data: url, 
   error: function(msg){alert('Si è verificato un errore!');} ,
   success: function(msg){ 
   
if(msg.values.error!=undefined)
{

 if (msg.values.error[0].errorId==0)
 {
  var mySplit = msg.values.update[0].value.split("|");
   var i=0;
        $(".groupWrapper .groupItem").each(function(i){ 
              
              var thisid=$(this).attr("id");
              
             if  (thisid.indexOf("_0_")!=-1){
             
                     thisid=thisid.replace("_0_","_"+ mySplit[i] + "_");
                     $(this).attr("id",thisid);
                     $(this).attr("id_key",mySplit[i]);
             
             }
             
           i++;
        });

    
    openDialog("Layout Updated.",200,100,2000);
 }
 else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
 
}
   
   }
   
});

};
/*
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*/

function displayCommonList(){
$('#bLCommon').show();$('#bLCustom').hide();

}
/*
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*/
function displayCustomList(){
$('#bLCommon').hide();$('#bLCustom').show();

}






