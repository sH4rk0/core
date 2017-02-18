<%@ Import Namespace="core_content_holder" %>
<%@ Page Language="VB" Debug="true" ValidateRequest="false" Trace="false" EnableEventValidation="false"%>
<script language="vb" runat="server"> 
    Public root_mypage As CORE_PAGE = New CORE_PAGE()
    Sub Page_Init()
        HttpContext.Current.Handler = CType(Activator.CreateInstance(Me.GetType()), IHttpHandler)
    End Sub

Sub Page_load()
        Try
        
            If CORE_USER.isLogged Then
                ltToken.Text = CORE_CRYPTOGRAPHY.encrypt(CORE_USER.getUserId)
            Else
                ltToken.Text = CORE_CRYPTOGRAPHY.encrypt(0)
            End If
        
            If root_mypage.id_content > 0 Then ltTokenC.Text = CORE_CRYPTOGRAPHY.encrypt(root_mypage.id_content) Else ltTokenC.Text = CORE_CRYPTOGRAPHY.encrypt(0)
            ltTokenS.Text = CORE_CRYPTOGRAPHY.encrypt(root_mypage.id_site)
            ltTokenL.Text = CORE_CRYPTOGRAPHY.encrypt(root_mypage.language_id)
            ltGlobal.Text = root_mypage.site_meta
            ltTree.Text = root_mypage.treeObject.tree_meta
            ltStatistics.Text = root_mypage.site_statistics
            Session.CodePage = 65001
            Response.Charset = "UTF-8"
            Dim myobj As CORE_MODULE
            Dim myobjmeta As CORE_MODULE = New CORE_MODULE("box_manager_meta")
            phAdminContents.Controls.Add(LoadControl("/core/" & myobjmeta.module_path))
                     
        Catch ex As Exception
            CORE.application_error_trace(ex.ToString())
        End Try
    End Sub

</script><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="it" lang="it" class="no-js">
<head runat="server">
<title>The 8-bit Governor page</title>

<asp:literal id="ltGlobal" runat="server"  EnableViewState="false"/>
<asp:literal id="ltTree" runat="server"  EnableViewState="false"/>

<script type="text/javascript">
var token='<asp:literal id="ltToken" runat="server"  EnableViewState="false"/>';
var tokenC='<asp:literal id="ltTokenC" runat="server"  EnableViewState="false"/>';
var tokenS='<asp:literal id="ltTokenS" runat="server"  EnableViewState="false"/>';
var tokenL='<asp:literal id="ltTokenL" runat="server"  EnableViewState="false"/>';
</script>
</head>

<body>

<form id="main_form" runat="server">
<div id="viewporter">
<div id="sitelayoutContainer">
<div id="sitelayout">
<div>
<header>
<div id="loadingBar"><span></span></div>
<h1><span><%=root_mypage.site_label%></span></h1>
</header>



<div id="parallaxcontainer" class="parallaxcontainer">
		<div id="parallaxscene" class="parallaxscene">
			<div class="layer" id="parallax-sky" data-depth="0"></div>
            <div class="layer" id="parallax-palace" data-depth="0.10"></div>
			<div class="layer" id="parallax-duomo"  data-depth="0.25"></div>
            <div class="layer" id="parallax-say"  data-depth="0.05">  <p id="salvini">Loading...</p></div>
          	<div class="layer" id="parallax-tombins"  data-depth="0"></div>
			<div class="layer" id="parallax-place" data-depth="0.4"></div>
            <div class="layer" id="parallax-salvini" data-depth="0"></div>
		</div>
</div>

</div>

<div id="footer">
<a href='http://www.zero89.it' id='core' title='Powered with CORE' target='_blank'><span>Tap/click the manholes!!!</span></a>
</div>
</div>
</div>
</div>
<!--<asp:PlaceHolder id="phAdminContents" runat="server" Visible="false" EnableViewState="false" />-->
</form>
<asp:literal id="ltStatistics" runat="server"  EnableViewState="false"/>
</body>
</html>
