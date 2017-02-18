
$(document).ready(function(){

$("#searchContentImg4").mouseover(function(){$('#searchTreeMenu').show().css("z-index","10000000000");})
$("#searchContentImg4").mouseout(function(){$("#searchTreeMenu").hide();})
$("#searchTreeMenu").mouseover(function(){$(this).show(); })
$("#searchTreeMenu").mouseout(function(){ $(this).hide();})

})

function closeSearchTreeMenu(){$("#searchTreeMenu").hide(); }

/*
-----------------------------------------------------------------------------------------------------------------------------*/
function treeToggle()
{
if($("#relatedTrees").is(":hidden")){$("#relatedTrees").fadeIn();$("#treeSpan").text("-")}else{$("#relatedTrees").fadeOut();$("#treeSpan").text("+")}

}

/*
-----------------------------------------------------------------------------------------------------------------------------*/
function treeDelete(idKey)
{
if(confirm('Do you want to delete only this Branch?')){

mydata="who=treeDelete&id_Key="+ idKey +"&id_site="+ currentKeySite +"&language_id="+ languageId;

$.ajax({
   type: "POST",
   url: engineTree,
   data: mydata,
    dataType: "json",
   success: function(msg){
   
   if(msg.values.error!=undefined)
{

 if (msg.values.error[0].errorId==0)
 {
   openDialog("Tree branch deleted.",200,100,2000);
   loadTree(languageId)
 }
 else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
 
}

 
   
   
   }
 });

}
}
/*
-----------------------------------------------------------------------------------------------------------------------------*/
function treeDeleteRecursive(idKey)
{
if(confirm('Do you want to delete this Branch and sub branches?')){

mydata="who=treeDeleteRecursive&id_Key="+ idKey +"&id_site="+ currentKeySite +"&language_id="+ languageId;

$.ajax({
   type: "POST",
   url: engineTree,
   data: mydata,
    dataType: "json",
   success: function(msg){
   
   
   if(msg.values.error!=undefined)
{

 if (msg.values.error[0].errorId==0)
 {
 openDialog("Tree branch delete recursively.",200,100,2000);
   loadTree(languageId)
 }
 else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
 
}
     
   }
 });

}
}
/*
-----------------------------------------------------------------------------------------------------------------------------*/
function treeUpdateOrder(id_father,id_key)
{


if (id_father==undefined) return false;
var idKey
treeOrder=[];

$("#menuTreeContents li").each(function(i){
        idKey=$(this).attr("id_key");
        if (idKey!=undefined){treeOrder.push(idKey);}
});

mydata="who=treeUpdateOrder&id_father="+id_father+"&id_key="+id_key+"&treeOrder="+ treeOrder.join("|") +"&id_site="+ currentKeySite +"&language_id="+ languageId;

$.ajax({
   type: "POST",
   url: engineTree,
   data: mydata,
    dataType: "json",
   success: function(msg){
   
if(msg.values.error!=undefined)
{

 if (msg.values.error[0].errorId==0)
 {
 
 $("#menuTreeContents").html(msg.values.tree[0].html).map( function(){initTree()} );
  //$("#menuTree").show();
  // loadTree(languageId);
		      openDialog("Branch moved correctly.",200,100,2000);
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
-----------------------------------------------------------------------------------------------------------------------------*/
function selectedTreesSerialize()
	
	{
		
	var treekeys = new Array()
for (i=0; i<treeSelected.length; i++)
{
treekeys[i]=treeSelected[i].key
}

return treekeys.join("|")
	
	}
	
/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function selectTree()
{
var newSel=currentContextTree[0].key

var exist=false;

	for (i=0; i<treeSelected.length; i++)
		{
		if (treeSelected[i].key==newSel){exist=true}
		}
		
		if (exist==false){treeSelected.push(currentContextTree[0]);$("#treeSelected span").text(treeSelected.length);}
		

	if(treeSelected.length>0){$("#treeSelected").fadeIn();}else{$("#treeSelected").fadeOut();}
displaySelectedTree()

}


/*
-----------------------------------------------------------------------------------------------------------------------------*/
function displaySelectedTree(){
$("#treeSelectedList").html("");
var _class=""
for (i=0; i<treeSelected.length; i++)
		{
		_class=""
		if(i==0){_class="first-nav-item"}
		//if(i+1==treeSelected.length){_class="last-nav-item"}
		
		$("#treeSelectedList").append("<li class='"+ _class +"'><a href=\"#\" onclick='javascript:treeModify("+ treeSelected[i].key +");return false;' title='"+ treeSelected[i].title + "'>" + displayMax(treeSelected[i].title,20) + "</a></li>")
	
		}
		
			$("#treeSelectedList").append("<li class='last-nav-item'><a href='javascript:addSelectedTreeToSearch();' title='Add Selected to content search'><strong>Add to content search</strong></a></li>")	
	//attachProfileOptions()
}



/*
-----------------------------------------------------------------------------------------------------------------------------*/
function removeTreeSelected(){
treeSelected=[];
$("#treeSelected").fadeOut();
//attachProfileOptions();
}

/*
-----------------------------------------------------------------------------------------------------------------------------*/
function setUpImageTreeUpload()
{
	if (swfi!=undefined){ $("#imageTreePlaceholder").html("<div id='treeImageUpload' ></div>");}
	
	
	var settings_default_image = {
			
			    upload_url: "/core/core_modules/admin/uploadTreeImages.aspx?idTree="+ treeValue.id_key,
				file_upload_limit : "0",
				
				file_queue_error_handler : imagefileQueueError,
				file_dialog_complete_handler : imagefileDialogComplete,
				upload_start_handler : imageuploadStartEventHandler,
				upload_progress_handler : imageuploadProgress,
				upload_error_handler : imageuploadError,
				upload_complete_handler : imageutreeploadComplete,
				file_queued_handler : imagefileQueuedFunction, 
				file_complete_handler : imagefileComplete,
				upload_success_handler : imageupload_success_function, 
				flash_url : "/core/core_js/swfupload.swf",
				debug: false,
				// Button settings
				button_image_url : imgPath+"upload_NoText_160x22.png",	// Relative to the SWF file
				button_placeholder_id : "treeImageUpload",
				button_text_style : '.button { font-family: Helvetica, Arial, sans-serif; font-size: 12pt; } .buttonSmall { font-size: 10pt; }',
				button_width: 160,
				button_height: 22,
				file_size_limit:"20480",
				file_types : "*.jpg;",
				file_types_description : "Images",
				button_window_mode: SWFUpload.WINDOW_MODE.OPAQUE,
				button_text : '<span class="button">Add Image <span class="buttonSmall">(jpg 2 MB Max)</span></span>'
			}; 
			
					
		
		swfi = new SWFUpload(settings_default_image); 
		swfi.customSettings.upload_target = "div";
		
	
	}

/*
-----------------------------------------------------------------------------------------------------------------------------*/

function removeContentFromTree(keyTree)
{
if(confirm('Rimuovo il contenuto da questo ramo?'))
{
mydata="who=removeContentFromTree&keyTree="+ keyTree +"&id_site="+ currentKeySite +"&language_id="+ languageId;

$.ajax({
   type: "POST",
   url: engineTree,
   data: mydata,
    dataType: "json",
   success: function(msg){
  	
  	if(msg.values.error!=undefined)
{

 if (msg.values.error[0].errorId==0)
 {
   	
    loadTree(languageId);
 }
 else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
 
}

  
   }
 });

}
}

/*
-----------------------------------------------------------------------------------------------------------------------------*/

function setContentToTree(keyTree)
{
if(confirm('Associo il contenuto corrente a questo ramo?'))
{
mydata="who=contentToTree&keyTree="+ keyTree +"&contentKey="+ currentContent +"&id_site="+ currentKeySite +"&language_id="+ languageId;

$.ajax({
   type: "POST",
   url: engineTree,
   data: mydata,
    dataType: "json",
   success: function(msg){
  	
  	if(msg.values.error!=undefined)
{

 if (msg.values.error[0].errorId==0)
 {
     loadTree(languageId);
 }
 else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
 
}
  	

  
   }
 });

}
}

/*
-----------------------------------------------------------------------------------------------------------------------------*/
/*
-----------------------------------------------------------------------------------------------------------------------------*/
	

function initTree()
{
simpleTree=jQuery.tree.create()
simpleTree.init("#menuTreeContents",

{

rules : {
         valid_children : [ "root" ]
       },
       
types : {

           "root" : {
              deletable : false
              ,draggable : false
         }
         },

callback : {
			onload :  function () {simpleTree.open_all()},
			onrename: function(NODE, LANG, TREE_OBJ) {//renameBranch(TREE_OBJ.get_text(NODE)); 
			},
			onselect: function(NODE, TREE_OBJ) {	
			currentContextTree[0]={"title": TREE_OBJ.get_text(NODE), "id": TREE_OBJ.get_node(NODE).attr('id'), "key": TREE_OBJ.get_node(NODE).attr('id_key')};
			//treeModify(TREE_OBJ.get_node(NODE).attr('id_key')) 
		    /*EV.preventDefault(); 
	        EV.stopPropagation(); 
	        return false; */
			},
			beforecreate: function(NODE, REF_NODE, TYPE, TREE_OBJ, RB) { TREE_OBJ.set_type("default",NODE); return true; },
			oncreate: function(NODE, REF_NODE, TYPE, TREE_OBJ, RB) { newBranch('New Node') },
			onmove : function(NODE, REF_NODE, TYPE, TREE_OBJ, RB){
						
			var idFather=TREE_OBJ.get_node(REF_NODE).attr('id');
			
			if (TYPE=="after"){ idFather=TREE_OBJ.get_node(TREE_OBJ.parent(REF_NODE)).attr('id') }
			
								
			treeUpdateOrder(idFather,TREE_OBJ.get_node(NODE).attr('id_key'),TYPE) 
			
			},
			onrgtclk: function(NODE, TREE_OBJ, EV) { 
			currentContextTree[0]={"title": TREE_OBJ.get_text(NODE), "id": TREE_OBJ.get_node(NODE).attr('id'), "key": TREE_OBJ.get_node(NODE).attr('id_key')};
			EV.preventDefault(); 
	        EV.stopPropagation(); 
	        return false; 
                                                    }
		
		},

plugins : { 


	contextmenu : { 
	
	            css : true,
		        items : {
		                my_delete : {
							label	: "Delete recursively", 
							icon	: "remove",
							visible	: function (NODE, TREE_OBJ) { 
			                    var ok = true; 
			                    $.each(NODE, function () { 
				                    if(TREE_OBJ.check("deletable", this) == false) {
					                    ok = false; 
					                    return false; 
				                    }
			                    }); 
			                    return ok; 
		                    }, 
							action	: function (NODE, TREE_OBJ) { 
							     treeDeleteRecursive(currentContextTree[0].key);
							},
							separator_before : true
						},
					    my_edit : {
							label	: "Edit", 
							icon	: "edit", 
							action	: function (NODE, TREE_OBJ) { 
							treeModify(TREE_OBJ.get_node(NODE).attr('id_key')) 
							},
							separator_before : true
						},
					    my_select : {
							label	: "Select", 
							icon	: "select", 
							action	: function (NODE, TREE_OBJ) { 
							selectTree()
							},
							separator_before : true
						},
						my_layout : {
							label	: "Manage Layout", 
							icon	: "layout", 
							action	: function (NODE, TREE_OBJ) { 
							showLayout(currentContextTree[0].id)
							},
							separator_before : true
						},
						my_layout_copy : {
							label	: "Copy Layout", 
							icon	: "layout",
							visible	: function (NODE, TREE_OBJ) { 
							     if (selectedLayout.length!=0)return false;
		                    }, 
							action	: function (NODE, TREE_OBJ) { 
							
							
							selectedLayout[0]={"title": TREE_OBJ.get_text(NODE), "id": TREE_OBJ.get_node(NODE).attr('id'), "key": TREE_OBJ.get_node(NODE).attr('id_key')}
							},
							separator_before : true
						},
						my_layout_paste : {
							label	: "Paste Layout", 
							icon	: "layout", 
							visible	: function (NODE, TREE_OBJ) { 
			                   if (selectedLayout.length==0)return false;
		                    }, 
							action	: function (NODE, TREE_OBJ) { 
							copyLayout();
							},
							separator_before : true
						},
						my_contents : {
							label	: "Contents", 
							icon	: "contents", 
							action	: function (NODE, TREE_OBJ) { 
							currentKeyTree=currentContextTree[0].key;
							contentsGet(currentContextTree[0].key);
							},
							separator_before : true
						},
						my_tocontent  : {
							label	: "Add to Content", 
							icon	: "toContent", 
							action	: function (NODE, TREE_OBJ) { 
							newTreeRelation(currentContextTree[0].key)
							},
							separator_before : true
						},
	                    create : {
		                    label	: "Add Child", 
		                    icon	: "create",
		                    visible	: function (NODE, TREE_OBJ) { 
			                    if(NODE.length != 1) return 0; 
			                    return TREE_OBJ.check("creatable", NODE); 
		                    }, 
		                    action	: function (NODE, TREE_OBJ) { 
		                        childOf=currentContextTree[0].id;
		                        TREE_OBJ.create(false, TREE_OBJ.get_node(NODE[0])); 
		                    },
		                    separator_after : true
	                    },
	                    rename : {
		                    label	: "Rename", 
		                    icon	: "rename",
		                    visible	: function (NODE, TREE_OBJ) { 
			                    if(NODE.length != 1) return false; 
			                    return TREE_OBJ.check("renameable", NODE); 
		                    }, 
		                    action	: function (NODE, TREE_OBJ) { 
			                    TREE_OBJ.rename(NODE); 
		                    },
		                    separator_after : true
	                    },
	                    remove : {
		                    label	: "Delete",
		                    icon	: "remove",
		                    visible	: function (NODE, TREE_OBJ) { 
			                    var ok = true; 
			                    $.each(NODE, function () { 
				                    if(TREE_OBJ.check("deletable", this) == false) {
					                    ok = false; 
					                    return false; 
				                    }
			                    }); 
			                    return ok; 
		                    }, 
		                    action	: function (NODE, TREE_OBJ) { 
                    //			$.each(NODE, function () { 
                    //				TREE_OBJ.remove(this); 
                    //			});
			                    TREE_OBJ.remove(this);
			                     treeDelete(currentContextTree[0].key);
                    			 
		                    } 
	}

					        
					            }
					           }
				        }
			

});

}
/*
-----------------------------------------------------------------------------------------------------------------------------*/
function copyLayout()
{

if(!confirm('Do you want to copy the Layout from '+selectedLayout[0].title + ' to ' + currentContextTree[0].title)) return false;

mydata="who=copyLayout&id_site="+ currentKeySite +"&id_language="+ languageId + "&from="+ selectedLayout[0].id + "&to="+ currentContextTree[0].id


$.ajax({
   type: "POST",
   url: engineLayout,
   dataType: "json",
   data: mydata,
   success: function(msg){
   
      if(msg.values.error!=undefined)
{

 if (msg.values.error[0].errorId==0)
 {
 openDialog("Layout copied.",200,100,2000);
selectedLayout=[];
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
-----------------------------------------------------------------------------------------------------------------------------*/
function loadTree(language_id)
{
selectedLayout=[];

if (jQuery.isFunction(simpleTree)){simpleTree.destroy();}
mydata="who=getTree&id_site="+ currentKeySite +"&language_id="+ languageId;

$.ajax({
   type: "POST",
   url: engineTree,
   dataType: "json",
   data: mydata,
   success: function(msg){
   
   if(msg.values.error!=undefined)
{

 if (msg.values.error[0].errorId==0)
 {
  $("#menuTreeContents").html(msg.values.tree[0].html).map( function(){initTree()} );
  $("#menuTree").show();
  if($("#contentForm").is(":visible")){$(".toTree").show();}
  
  getBoxListCustom(currentKeySite);
  
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
-----------------------------------------------------------------------------------------------------------------------------*/
function showLayout(KeyTree)
{

 showForm("layoutContainer");
        	
	        currentKeyTree=KeyTree
	        getBoxData(0);
	        $("#eventList").val("0");
        	
        	/*
	        $(".imgLayout").removeClass("selected")
	        $(this).addClass("selected")
	        */
}
/*
-----------------------------------------------------------------------------------------------------------------------------*/
function addChild(father)
{
            childOf=father;
	        openLayer("#newBranch",300,100);

}
/*
-----------------------------------------------------------------------------------------------------------------------------*/

function newBranch(tree_name)
	{
	
	
var treeTitle='';

if(tree_name==undefined){treeTitle=$("#new_tree_title").val()}else{treeTitle=tree_name}
	
if (treeTitle==''){alert('Insert Tree Title!'); return false;}
		
		mydata="who=newBranch&id_tree="+ childOf +"&id_site="+ currentKeySite + "&language_id="+ languageId +"&tree_title=" + treeTitle;

		$.ajax({
		   type: "POST",
		   url: engineTree,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
		   alert(languageId)
		   if(msg.values.error!=undefined)
{

 if (msg.values.error[0].errorId==0)
 {
   //alert(languageId)
		    //closeLayer("#newBranch");
		    
		    loadTree(languageId);
		      openDialog("New branch added.",200,100,2000);
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
-----------------------------------------------------------------------------------------------------------------------------*/		
function renameBranch(treeTitle)
	{
	
	
if (treeTitle==''){alert('Insert branch Title!'); return false;}
		
		mydata="who=renameBranch&id_tree="+ currentContextTree[0].key +"&id_site="+ currentKeySite + "&language_id="+ languageId +"&tree_title=" + treeTitle;

		$.ajax({
		   type: "POST",
		   url: engineTree,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
		   
		   
		   if(msg.values.error!=undefined)
{

 if (msg.values.error[0].errorId==0)
 {
   openDialog("Branch renamed correctly.",200,100,2000);
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
-----------------------------------------------------------------------------------------------------------------------------*/
	function resetTreeForm(){
		$("#tree_title").val("")
		$("#tree_description").val("")
		$("#tree_keywords").val("")
		$("#tree_link").val("")
		$("#tree_link_type").val("")
		$("#tree_enabled").attr("checked","")
		
	}

/*
-----------------------------------------------------------------------------------------------------------------------------*/
function treeModify(id_tree)
	{
		
		
		//alert(id_tree);
		//return false;
		
		currentTree=id_tree;
			
	mydata="who=getTreeValue&id_site="+ currentKeySite +"&id_tree="+ id_tree + "&language_id="+ languageId;
		
		$.ajax({
		   type: "POST",
		   url: engineTree,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
		   
		   if(msg.values.error!=undefined)
{

 if (msg.values.error[0].errorId==0)
 {
   treeValue=msg.values.tree[0]
		   treeDisplayValues()
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
-----------------------------------------------------------------------------------------------------------------------------*/	
function treeDisplayValues()
	{
		
		
		resetTreeForm();
		
		$("#tree_title").val(treeValue.title);
		$("#tree_description").val(treeValue.description);
		$("#tree_keywords").val(treeValue.keywords);
		$("#tree_link").val(treeValue.link);
		$("#tree_link_type").val(treeValue.linkType);
		$("#tree_content").val(treeValue.id_content);
		$("#tree_meta").val(treeValue.meta);
		
		if (treeValue.enabled=="True"){$("#tree_enabled").attr("checked","checked")}

		openLayer("#treeForm",800,undefined,false,true,true,"Tree modify: "+ treeValue.title);
		
		treeImageExist();
			
		return false;
		}

/*
-----------------------------------------------------------------------------------------------------------------------------*/
function treeImageExist()
	{
			
		mydata="who=treeImageExist&id_site="+ currentKeySite +"&id_tree="+ treeValue.id_key + "&language_id="+ languageId + "&imgPath=" + treePath + treeValue.id_key + ".jpg"
		
		$.ajax({
		   type: "POST",
		   url: engineTree,
		   data: mydata,
		   dataType: "json",
		     success: function(msg){
	
	 if(msg.values.error[0].errorId==0){
			   
			   if(msg.values.image[0].exist==true)
			   {
			   $("#treeImage").attr("src","/covers.aspx?img="+ treePath + treeValue.id_key + ".jpg&time="+ new Date() );
			   $("#treeImage").attr("path",treePath + treeValue.id_key + ".jpg")
			   $("#treeImageOptions").show();
			   $("#treeImage").parent().addClass("imageCropResize");
			   $("#imageTreePlaceholder").html("<div id='treeImageUpload'></div>");
			   
			   }
			   else
			   {
			   $("#treeImage").attr("alt","No Image").attr("src","");
			   $("#treeImage").removeAttr("path");
			   $("#treeImage").parent().removeClass("imageCropResize");
			   
			   $("#treeImageOptions").hide();
			   setUpImageTreeUpload();
			   }
			   
			   }else{
			   
			    if (msg.values.error[0].errorId==666){ displayActionForbidden()}
			   }
			   
			   
	   }
		 });
		return false;
		}
/*
-----------------------------------------------------------------------------------------------------------------------------*/		
function treeImageRemove()
	{
			
			if (confirm('Remove this Image??')){
			
			
		mydata="who=treeImageRemove&id_site="+ currentKeySite +"&id_tree="+ treeValue.id_key + "&language_id="+ languageId + "&imgPath=" + treePath
		
		$.ajax({
		   type: "POST",
		   url: engineTree,
		   data: mydata,
		   dataType: "json",
		     success: function(msg){
if(msg.values.error!=undefined)
{
	
	 if(msg.values.error[0].errorId==0){
	 treeImageExist()
	 
	   openDialog("Tree image removed correctly.",200,100,2000);
	 }
	  else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
 }
	 
	 }
	 
		 });
		return false;
		
		}
		else{return false;}
		
		
		}
		
		
/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function treeUpdateValues()
	{
			
		mydata="who=updateTree&id_site="+ currentKeySite +"&id_tree="+ currentTree + "&language_id="+ languageId + "&" + $(".treeserialize").serialize();
		
		showForm('processing')
	
		$.ajax({
		   type: "POST",
		   url: engineTree,
		   data: mydata,
		   dataType: "json",
		     success: function(msg){
		     
if(msg.values.error!=undefined)
{

 if (msg.values.error[0].errorId==0)
 {
 showForm()
		loadTree(languageId);
		updateTreeSelectedList(currentTree,$("#tree_title").val())
		openDialog("Tree modified correctly.",200,100,2000);
		
		closeLayer("#treeForm")
 }
 else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
 
}		     
		     
		
		   }
		 });
		return false;
		}
		
/*
-----------------------------------------------------------------------------------------------------------------------------*/		
function updateTreeSelectedList(id,title)
{
	for (i=0; i<treeSelected.length; i++)
		{
	        if (treeSelected[i].id==id){treeSelected[i].title=title;displaySelectedTree(); break;}
		}
	
}
	
	
/*
-----------------------------------------------------------------------------------------------------------------------------*/		
function getTreesRelated(id_content)
{
	
	treesRelatedsValues=[];
	currentContent=id_content;
		mydata="who=getTreesRelated&id_content="+ id_content;
		
		$.ajax({
		   type: "POST",
		   url: engineTree,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
		   
		   if(msg.values.error!=undefined)
{

 if (msg.values.error[0].errorId==0)
 {
  treesRelatedsValues=msg
		   displayTreesRelatedValues()
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
-----------------------------------------------------------------------------------------------------------------------------*/
function displayTreesRelatedValues()
{
$(".itemsTrees").remove()
	
	
	if (treesRelatedsValues.values.value!=undefined){
		for (i=0; i<treesRelatedsValues.values.value.length; i++)
		{
			
		$("#gridTrees").append("<tr class='itemsTrees' id='tr_treerelation_"+ treesRelatedsValues.values.value[i].id_relation +"' sequence='"+ i +"'><td valign='top'>"+ treesRelatedsValues.values.value[i].site_host + " - "+treesRelatedsValues.values.value[i].tree_title +"</a></td><td valign='top'><a href='#' onclick='removeTreeRelation("+ treesRelatedsValues.values.value[i].id_relation +")' title='Remove Tree Relation'><img src='"+imgPath+"relation_delete.gif' alt='' border='0'/></a></td></tr>")	
			
			}
}
}
/*
-----------------------------------------------------------------------------------------------------------------------------*/
function removeTreeRelation(idkey)
{
	
	if (confirm('This operation will remove the relation with this Tree. Are you sure?')){
	
	mydata="who=removeTreeRelation&id_content="+ currentContent +"&id_key="+  idkey ;
		
		$.ajax({
		   type: "POST",
		   url: engineTree,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
		   
		   
		   if(msg.values.error!=undefined)
{

 if (msg.values.error[0].errorId==0)
 {
 	  
		  $("#tr_treerelation_"+ idkey).remove();
		 
		   getTreesRelated(currentContent)
		     openDialog("Tree relation deleted.",200,100,2000);
 }
 else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
 
}
	
		   }
		 });
		
	}
}
/*
-----------------------------------------------------------------------------------------------------------------------------*/
function newTreeRelation(idkey)
{
	
	if (currentContent==0){ openDialog("Select a Content first.",200,100,2000);}else{
	mydata="who=newTreeRelation&id_content="+ currentContent +"&id_key="+  idkey + "&id_site="+ currentKeySite ;

	
		$.ajax({
		   type: "POST",
		   url: engineTree,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
		   
		   if(msg.values.error!=undefined)
{

 if (msg.values.error[0].errorId==0)
 {
 openDialog("Tree relation inserted.",200,100,2000);
getTreesRelated(currentContent);
 }
 else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
 
}
		   
		     
		   }
		 });
	}	
	
}

/*
-----------------------------------------------------------------------------------------------------------------------------*/

function treeImageCrop()
	{
        $("#treeImage").addClass("imageCropResize")
        showCrop("#treeImage",treePath + currentTree + ".jpg")
		return false;
		}

	/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function addSelectedTreeToSearch(){
var exist=false;
for (i=0; i<treeSelected.length; i++)
{
		exist=false;
		if (contentSearchObj.trees!=undefined){
		
		    for (z=0; z<contentSearchObj.trees.length; z++)
		    {
		   		    
    		if (treeSelected[i].key==contentSearchObj.trees[z].key){exist=true; break;}
    		
		    }
		}
		
		if (exist==false){contentSearchObj.trees.push(treeSelected[i]);contentSearchObj.trees[contentSearchObj.trees.length-1].status=1;  }
}
	
	printSelectedTreeToSearch()
	openDialog ('Filter Added',200,100,2000);	
}

/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function printSelectedTreeToSearch(){


    myArr=new Array;
	if (contentSearchObj.trees!=undefined){
	
	$(".searchTreeTr").remove();
	 for (z=0; z<contentSearchObj.trees.length; z++)
		    {
		  
		    if(contentSearchObj.trees[z].status==1){myArr.push(contentSearchObj.trees[z].key)}
		    
		    $("#searchTreeMenu table").append("<tr class='searchTreeTr' id='searchTreeTr"+z+"' index='"+z+"'><td colspan='2'><a href='#' onclick='javascript:removeTreeSearch("+z+");' style='border:none;'><img src='"+imgPath+"searchRemove.gif' alt=''/></a> <a href='#'  onclick='javascript:changeTreeStatusSearch("+z+");'><img src='"+setSearchStatus(contentSearchObj.trees[z].status)+"' alt='' style='border:none;'/></a> <a href='javascript:treeModify("+contentSearchObj.trees[z].key+",1);'>"+ displayMax(contentSearchObj.trees[z].title,30) +"</a></td></tr>")
		    }
	$("#searchTreesContents").val(myArr.join("|")) 
	checkSearchValues()
	 
	}

}

/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function removeTreeSearch(index){
$("#searchTreeTr"+index).remove();
contentSearchObj.trees.splice(index,1);
printSelectedTreeToSearch()
}	

/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function changeTreeStatusSearch(index){

if (contentSearchObj.trees[index].status==0){contentSearchObj.trees[index].status=1}else{contentSearchObj.trees[index].status=0};
printSelectedTreeToSearch();

}