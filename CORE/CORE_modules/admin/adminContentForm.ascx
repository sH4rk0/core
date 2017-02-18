<div id="contentForm" style="display:none;">
<div id="modalContentTabs">

<ul>
<li><a href="#ctabs-1">Content</a></li>
<li><a href="#ctabs-2">Tags</a></li>
<li><a href="#ctabs-3">Covers</a></li>
<li><a href="#ctabs-4">Relateds</a></li>
<li><a href="#ctabs-5">Posts</a></li>
<li><a href="#ctabs-6">Trees</a></li>
</ul>
<!-- Content Detail
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
-->  
<div  id="ctabs-1">

<table width="100%" border="0" cellspacing="0" cellpadding="2">
  <tr id="tr_title">
    <td><span class="label" rel="Title">Title</span> <span style="float:right;">Valid character: A-Z a-z àòèéìù 0-9 .,:;!?'°</span></td>
  </tr>
   <tr id="tr_title_value">
    <td><input id="content_title" name="content_title"  class="serialize" style="width:70%"/>&nbsp;<select id="content_type" name="content_type" class="serialize">
<option value="0">All</option>    
<option value="1">Content</option>
<!--<option value="2">Content Related</option>  -->  
<option value="3">Content Event</option> 
<option value="4">Content Location</option> 
<option value="5">Content Post</option>
<option value="6">Content Blog</option>    
<option value="7">Content News</option> 
<option value="8">Content Album</option> 
<option value="9">Content Static</option>
<option value="10">Content Book</option>
</select></td>
  </tr>
   <tr id="tr_abstract_value">
    <td><textarea id="content_abstract" name="content_abstract" class="serialize" style="width:99%"></textarea></td>
  </tr>
   <tr>
    <td> <textarea id="content_description" name="content_description" ></textarea></td>
</tr>

<tr>
    <td>
    
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr><td><h3><span class="label" rel="Date publication">Content Date publication</span></h3></td><td><h3><span class="label" rel="Enabled">Content Enabled</span></h3></td></tr>
    <tr><td> <input id="content_publication" name="content_publication"  class="serialize"/></td><td><input type="checkbox"  id="content_enabled" name="content_enabled"  class="serialize" value="true"/></td></tr>
   </table>
    
    
    </td>
  </tr>
     
</table>

</div>
<!-- Content Tags
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
-->   
<div id="ctabs-2">

<div style="margin-bottom:10px;">
<div id="relatedTags" style="padding:10px;" class="bottomBkg">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
  <td><div style="text-align:right;"><input type="button" class="buttonGray" value="New" onclick="javascript:newTags();return false;"/></div></td>
  </tr>
</table>
<ul id="gridTags" style="margin:10px 0 0 0;"></ul>
</div>
</div>

</div>
<!-- Content Covers
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
-->  
<div  id="ctabs-3">
<div style="margin-bottom:10px;">
<div id="relatedCovers" style="padding:10px;" class="bottomBkg">
<table border="0" cellspacing="0" cellpadding="0">
<tr>
<td style="width:33px;">
<div id="coverPlaceholder" style="display:inline;"><div id="imageContent"></div></div></td>
<td>
<span style="text-align:right; display:none; font-size:10px;" id="removeAllCovers"> 
<input type="button" class="buttonGray" value="Remove All Covers" onclick="javascript:removeAllCovers();return false;"/>
<input type="button" class="buttonGray" value="Remove All Resized Covers" onclick="javascript:removeAllResizedCovers();return false;"/>
</span>
</td>
</tr>
</table>
<div class="clear" style="margin-top:10px;"></div>
<ul id="gridCovers" style="list-style-type:none; margin:10px 0 0 0 0; padding:0;"></ul>
<div class="clear"></div>
</div>
</div>   
</div>
<!-- Content Relateds
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
-->  
<div  id="ctabs-4">
<div style="margin-bottom:10px;">
<div id="relatedMaterials" style="padding:10px;" class="bottomBkg">

<table  border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td style="font-size:10px;width:33px;"><input type="button" class="buttonGray" value="New" onclick="javascript:newRelated();return false;"/></td>
    <td style="width:128px;" id="macroImagePlaceholder" ><div id="macroImageContent"></div></td>
    <td style="width:125px; display:none; font-size:10px;" id="removeAllRelated"><input type="button" class="buttonGray" value="Remove All Related" onclick="javascript:removeAllRelated();return false;"/></td>
  </tr>
</table>

<div style="height:200px; overflow: auto; margin:10px 0 0 0;">
<table width="100%" border="0" cellspacing="0" cellpadding="0" id="gridRelated" >
</table>
</div>
</div>
</div>
</div>
<!-- Content Posts
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
-->  
<div  id="ctabs-5">
<div id="postArchive" >
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
    <div>
    <select id="post_option" name="post_option" class="serialize">
    <option value="0">Disable</option>
    <option value="1">Logged with control</option>
    <option value="2">All with control</option>
    <option value="3">Logged</option>
    <option value="4">All</option>
    </select>
   
    <input type="button" value="New Post" onclick="javascript:newPost();return false;" class="button"/>
    <a id="postSelected" href="javascript:displaySelectedPost();" style="display:none;">Posts selected: <span></span></a></div>
    </td></tr>

  <tr>
    <td>
<table width="100%" border="0" cellspacing="2" cellpadding="2" class="postPagers">
  <tr>
    <td> <span class="First"><a href="#" onclick="goPostPage('first');return false;"><span class="label" rel="First">First</span></a></span> <span class="Previous"><a href="#" onclick="goPostPage('prev');return false;"><span class="label" rel="Previous">Previous</span></a></span></td>
    <td align="center" > <span class="postPages"></span></td>
    <td align="right"><span class="Next"><a href="#" onclick="goPostPage('next');return false;"><span class="label" rel="Next">Next</span></a></span> <span class="Last"><a href="#" onclick="goPostPage('last');return false;"><span class="label" rel="Last">Last</span></a></span></td>
  </tr>
</table>   
    
   </td>
  </tr>
  <tr>
    <td>
    <table width="100%" border="0" cellspacing="0" cellpadding="5" id="postGrid">
     <tr id="postGridHeader">
    <td style="width:20px;"></td>
    <td style="width:35px;"><span class="postOrder selected" rel="id" desc="0" asc="1">#ID</span></td>
    <td style="width:55px;"><span class="postOrder" desc="4" asc="5">Status</span></td>
    <td style="width:120px;"><span class="postOrder" desc="2" asc="3">Date</span></td>
    <td><span>Subject</span></td>
   
  </tr>
 
</table>




    </td>
  </tr>
  <tr>
    <td>
    
 <table width="100%" border="0" cellspacing="2" cellpadding="2" class="postPagers">
  <tr>
    <td><span class="First"><a href="#" onclick="goPostPage('first');return false;"><span class="label" rel="First">First</span></a></span> <span class="Previous"><a href="#" onclick="goPostPage('prev');return false;"><span class="label" rel="Previous">Previous</span></a></span></td>
    <td align="center" > <span class="postPages"></span></td>
    <td align="right"><span class="Next"><a href="#" onclick="goPostPage('next');return false;"><span class="label" rel="Next">Next</span></a></span> <span class="Last"><a href="#" onclick="goPostPage('last');return false;"><span class="label" rel="Last">Last</span></a></span></td>
  </tr>
</table> 
    
    </td>
  </tr>
</table>
</div>
</div>

<!-- Content Trees
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
-->  
<div  id="ctabs-6">

<div style="margin-bottom:10px;">
<div id="relatedTrees" style="padding:10px;" class="bottomBkg">
<table width="100%" border="0" cellspacing="0" cellpadding="5" id="gridTrees"></table>
</div>
</div>

</div>



</div>
</div>