<div id="archive" class="Forms">

<div class="optionHead">
<div class="optionLeftHead"></div>
<div class="optionBar">

<ul>
<li><a class="gridOptions" href="#" onclick="javascript:newContent();return false;" id="contentOptionNew"><em class="nav-new">New</em></a></li>
<li><a class="gridOptions option-disabled" href="#" onclick="javascript:deleteContentsSelected(selectedContentsSerialize());return false;"  id="contentOptionDelete"><em class="nav-delete">Delete</em></a></li>
<li>
<div style="padding-top:10px;padding-left:100px;">
<!-- ###################################################### -->
<img src="/core/CORE_images/admin/root.gif" id="searchContentImg0" alt="Sites Selected" style="display:none; cursor:pointer;" class="searchContentImg"/>
<div id="searchSiteMenu" class="filterSearchMenu" >
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr><td>Site filter mode: <span>OR</span></td><td style="text-align:right"><a href="#" onclick="javascript:clearSearch(0);">[clear]</a></td></tr>
</table>
</div>
<input type="hidden" id="searchTypeSitesContents" name="sitesSearch" class="searchContentSerialize"  value=""/>
<input type="hidden" id="searchSitesContents" name="sites" class="searchContentSerialize"  value=""/>
<!-- ###################################################### -->
<img src="/core/CORE_images/admin/user_status_3.gif" id="searchContentImg1" alt="Sites Selected" style="display:none; cursor:pointer;" class="searchContentImg"/>
<div id="searchUserMenu" class="filterSearchMenu" >
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr><td>User filter mode: <span>OR</span></td><td style="text-align:right"><a href="#" onclick="javascript:clearSearch(1);">[clear]</a></td></tr>
</table>
</div>
<input type="hidden" id="searchTypeUsersContents" name="usersSearch" class="searchContentSerialize" value=""/>
<input type="hidden" id="searchUsersContents" name="users" class="searchContentSerialize" value=""/>
<!-- ###################################################### -->
<img src="/core/CORE_images/admin/attachOff.gif" id="searchContentImg2" alt="Sites Selected" style="display:none; cursor:pointer;" class="searchContentImg"/>
<div id="searchRelatedMenu" class="filterSearchMenu" >
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr><td>Related filter mode: <span>OR</span></td><td style="text-align:right"><a href="#" onclick="javascript:clearSearch(2);">[clear]</a></td></tr>
</table>
</div>
<input type="hidden" id="searchTypeRelatedsContents" name="relatedsSearch" class="searchContentSerialize"  value=""/>
<input type="hidden" id="searchRelatedsContents" name="relateds" class="searchContentSerialize"  value=""/>
<!-- ###################################################### -->
<img src="/core/CORE_images/admin/content_context_disabled.gif" id="searchContentImg3" alt="Context Selected" style="display:none; cursor:pointer;" class="searchContentImg"/>
<div id="searchContextMenu" class="filterSearchMenu" >
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr><td>Context filter mode: <span>OR</span></td><td style="text-align:right"><a href="#" onclick="javascript:clearSearch(3);">[clear]</a></td></tr>
</table>
</div>
<input type="hidden" id="searchTypeContextsContents" name="contextsSearch" class="searchContentSerialize"  value=""/>
<input type="hidden" id="searchContextsContents" name="contexts" class="searchContentSerialize"  value=""/>
<!-- ###################################################### -->
<img src="/core/CORE_images/admin/sitemap.png" alt="Tree Selected" id="searchContentImg4" style="cursor:pointer;" class="searchContentImg"/>
<div id="searchTreeMenu" class="filterSearchMenu">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr><td>Tree filter mode: <span>OR</span></td><td style="text-align:right"><a href="#" onclick="javascript:clearSearch(4);">[clear]</a></td></tr>
</table>
</div>
<input type="hidden" id="searchTypeTreesContents" name="treesSearch" class="searchContentSerialize"  value=""/>
<input type="hidden" id="searchTreesContents" name="trees" class="searchContentSerialize"  value=""/>
<!-- ###################################################### -->
<select id="searchTypeContent" name="searchTypeContent" class="searchContentSerialize">
<option value="">All</option>    
<option value="1">Content</option>
<!--<option value="2">Content Related</option>    -->
<option value="3">Content Event</option> 
<option value="4">Content Location</option> 
<option value="5">Content Post</option>
<option value="6">Content Blog</option>    
<option value="7">Content News</option> 
<option value="8">Content Album</option> 
<option value="9">Content Static</option>
<option value="10">Content Book</option>
</select>
<input type="text" value="" id="searchText" name="searchText" class="searchContentSerialize"/> 
<input type="button" class="button" value="Search" onclick="javascript:contentsGet();"/>
</div>

</li>
</ul>
<div class="clear"></div>
</div>
<div class="optionRightHead"></div>
</div>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
    

  <tr>
    <td>
<table width="100%" border="0" cellspacing="2" cellpadding="2" class="pagers">
  <tr>
    <td> <span class="First"><a href="#" onclick="goPage('first');return false;" title="First"><span class="label" rel="First"><img src="/core/CORE_images/admin/icon_pagination_first.gif" alt="First" style="vertical-align:middle;"/></span></a></span> <span class="Previous"><a href="#" onclick="goPage('prev');return false;" title="Previous"><span class="label" rel="Previous"><img src="/core/CORE_images/admin/icon_pagination_previous.gif" alt="Previous" style="vertical-align:middle;"/></span></a></span></td>
    <td align="center" > <span class="pages"></span></td>
    <td align="right"><span class="Next"><a href="#" onclick="goPage('next');return false;" title="Next"><span class="label" rel="Next"><img src="/core/CORE_images/admin/icon_pagination_next.gif" alt="Next" style="vertical-align:middle;"/></span></a></span> <span class="Last"><a href="#" onclick="goPage('last');return false;"><span class="label" rel="Last" title="Last"><img src="/core/CORE_images/admin/icon_pagination_last.gif" alt="Last" style="vertical-align:middle;"/></span></a></span></td>
  </tr>
</table>   
    
   </td>
  </tr>
  <tr>
    <td>
<table width="100%" border="0" cellspacing="0" cellpadding="5" id="grid">
<tr id="contentGridHeader" class="gridHeader" >
    <td style="width:20px;" class="gridHeaderTd"><img src="/core/CORE_images/admin/column_checkmark.gif" /></td>
    <td style="width:35px;" class="gridHeaderTd"><span class="contentOrder selected" rel="id" desc="0" asc="1">#ID</span></td>
    <td style="width:55px;" class="gridHeaderTd"><span class="contentOrder" desc="4" asc="5">Status</span></td>
    <td style="width:55px;" class="gridHeaderTd"><span class="contentOrder" desc="18" asc="19">Type</span></td>
    <td style="width:130px;" class="gridHeaderTd"><span class="contentOrder" desc="8" asc="9">Date Creation</span></td>
    <td style="width:130px;" class="gridHeaderTd"><span class="contentOrder" desc="2" asc="3">Date Publication</span></td>
    <td class="gridHeaderTd"><span class="contentOrder" desc="6" asc="7" >Content Title</span></td>
    <td class="gridHeaderTd">&nbsp;</td>
    <td class="gridHeaderTd">&nbsp;</td>
    <td class="gridHeaderTd">&nbsp;</td>
    <td class="gridHeaderTd">&nbsp;</td>
    <td class="gridHeaderTd">&nbsp;</td>
    <td class="gridHeaderTd">&nbsp;</td>
</tr>
 
</table>




    </td>
  </tr>
  <tr>
    <td>
    
<table width="100%" border="0" cellspacing="2" cellpadding="2" class="pagers">
  <tr>
    <td> <span class="First"><a href="#" onclick="goPage('first');return false;" title="First"><span class="label" rel="First"><img src="/core/CORE_images/admin/icon_pagination_first.gif" alt="First" style="vertical-align:middle;"/></span></a></span> <span class="Previous"><a href="#" onclick="goPage('prev');return false;" title="Previous"><span class="label" rel="Previous"><img src="/core/CORE_images/admin/icon_pagination_previous.gif" alt="Previous" style="vertical-align:middle;"/></span></a></span></td>
    <td align="center" > <span class="pages"></span></td>
    <td align="right"><span class="Next"><a href="#" onclick="goPage('next');return false;" title="Next"><span class="label" rel="Next"><img src="/core/CORE_images/admin/icon_pagination_next.gif" alt="Next" style="vertical-align:middle;"/></span></a></span> <span class="Last"><a href="#" onclick="goPage('last');return false;"><span class="label" rel="Last" title="Last"><img src="/core/CORE_images/admin/icon_pagination_last.gif" alt="Last" style="vertical-align:middle;"/></span></a></span></td>
  </tr>
</table>  
    
    </td>
  </tr>
</table>
</div>
