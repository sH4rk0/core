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
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="it" lang="it">
<head runat="server">
<title></title>

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
<h1><span><%=root_mypage.site_label%></span></h1>

<form id="main_form" runat="server">
<div id="sitelayoutContainer">
<div id="sitelayout">
<asp:placeholder id="phLayout" runat="server"/>
</div>
</div>
<asp:PlaceHolder id="phAdminContents" runat="server" Visible="false" EnableViewState="false" />
<asp:PlaceHolder id="phAdminLayout" runat="server" Visible="false" EnableViewState="false" />
</form>
<asp:literal id="ltStatistics" runat="server"  EnableViewState="false"/>
</body>
</html>
