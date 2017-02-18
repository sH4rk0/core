<div id="profileArchive" class="Forms">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td style="width:50%;vertical-align:top;">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td>
            <div>
            <input type="button" value="New Profile" onclick="javascript:newProfile();return false;" class="button" id="newProfileBtn"/> 
            <span style="display:none;" id="profileForm">Profile: <input type="text" id="profileName" name="profileName" /> <input type="button" value="Create Profile" onclick="javascript:insertProfile();return false;" class="button"/> <input type="button" value="Cancel" onclick="javascript:closeProfile();return false;" class="button"/>
            </span>
            </div>
            </td>
          </tr>

          <tr>
            <td>
            
        <table width="100%" border="0" cellspacing="0" cellpadding="5" id="profileGrid">
            <tr id="profileGridHeader">
            <td style="width:20px;" ><img src="/core/CORE_images/admin/column_checkmark.gif" alt=""/></td>
            <td><span><strong>Profiles</strong></span></td>
            </tr>
        </table>

            </td>
          </tr>
        </table>
</td>

<td style="width:50%; vertical-align:top;">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
    <div>
    <input type="button" value="New Role" onclick="javascript:newRole();return false;" class="button" id="newRoleBtn"/> 
    <span style="display:none;" id="roleForm">Role: <input type="text" id="roleName" name="roleName" /> <input type="button" value="Create Role" onclick="javascript:insertRole();return false;" class="button"/> <input type="button" value="Cancel" onclick="javascript:closeRole();return false;" class="button"/>
    </span>
    </div>
    </td>
  </tr>

  <tr>
    <td>
    
<table width="100%" border="0" cellspacing="0" cellpadding="5" id="roleGrid">
    <tr id="roleGridHeader">
    <td style="width:20px;" ><img src="/core/CORE_images/admin/column_checkmark.gif" alt=""/></td>
    <td><span><strong>Roles</strong></span></td>
    </tr>
</table>

    </td>
  </tr>
</table>
</td>
</tr>
</table>





</div>
