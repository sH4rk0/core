
<div id="contentFormNew" class="Forms">
<div style="margin:10px">
<table width="100%" border="0" cellspacing="0" cellpadding="2">
  <tr id="tr_title">
    <td><span class="label" rel="Title">Title</span> <span style="float:right;">Valid character: A-Z a-z àòèéìù 0-9 .,:;!?'°</span></td>
  </tr>
  <tr id="tr_title_value">
    <td><input id="content_title_new" name="content_title_new" style="width:460px;"/>&nbsp;<select id="content_type_new" name="content_type_new"><option value="1">Content</option>
<option value="2">Content Related</option>    
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
  <tr>
    <td>
    <input type="button" value="Create" onclick="javascript:insertContent();return false;" class="button"/>
    <input type="button" value="Close" onclick="javascript:closeLayer('#contentFormNew');return false;" class="button"/>
</td>
  </tr>
 </table>
 </div>
</div>