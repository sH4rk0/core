


<script runat="server">


'//////////////////////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////////////////////
    Sub page_load()

    End Sub



'//////////////////////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////////////////////
    Sub do_logout(ByVal s As Object, ByVal e As EventArgs)
        CORE_USER.userLogout()
        Response.Redirect("/console.aspx")
    End Sub

</script>

<div style="line-height: 1; height: 113px;" class="header" id="header">
<div class="header-container">
	<div class="logo-header-container">
		<div class="logo-text"><a href="http://core.zero89.it">Core.Zero89.it</a></div>
		<div class="suite-logo"></div> 
		<div class="top-bar">
			<p>Welcome: <span><%=CORE_COOKIE.getValue("user_name")%> <%=CORE_COOKIE.getValue("user_surname")%></span></p>
			<p><asp:linkbutton ID="btnLogOut"  onclick="do_logout" runat="server" >Logout</asp:linkbutton></p>
			<p></p>
			<p class="flyout"></p>
		</div>
	</div>
	<div class="menu-header clear-fix">
	<div class="tabs clear-fix tabs-menu">
		<ul class="nav clear-fix" id="nav">
		    <li><a href="#home">Home</a></li>
			<li><a href="#main">Manage</a>
			<ul>
			<li class="first-nav-item" ><a href="#contents" onclick="javascript:startUpContents();return false;">Contents</a></li>
			<li class="first-nav-item" ><a href="#relateds" onclick="javascript:startUpRelateds();return false;">Relateds</a></li>
			<li class="first-nav-item" ><a href="#contexts" onclick="javascript:startUpContexts();return false;">Contexts</a></li>
			<li class="first-nav-item" ><a href="#users" onclick="javascript:startUpUsers();return false;">Users</a></li>
			<li class="last-nav-item" ><a href="#" onclick="javascript:startUpProfiles();return false;">Roles & Profiles</a></li>
			</ul>
			
			</li>
								
			<li style="margin-right:80px"><a href="#tools" ><span class="label" rel="Tools">Tools</span></a> 
			<ul><li class="first-nav-item" ><a href="#" onclick="javascript:cacheRemove('contents');return false;">Remove Cache</a></li>
			<li class="last-nav-item" ><a href="#" onclick="javascript:getLogList();return false;">Logs</a></li>
			<li class="last-nav-item" ><a href="#" onclick="javascript:exportDatabase();return false;">Export Database</a></li>
			<li class="last-nav-item" ><a href="#" onclick="javascript:searcherKeyGen();return false;">Searcher KeyGen</a></li>
			
			</ul>
			</li>
			
			<li style="display:none;" id="contentSelected"><a href="#" >Contents <span></span>&nbsp;<img src="/CORE/CORE_images/admin/cross-red.png" style="vertical-align:middle;" onclick="javascript:removeContentSelected();return false;" style="border:none;" alt=""/></a>
			<ul id="contentSelectedList"></ul>
			
			</li>
<li style="display:none;" id="relatedSelected"><a href="#" >Relateds <span></span>&nbsp;<img src="/CORE/CORE_images/admin/cross-red.png" style="vertical-align:middle;" onclick="javascript:removeRelatedSelected();return false;" style="border:none;" alt=""/></a> <ul id="relatedSelectedList"></ul></li>
	
	

	<li style="display:none;" id="contextSelected"><a href="#" >Contexts <span></span>&nbsp;<img src="/CORE/CORE_images/admin/cross-red.png" style="vertical-align:middle;" onclick="javascript:removeContextSelected();return false;" style="border:none;" alt=""/></a><ul id="contextSelectedList"></ul></li>
	
	
	<li style="display:none;" id="treeSelected"><a href="#" >Trees <span></span>&nbsp;<img src="/CORE/CORE_images/admin/cross-red.png" style="vertical-align:middle;" onclick="javascript:removeTreeSelected();return false;" style="border:none;" alt=""/></a> <ul id="treeSelectedList"></ul></li>
	
<li style="display:none;" id="userSelected"><a href="#"  >Users <span></span>&nbsp;<img src="/CORE/CORE_images/admin/cross-red.png" style="vertical-align:middle;" onclick="javascript:removeUserSelected();return false;" style="border:none;" alt=""/></a><ul id="userSelectedList"></ul></li>

<li style="display:none;" id="profileSelected"><a href="#"  >Profiles <span></span>&nbsp;<img src="/CORE/CORE_images/admin/cross-red.png" style="vertical-align:middle;" onclick="javascript:removeProfileSelected();return false;" style="border:none;" alt=""/></a>
<ul id="profileSelectedList"></ul>

</li>
<li style="display:none;" id="roleSelected"><a href="#"  >Roles <span></span>&nbsp;<img src="/CORE/CORE_images/admin/cross-red.png" style="vertical-align:middle;" onclick="javascript:removeRoleSelected();return false;" style="border:none;" alt=""/></a><ul id="roleSelectedList"></ul></li>

		</ul>
	</div>
		<!--<div class="right-content">


			<div class="flyout" id="header-newfeatures">
				<img src="/CORE/CORE_images/admin/new-features-icon.gif" class="flyout" alt="New features"/>
				<span class="flyout"><a onclick="return false;" href="javascrip: return false;">New Features</a></span>
			</div>
			<div class="flyout" id="header-feedback">
				<img src="/CORE/CORE_images/admin/feedback-icon.gif" class="flyout" alt="feedback"/>
				<span class="flyout"><a onclick="return false;" href="javascrip: return false;">Feedback</a></span>
			</div>
		</div>-->
	</div>
	<div class="header-title">
		<div class="container">
			<span class="header-title-left"><span id="section"></span></span>
<!--
<span class="header-title-right">zero89.it	<a href="AccountList.aspx">(Change Account)</a></span>
<span class="header-title-right">
<img src="/CORE/CORE_images/admin/spacer.gif" id="spacer"/><a class="header_link" href="RedirectSCC.aspx?app=wmt">Google Webmaster Tools</a>
</span>
-->
		</div>
	</div>
</div>
</div>



