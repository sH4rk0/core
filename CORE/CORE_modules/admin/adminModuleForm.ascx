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
    <td><span class="label" rel="Module Name">Module Name</span></td><td><input id="moduleName" name="moduleName" class="moduleSerialize" style="width:150px"/></td>
  </tr> 
  <tr class="siteTr instance ">
    <td><span class="label" rel="Site Username">Module Label</span></td><td><input id="moduleLabel" name="moduleLabel" class="moduleSerialize" style="width:150px"/></td>
  </tr>
  <tr class="siteTr instance ">
    <td><span class="label" rel="Module Path">Module Path</span></td><td><input id="modulePath" name="modulePath" class="moduleSerialize" style="width:300px" value="/core/core_modules/"/> </td>
  </tr>
 
  
  <tr>
    <td> 
    <input id="btnModuleInsert" type="button" class="button" value="Save" onclick="javascript:moduleInsert();return false;" />
     <input  id="btnModuleUpdate"  type="button" class="button" value="Update" onclick="javascript:moduleUpdate();return false;" />
   
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