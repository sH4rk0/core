<div id="postForm" style="display:none;">
<div style="margin:10px;">
 <table width="100%" border="0" cellspacing="0" cellpadding="5">
 <tr>
    <td><h3>CONTENT POST</h3></td>
  </tr>
  <tr>
    <td><span class="label" rel="Subject">Subject</span>: <input id="post_subject" name="post_subject"  class="postSerialize" maxlength="100" size="50"/> </td>
  </tr>
     <tr>
    <td> <textarea id="post_description" name="post_description" class="postSerialize"></textarea>
</td>
  
    
 
  <tr>
    <td>    
    
    <input type="hidden" value="" id="id_post"/>
     <input id="btnModuleInsert" type="button" class="button" value="Save" onclick="javascript:managePost();return false;" />
      <input id="Button1" type="button" class="button" value="Close" onclick="javascript:closeLayer('#postForm','resetPostForm()');return false;" />
     
 
    
    </td>
  </tr>
</table></div>
</div>
