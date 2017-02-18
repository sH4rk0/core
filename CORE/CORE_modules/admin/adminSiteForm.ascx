<div id="siteForm" class="Forms">

 <div id="modalSiteTabs">

<ul>
<li><a href="#sitabs-1">Site Data</a></li>
<li><a href="#sitabs-2">Site Meta</a></li>
<li><a href="#sitabs-3">Site Statistics Script</a></li>
</ul>


<div id="sitabs-1">
<table width="100%" border="0" cellspacing="0" cellpadding="2">
  <tr class="siteTr instance clone">
    <td style="width:150px;"><span class="label" rel="Site Domain">Site Domain</span> <a href="#" title="Complete Domain without http:// Example: www.mysite.com">?</a></td><td><input id="siteDomain" name="siteDomain" class="siteserialize" style="width:100%;"/></td>
  </tr>
  <tr class="siteTr instance ">
    <td><span class="label" rel="Site Label">Site Label</span></td><td><input id="siteLabel" name="siteLabel" class="siteserialize" style="width:100%;"/></td>
  </tr>
  <tr class="siteTr instance ">
    <td><span class="label" rel="Site Folder">Site Folder</span> <a href="#" title="Example: /core/core_sites/defaultSite/">?</a> </td><td><input id="siteFolder" name="siteFolder" class="siteserialize" style="width:100%;"/></td>
  </tr>
  <tr class="siteTr instance ">
    <td><span class="label" rel="Site Master Page">Site Master Page</span> <a href="#">?</a> </td><td><input id="siteMasterPage" name="siteMasterPage" class="siteserialize" style="width:100%;"/></td>
  </tr>
  <tr class="siteTr instance ">
    <td><span class="label" rel="Site Css">Site Css</span> <a href="#">?</a> </td><td><input id="siteCss" name="siteCss" class="siteserialize" style="width:100%;"/></td>
  </tr>
  <tr class="siteTr instance ">
    <td><span class="label" rel="Site Username">Site Username</span> <a href="#" title="Username and password for pre Login page">?</a></td><td><input id="siteUsername" name="siteUsername" class="siteserialize" maxlength="15" style="width:200px" style="width:100%;"/></td>
  </tr>
    <tr class="siteTr instance ">
    <td><span class="label" rel="Site Password">Site Password</span></td><td><input id="sitePassword" name="sitePassword" class="siteserialize" maxlength="15" style="width:200px"/></td>
  </tr>
  

 </table>
</div>
<div id="sitabs-2"><textarea id="siteMeta" name="siteMeta" style="width:100%; height:400px;" class="siteserialize"></textarea></div>
<div id="sitabs-3"><textarea id="siteStatistics" name="siteStatistics" class="siteserialize" style="width:100%; height:400px;"></textarea></div>


</div>

 <div style="margin-top:10px;">  
 <input type="button" class="button" value="Save" onclick="javascript:siteInsert();return false;" />
 <input type="button" class="button" value="Close" onclick="javascript:closeLayer('#siteForm');return false;" />
 </div>

</div>
