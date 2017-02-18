<%  If CORE_USER.hasRole(CORE_USER.userRole.siteAdministrator) Then%> 
 <table width="100%" border="0" cellpadding="4" cellspacing="0" style="color:Black;">
      <tr class="backTr">
      <td class="borderTdL">Sites Admin</td>
      <td class="borderTdR"><a href="#" onclick="javascript:siteAdminToggle();return false;" class="openClose"><span id="archiveSitesSpan">+</span></a></td>
      </tr>
  </table>
<div style="margin-bottom:10px;">
<div id="archiveSites" style="display:none;" class="bottomBkg">
<table width="100%" border="0" cellspacing="0" cellpadding="4">
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
    <div style="text-align:right">
    <input type="button" class="buttonGray" onclick='javascript:newSite();return false;' value='New Site'/>
    </div>
    </td>
  </tr>
</table>
</div>
</div> 
<%End If%>
<%  If CORE_USER.hasRole(CORE_USER.userRole.treeAdministrator) Then%> 
 <table width="100%" border="0" cellpadding="4" cellspacing="0" style="color:Black;">
      <tr class="backTr"><td class="borderTdL">Sites Tree</td><td class="borderTdR"><a href="#" onclick="javascript:siteMenuToggle();return false;" class="openClose"><span id="siteMenuSpan">+</span></a></td></tr>
  </table>
  
  <div id="sitesSelector" style="margin-bottom:10px;">
  <div id="siteMenu" style="display:none;" class="bottomBkg">
  <table width="100%" border="0" cellspacing="0" cellpadding="4">
        <tr>
        <td>
         <select id="treeSelector" name="treeSelector"><option class="treeSelectors">Loading...</option></select><br />
        </td>
      </tr>
  </table>
  
  <table width="100%" border="0" cellspacing="0" cellpadding="4">
      <tr>
        <td><img src="/core/CORE_images/admin/flags/2.gif" alt="It" width="19" height="13" id="language_2" language="2" class="flags" style="vertical-align:middle;"/> <img src="/core/CORE_images/admin/flags/1.gif" alt="En" width="19" height="13" id="language_1" language="1" class="flags" style="vertical-align:middle;"/>&nbsp; </td>
      </tr>
    </table>
    
        <div id="menuTree" style="display:none;">
        <div id="menuTreeContents" ></div>
        <div class="clear"></div>
        </div>
  
  
</div>
</div>
<%End If%>

