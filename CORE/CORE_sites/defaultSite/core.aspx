<%@ Import Namespace="core_content_holder" %>
<%@ Import Namespace="System.Web.Optimization"%>

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
              
            Dim adminLayout As String = String.Empty
            'If CORE_USER.hasProfile(CORE_USER.userProfile.administrator) Then
            '    myobj = New CORE_MODULE("box_manager_content")
            '    phAdminContents.Controls.Add(LoadControl("/core/" & myobj.module_path))
            '    phAdminContents.Visible = True
            '    phAdminContents.Dispose()
            'End If

            'If CORE_USER.hasProfile(CORE_USER.userProfile.administrator) Then
            '    myobj = New CORE_MODULE("box_manager_layout")
            '    phAdminLayout.Controls.Add(LoadControl("/core/" & myobj.module_path))
            '    adminLayout = "Admin"
            '    phAdminLayout.Visible = True
            '    phAdminLayout.Dispose()
            'End If
                        
       
            myobj = New CORE_MODULE("box_manager")
            Dim _layout_path As String = CORE.module_path("", "core_layout/" & root_mypage.layout.ToString() & "/layout" & adminLayout & ".ascx")
            phLayout.Controls.Add(LoadControl(_layout_path))
        Catch ex As Exception
            CORE.application_error_trace(ex.ToString())
        End Try
    End Sub

</script><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="it" lang="it" class="no-js">
<head runat="server">
<title></title>

<asp:literal id="ltGlobal" runat="server"  EnableViewState="false"/>
<asp:literal id="ltTree" runat="server"  EnableViewState="false"/>


<asp:PlaceHolder runat="server">        
       
      
</asp:PlaceHolder>


<script type="text/javascript">
var token='<asp:literal id="ltToken" runat="server"  EnableViewState="false"/>';
var tokenC='<asp:literal id="ltTokenC" runat="server"  EnableViewState="false"/>';
var tokenS='<asp:literal id="ltTokenS" runat="server"  EnableViewState="false"/>';
var tokenL='<asp:literal id="ltTokenL" runat="server"  EnableViewState="false"/>';
</script>
</head>

<body>
<h1><span><%=root_mypage.site_label%></span></h1>

<form id="main_form" runat="server">


<div id="viewporter">
<div id="sitelayoutContainer">
<header>
<div id="headerMin" class="headerMin"><div id="headerMinWrapper"><div class="menuBtn"></div> <div class="menuLogo">ZERO89.IT</div><div class="goTop"></div></div></div>
<div style="position:relative; height:150px; width:100%; overflow:hidden;">
<div class="loadingHeader">Loading Header...</div>
<div id="parallaxcontainer" class="parallaxcontainer">
		<div id="parallaxscene" class="parallaxscene">
			<div class="layer" id="parallaxBg" data-depth="0.05"></div>
            <div class="layer" id="starsGame" data-depth="0" style="width:100%;"></div>
			<div class="layer" id="parallaxMountains"  data-depth="0.15"></div>
			<div class="layer" id="parallaxCastle" data-depth="0.20"></div>
			<div class="layer" id="parallaxTrees"  data-depth="0.25"></div>
			<div class="layer" id="parallaxLand" data-depth="0.35"></div>
			<div class="layer" id="parallaxWater" data-depth="0.45"></div>
            <div class="layer" id="parallaxMenu" data-depth="0.03"></div>
            <div class="layer" id="headerGame" data-depth="0.03" style="width:100%; z-index:6;"></div>
		</div>
	</div>
</div>
</header>

<div id="sitelayout">


<asp:placeholder id="phLayout" runat="server"/>



</div>
<div id="footerGame">

<div id="image-of-me-wrapper">
<div id="image-of-me"></div></div>
<div id="about-me">
<p>My name is Francesco Raimondo. <br><br>I'm Presentation Layer Architect @ <a href="http://www.healthwareinternational.com" target="_blank" title="healthwareinternational.com" class="cyan">HealthwareInternational</a>.</p>
<p>I'm responsible for defining the front-end layer of web and HTML mobile applications.</p>
<p>I have 15 year of experience in web development and 5 years of experience in developing HTML5 eDetailing presentations on CLM platforms.</p>
<p>I am also Co-founder of <a href="http://www.cyclosee.com" target="_blank" title="Cyclosee, communicate everything everywhere" class="cyan">CYCLOSEE</a>, a mobile SaaS CLM platform that can be easily customized to meet business needs.</p>
</div>
<div id="contact-me">
<div class="contact" id="contact-me-linkedin"><a href="https://www.linkedin.com/in/francescoraimondo" target="_blank" title="Linkedin profile">L1nk3d1n</a></div>
<div class="contact" id="contact-me-facebook"><a href="https://www.facebook.com/lucutus" target="_blank" title="Facebook page">:DB00k</a></div>
<div class="contact" id="contact-me-twitter"><a href="https://twitter.com/zeroottonove" target="_blank" title="Twitter profile">7w1773r</a></div>
<div class="contact" id="contact-me-googleplus"><a href="https://plus.google.com/+francescoraimondo089" target="_blank" title="Google plus page">gP1u5</a></div>
</div>

</div>
</div>
</div>
<!--<asp:PlaceHolder id="phAdminContents" runat="server" Visible="false" EnableViewState="false" />
<asp:PlaceHolder id="phAdminLayout" runat="server" Visible="false" EnableViewState="false" />-->
</form>
<asp:literal id="ltStatistics" runat="server"  EnableViewState="false"/>
</body>
</html>
