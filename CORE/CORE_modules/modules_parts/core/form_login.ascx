<%@ Control Language="VB" %>
<script language="vb" runat="server">

    
    Private boxStyle As String = String.Empty
    Private boxTitle As String = String.Empty
    Private boxDescription As String = String.Empty
    'Private mypage As CORE_PAGE = Nothing
    Private siteLabel As String = String.Empty
    Private rootPath As String = String.Empty
    Public boxOption As New CORE_BOX_OPTIONS
         
    '/////////////////////////////////////////////////////////////////////////////////////////
    Sub Page_load()
        
        Dim mybox As New CORE_BOX(boxOption.id_box)
        boxStyle = mybox.style
        boxTitle = mybox.box_title
        boxDescription = mybox.box_description
        mybox.Dispose()
        mybox = Nothing
  
        'mypage = CORE.MyPage(Me).root_mypage
        'siteLabel = CORE.MyPage(Me).root_mypage.site_label ' mypage.site_label
        
        rootPath = "/" & CORE.MyPage(Me).root_mypage.language & "/1/" & CORE_formatting.urlFilter(CORE.MyPage(Me).root_mypage.site_root_tree.tree_title) & "/"
        
        If CORE_USER.isLogged Then
            phLogout.Visible = True
        Else
            phLogin.Visible = True
        End If
                 
        
      
    End Sub

    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    Sub doLogin(ByVal s As Object, ByVal e As EventArgs)
        If tbUsername.Text <> "" And tbPassword.Text <> "" Then

            'Dim access As CORE_USER.userAccess = CORE_USER.userLogin(tbUsername.Text, tbPassword.Text, CORE_USER.userProfile.noProfile, CORE_USER.userRole.noRole, mypage.id_key)
            
            Dim access As CORE_USER.userAccess = CORE_USER.userLogin(tbUsername.Text, tbPassword.Text, CORE.MyPage(Me).root_mypage.id_key, False)
            
            ' Response.Write(access)
            If access = CORE_USER.userAccess.userConfirmed Then
                Response.Redirect("/")
            ElseIf access = CORE_USER.userAccess.userCredentialError Then
                ltErrorMessage.Text = "Invalid Login"
            ElseIf access = CORE_USER.userAccess.userRegistrationAttendeance Then
            ElseIf access = CORE_USER.userAccess.userStatusDisabled Then
            End If
            
        End If
    End Sub
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    Sub doLogout(ByVal s As Object, ByVal e As EventArgs)
        CORE_USER.userLogout()
        Response.Redirect("/")
    End Sub
  </script>

<asp:PlaceHolder ID="phLogin" runat="server" visible="false" EnableViewState="false">

<script type="text/javascript" src="/core/CORE_js/checkEmail.js"></script>
<script type="text/javascript">
var userName='<%=tbUsername.clientid %>';
var userPassword='<%=tbPassword.clientid %>';

$(document).ready(function(){

$("#"+userName).focus(function(){if($(this).val()=='Email'){$(this).val('')};});
$("#"+userName).blur(function(){if($(this).val()==''){$(this).val('Email')};});

})

function checkLogin()
{
//if (checkEmail($("#"+userName).val())==false ){alert('Inserire un E-mail valida.');$("#"+userName).focus().val('');return false;}
if ($("#"+ userPassword).val()==''){alert('Inserire una password.');$("#"+userPassword).focus().val('');return false;}
}

</script>
<div id="box_<%=boxOption.id_box%>" <%=boxOption.serialize_key%> class="template0 draggable">
<div <%=boxStyle %>>
<div class="adminItem">

<div class="boxContainer"><div class="boxWrapper"><div class="box"><div class="corner-left-bot"><div class="corner-right-bot">
<div class="box-title"><div><div><h3><span>Login</span></h3></div></div></div>
<div class="box-content">

<div id="divUsername"><label for="<%=tbUsername.clientid %>">E-mail:</label><div class="inputBoxLeft"></div><div class="inputBoxMiddle"><asp:textbox id="tbUsername" runat="server" MaxLength="50" CssClass="inputBox tbUsername" Text="Email" EnableViewState="false"/></div><div class="inputBoxRight"></div></div>

<div id="divPassword"><label for="<%=tbPassword.clientid %>">Password:</label><div class="inputBoxLeft"></div><div class="inputBoxMiddle"><asp:textbox id="tbPassword" runat="server" MaxLength="20" textmode="password" CssClass="inputBox tbPassword" EnableViewState="false" /></div><div class="inputBoxRight"></div></div>

<div id="divEnter"><asp:Button id="aEnter" CssClass="button black" runat="server" onClick="doLogin" OnClientClick="javascript:return checkLogin();" EnableViewState="false" Text="Enter" /></div>

<div id="divSign"><a href="<%=core.makeLink("/" & CORE.MyPage(Me).root_mypage.language & "/1/" & CORE_formatting.urlFilter(CORE.MyPage(Me).root_mypage.site_root_tree.tree_title), 0, "", CORE.pageEvent.joinUs) %>" id="aSign"><span>Registrati</span></a></div>

<div id="divRecover"><a id="aRecover" href="<%=core.makeLink("/" & CORE.MyPage(Me).root_mypage.language & "/1/" & CORE_formatting.urlFilter(CORE.MyPage(Me).root_mypage.site_root_tree.tree_title), 0, "", CORE.pageEvent.recoverData) %>"><span>Hai perso i dati?</span></a></div>


<div id="loginErrorMessage"><asp:Literal ID="ltErrorMessage" runat="server" EnableViewState="false"></asp:Literal></div>
</div></div></div></div></div></div>
</div>		
</div>
</div>
</asp:PlaceHolder>



<asp:PlaceHolder ID="phLogout" runat="server" Visible="false" EnableViewState="false">
<div id="box_<%=boxOption.id_box%>" <%=boxOption.serialize_key%> class="template0 draggable">
<div <%=boxStyle %>>
<div class="adminItem">

<div class="boxContainer"><div class="boxWrapper"><div class="box"><div class="corner-left-bot"><div class="corner-right-bot">
<div class="box-title"><div><div><h3><span>Logout</span></h3></div></div></div>
<div class="box-content">
<ul><li>Benvenuto <strong><%=CORE_USER.getUserNickname%></strong></li><li><a href="<%=core.makeLink("/" & CORE.MyPage(Me).root_mypage.language & "/1/" & CORE_formatting.urlFilter(CORE.MyPage(Me).root_mypage.site_root_tree.tree_title), 0, "", CORE.pageEvent.modifyData) %>">modifica dati</a></li><li><asp:linkbutton ID="btnLogOut"  onclick="doLogout" runat="server" EnableViewState="false">Logout</asp:linkbutton></li></ul>
</div></div></div></div></div></div>

</div>	
</div>	
</div>
</asp:PlaceHolder>

