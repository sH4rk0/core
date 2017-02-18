 <div id="treeForm" style="display:none;">
    
 <div id="modalTreeTabs">

<ul>
<li><a href="#trtabs-1">Main Data</a></li>
<li><a href="#trtabs-2">Meta</a></li>
<li><a href="#trtabs-3">Description</a></li>
<li><a href="#trtabs-4">Keywords</a></li>
</ul>
    
<div  id="trtabs-1">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top">
    
    
<table width="98%" border="0" cellspacing="0" cellpadding="2">
  <tr>
    <td><span class="label" rel="Tree Title">Tree Title</span></td>
  </tr>
  <tr>
    <td><input id="tree_title" name="tree_title"  class="treeserialize"/></td>
  </tr>
<tr>
    <td><span class="label" rel="treeLink">Tree Link</span></td>
</tr>
<tr>
    <td>
    <input id="tree_link" name="tree_link" class="treeserialize"/> Link Type: <select id="tree_link_type" name="tree_link_type" class="treeserialize"><option value="0">Default</option><option value="1">Link</option><option value="2">Function</option><option value="3">Email</option></select>
    </td>
</tr>
<tr>
    <td><span class="label" rel="Tree Content">Tree Content</span></td>
</tr>
<tr>
    <td><input id="tree_content" name="tree_content"  class="treeserialize"/></td>
</tr>
<tr>
    <td><span class="label" rel="Enabled">Enabled</span></td>
  </tr>
      <tr>
    <td> <input type="checkbox"  id="tree_enabled" name="tree_enabled"  class="treeserialize" value="true"/>
</td>
</tr>
</table>  

</td>
<td valign="top">
<img src="" id="treeImage"  alt="Tree image"  />
<div id="treeImageOptions">
<a href="#" onclick="javascript:treeImageRemove();return false;" title="Remove Image"><img src="/core/CORE_images/admin/delete.gif" /></a> 
<a href="#" onclick="javascript:imageTools($('#treeImage').attr('path'),'treeImage');return false;" title="Image Tools"><img src="/core/CORE_images/admin/wrench.png" /></a>
</div>
<div id="imageTreePlaceholder"><div id="treeImageUpload"></div></div>
</td>
</tr>
</table>
</div>
    
    <div  id="trtabs-2"><textarea id="tree_meta" name="tree_meta" class="treeserialize" ></textarea></div>
    <div  id="trtabs-3"><textarea id="tree_description" name="tree_description" class="treeserialize" ></textarea></div>
    <div  id="trtabs-4"><textarea id="tree_keywords" name="tree_keywords" class="treeserialize" ></textarea></div>
        
    </div>
    
   <div style="margin-top:10px;"><input type="button" class="button" onclick="javascript:treeUpdateValues();return false;" value="Save"/>&nbsp;<input type="button" class="button" onclick="javascript:closeLayer('#treeForm');return false;" value="Close"/></div>
    </div>