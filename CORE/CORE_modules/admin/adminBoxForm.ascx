
<div id="box_form" class="Forms">

	
	
	
	
	<table cellpadding="0" cellspacing="3" width="100%">
	
	<tr>
	<td colspan="2">
	<div>
	<h4><label for="boxTitle"><span class="label" rel="Title">Box Title</span></label></h4>
	<input type="text" id="boxTitle" name="boxTitle" class="boxSerialize" style="width:90%"/>
	</div>
	</td>
	</tr>
	
	<tr id="boxLDescription" class="hidable">
	<td colspan="2">
	<div>
	<h4><label for="boxDescription"><span class="label" rel="Description">Box Description</span></label></h4>
	<textarea id="boxDescription" name="boxDescription" class="boxSerialize" cols="10" rows="5" style="width:90%"></textarea>
	</div>
	</td>
	</tr>
	
	<tr>
	<td colspan="2">
	<span id="boxLModule" class="hidable"><span class="label" rel="Id Module">Id Module</span> <select id="boxIdModule" name="boxIdModule" class="boxSerialize"><option value="">-- Select Module -- </option></select></span>
	Only for: <select id="boxIdSite" name="boxIdSite" class="boxSerialize">
	<option value="">-- Select Site -- </option>
	</select>
	
	<span id="boxTemplates" style="display:none;">
	Template: <select id="boxIdTemplate" name="boxIdTemplate" class="boxSerialize"></select>
	</span>
	
	</td>
	</tr>
	
	<tr  id="boxLStyle" class="hidable">
	<td><h4><label for="boxStyle"><span class="label" rel="Style">Box Style</span></label></h4></td>
	<td><input type="text" id="boxStyle" name="boxStyle" class="boxSerialize"/></td>
	</tr>
	
	<tr>
	<td colspan="2"><strong><label for="boxEnabled"><span class="label" rel="Style">Enabled</span></label></strong><input type="checkbox"  id="boxEnabled" name="boxEnabled"  class="boxSerialize" value="true"/>
	
	<span id="boxLDates" class="hidable">
	 - Box 
	Start <input type="text" id="boxDateStart" name="boxDateStart" class="boxSerialize" value=""/> - Box 
	End <input type="text" id="boxDateEnd" name="boxDateEnd" class="boxSerialize" value=""/>
	</span>
	<script type="text/javascript">
	$(function() {
		$("#boxDateStart").datepicker({showAnim: '', dateFormat: 'dd/mm/yy'});
		$("#boxDateEnd").datepicker({showAnim: '', dateFormat: 'dd/mm/yy'});
	
	});
</script>
	
	</td>
	</tr>
	<tr id="boxLRows" class="hidable">
	<td><h4><label for="boxRows"><span class="label" rel="Style">Rows</span></label></h4></td>
	<td><input type="text" id="boxRows" name="boxRows" class="boxSerialize" style="width:70px" maxlength="3"/> </td>
	</tr>
	
	<tr id="boxLContents" class="hidable">
	<td><h4><label for="boxContents"><span class="label" rel="Style">Contents</span></label></h4></td>
	<td><input type="text" id="boxContents" name="boxContents" class="boxSerialize"/> <a href="#" onclick="javascript:getSelectedContents();">Get Contents</a></td>
	</tr>
	
	<tr id="boxLTrees" class="hidable">
	<td><h4><label for="boxTrees"><span class="label" rel="Style">Trees</span></label></h4></td>
	<td><input type="text" id="boxTrees" name="boxTrees" class="boxSerialize"/> <a href="#" onclick="javascript:getSelectedTrees();">Get Trees</a></td>
	</tr>
	
	<tr id="boxLContexts" class="hidable">
	<td><h4><label for="boxContexts"><span class="label" rel="Style">Contexts</span></label></h4></td>
	<td><input type="text" id="boxContexts" name="boxContexts" class="boxSerialize"/> <a href="#" onclick="javascript:getSelectedContexts()">Get Contexts</a></td>
	</tr>
	
	<tr id="boxLRelateds" class="hidable">
	<td><h4><label for="boxRelateds"><span class="label" rel="Style">Relateds</span></label></h4></td>
	<td><input type="text" id="boxRelateds" name="boxRelateds" class="boxSerialize"/> <a href="#" onclick="javascript:getSelectedRelateds()">Get Relateds</a></td>
	</tr>
	
	<tr id="boxLUsers" class="hidable">
	<td><h4><label for="boxUsers"><span class="label" rel="Style">Users</span></label></h4></td>
	<td><input type="text" id="boxUsers" name="boxUsers" class="boxSerialize"/> <a href="#" onclick="javascript:getSelectedUsers()">Get Users</a></td>
	</tr>
	
	<tr id="boxLContentTypes" class="hidable">
	<td valign="top"><h4><label for="boxContentTypes"><span class="label" rel="Style">Content Types</span></label></h4></td>
	<td>
        
<select multiple="multiple"  id="boxContentTypes" name="boxContentTypes" class="boxSerialize">
<option value="0">All</option>
<option value="1">content</option>
<option value="2">contentRelated</option>
<option value="3">contentEvent</option>
<option value="4">contentLocation</option>
<option value="5">contentPost</option>
<option value="6">contentBlog</option>
<option value="7">contentNews</option>
<option value="8">contentAlbum</option>
<option value="9">Content Static</option> 
<option value="10">Content Book</option>
</select>
</td>
	</tr>
	
	
   <tr id="boxLDimension" class="hidable">
	<td colspan="2">Width: <input type="text" id="boxWidth" name="boxWidth" class="boxSerialize"/> Height: <input type="text" id="boxHeight" name="boxHeight" class="boxSerialize"/></td>
   </tr>
   
   <tr id="boxLCache" class="hidable">
	<td colspan="2"><input type="text" id="boxCache" name="boxCache" class="boxSerialize" readonly="readonly"/></td>
   </tr>
	
	</table>
	

			
	<div style="margin-top:10px;margin-bottom:10px;">
	
	        <input type="button" class="button" onclick="javascript:myBoxInsert();return false;" value="Create Box" id="boxInsert"/>
	        <input type="button" class="button" onclick="javascript:myBoxUpdate();return false;" value="Update Box" id="boxUpdate"/>
	        <input type="button" class="button" onclick="javascript:closeLayer('#box_form');return false;" value="Close" />

	</div>
	
</div>
