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

<input type="button" onclick="javascript:manageTags();return false;" value="Save" class="button"/>
<input type="button" onclick="javascript:closeLayer('#tagsForm');return false;" value="Close" class="button"/>
<input type="button" onclick="javascript:clearTags();return false;" value="Clear All" class="button"/>

</td>
</tr>
</table>
</div>



<div id="tagFormModify" style="display:none;">

<div id="tagsTabs">
          
<ul>
<li><a href="#ttag-1">Tag</a></li>
<li><a href="#ttag-2">Contents related</a></li>
<li><a href="#ttag-3">Contexts related</a></li>
</ul> 

<div id="ttag-1">
<div style="margin-bottom:10px;"><input type="text" id="contextTitle" style="width:100%;" /></div>
<input type="button" onclick="javascript:contextUpdate();return false;" value="Update" class="button"/>
<input type="button" onclick="javascript:closeLayer('#tagFormModify');return false;" value="Close" class="button"/>
</div>

<div id="ttag-2">
Contents
</div>

<div id="ttag-3">
<div>
<ol id="groupContexts" style="margin:0 0 0 0; padding:0 0 0 0;"></ol>
</div>
</div>

</div>
</div>
