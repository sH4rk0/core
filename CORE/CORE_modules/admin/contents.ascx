<script type="text/javascript" language="javascript">
var coversPath="<%=ConfigurationManager.AppSettings("CORE_related_folder").replace("\","/") %>"
var treePath="<%=ConfigurationManager.AppSettings("CORE_tree_folder").replace("\","/") %>"
</script>
<script src="/CORE/Core_js/admin.js" type="text/javascript"></script>

<script src="/CORE/Core_js/admin_tree.js" type="text/javascript"></script>
<script src="/CORE/Core_js/admin_contents.js" type="text/javascript"></script>
<script src="/CORE/Core_js/admin_related.js" type="text/javascript"></script>
<script src="/CORE/Core_js/admin_covers.js" type="text/javascript"></script>
<script src="/CORE/Core_js/admin_context.js" type="text/javascript"></script>
<script src="/CORE/Core_js/admin_layout.js" type="text/javascript"></script>
<script src="/CORE/Core_js/admin_site.js" type="text/javascript"></script>
<script src="/CORE/Core_js/admin_module.js" type="text/javascript"></script>
<script src="/CORE/Core_js/admin_macroUpload.js" type="text/javascript"></script>
<script src="/CORE/Core_js/admin_imageTools.js" type="text/javascript"></script>

<script type="text/javascript" src="/CORE/Core_js/jquery-ui/ui.core.js"></script>
<script type="text/javascript" src="/CORE/Core_js/jquery-ui/ui.draggable.js"></script>
<script type="text/javascript" src="/CORE/Core_js/jquery-ui/ui.droppable.js"></script>
<script type="text/javascript" src="/CORE/Core_js/jquery-ui/ui.sortable.js"></script>

<script src="/CORE/Core_js/jquery.qtip-1.0.0-rc3.min.js" type="text/javascript"></script>
<script src="/CORE/Core_js/jquery.simple.tree.js" type="text/javascript" ></script>

<script src="/CORE/CORE_js/jquery.Jcrop.min.js"type="text/javascript"></script>

<script src="/CORE/Core_js/swfupload.js" type="text/javascript"></script>
<script src="/CORE/Core_js/swfuploadHandlers.js" type="text/javascript"></script>
<script src="/CORE/Core_js/swfuploadImageHandlers.js" type="text/javascript"></script>
<script src="/CORE/Core_js/swfuploadMacroHandlers.js" type="text/javascript"></script>


<script type="text/javascript" src="/fckeditor/fckeditor.js"></script>

<link rel="stylesheet" href="/CORE/CORE_js/jquery.Jcrop.css" type="text/css" />

  <!--
////////////////////////////////////////////////////////////////
-->
<div class="contextMenu" id="myMenu1">
	<ul>
	<li class="treeEdit"><span><img src="/core/core_images/admin/folder_edit.png" /> Edit</span></li>
		<li class="treeAdd"><span><img src="/core/core_images/admin/folder_add.png" /> Add child</span></li>
		<li class="treeContents"><span><img src="/core/core_images/admin/content_context_disabled.gif" /> Contents</span></li>
		<li class="treeAddContent"><span><img src="/core/core_images/admin/copy_clipboard.gif" /> Add to Content</span></li>
	
	<li class="treeSelect"><span><img src="/core/core_images/admin/checkedOn.gif" /> Select</span></li>	
		<li class="treeLayout"><span><img src="/core/core_images/admin/layout_ico.png" /> Layout</span></li>
		
		<li class="treeDelete"><span><img src="/core/core_images/admin/folder_delete.png" /> Delete</span></li>
	</ul>
</div>

  <!--
////////////////////////////////////////////////////////////////
-->

<div id="fitTools" class="window">
	
    <div id="fitToolsTop">
		<div id="fitToolsTopContent" style="text-align:right;">
		
        <div id="toolsOptionsImages">
        <a href="#" onclick="javascript:showInfo()" rel="Info" title="Info Image" class="toolsOption" id="toolOptionInfo"><span>Info</span></a> <a href="#" onclick="javascript:showCrop()" rel="Crop" title="Crop Image" class="toolsOption" id="toolOptionCrop"><span>Crop</span></a> <a href="#" onclick="javascript:showResize()" rel="Resize" title="Resize Image" class="toolsOption" id="toolOptionResize"><span>Resize</span></a>
        </div>
        
        <a href="#" onclick="javascript:imageToolsClose();" ><span  class="label" rel="Close">Close</span></a>
        </div>
    </div>
    <div id="fitToolsWrapper">
        <div id="fitToolsContent">
        <div id="imageToolsOption">



<div id="infoOptions" class="toolsOptions">
<table width="100%" cellpadding="0" cellspacing="0">
<tr>
<td>Name:</td><td><span id="infoName"></span></td>
</tr>
<tr>
<td>Path:</td><td><span id="infoPath"></span></td>
</tr>
<tr>
<td>Width:</td><td><span id="infoWidth"></span>px</td>
</tr>
<tr>
<td>Height:</td><td><span id="infoHeight"></span>px</td>
</tr>
<tr>
<td>Size:</td><td><span id="infoSize"></span>Kb</td>
</tr>
</table>
 
</div>


<div id="cropOptions" class="toolsOptions">
<label><input type="hidden"  id="cropX" name="cropX" class="cropSerialize"/></label>
<label><input type="hidden"  id="cropY" name="cropY" class="cropSerialize"/></label>
<label><input type="hidden"  id="cropX2" name="cropX2" class="cropSerialize"/></label>
<label><input type="hidden"  id="cropY2" name="cropY2" class="cropSerialize"/></label>
<label>Width:<input type="text" size="4" id="cropW" name="cropW" class="cropSerialize"/></label>
<label>Height: <input type="text" size="4" id="cropH" name="cropH" class="cropSerialize"/></label>
<div style="margin-top:10px;"><a href="#" onclick="javascript:crop();" class="button" rel="Make Crop"><span>Make Crop</span></a></div>
</div>

<div id="resizeOptions" class="toolsOptions" >
<label>New Width:<input type="text" size="4" id="resizeW" name="resizeW" class="resizeSerialize"/></label>
<label>New Height: <input type="text" size="4" id="resizeH" name="resizeH" class="resizeSerialize"/></label>
<div style="margin-top:10px;"><a href="#" onclick="javascript:resize();" class="button" rel="Make Resize"><span>Make Resize</span></a></div>
</div>
</div>
        
        </div>
    </div>
    <div id="fitToolsBottom"><div id="fitToolsBottomContent">&nbsp;</div></div>
   
</div>

  <!--
////////////////////////////////////////////////////////////////
-->
<div id="imageTools" class="Forms">
<img id="imageToolsSource"  scr="" alt=""/>
</div>

  <!--
////////////////////////////////////////////////////////////////
-->
<div id="relatedSelectedMenu" class="Forms">
<div style="margin:10px;">
<ul id="relatedSelectedList"></ul>
<div style="margin-top:10px;"><a href="#"  class="button" rel="Add to current content"><span>Add to current content</span></a> <a href="#" onclick="javascript:addRelatedToContents()" class="button" rel="Add to selected content"><span>Add to selected content</span></a> <a href="#"  onclick="javascript:removeRelatedSelected();closeLayer('#relatedSelectedMenu');return false;" class="button" rel="Clear and Close"><span>Clear and Close</span></a> <a href="#"  onclick="javascript:closeLayer('#relatedSelectedMenu');return false;" class="button" rel="Close"><span>Close</span></a> </div><div class="clear"></div>
</div>
</div>

  <!--
////////////////////////////////////////////////////////////////
-->
<div id="treeSelectedMenu" class="Forms">
<div style="margin:10px;">
<ul id="treeSelectedList"></ul>
<div style="margin-top:10px;">
<a href="#"  onclick="javascript:removeTreeSelected();closeLayer('#treeSelectedMenu');return false;" class="button" rel="Clear and Close"><span>Clear and Close</span></a> 
<a href="#"  onclick="javascript:closeLayer('#treeSelectedMenu');return false;" class="button" rel="Close"><span>Close</span></a> </div><div class="clear"></div>
</div>
</div>

  <!--
////////////////////////////////////////////////////////////////
-->
<div id="contentSelectedMenu" class="Forms">
<div style="margin:10px;">
<ul id="contentSelectedList"></ul>
<div style="margin-top:10px;"> <a href="#"  onclick="javascript:deleteContentsSelected(selectedContentsSerialize());return false;" class="button" rel="Delete"><span>Delete</span></a> <a href="#"  onclick="javascript:removeContentSelected();closeLayer('#contentSelectedMenu');return false;" class="button" rel="Clear and Close"><span>Clear and Close</span></a> <a href="#"  onclick="javascript:closeLayer('#contentSelectedMenu');return false;" class="button" rel="Close"><span>Close</span></a></div><div class="clear"></div>
</div>
</div>

  <!--
////////////////////////////////////////////////////////////////
-->


<table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
    <td valign="top">
    
    <table width="100%" border="0" cellpadding="5" cellspacing="5">
      <tr>
        <td width="200" bgcolor="#FFFFFF" valign="top">
        

         <div id="sitesSelector">
        
        <table width="100%" border="0" cellspacing="5" cellpadding="5">
        <tr bgcolor="#CCCCCC">
        <td>
        Select site:<br />
        <select id="treeSelector" name="treeSelector"><option class="treeSelectors">Loading...</option></select><br />
        <a href="#" onclick="javascript:$('#archiveSites').fadeIn();">Open Site Admin List</a>
        </td>
      </tr>
      <tr bgcolor="#CCCCCC">
        <td><img src="/core/CORE_images/admin/flags/2.gif" alt="It" width="19" height="13" id="language_2" language="2" class="flags"> <img src="/core/CORE_images/admin/flags/1.gif" alt="En" width="19" height="13" id="language_1" language="1" class="flags"> </td>
      </tr>
    </table>
        
        </div>
        
        <div id="menuTree">
        <div id="menuTreeContents"></div>
        </div>
        
        <div id="menuSites"></div>
                <!--
////////////////////////////////////////////////////////////////
-->
<div id="archiveSites" style="display:none;">
  <table width="100%" border="0" cellpadding="5" cellspacing="5">
      <tr><td bgcolor="#CCCCCC">Site List Admin</td></tr></table>
        
<table width="100%" border="0" cellspacing="0" cellpadding="5">

  <tr>
    <td>
    <div><a href="#" onclick="javascript:newSite();return false;"><span class="label" rel="New Site">New Site</span></a></div>
    </td>
  </tr>
  <tr>
    <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" >
         <tr>
         <td id="gridSites"></td>
         </tr>
         </table>
    </td>
</tr>
<tr>
    <td>
    <a href="#" onclick="javascript:$('#archiveSites').fadeOut();">Close</a>
    </td>
  </tr>
</table>



</div>        <!--
////////////////////////////////////////////////////////////////
-->
        </td>
        <td valign="top" bgcolor="#FFFFFF" id="main">
  <!--
////////////////////////////////////////////////////////////////
-->      
<div id="processing" class="Forms"><img src="/CORE/CORE_images/admin/loading_circle.gif" alt="Processing..." /></div>    
  
  
 <!--
////////////////////////////////////////////////////////////////
-->
<div id="contentFormNew" class="Forms">
<table width="100%" border="0" cellspacing="0" cellpadding="2">
  <tr id="tr_title">
    <td><span class="label" rel="Title">Title</span></td>
  </tr>
  <tr id="tr_title_value">
    <td><input id="content_title_new" name="content_title_new"/></td>
  </tr>
  <tr>
    <td> <input type="button" value="Save" onclick="javascript:insertContent();return false;"/>
</td>
  </tr>
 </table>
</div>
  <!--
////////////////////////////////////////////////////////////////
-->  
    <div id="treeForm" class="Forms">
    
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top">
    <table width="100%" border="0" cellspacing="0" cellpadding="2">
  <tr>
    <td><span class="label" rel="Tree Title">Tree Title</span></td>
  </tr>
  <tr>
    <td><input id="tree_title" name="tree_title"  class="treeserialize"/></td>
  </tr>
  <tr>
    <td><span class="label" rel="Description">Description</span></td>
  </tr>
  <tr>
    <td><textarea id="tree_description" name="tree_description" class="treeserialize"></textarea></td>
  </tr>
  <tr>
    <td><span class="label" rel="Keywords">Keywords</span></td>
  </tr>
      <tr>
    <td> <textarea id="tree_keywords" name="tree_keywords" class="treeserialize"></textarea>
</td>
</tr>
<tr>
    <td><span class="label" rel="Enabled">Enabled</span></td>
  </tr>
      <tr>
    <td> <input type="checkbox"  id="tree_enabled" name="tree_enabled"  class="treeserialize" value="true"/>
</td>
</tr>

 <tr>
    <td> <a href="#" onclick="javascript:treeUpdateValues();return false;" class="button"><span class="label" rel="Save">Save</span></a>
    </td>
  </tr>
 </table>
  </td>
    <td width="250px" valign="top">
    
    <div id="treeImageDiv" style="margin-left:20px">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td> <h3><span class="label" rel="Tree Image">Tree Image</span></h3></td>
    </tr>
</table>


<img src="" id="treeImage"  alt="Tree image"  />


<div id="treeImageOptions">
<a href="#" onclick="javascript:treeImageRemove();return false;" title="Remove Image"><img src="/core/CORE_images/admin/delete.gif" /></a> 
<a href="#" onclick="javascript:imageTools($('#treeImage').attr('path'),'treeImage');return false;" title="Image Tools"><img src="/core/CORE_images/admin/wrench.png" /></a>

</div>
 <div id="imageTreePlaceholder"><div id="treeImageUpload"></div></div>
</div>
    
    </td></tr>
    </table>
    
    </div>
    <!--
////////////////////////////////////////////////////////////////
-->  
<div id="newBranch" class="Forms">
       <div style="margin:10px">
        <div><label for="new_tree_title"><span class="label" rel="Enabled"><strong>New Tree Branch</strong></span></label></div>
        <p>
       <input id="new_tree_title" name="new_tree_title"  class="newtreeserialize"/>
       </p>
       <a href="#" onclick="javascript:newBranch();return false;" class="button"><span class="label" rel="Save">Save</span></a> <a href="#" onclick="javascript:closeLayer('#newBranch');return false;" class="button"><span class="label" rel="Close">Close</span></a>
       
        </div>
</div>
        
            <!--
////////////////////////////////////////////////////////////////
-->  
<div id="coversInfo" class="Forms">
       <div style="margin:10px">
        <div><label for="new_tree_title"><span class="label" rel="Enabled"><strong>Cover Info</strong></span></label></div>
       
       <ul id="coverInfoItems" style="margin-bottom:10px;">
       
       </ul>
      
       <div style="margin-bottom:10px;"><a href="#" onclick="javascript:removeCovers();return false;" class="button" id="removeCoversBtn"><span class="label" rel="Remove Temp Covers">Remove Temp Covers</span></a> <a href="#" onclick="javascript:closeLayer('#coversInfo');return false;" class="button"><span class="label" rel="Close">Close</span></a></div>
       <div class="clear"></div>
        </div>
</div>
        
    <!--
////////////////////////////////////////////////////////////////
-->    
<div id="contentForm" class="Forms">

<div><a href="#" onclick="javascript:$('#contentForm').hide();$('#archive').show();"><< Back to archive</a></div>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top">
    
    
    <table width="100%" border="0" cellspacing="0" cellpadding="2">
  <tr id="tr_title">
    <td><span class="label" rel="Content Title">Content Title</span></td>
  </tr>
  <tr id="tr_title_value">
    <td><input id="content_title" name="content_title"  class="serialize" style="width:100%"/></td>
  </tr>
  <tr id="tr_abstract">
    <td><span class="label" rel="Abstract">Abstract</span>s</td>
  </tr>
  <tr id="tr_abstract_value">
    <td><textarea id="content_abstract" name="content_abstract" class="serialize" style="width:100%"></textarea></td>
  </tr>
  <tr>
    <td><span class="label" rel="Full-text">Full-text</span></td>
  </tr>
      <tr>
    <td> <textarea id="content_description" name="content_description" ></textarea>
</td>
</tr>

<tr>
    <td><span class="label" rel="Date publication">Date publication</span></td>
  </tr>
      <tr>
    <td> <input id="content_publication" name="content_publication"  class="serialize"/>
</td>
</tr>
<tr>
    <td><span class="label" rel="Enabled">Enabled</span></td>
  </tr>
      <tr>
    <td> <input type="checkbox"  id="content_enabled" name="content_enabled"  class="serialize" value="true"/>
</td>

 
  <tr>
    <td>
    
    <a href="#" onclick="javascript:updateContent();return false;" class="button"><span class="label" rel="Save">Save</span></a>
</td>
  </tr>
 </table>    
    
    
    </td>
    <td width="350px" valign="top">
    
<div id="relatedCovers" style="margin-left:15px">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td id="coverPlaceholder"><div id="imageContent"></div></td>
  </tr>
</table>
<ul id="gridCovers" class="clear" style="list-style-type:none; margin:0; padding:0;"></ul>
<div class="clear"></div>
<div style="text-align:right; display:none; clear:both;" id="removeAllCovers"> <a href="#" onclick="javascript:removeAllCovers();return false;"><span class="label" rel="Remove All Covers">Remove All Covers</span></a> <a href="#" onclick="javascript:removeAllResizedCovers();return false;"><span class="label" rel="Remove All Covers">Remove All Resized Covers</span></a></div>
</div>   
<hr />
    
<div id="relatedMaterials" style="margin-left:15px">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td> <h3><span class="label" rel="Related Materiales">Related Materiales</span></h3></td>
    <td><div style="text-align:right;"><a href="#" onclick="javascript:newRelated();return false;"><span class="label" rel="New Related">New Related</span></a></div></td>
  </tr>
</table>
<div style="height:200px; overflow: auto;">
<table width="100%" border="0" cellspacing="0" cellpadding="5" id="gridRelated" >
</table>
</div>
</div>
 <div style="margin-left:20px">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td id="macroImagePlaceholder"><div id="macroImageContent"></div></td> <td> <div style="text-align:right; display:none; clear:both;" id="removeAllRelated"> <a href="#" onclick="javascript:removeAllRelated();return false;"><span class="label" rel="Remove All Related">Remove All Related</span></a></div></td>
  </tr>
</table>
</div> 
<hr />

<div id="relatedTags" style="margin-left:15px">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td> <h3><span class="label" rel="Related Tags">Related Tags</span></h3></td>
    <td><div style="text-align:right;"><a href="#" onclick="javascript:newTags();return false;"><span class="label" rel="New Tag">New Tags</span></a></div></td>
  </tr>
</table>
<ul id="gridTags">
</ul>
</div>
<hr />
<div id="relatedTrees" style="margin-left:15px">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td> <h3><span class="label" rel="Related Trees">Related Trees</span></h3></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="5" id="gridTrees"></table>
</div>



</td>
  </tr>
</table>





</div>
<!--
////////////////////////////////////////////////////////////////
-->
<div id="tagsForm" class="Forms">

<table width="100%" border="0" cellspacing="0" cellpadding="5">
  <tr>
<td>

<span class="label">Insert Tags separed by comma</span>
</td>
</tr>
  <tr>
<td>
<div style="border:1px solid #ccc; padding:5px;" id="tagsContainer">
<span id="selectedTagsContainer"></span>
<input type="text" id="context_title" style="width:100px;border:none;" />
</div>


<div id="context_helper_container" style="display:none;">
<ul id="context_helper">
</ul>
</div>

</td>
</tr>
  <tr>
<td>

<a href="#" onclick="javascript:manageTags();return false;" class="button relatedButtons" ><span class="label" rel="Save">Save</span></a>
    
    <a href="#" onclick="javascript:closeLayer('#tagsForm');return false;" class="button relatedButtons"><span class="label" rel="Close">Close</span></a>
    <a href="#" onclick="javascript:clearTags();return false;" class="button relatedButtons"><span class="label" rel="Remove All">Clear All</span></a>
</td>
</tr>
</table>
</div>


<!--
////////////////////////////////////////////////////////////////
-->
<div id="relatedMaterialsForm" >
 <div id="relatedLayer">Saving...</div>
 <table width="100%" border="0" cellspacing="0" cellpadding="5">
 <tr>
    <td><h3>Related material</h3></td>
  </tr>
  <tr>
    <td><span class="label" rel="Title">Title</span>: <input id="related_title" name="related_title"  class="relatedserialize" maxlength="100" size="50"/> </td>
  </tr>
  <tr id="tr_related_type">
    <td ><span class="label" rel="Tipology">Tipology</span>: 
    <select id="related_type" name="related_type" class="relatedserialize" onchange="setRelated()">
    <option value="0">--------</option>
    <option value="1">Url</option>
    <option value="2">Image: gif, jpg, bmp</option>
    <option value="3">Document: doc, pdf, rar, zip, txt, ppt, xls, mpeg, rtf</option>
    <option value="4">Audio: mp3, wav, wma</option>
    <option value="5">Video: flv, wmv, avi</option>
    <option value="6">Flash: swf</option>
    </select></td>
  </tr>
  <tr id="tr_related_link" class="relatedExtra">
    <td><span class="label" rel="Link">Link</span>: <input id="related_link" name="related_link"  class="relatedserialize" maxlength="200" size="50"/></td>
  </tr>
  <tr id="tr_related_file" class="relatedExtra">
    <td>
      
        <div id="swfu_container" style="margin: 0px 10px;">
		    <div id="relatedPlaceholder">
	
				<div id="spanButtonPlaceholder"></div>
	
				
		    </div>
            <div id="divFileDetails"></div>
		    <div id="divFileProgressContainer"><div id="progressBar"></div></div>
		    
	    </div>
          <input type="hidden" id="related_size" name="related_size" class="relatedserialize" value="0"/>
      </td>
  </tr>
  
  
  
  <tr id="tr_related_size" class="relatedExtra">
    <td >Width: <input id="related_width" name="related_width"  class="relatedserialize" maxlength="4" size="5"/> Height: <input id="related_height" name="related_height"  class="relatedserialize" maxlength="4" size="5"/></td>
  </tr>
  
  <tr id="tr_related_target" class="relatedExtra">
    <td >Target: Self <input type="radio"  name="related_target" id="relatedTarget0" class="relatedserialize" value="0"/> Blank<input type="radio"  name="related_target" id="relatedTarget1" class="relatedserialize" value="1"/></td>
  </tr>
  
  <tr id="tr_related_enabled" class="relatedExtra">
    <td >Enabled: <input type="checkbox"  id="related_enabled" name="related_enabled"  class="relatedserialize" value="true"/></td>
  </tr>
 
  <tr>
    <td>    
    <a href="#" onclick="javascript:manageRelated();return false;" class="button relatedButtons" ><span class="label" rel="Save">Save</span></a>
    
    <a href="#" onclick="javascript:closeLayer('#relatedMaterialsForm','resetRelated()');return false;" class="button relatedButtons"><span class="label" rel="Close">Close</span></a>
 
    
    </td>
  </tr>
</table>
</div>

<!--
////////////////////////////////////////////////////////////////
-->
<div id="archive" class="Forms">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
    <div><a href="#" onclick="javascript:newContent();return false;"><span class="label" rel="New Content">New Content</span></a></div>
    </td></tr>

  <tr>
    <td>
<table width="100%" border="0" cellspacing="2" cellpadding="2" class="pagers">
  <tr>
    <td> <span class="First"><a href="#" onclick="goPage('first');return false;"><span class="label" rel="First">First</span></a></span> <span class="Previous"><a href="#" onclick="goPage('prev');return false;"><span class="label" rel="Previous">Previous</span></a></span></td>
    <td align="center" > <span class="pages"></span></td>
    <td align="right"><span class="Next"><a href="#" onclick="goPage('next');return false;"><span class="label" rel="Next">Next</span></a></span> <span class="Last"><a href="#" onclick="goPage('last');return false;"><span class="label" rel="Last">Last</span></a></span></td>
  </tr>
</table>   
    
   </td>
  </tr>
  <tr>
    <td>
    <table width="100%" border="0" cellspacing="0" cellpadding="5" id="grid">
     <tr id="contentGridHeader">
    <td style="width:20px;"></td>
    <td style="width:35px;"><span class="contentOrder selected" rel="id" desc="0" asc="1">#ID</span></td>
    <td style="width:55px;"><span class="contentOrder" desc="4" asc="5">Status</span></td>
    <td><span class="contentOrder" desc="6" asc="7">Titolo</span></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
 
</table>




    </td>
  </tr>
  <tr>
    <td>
    
 <table width="100%" border="0" cellspacing="2" cellpadding="2" class="pagers">
  <tr>
    <td><span class="First"><a href="#" onclick="goPage('first');return false;"><span class="label" rel="First">First</span></a></span> <span class="Previous"><a href="#" onclick="goPage('prev');return false;"><span class="label" rel="Previous">Previous</span></a></span></td>
    <td align="center" > <span class="pages"></span></td>
    <td align="right"><span class="Next"><a href="#" onclick="goPage('next');return false;"><span class="label" rel="Next">Next</span></a></span> <span class="Last"><a href="#" onclick="goPage('last');return false;"><span class="label" rel="Last">Last</span></a></span></td>
  </tr>
</table> 
    
    </td>
  </tr>
</table>
</div>



 <!--
////////////////////////////////////////////////////////////////
-->
<div id="siteForm" class="Forms">
<div style="margin:10px;">
<table width="100%" border="0" cellspacing="0" cellpadding="2">
  <tr class="siteTr instance clone">
    <td><span class="label" rel="Site Domain">Site Domain</span> <a href="#" title="Complete Domain without http:// Example: www.mysite.com">?</a></td><td><input id="siteDomain" name="siteDomain" class="siteserialize"/></td>
  </tr>
  <tr class="siteTr instance ">
    <td><span class="label" rel="Site Label">Site Label</span></td><td><input id="siteLabel" name="siteLabel" class="siteserialize"/></td>
  </tr>
  <tr class="siteTr instance ">
    <td><span class="label" rel="Site Folder">Site Folder</span> <a href="#" title="Example: /core/core_sites/defaultSite/">?</a> </td><td><input id="siteFolder" name="siteFolder" class="siteserialize"/></td>
  </tr>
  <tr class="siteTr instance ">
    <td><span class="label" rel="Site Username">Site Username</span> <a href="#" title="Username and password for pre Login page">?</a></td><td><input id="siteUsername" name="siteUsername" class="siteserialize" maxlength="15" style="width:100px"/></td>
  </tr>
    <tr class="siteTr instance ">
    <td><span class="label" rel="Site Password">Site Password</span></td><td><input id="sitePassword" name="sitePassword" class="siteserialize" maxlength="15" style="width:100px"/></td>
  </tr>
  
  <tr>
    <td> 
    <a href="#" onclick="javascript:siteInsert();return false;" class="button relatedButtons" ><span class="label" rel="Save">Save</span></a>
    
    <a href="#" onclick="javascript:closeLayer('#siteForm');return false;" class="button relatedButtons"><span class="label" rel="Close">Close</span></a>
    
   
</td>
  </tr>
 </table>
 </div>
</div>



 <!--
////////////////////////////////////////////////////////////////
-->

 <div id="cache"><div style="position:absolute;top:0; right:0;"><a href="#" onclick="javascript:closeLayer('#cache');return false;" title="close"><img src="/core/CORE_images/admin/layer_close.gif" border="0" alt="close"/></a></div>
 <h3>Tools</h3>
 <ul>
 <li><a href="#" onclick="javascript:cacheRemove('contents');return false;">Remove Cache</a></li>
 </ul>
 </div>
 <!--
////////////////////////////////////////////////////////////////
-->
<div id="dialog">
<table width="100%" border="0" cellspacing="0" cellpadding="5">
 <tr>
    <td><h3></h3></td>
  </tr>
  </table> 
</div>
<!--
////////////////////////////////////////////////////////////////
-->
<div id="relatedPreview" style="display:none; width:500px; height:400px;">
<div style="text-align:right;"><a href="#" onclick="javascript:closeLayer('#relatedPreview');return false;" title="close"><img src="/core/CORE_images/admin/layer_close.gif" border="0" alt="close"/></a></div>
<iframe style="width:100%; height:100%; border:none;" src=""></iframe>
</div>
 <!--
////////////////////////////////////////////////////////////////
-->

 <div id="layoutContainer" class="Forms">
  <div>
  <a href="#" class="button" id="windowOpen" onclick="javascript:$('#window').fadeIn();return false;"  ><span class="label" rel="Open Box List">Open Box List</span></a>
  <select id="eventList" name="eventList" onchange="javascript:changeEvent()" >
	<option value="0">Home</option>
    <option value="1">Archive</option>
    <option value="2">Detail</option>
    <option value="3">Join us</option>
    <option value="4">Login</option>
	</select>
  </div>
     <div id="layout"></div>   
 </div>  
  <!--
////////////////////////////////////////////////////////////////
-->


<div id="box_form" class="Forms">

	<div>
	<h4><label for="boxTitle"><span class="label" rel="Title">Title</span></label></h4>
	<input type="text" id="boxTitle" name="boxTitle" class="boxSerialize" style="width:90%"/>
	</div>
	
	<div>
	<h4><label for="boxDescription"><span class="label" rel="Description">Description</span></label></h4>
	<textarea type="text" id="boxDescription" name="boxDescription" class="boxSerialize" rows="5" style="width:90%"></textarea>
	</div>
	
	<table >
	<tr>
	<td><h4><label for="boxIdModule"><span class="label" rel="Id Module">Id Module</span></label></h4></td>
	<td><select id="boxIdModule" name="boxIdModule" class="boxSerialize">
	<option value="">-- Select Module -- </option>
	</select></td>
	</tr>
	
	<tr>
	<td><h4><label for="boxStyle"><span class="label" rel="Style">Style</span></label></h4></td>
	<td><input type="text" id="boxStyle" name="boxStyle" class="boxSerialize"/></td>
	</tr>
	
	<tr>
	<td><h4><label for="boxContents"><span class="label" rel="Style">Contents</span></label></h4></td>
	<td><input type="text" id="boxContents" name="boxContents" class="boxSerialize"/> <a href="#" onclick="javascript:getSelectedContents();">Get Contents</a></td>
	</tr>
	
	<tr>
	<td><h4><label for="boxTrees"><span class="label" rel="Style">Trees</span></label></h4></td>
	<td><input type="text" id="boxTrees" name="boxTrees" class="boxSerialize"/> <a href="#" onclick="javascript:getSelectedTrees();">Get Trees</a></td>
	</tr>
	
	<tr>
	<td><h4><label for="boxContexts"><span class="label" rel="Style">Contexts</span></label></h4></td>
	<td><input type="text" id="boxContexts" name="boxContexts" class="boxSerialize"/> <a href="#" onclick="javascript:getSelectedContexts()">Get Contexts</a></td>
	</tr>
	
	<tr>
	<td><h4><label for="boxRelateds"><span class="label" rel="Style">Relateds</span></label></h4></td>
	<td><input type="text" id="boxRelateds" name="boxRelateds" class="boxSerialize"/> <a href="#" onclick="javascript:getSelectedRelateds()">Get Relateds</a></td>
	</tr>
	</table>
	
    <!--
	<div>
	<h4><label for="boxWidth"><span class="label" rel="Width">Width</span></label></h4>
	<input type="text" id="boxWidth" name="boxWidth" class="boxSerialize"/>
	</div>
	<div> 
	<h4><label for="boxHeight"><span class="label" rel="Height">Height</span></label></h4>
	<input type="text" id="boxHeight" name="boxHeight" class="boxSerialize"/>
	<div>
	<div>
	<h4><label for="boxCache"><span class="label" rel="Cache">Cache</span></label></h4>
	<input type="text" id="boxCache" name="boxCache" class="boxSerialize" readonly="readonly"/>
	</div>
	-->
		
	<div style="margin-top:10px;">
	<a href="#" class="button" id="boxInsert" onclick="boxInsert();return false;"><span class="label" rel="Create Box">Create Box</span></a> <a href="#" class="button" id="boxUpdate" onclick="boxUpdate();return false;"><span class="label" rel="Create Box">Update Box</span></a> <a href="#" onclick="javascript:closeLayer('#box_form');return false;" class="button relatedButtons"><span class="label" rel="Close">Close</span></a><div class="clear"></div>
	</div>
	
</div>

        
        </td>
        
       
      </tr>
    </table>
    
    </td>
  </tr>
</table>
  <!--
////////////////////////////////////////////////////////////////
-->
<div id="window" class="window">
	
    <div id="windowTop">
		<div id="windowTopContent">
        <a href="#" onclick="javascript:$('#window').fadeOut();return false;" ><span  class="label" rel="New Box">Close</span></a>
        </div>
    </div>
        
	<div id="windowWrapper" >
        <div id="windowContent">
       		<div id="box_list" class="modules"></div>
        </div>
    </div>
    
    
	<div id="windowBottom">
    <div id="windowBottomContent">
    <div class="clear">
    <a href="#" onclick="javascript:displayBox();return false;" class="button"><span  class="label" rel="New Box">New Box</span></a>
    <a href="#" onclick="javascript:displayModules();return false;" class="button"><span  class="label" rel="New Box">Manage Modules</span></a>
    <div class="clear"></div>
    </div>
    </div>
    </div>
   
</div>


  <!--
////////////////////////////////////////////////////////////////
-->

<div id="moduleForm" class="Forms">
<div style="margin:10px">

<div><a href="#" onclick="javascript:moduleNew();return false;" id="newModule"><span class="label" rel="NewModule">New Module</span></a> <a href="#" onclick="javascript:getModules();return false;" ><span class="label" rel="Refresh">Refresh</span></a>   <a href="#" onclick="javascript:closeLayer('#moduleForm');return false;"><span class="label" rel="Close">Close</span></a></div>
<div style="height:175px; margin:10px; border:1px solid #ccc; overflow:auto;">
<ul id="moduleList">
</ul>
</div>

<div id="moduleFields" style="display:none;">
<table width="100%" border="0" cellspacing="0" cellpadding="2">
 <tr class="siteTr instance ">
    <td><span class="label" rel="Site Username">Module Definition</span></td><td>
    <select id="moduleDefinition" name="moduleDefinition" class="moduleSerialize">
	<option value="Parts">Parts Module</option>
    <option value="System">System Module</option>
	</select></td>
  </tr>
  <tr class="siteTr instance ">
    <td><span class="label" rel="Module Name">Module Name</span></td><td><input id="moduleName" name="moduleName" class="moduleSerialize"/></td>
  </tr>
  <tr class="siteTr instance ">
    <td><span class="label" rel="Module Path">Module Path</span></td><td><input id="modulePath" name="modulePath" class="moduleSerialize"/></td>
  </tr>
  <tr class="siteTr instance ">
    <td><span class="label" rel="Site Username">Module Label</span></td><td><input id="moduleLabel" name="moduleLabel" class="moduleSerialize"/></td>
  </tr>
  
  <tr>
    <td> 
    <a href="#" onclick="javascript:moduleInsert();return false;" class="button relatedButtons" id="btnModuleInsert" style="display:none;"><span class="label" rel="Save">Save</span></a>
    <a href="#" onclick="javascript:moduleUpdate();return false;" class="button relatedButtons" id="btnModuleUpdate"  style="display:none;"><span class="label" rel="Save">Update</span></a>
   
</td>
  </tr>
 </table>
<input type="hidden" id="moduleIdKey" name="moduleIdKey" class="moduleSerialize"/>
<input type="hidden" id="moduleId" name="moduleId" class="moduleSerialize"/>
<input type="hidden" id="moduleType" name="moduleType" class="moduleSerialize"/>
<input type="hidden" id="moduleDescription" name="moduleDescription" class="moduleSerialize"/>
 </div>
 
 </div>
</div>




