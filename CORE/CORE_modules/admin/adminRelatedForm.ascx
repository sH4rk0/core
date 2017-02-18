<div id="relatedMaterialsForm" >
 <div id="relatedLayer">Saving...</div>
 <table width="100%" border="0" cellspacing="0" cellpadding="5">
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
  <tr id="tr_related_duration" class="relatedExtra">
    <td >Duration: <input id="related_duration" name="related_duration"  class="relatedserialize" maxlength="4" size="5"/></td>
  </tr>
  
  <tr id="tr_related_target" class="relatedExtra">
    <td >Target: Self <input type="radio"  name="related_target" id="relatedTarget0" class="relatedserialize" value="0"/> Blank<input type="radio"  name="related_target" id="relatedTarget1" class="relatedserialize" value="1"/></td>
  </tr>
  
  <tr id="tr_related_enabled" class="relatedExtra">
    <td >Enabled: <input type="checkbox"  id="related_enabled" name="related_enabled"  class="relatedserialize" value="true"/></td>
  </tr>
  
  <tr id="tr_related_cover" style="display:none;"><td>
  
  <div id="relatedImageDiv" style="margin-left:20px">
   
<img src="" id="relatedImage"  alt="Cover image" style="width:70px;height:70px"  />
<div id="relatedImageOptions" >
<a href="#" onclick="javascript:relatedImageRemove();return false;" title="Remove Image"><img src="/core/CORE_images/admin/delete.gif" alt="" /></a> 
<a href="#" onclick="javascript:imageTools($('#relatedImage').attr('path'),'relatedImage');return false;" title="Image Tools"><img src="/core/CORE_images/admin/wrench.png" alt="" /></a>
</div>
 <div id="imageRelatedPlaceholder"><div id="relatedImageUpload"></div></div>
</div>
  </td></tr>
 
  <tr>
    <td>  
     <input type="button" value="Save" onclick="javascript:manageRelated();return false;" class="button"/>
      <input type="button" value="Close" onclick="javascript:closeLayer('#relatedMaterialsForm','resetRelated()');return false;" class="button"/>
  
    
    </td>
  </tr>
</table>
</div>
