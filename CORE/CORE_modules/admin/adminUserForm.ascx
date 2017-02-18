<div id="userForm" class="Forms">
<div style="margin:10px;" id="userTabs">

<ul>
<li><a href="#userTab-1">General Data</a></li>
<li><a href="#userTab-2">User Status</a></li>
</ul> 


<div id="userTab-1">
<table width="100%" border="0" cellspacing="0" cellpadding="2" id="userTab0" class="userFormTabs">


  <tr class="userTr">
    <td style="width:100px;"><span class="label" rel="userName">Name</span> <a href="#" title="">?</a></td>
    <td><input id="userName" name="userName" class="userSerialize" maxlength="20" /></td>
    <td><span class="label" rel="userSurname">Surname</span> <a href="#" title="">?</a></td>
    <td><input id="userSurname" name="userSurname" class="userSerialize" maxlength="20"/></td>
  </tr>
  
  <tr class="userTr">
    <td><span class="label" rel="userUsername">Username</span> <a href="#" title="">?</a></td>
    <td><input id="userUsername" name="userUsername" class="userSerialize" maxlength="20" /></td>
     <td><span class="label" rel="userEmail">Email</span> <a href="#" title="">?</a></td>
     <td><input id="userEmail" name="userEmail" class="userSerialize" style="width:230px;"/></td>
  </tr>
 
  <tr class="userTr">
    <td><span class="label" rel="userPassword">Password</span> <a href="#" title="">?</a></td>
    <td><input id="userPassword" name="userPassword" class="userSerialize" type="password" maxlength="20" /></td>
    <td><span class="label" rel="userPasswordConfirm">Password Confirm</span> <a href="#" title="">?</a></td>
    <td><input id="userPasswordConfirm" name="userPasswordConfirm" class="userSerialize" maxlength="20" type="password"/></td>
  </tr>
  
  
  <tr class="userTr">
    <td><span class="label" rel="userNickname">Nickname</span> <a href="#" title="">?</a></td>
    <td><input id="userNickname" name="userNickname" class="userSerialize" maxlength="20" /></td>
    <td><span class="label" rel="userHomepage">Homepage</span> <a href="#" title="">?</a></td>
    <td><input id="userHomepage" name="userHomepage" class="userSerialize" style="width:230px;"/></td>
  </tr>
  
  <tr class="userTr">
    <td><span class="label" rel="userGender">Gender</span> <a href="#" title="">?</a></td>
    <td><select id="userGender" name="userGender" class="userSerialize">
        <option value="">-- Not selected --</option>
        <option value="1">Man</option>
        <option value="0">Woman</option>
        </select>
        </td>
    <td><span class="label" rel="userBornDate">Born Date</span> <a href="#" title="">?</a></td>
    <td><select id="userBornDay" name="userBornDay" class="userSerialize">
    <option value=""> -Day- </option>
<option value="01">1</option>
<option value="02">2</option>
<option value="03">3</option>
<option value="04">4</option>
<option value="05">5</option>
<option value="06">6</option>
<option value="07">7</option>
<option value="08">8</option>
<option value="09">9</option>
<option value="10">10</option>
<option value="11">11</option>
<option value="12">12</option>
<option value="13">13</option>
<option value="14">14</option>
<option value="15">15</option>
<option value="16">16</option>
<option value="17">17</option>
<option value="18">18</option>
<option value="19">19</option>
<option value="20">20</option>
<option value="21">21</option>
<option value="22">22</option>
<option value="23">23</option>
<option value="24">24</option>
<option value="25">25</option>
<option value="26">26</option>
<option value="27">27</option>
<option value="28">28</option>
<option value="29">29</option>
<option value="30">30</option>
<option value="31">31</option>
</select> / <select id="userBornMonth" name="userBornMonth" class="userSerialize">
    <option value=""> -Month- </option>
<option value="01">Gen</option>
<option value="02">Feb</option>
<option value="03">Mar</option>
<option value="04">Apr</option>
<option value="05">May</option>
<option value="06">Jun</option>
<option value="07">Jul</option>
<option value="08">Aug</option>
<option value="09">Sep</option>
<option value="10">Oct</option>
<option value="11">Nov</option>
<option value="12">Dec</option>
</select> / <select id="userBornYear" name="userBornYear" class="userSerialize">
    <option value=""> -Year- </option>

</select> 

</td>
  </tr>
   
</table>
</div>
 
<div id="userTab-2">
<table width="100%" border="0" cellspacing="0" cellpadding="2" id="userTab1" class="userFormTabs"> 

</table>
</div>

<table width="100%" border="0" cellspacing="0" cellpadding="2" >
  <tr>
    <td colspan="4"> 
    <input type="hidden" id="idUser" name="idUser" class="userSerialize"/>
    <input type="button" value="Create User" onclick="javascript:insertUser();return false;" class="button" id="userInsertBtn" style="display:none;"/>
    <input type="button" value="Update User" onclick="javascript:updateUser();return false;" class="button" id="userUpdateBtn" style="display:none;"/>
    <input type="button" value="Close" onclick="javascript:closeLayer('#userForm');return false;" class="button"/>
    
   
</td>
  </tr>
 </table>

 </div>
</div>


<div id="userStatusSelector" style="width:180px;border:2px solid #000; background-color:#fff; position:fixed; display:none;">
<table width="100%" border="0" cellspacing="0" cellpadding="2" style="width:180px" >
<tr>
<td colspan="2">
<table width="100%" border="0" cellspacing="0" cellpadding="0"  >
<tr>
<td style="width:150px;"><strong>Select <span id="hostSiteName"></span> status</strong></td><td></td>
</tr>
</table>
</td>
</tr>

<tr>
<td><a href="#" onclick="javascript:setUserStatusTo(0)" title="Set user status to awaiting confirmation"><img src="/core/CORE_images/admin/user_status_0.gif" style="border:none;" alt="" /></a></td>
<td>User awaiting confirmation</td>
</tr>
<tr>
<td><a href="#" onclick="javascript:setUserStatusTo(1)" title="Set user status to enabled"><img src="/core/CORE_images/admin/user_status_1.gif" style="border:none;" alt="" /></a></td>
<td>User enabled</td>
</tr>
<tr>
<td><a href="#" onclick="javascript:setUserStatusTo(2)" title="Set user status to disabled"><img src="/core/CORE_images/admin/user_status_2.gif" style="border:none;" alt="" /></a></td>
<td>User disabled</td>
</tr>
<tr>
<td><a href="#" onclick="javascript:setUserStatusTo(3)" title="Set user status to not registered"><img src="/core/CORE_images/admin/user_status_3.gif" style="border:none;" alt="" /></a></td>
<td>User not registered</td>
</tr>
</table>
</div>


<div id="userProfiles" style=" z-index:10000000000000;width:180px;border:2px solid #000; background-color:#fff; position:fixed; display:none;">
<table width="100%" border="0" cellspacing="0" cellpadding="2" style="width:180px" id="profileSelector">
<tr>
<td colspan="2">
<table width="100%" border="0" cellspacing="0" cellpadding="0"  >
<tr>
<td style="width:150px;"><strong>Select Profile</strong></td>
</tr>
</table>
</td>
</tr>
</table>
</div>