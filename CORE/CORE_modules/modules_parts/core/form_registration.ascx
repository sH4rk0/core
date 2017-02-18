<%@ Control Language="VB" %>
<script language="vb" runat="server">

    Private boxStyle As String = String.Empty
    Private boxTitle As String = String.Empty
    Private boxDescription As String = String.Empty
    Private mypage As CORE_PAGE
    Private siteToken As String = String.Empty
    Private urlToken As String = String.Empty
    Public boxOption As New CORE_BOX_OPTIONS
    
    Sub page_load()
       
        mypage = CORE.MyPage(Me).root_mypage
        siteToken = CORE_CRYPTOGRAPHY.encrypt(mypage.id_site)
        urlToken = CORE_CRYPTOGRAPHY.encrypt(Request.Url.OriginalString)
        
        Dim mybox As New CORE_BOX(boxOption.id_box)
        boxStyle = mybox.style
        boxTitle = mybox.box_title
        boxDescription = mybox.box_description
        mybox.Dispose()
        mybox = Nothing
        
        If Request("cc") <> "" Then
            
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
                phConfirm.Visible = True
            Else
                
            End If
            
        Else
            phRegistration.Visible = True
        End If
        
    End Sub

</script>
<asp:PlaceHolder ID="phRegistration" runat="server" visible="false">
<script type="text/javascript" src="/core/CORE_js/checkEmail.js"></script>
<script type="text/javascript" src="/core/CORE_js/checkNickname.js"></script>
<script type="text/javascript" language="javascript">
var engineMain="/api/json/userPublic/core.aspx";
var siteToken='<%=siteToken %>';
var urlToken='<%=urlToken %>';
var errorValue=0;
$(document).ready(function(){

$("#nickname, #email, #password, #cpassword").val("");

$("#nickname").change(function(){
if (checkValidNickname()==true){
$("#nicknameMessage").val("").addClass("working");
mydata="who=checkUserNickname&nickname="+ $("#nickname").val();
$.ajax({type: "POST",url: engineMain,data: mydata,dataType: "json",
		success: function(msg){
		     if(msg.values.error!=undefined)
		     {
		         if (msg.values.error[0].errorId==0){
		              if (msg.values.nickname!=undefined){
		              if (msg.values.nickname[0].isUsed==true){$("#nicknameMessage").html("Nickname già utilizzato").removeClass("working");$("#nickname").val("").focus();}else{
		              $("#nicknameMessage").html("OK!").removeClass("working");
		              }
		              	              
		              }
		              
					  }
		              else		
		              {
					    $("#returnMessage").val("Si è verificato un errore!")
				      }
				
		    }
		  }
		 });
}else{$("#nicknameMessage").html('Inserire un nickname Valido!');$("#nickname").val("").focus();}
})

$("#email").change(function(){
if (checkValidEmail()==true){
$("#emailMessage").val("").addClass("working");
mydata="who=checkUserEmail&email="+ $("#email").val();
$.ajax({type: "POST",url: engineMain,data: mydata,dataType: "json",
		success: function(msg){
		     if(msg.values.error!=undefined)
		     {
		         if (msg.values.error[0].errorId==0){
		              if (msg.values.email!=undefined){
		              if (msg.values.email[0].isUsed==true){$("#emailMessage").html("Email già utilizzata").removeClass("working");$("#email").val("").focus();}else{$("#emailMessage").html("OK!").removeClass("working");}
		              	              
		              }
		              
					  }
		              else		
		              {
					    $("#returnMessage").val("Si è verificato un errore!")
				      }
				
		    }
		  }
		 });
}else{$("#emailMessage").html('Inserire un E-mail Valida!');$("#email").val("");$("#email").focus();}
})


})

function tryAgain(){
$("#nickname, #email, #password, #cpassword").val("");
$("#returnMessage").fadeOut(function(){$("#registrationForm").fadeIn();});
}

function checkValidNickname(){
if (checkNickname($("#nickname").val())==false){return false}
if($("#nickname").val()=="" || $("#nickname").val().length<5 ){return false}
return true
}

function checkValidEmail(){
if (checkEmail($("#email").val())==false){return false}
return true
}

function checkPassword()
{
newP=$("#user_password").val();
newPC=$("#user_password_confirm").val();
if(newP=="" || newPC==""){errorValue=1;return false;}
if(newP!=newPC){errorValue=2;return false;}
return true;
}

function displayError(){
            switch (errorValue) {

            case 1:
            alert("Inserire Password e Conferma Password");
            $("#user_password").val("").focus();
            break;
            
            case 2:
            alert("Password e Conferma Password non corrispondono");
            $("#user_password").val("").focus();
            $("#user_password_confirm").val("");
            break;
            
            case 3:
            alert(errorValue)
            break;


            }
}

function checkRegistrationForm(){

if(checkValidNickname()==false){alert('Inserire un nickname Valido!');$("#nickname").val("").focus(); return false;}
if(checkValidEmail()==false){alert('Inserire un E-mail valida!');$("#email").val("").focus(); return false;}
if(checkPassword()==false){displayError(errorValue); return false;}

$("#registrationForm").fadeOut();
mydata="who=userInsert&siteToken="+siteToken+"&urlToken="+urlToken+"&"+ $(".userSerialize").serialize();

		$("#returnMessage").html("");
		$("#contactForm").hide();
		 Shadowbox.open({
        player:     'html',
        content:    '<div style="padding:10px; text-align:center; color:#fff;">Registrazione in corso</div>',
		height:     50,
        width:      200}
		,
		{modal: true, animate: false, animateFade: false, displayNav: false, onClose: function(){}});

		
		
		$.ajax({type: "POST",url: engineMain,data: mydata,dataType: "json",
		success: function(msg){
		     if(msg.values.error!=undefined)
		     {
		         if (msg.values.error[0].errorId==0){
		              setTimeout("closeSender(true)",1000)
					  }
		              else		
		              {
					    setTimeout("closeSender(false)",1000)
				      }
				
		    }
		  }
		 });

		return false;
}

function closeSender(msg){
Shadowbox.close();

if (msg){
$("#returnMessage").html("<h4>La tua richiesta di registrazione è stata inoltrata correttamentre.</h4><p>Riceverai a breve la password per accedere al portale all'indirizzo di posta da te indicato.</p>"); 
}else{
$("#returnMessage").html("<h4>La tua richiesta di registrazione non è stata inoltrata a causa di un errore.</h4><p><a href='javascript: tryAgain();'>Clicca qui</a> per riprovare.</p>"); 
}
}
</script>
<div id="box_<%=boxOption.id_box%>" <%=boxOption.serialize_key%> class="template0 draggable">
<div <%=boxStyle %>>
<div class="adminItem">
<div id="registrationForm">
<h2><span>Form di Registrazione</span></h2>
<h3><label for="nickname"><span>Nickname:</span></label></h3>
<div class="inputBox"><div class="inputBoxLeft"></div><div class="inputBoxMiddle">
<input type="text" id="nickname" name="nickname" class="userSerialize" maxlength="15" />
</div><div class="inputBoxRight"></div><div id="nicknameMessage"></div></div>

<h3><label for="email"><span>Email:</span></label></h3>
<div class="inputBox"><div class="inputBoxLeft"></div><div class="inputBoxMiddle"><input type="text" id="email" name="email" class="userSerialize" maxlength="50"/></div><div class="inputBoxRight"></div><div id="emailMessage"></div></div>

<div class="clear">
<div class="twentyFive fLeft userNewPassword">
<h3><label for="user_password_new"><span>Password:</span></label></h3>
<div class="inputBox"><div class="inputBoxLeft"></div><div class="inputBoxMiddle">
<input id="user_password" name="user_password" class="userSerialize" type="password" maxlength="16"/>
</div><div class="inputBoxRight"></div></div>
</div>

<div class="fifty fLeft userNewPasswordConfirm">
<h3><label for="user_password_confirm"><span>Conferma Password:</span></label></h3>
<div class="inputBox"><div class="inputBoxLeft"></div><div class="inputBoxMiddle">
<input id="user_password_confirm" name="user_password_confirm" type="password" maxlength="16"/>
</div><div class="inputBoxRight"></div></div>
</div>
<div class="clear"></div>

<div class="fLeft"><a href="#" onclick="javascript: return checkRegistrationForm();return false;" class="formButton"><span>Registrati</span></a></div> 

<div class="fLeft"><a href="/" class="formButton"><span>Cancel</span></a></div>
</div>
<div class="clear"></div>
</div>
<div id="returnMessage"></div>
</div>
</div>
</div>
</asp:PlaceHolder>

<asp:PlaceHolder ID="phConfirm" runat="server" Visible="false">
confirm
</asp:PlaceHolder>