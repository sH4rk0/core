<%@ Control Language="VB" %>
<script language="vb" runat="server">
    
    Private boxStyle As String = String.Empty
    Private boxTitle As String = String.Empty
    Private boxDescription As String = String.Empty
    Private contents As SEARCH_VALUE_COLLECTION(Of Int32)
    Private id_content As Integer = 0
    Private logged As Boolean = False
    Private content_title As String = String.Empty
    Private postOption As Integer
    Private usersHolder As CORE_USER_COLLECTION(Of CORE_USER)
    Private contentObject As CORE_CONTENT
    Private isAuthorClass As String = String.Empty
    Public boxOption As New CORE_BOX_OPTIONS
    Private mycontent As CORE_CONTENT = Nothing
    
    
'/////////////////////////////////////////////////////////////////////////////////////////

    Sub Page_load()
        
       
        contentObject = CORE.MyPage(Me).root_mypage.contentObject
        
        Dim mybox As CORE_BOX = New CORE_BOX(boxOption.id_box)
        boxStyle = mybox.style
        contents = mybox.contentsCollection
        mybox.Dispose()
        mybox = Nothing
       
        id_content = CORE.MyPage(Me).root_mypage.id_content
        If CORE.MyPage(Me).root_mypage.treeObject.id_content > 0 Then id_content = CORE.MyPage(Me).root_mypage.treeObject.id_content
        
        If CORE.MyPage(Me).root_mypage.id_content > 0 Then id_content = CORE.MyPage(Me).root_mypage.id_content
        If contents.Items > 0 Then id_content = contents.Item(0)
        
        
        Dim user2content As ArrayList = New ArrayList
        Dim myusersearcher = New CORE_USER_SEARCHER
        user2content.Add(id_content)
        myusersearcher.contents = user2content
        usersHolder = myusersearcher.search()
        
        
        If Not CORE.MyPage(Me).root_mypage.contentObject Is Nothing Then
            content_title = CORE.MyPage(Me).root_mypage.contentObject.content_title
            postOption = CORE.MyPage(Me).root_mypage.contentObject.post_option
        Else
            mycontent = New CORE_CONTENT(id_content)
            content_title = mycontent.content_title
            postOption = mycontent.post_option
            mycontent.Dispose()
            mycontent = Nothing
            phTokenC.Visible = True
            ltTokenC.Text = CORE_CRYPTOGRAPHY.encrypt(id_content.ToString)
        End If
        
        If postOption = 0 Then postFormContainer.Visible = False
		
        Dim posts As CORE_CONTENT_POST_SEARCHER = New CORE_CONTENT_POST_SEARCHER
        Dim cposts As CORE_CONTENT_SEARCHER = New CORE_CONTENT_SEARCHER
        posts.id_content = id_content
        cposts.searchStatus = CORE_CONTENT_SEARCHER.status.all
        cposts.searchOrder = CORE_CONTENT_SEARCHER.order.contentDateCreationAsc
        cposts.type = CORE_CONTENT.contentType.contentPost
        cposts.postSearcher = posts
        
        rpPosts.DataSource = cposts.search()
        rpPosts.DataBind()
        
        If rpPosts.Items.Count = 0 AndAlso postOption = 0 Then phPosts.Visible = False
        ltComments.Text = rpPosts.Items.Count
        logged = CORE_USER.isLogged
        
    End Sub
		
		
    Sub managePost(ByVal o As Object, ByVal e As RepeaterItemEventArgs)
        
        If (e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.Item) Then
          
            If CType(e.Item.DataItem, CORE_CONTENT_HOLDER).contentPostData.content_enabled = True Then
                'isAuthorClass = isAuthor(CType(e.Item.DataItem, CORE_CONTENT_HOLDER).contentPostData.id_user)
                'Response.Write(CType(e.Item.DataItem, CORE_CONTENT_HOLDER).contentPostData.id_user & " " & isAuthorClass & "<bR>")
                e.Item.FindControl("postEnabled").Visible = True
            Else
                e.Item.FindControl("postDisabled").Visible = True
            End If

        End If
        
    End Sub
    
    Function checkAuthor(ByVal idUser As Integer) As Boolean
        Dim user As CORE_USER
        For Each user In usersHolder
            If user.id_user = idUser Then Return True
        Next
        Return False
    End Function
    
    Function isAuthor(ByVal idUser As Integer) As String
        If checkAuthor(idUser) Then Return "author"
        Return ""
    End Function
    
    Function checkAvatar(ByVal idUser As Integer) As String
        
        If idUser = 0 Then Return ConfigurationManager.AppSettings("CORE_user_folder").ToString().Replace("\", "/") & "0/avatar/0.jpg"
        If CORE_filesystem.fileExists(ConfigurationManager.AppSettings("CORE_user_folder").ToString() & idUser & "/avatar/" & idUser & ".jpg") Then Return ConfigurationManager.AppSettings("CORE_user_folder").ToString().Replace("\", "/") & idUser & "/avatar/" & idUser & ".jpg"
        Return String.Empty
        
    End Function
    
		</script>
	
<asp:PlaceHolder ID="phTokenC" runat="server" Visible="false" EnableViewState="false">
<script type="text/javascript">
tokenC='<asp:literal id="ltTokenC" runat="server" EnableViewState="false"/>';
</script>
</asp:PlaceHolder>

<div id="box_<%=boxOption.id_box%>" <%=boxOption.serialize_key%> class="template0 draggable">
<div <%=boxStyle%>>
<div class="adminItem">
<asp:placeholder id="phPosts" runat="server" EnableViewState="false">
<div>
<h3><span id="commentsCount"><asp:Literal ID="ltComments" runat="server" EnableViewState="false"></asp:Literal></span> Comments</h3>
<ul id="postGrid">
<asp:Repeater ID="rpPosts" runat="server" OnItemDataBound="managePost" EnableViewState="false">
<ItemTemplate>
<asp:PlaceHolder ID="postEnabled" runat="server" Visible="false" EnableViewState="false">
<li class="<%#isAuthor(CType(Container.DataItem, CORE_CONTENT_HOLDER).contentPostData.id_user)%>">
<div class="postItem">
<div class="postImage"><img src="<%#checkAvatar(CType(Container.DataItem, CORE_CONTENT_HOLDER).contentPostData.id_user)%>" /></div>
<div class="postMessage">
<p class="postAuthor">Comment posted <strong class="postDate" ><%#CORE_formatting.dateFormat(CType(Container.DataItem, CORE_CONTENT_HOLDER).contentPostData.content_date_creation, "ddd\, d MMMM yyyy \@ HH\:mm")%></strong> by <strong class="postUser"><%#CType(Container.DataItem, CORE_CONTENT_HOLDER).contentPostData.post_author%></strong></p>
<p class="postSubject"><strong><%#CType(Container.DataItem, CORE_CONTENT_HOLDER).contentPostData.content_title%></strong></p>
<p class="postDescription"><%#CType(Container.DataItem, CORE_CONTENT_HOLDER).contentPostData.content_description%></p>
</div>
<hr />
</div>
</li>
</asp:PlaceHolder>
<asp:PlaceHolder ID="postDisabled" runat="server" Visible="false" EnableViewState="false">
<li  class="disabled" id="li_<%#CType(Container.DataItem, CORE_CONTENT_HOLDER).contentPostData.id_key%>" sequence="">
<div class="postItem">
<div class="postImage"></div>
<div class="postMessage">
<p class="postAuthor">Comment posted <strong><%#CORE_formatting.dateFormat(CType(Container.DataItem, CORE_CONTENT_HOLDER).contentPostData.content_date_creation, "ddd\, d MMMM yyyy \@ HH\:mm")%></strong> by <strong><%#CType(Container.DataItem, CORE_CONTENT_HOLDER).contentPostData.post_author%></strong></p>
<p class="postDescription">This message is waiting for Administrator validation!</p></div>
<hr />
</div>
</li>
</asp:PlaceHolder>
</ItemTemplate>
</asp:Repeater>
</ul>
</div>
</asp:placeholder>

<asp:PlaceHolder ID="postFormContainer" runat="server" EnableViewState="false">
<script type="text/javascript" src="/core/CORE_js/checkEmail.js"></script>
<script type="text/javascript" src="/core/CORE_js/checkNickname.js"></script>
<script language="javascript" type="text/javascript">
var postObj=new Array()
var iAmUser=false;
var _postType='<%=CORE_CRYPTOGRAPHY.encrypt("1") %>';
var _postOption='<%= CORE_CRYPTOGRAPHY.encrypt(postOption)%>';
var _postEngine="/api/json/postPublic/core.aspx";
var _title="Re: <%=content_title%>"; 
var currentIndex=0;

$(document).ready(function(){
clearFields()

$(".boxUser").hide();
$(".boxUser").eq(currentIndex).show();

$("a.postType").click(function(){
var index=$("a.postType").index(this);
if (index==currentIndex) return false;

$(".boxUser").eq(currentIndex).hide()
$(".boxUser").eq(index).show();

if (index==0){iAmUser=false;$("#captcha").show();}else{iAmUser=true;$("#captcha").hide();}
$("a.postType").removeClass("selected")
$("a.postType").eq(index).addClass("selected")
currentIndex=index;
return false;
})

$("#directLogin").toggle(
function(){},
function(){}
)

$(".vote").click(function(){
        $(".vote").removeClass("selected");
        var index=$(".vote").index(this);
        for (i=0; i<=index; i++){$(".vote").eq(i).addClass("selected")}
        $("#postVote").val(index+1); 
        return false;
        });

$("#votes").hover(
function(){},
function(){
if($("#postVote").val()!=''){$(".vote").eq(parseInt($("#postVote").val())-1).addClass("selected"); }else{$(".vote").removeClass("selected");}
});

$(".vote").hover(
function(){
var index=$(".vote").index(this);
for (i=0; i<=index; i++){$(".vote").eq(i).addClass("hover")}

},
function(){$(".vote").removeClass("hover")}
);


})

function clearFields()
{
$(".postSerialize").val("");
$("#postSubject").val(_title);
reCaptcha(100,50);
$(".vote").removeClass("selected");
}

function insertPosts()
{
<%if logged=false %>
if(checkValidNickname()==false && iAmUser==false){alert('Type a valid Nickname!');$("#postAuthor").val("").focus(); return false;}
if(checkValidEmail()==false && iAmUser==false){alert('Type a valid E-mail!');$("#postEmail").val("").focus(); return false;}
if($("#postUsername").val()=="" && iAmUser==true){alert('Type the password E-mail!');$("#postUsername").val("").focus(); return false;}
if($("#postPassword").val()=="" && iAmUser==true){alert('Type the password!');$("#postPassword").val("").focus(); return false;}
<%end if %>
if($("#postSubject").val()==""){alert('Write a subject!');$("#postSubject").val("").focus(); return false;}
if($("#postDescription").val()==""){alert('Write a message!');$("#postDescription").val("").focus(); return false;}
<%if logged=false %>
if($("#postCaptcha").val()=="" && iAmUser==false){alert('Insert Captcha!');$("#postCaptcha").val("").focus(); return false;}
<%end if %>


_who='<%=CORE_CRYPTOGRAPHY.encrypt("insertPost") %>';
mydata="who="+_who+"&postType="+_postType+"&postOption="+_postOption+"&tokenC="+ tokenC + "&tokenS="+ tokenS + "&tokenL="+ tokenL + "&" + $(".postSerialize").serialize();
	
		 $.ajax({
		   type: "POST",
		   url: _postEngine,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
			    if(msg.values.error!=undefined)
		     {
				 	 if (msg.values.error[0].errorId==0)
				 	 {
				 	 $(".postSerialize").val("");
				 	 reCaptcha(100,50);
				 	 postObj=msg;
				 	 displayPosts(true);
				 	 clearFields();
				 	 
				 	 
				 	 }
				 	 else
				 	 {
				 	 if (parseInt(msg.values.error[0].errorId)==9000){$("#returnMessage").html(msg.values.error[0].errorMessage);reCaptcha(200,100);clearFields();}
				 	 if (parseInt(msg.values.error[0].errorId)==9001){$("#returnMessage").html(msg.values.error[0].errorMessage);reCaptcha(200,100);clearFields();}
				 	 if (parseInt(msg.values.error[0].errorId)==9002){$("#returnMessage").html(msg.values.error[0].errorMessage);reCaptcha(200,100);clearFields();}
				 	 
				 	 }
				 	 
				 	 }else{
				 	 
				 	 }
		   }
		 });
		
}

function getPosts()
{
_who='<%=CORE_CRYPTOGRAPHY.encrypt("getPosts") %>';
mydata="who="+_who+"&postType="+_postType+"&tokenC="+ tokenC + "&tokenS="+ tokenS + "&tokenL="+ tokenL;
	
		 $.ajax({
		   type: "POST",
		   url: _postEngine,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
			    if(msg.values.error!=undefined)
		     {
				 	 if (msg.values.error[0].errorId==0)
				 	 {
				 	 postObj=msg;
				 	 displayPosts(false);
				 	 }
				 	 else
				 	 {
				 
				 	 }
				 	 
				 	 }else{
				 	 
				 	 }
		   }
		 });
}

function displayPosts(append)
{
if (append==false) $("#postGrid").html("");

	for (i=0; i<postObj.values.post.length; i++)
		{
		
		$("#postGrid").append("<li class='postItems' id='li_"+ postObj.values.post[i].idPost +"' sequence='"+ i +"'><div class='postAuthor'>Comment posted by <strong>"+ postObj.values.post[i].author +"</strong> il <strong>"+  postObj.values.post[i].date + "</strong></div><div class='postSubject'><strong>"+postObj.values.post[i].subject+"</strong></div><p class='postMessage'>"+ postObj.values.post[i].description +"</p></li>")
			
		}
$("#commentsCount").text($(".postItems").length);
		
		
		
		
//if (append==true) var last=$(".postItems").eq(i); last.scrollTop();	
}

function reCaptcha(w,h){
var date = new Date()
$("#captchaImage").attr("src","/captcha.aspx?w=" + w + "&h=" + h + "&date=" + date);
}

function checkValidNickname(){
if (checkNickname($("#postAuthor").val())==false){return false}
if($("#postAuthor").val()=="" || $("#postAuthor").val().length<5 ){return false}
return true
}

function checkValidEmail(){
if (checkEmail($("#postEmail").val())==false){return false}
return true
}



</script>

<div class="spacer"></div>
<div id="postForm">
<h3><span>Insert Comment</span></h3>
<%  If logged = False Then%>
<p><a href="#" class="postType selected"><span>Anonymous</span></a> - <a href="#" class="postType"><span>Registered</span></a> - <a href="#" class="postType"><span>From Network</span></a></p>

<div class="boxUser">
    <div class="twentyFive fLeft postNickname postAnonymous">
    <h4><label for="postAuthor"><span>Nickname:<sup>*</sup></span></label></h4>
    <div class="inputBox"><div class="inputBoxLeft"></div><div class="inputBoxMiddle"><input type="text" id="postAuthor" class="postSerialize inputbox" name="postAuthor" maxlength="30"/></div><div class="inputBoxRight"></div></div>
    </div>
    <div class="seventyFive fLeft postEmail postAnonymous">
    <h4><label for="postEmail"><span>Email:<sup>* not visible to other users</sup></span></label></h4>
    <div class="inputBox"><div class="inputBoxLeft"></div><div class="inputBoxMiddle"><input type="text" id="postEmail" class="postSerialize inputbox" name="postEmail" maxlength="50"/></div><div class="inputBoxRight"></div></div>
    </div>
</div>

<div class="boxUser">
    <div class="twentyFive fLeft postUsername postLogged">
    <h4><label for="postUsername"><span>Email:<sup>*</sup></span></label></h4>
    <div class="inputBox"><div class="inputBoxLeft"></div><div class="inputBoxMiddle"><input type="text" id="postUsername" class="postSerialize inputbox" name="postUsername" maxlength="50"/></div><div class="inputBoxRight"></div></div>
    </div>
    <div class="seventyFive fLeft postPassword postLogged">
    <h4><label for="postPassword"><span>Password:<sup>*</sup></span></label></h4>
    <div class="inputBox"><div class="inputBoxLeft"></div><div class="inputBoxMiddle"><input type="password" id="postPassword" class="postSerialize inputbox" name="postPassword" maxlength="20"/></div><div class="inputBoxRight"></div></div>
    </div>
</div>

<div class="boxUser">
<div class="full">
Network
</div>
</div>
<%End If%>

<div class="full clear postSubject">
<h4><label for="postSubject"><span>Subject:<sup>*</sup></span></label></h4>
<div class="inputBox"><div class="inputBoxLeft"></div><div class="inputBoxMiddle">
<input type="text" id="postSubject" class="postSerialize inputbox" name="postSubject" maxlength="300"/>
</div><div class="inputBoxRight"></div></div>
</div>

<div class="full postDescription">

<h4><label for="postDescription"><span>Message:<sup>*</sup></span></label></h4>

<div class="textareaBox">
<div class="textareaTop"><div class="textareaTopLeft"></div><div class="textareaTopRight"></div></div>
<div class="textareaBoxMiddleLeft">
<div class="textareaBoxMiddleRight">
<textarea id="postDescription" class="postSerialize" name="postDescription" rows="5" cols="20" ></textarea>
</div>
</div>
<div class="textareaBottom"><div class="textareaBottomLeft"></div><div class="textareaBottomRight"></div></div>
</div>

</div>

<div class="full postVote"> 
<input type="hidden" id="postVote" name="postVote" class="postSerialize" />
<div id="votes"><span>Vote:</span>
<a href="#" class="vote"><span>1</span></a><a href="#" class="vote"><span>2</span></a><a href="#" class="vote"><span>3</span></a><a href="#" class="vote"><span>4</span></a><a href="#" class="vote"><span>5</span></a>
</div>
</div>
<div class="clear"></div>
<%  If logged = False Then%>
<div id="captcha" class="clear postAnonymous">
<a href="#" id="captchaRefresh" onclick="javascript:reCaptcha(100,50);return false;" title="Click to refresh the Captcha image."><img src="" alt="Captcha Image" class="noBorder" id="captchaImage"/></a> <input type="text" id="postCaptcha" class="postSerialize" maxlength="6" name="postCaptcha"/>
</div>
<%End If%>
<div class="clear">
<div id="submitButton"><a href="#" onclick="javascript:insertPosts(); return false;" class="formButton"><span>Submit Comment</span></a></div>
</div>
<div class="clear" id="returnMessage"></div>
<div class="clear" id="compulsoryFields"><span>*</span> Compulsory fields</div>
</div>
</asp:PlaceHolder>


</div>
</div>
</div>