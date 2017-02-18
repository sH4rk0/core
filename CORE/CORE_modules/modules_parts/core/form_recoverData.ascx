<%@ Control Language="VB" %>
<script language="vb" runat="server">

    Private boxStyle As String = String.Empty
    Private boxTitle As String = String.Empty
    Private boxDescription As String = String.Empty
    Private mypage As CORE_PAGE
    Private id_user As Integer = 0
    Private siteToken As String = String.Empty
    Private urlToken As String = String.Empty
    Public boxOption As New CORE_BOX_OPTIONS
    
    Sub page_load()
       
        mypage = CORE.MyPage(Me).root_mypage
        siteToken = CORE_CRYPTOGRAPHY.encrypt(mypage.id_site)
        urlToken = CORE_CRYPTOGRAPHY.encrypt(Request.Url.OriginalString)
        
        
        If Request("cp") <> "" And Request("cc") <> "" Then
            
            Dim cp As String = CORE_CRYPTOGRAPHY.decrypt(Request("cp"))
            Dim cc As String = CORE_CRYPTOGRAPHY.decrypt(Request("cc"))
            
            Dim values() As String = cc.Split("|")
            
            Dim idUser As Integer = 0
            Dim idSite As Integer = 0
            
            If IsNumeric(values(0)) AndAlso IsNumeric(values(1)) Then
                idUser = values(0)
                idSite = values(1)
                Dim user As CORE_USER = New CORE_USER(idUser)
                user.siteUpdate(idUser, idSite, 1)
                user.user_date_activation = Date.Now
                user.update(user)
                user.Dispose()
                user = Nothing
                phChangePassword.Visible = True
            Else
                
            End If
            
        Else
            
            If CORE_COOKIE.getValue("id_user") = "" Then
                phRecover.Visible = True
                        
            Else
                Response.Redirect("/")
            End If
            
            
        End If
        
        
        
        
    End Sub

</script>
<div id="box_<%=boxOption.id_box%>" <%=boxOption.serialize_key%> class="template0 draggable">
<div <%=boxStyle %>>
<div class="adminItem">
<asp:PlaceHolder ID="phRecover" runat="server" visible="false">


<script type="text/javascript" src="/core/CORE_js/checkEmail.js"></script>
<script type="text/javascript" src="/core/CORE_js/checkNickname.js"></script>
<script type="text/javascript" language="javascript">
var engineMain="/api/json/userPublic/core.aspx";
var siteToken='<%=siteToken %>';
var urlToken='<%=urlToken %>';

var errorValue=0;
$(document).ready(function(){
})

function checkValidNickname(){
if (checkNickname($("#nickname").val())==false){return false}
if($("#user_nickname").val()=="" || $("#user_nickname").val().length<5 ){return false}
return true
}

function checkValidEmail(){
if (checkEmail($("#user_email").val())==false){return false}
if($("#user_email").val()==""){return false}
return true
}


function checkRecoverForm(){

if(checkValidNickname()==false){alert('Inserire un nickname Valido!');$("#user_nickname").val("").focus(); return false;}
if(checkValidEmail()==false){alert('Inserire un E-mail valida!');$("#user_email").val("").focus(); return false;}

$("#recoverForm").fadeOut();
mydata="who=userRecoverData&urlToken="+ urlToken +"&siteToken="+siteToken+"&"+ $(".userSerialize").serialize();

		$("#recoverForm").hide();
		 Shadowbox.open({
        player:     'html',
        content:    '<div style="padding:10px; text-align:center; color:#fff;">Recupero dati in corso</div>',
		height:     50,
        width:      200}
		,
		{modal: true, animate: false, animateFade: false, displayNav: false, onClose: function(){}});

		
		
		$.ajax({type: "POST",url: engineMain,data: mydata,dataType: "json",
		success: function(msg){
		     if(msg.values.error!=undefined)
		     {
		         if (msg.values.error[0].errorId==0){
		         $("#returnMessage").html("La richiesta di recupero dati è avvenuta con successo.")
		              
					  }
		              else		
		              { 
		              $("#returnMessage").html(msg.values.error[0].errorMsg)
				      }
				
		    }
		    Shadowbox.close();
		  }
		 });

		return false;
}

</script>
<div id="recoverForm" >
<h2><span>Recupero Dati</span></h2>

<h3><label for="user_nickname"><span>Nickname:</span></label></h3>
<div class="inputBox"><div class="inputBoxLeft"></div><div class="inputBoxMiddle">
<input id="user_nickname" name="user_nickname" class="userSerialize" type="text" />
</div><div class="inputBoxRight"></div></div>

<h3><label for="user_email"><span>Email:</span></label></h3>
<div class="inputBox"><div class="inputBoxLeft"></div><div class="inputBoxMiddle">
<input id="user_email" name="user_email" class="userSerialize" type="text" />
</div><div class="inputBoxRight"></div></div>


<div class="clear">
<div class="fLeft"><a href="#" onclick="javascript: return checkRecoverForm();return false;" class="formButton"><span>Recupero dati</span></a></div> 

<div class="fLeft"><a href="/" class="formButton"><span>Cancel</span></a></div>
</div>
<div class="clear"></div>
</div>


</div>



<div id="returnMessage"></div>
</asp:PlaceHolder>




<asp:PlaceHolder ID="phChangePassword" runat="server" Visible="false">
<script type="text/javascript" language="javascript">
var engineMain="/api/json/userPublic/core.aspx";
var checkToken='<%=request("cc") %>';
var errorValue=0;
$(document).ready(function(){

})



function checkPasswordForm(){
$("#recoverForm").fadeOut();
mydata="who=userChangePassword&checkToken="+checkToken+"&"+ $(".userSerialize").serialize();

		$("#recoverForm").hide();
		 Shadowbox.open({
        player:     'html',
        content:    '<div style="padding:10px; text-align:center; color:#fff;">Modifica Password in corso</div>',
		height:     50,
        width:      200}
		,
		{modal: true, animate: false, animateFade: false, displayNav: false, onClose: function(){}});

		
		
		$.ajax({type: "POST",url: engineMain,data: mydata,dataType: "json",
		success: function(msg){
		     if(msg.values.error!=undefined)
		     {
		         if (msg.values.error[0].errorId==0){
		              Shadowbox.close();
					  }
		              else		
		              {
					    
				      }
				
		    }
		  }
		 });

		return false;
}

</script>
<div id="changePasswordForm">
<h2><span>Inserisci la nuova password</span></h2>

<h3><label for="password"><span>Password:</span></label></h3>
<div><div class="inputBoxLeft"></div><div class="inputBoxMiddle">
<input id="password" name="password" class="userSerialize" type="password"/>
</div><div class="inputBoxRight"></div></div>

<h3><label for="password_confirm"><span>Conferma Password:</span></label></h3>
<div><div class="inputBoxLeft"></div><div class="inputBoxMiddle">
<input id="password_confirm" name="password_confirm" type="password"/>
</div><div class="inputBoxRight"></div></div>


<div class="clear">
<div class="fLeft"><a href="#" onclick="javascrpt:checkPasswordForm();return false;" class="formButton"><span>Modifica Password</span></a></div> 

<div class="fLeft"><a href="/" class="formButton"><span>Cancel</span></a></div>
</div>
<div class="clear"></div>
</div>


</div>
</asp:PlaceHolder>

</div></div></div>