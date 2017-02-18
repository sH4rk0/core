<%@ Control Language="VB" %>
<script language="vb" runat="server">

    Private boxStyle As String = String.Empty
    Private boxTitle As String = String.Empty
    Private boxDescription As String = String.Empty
    Private mypage As CORE_PAGE
    Private id_user As Integer = 0
    Private user_email As String = String.Empty
    Private user_nickname As String = String.Empty
    Private user_username As String = String.Empty
    Private user_name As String = String.Empty
    Private user_surname As String = String.Empty
    Private user_gender As Integer = 0
    Private user_birth_date As Integer = 0
    Private user_geo_country As Integer = 0
    Private user_geo_region As Integer = 0
    Private user_geo_province As Integer = 0
    Private user_geo_city As String = String.Empty
    Private user_address As String = String.Empty
    Private user_zipcode As String = String.Empty
    Private user_telephone As String = String.Empty
    Private user_mobile As String = String.Empty
    Private user_fax As String = String.Empty
    Private user_sign As String = String.Empty
    Private user_homepage As String = String.Empty
    Private siteToken As String = String.Empty
    Public boxOption As New CORE_BOX_OPTIONS
    
    Sub page_load()
       
        mypage = CORE.MyPage(Me).root_mypage
                
        If CORE_USER.isLogged Then
            phModify.Visible = True
            Dim user As CORE_USER = New CORE_USER(CORE_USER.getUserId)
            user_name = user.user_name
            user_surname = user.user_surname
            user_homepage = user.user_homepage
            user_sign = user.user_sign
            user_gender = user.user_gender
            user.Dispose()
            user = Nothing
        Else
            Response.Redirect("/")
        End If
        
    End Sub

</script>

<asp:PlaceHolder ID="phModify" runat="server" visible="false">

<script type="text/javascript" language="javascript">
var engineMain="/api/json/userPublic/core.aspx";
var errorValue=0;
$(document).ready(function(){

$("#user_gender").val(<%=user_gender %>);

})



function checkModifyForm(){
if (checkPasswordModify()==false){displayError(errorValue);return false;}
$("#registrationForm").fadeOut();
mydata="who=userUpdate&token="+token+"&siteToken="+tokenS+"&"+ $(".userSerialize").serialize();

		Shadowbox.open({
        player:     'html',
        content:    '<div style="padding:10px; text-align:center; color:#fff;">Salvataggio in corso</div>',
		height:     50,
        width:      200}
		,
		{modal: true, animate: false, animateFade: false, displayNav: false, onClose: function(){}});

		
		
		$.ajax({type: "POST",url: engineMain,data: mydata,dataType: "json",
		success: function(msg){
		     if(msg.values.error!=undefined)
		     {
		         if (msg.values.error[0].errorId==0)
		              {
		              $("#returnMessage").text("La modifica dei dati è avvenuta correttamente.");
					  }
		              else		
		              {
		              $("#returnMessage").text("Si è verificato un errore nella modifica dati.");
				      }
				      
				      $("#modifyForm").fadeOut(function(){$("#modifyFormResult").fadeIn()});
		             
				    Shadowbox.close();
		    }
		  }
		 });

		return false;
}

function checkPasswordModify()
{
oldP=$("#user_password_old").val();
newP=$("#user_password_new").val();
newPC=$("#user_password_confirm").val();

if((oldP=="" && (newP!="" || newPC!=""))){errorValue=1;return false;}
if((oldP!="" && newP=="")){errorValue=2;return false;}
if((oldP!="" && newP!="" && newPC!="" && newP!=newPC)){errorValue=3;return false;}
return true;
}

function displayError(){
            switch (errorValue) {

            case 1:
            alert(errorValue)
            break;
            
            case 2:
            alert(errorValue)
            break;
            
            case 3:
            alert(errorValue)
            break;


            }
}
</script>

<div id="box_<%=boxOption.id_box%>" <%=boxOption.serialize_key%> class="template0 draggable">
<div <%=boxStyle%>>
<div class="adminItem">

<div id="modifyForm">
<h2>Modifica dati</h2>

<div class="twentyFive fLeft userName">
<h3><label for="user_name"><span>Nome:</span></label></h3>
<div class="inputBox"><div class="inputBoxLeft"></div><div class="inputBoxMiddle">
<input id="user_name" name="user_name" class="userSerialize" type="text" value="<%=user_name %>" maxlength="30"/>
</div><div class="inputBoxRight"></div></div>
</div>

<div class="fifty fLeft userSurname">
<h3><label for="user_surname"><span>Cognome:</span></label></h3>
<div class="inputBox"><div class="inputBoxLeft"></div><div class="inputBoxMiddle">
<input id="user_surname" name="user_surname" class="userSerialize" type="text" value="<%=user_surname %>" maxlength="30"/>
</div><div class="inputBoxRight"></div></div>
</div>

<div class="full fLeft userGender">
<h3><label for="user_gender"><span>Sesso:</span></label></h3>
<select id="user_gender" name="user_gender" class="userSerialize">
<option value="1">Maschio</option>
<option value="0">Femmina</option>
</select>
</div>
<div class="clear"></div>
<div class="spacer"></div>
<div class="full clear userOldPassword">
<h3><label for="user_password_old"><span>Vecchia Password:</span></label></h3>
<div class="inputBox"><div class="inputBoxLeft"></div><div class="inputBoxMiddle">
<input id="user_password_old" name="user_password_old" class="userSerialize" type="password" maxlength="16" />
</div><div class="inputBoxRight"></div></div>
</div>
<div class="clear"></div>

<div class="twentyFive fLeft userNewPassword">
<h3><label for="user_password_new"><span>Nuova Password:</span></label></h3>
<div class="inputBox"><div class="inputBoxLeft"></div><div class="inputBoxMiddle">
<input id="user_password_new" name="user_password_new" class="userSerialize" type="password" maxlength="16"/>
</div><div class="inputBoxRight"></div></div>
</div>

<div class="fifty fLeft userNewPasswordConfirm">
<h3><label for="user_password_confirm"><span>Conferma Password:</span></label></h3>
<div class="inputBox"><div class="inputBoxLeft"></div><div class="inputBoxMiddle">
<input id="user_password_confirm" name="user_password_confirm" type="password" maxlength="16"/>
</div><div class="inputBoxRight"></div></div>
</div>
<div class="clear"></div>

<div class="spacer"></div>
<div class="full userSign">
<h3><label for="user_password_confirm"><span>Firma:</span></label></h3>

<div class="textareaBox">
<div class="textareaTop"><div class="textareaTopLeft"></div><div class="textareaTopRight"></div></div>
<div class="textareaBoxMiddleLeft">
<div class="textareaBoxMiddleRight">
<textarea id="user_sign" class="userSerialize" name="user_sign" rows="5" cols="20" ><%=user_sign %></textarea>
</div>
</div>
<div class="textareaBottom"><div class="textareaBottomLeft"></div><div class="textareaBottomRight"></div></div>
</div>
</div>

<div class="full userHomepage">
<h3><label for="user_homepage"><span>Homepage:</span></label></h3>
<div class="inputBox"><div class="inputBoxLeft"></div><div class="inputBoxMiddle">
<input id="user_homepage" name="user_homepage" class="userSerialize" value="<%=user_homepage %>"/>
</div><div class="inputBoxRight"></div></div>
</div>

<div class="clear">
<div class="fLeft"><a href="#" onclick="javascrpt:checkModifyForm();return false;" class="formButton"><span>Modifica Dati</span></a></div> 

<div class="fLeft"><a href="/" class="formButton"><span>Cancel</span></a></div>
</div>
<div class="clear"></div>
</div>

</div>



<div id="modifyFormResult">
<h2>Modifica dati</h2>
<p id="returnMessage"></p>
<div class="clear">
<div class="fLeft"><a href="/" class="formButton"><span>Torna alla Homepage</span></a></div> 
</div>
<div class="clear"></div>
</div>


</div></div></div>
</asp:PlaceHolder>

