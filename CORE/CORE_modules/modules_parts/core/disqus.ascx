<script language="vb" runat="server">
    
    Private boxStyle As String = String.Empty
    Private boxTitle As String = String.Empty
    Private boxDescription As String = String.Empty
    Private contents As SEARCH_VALUE_COLLECTION(Of Int32)
    Private id_content As Integer = 0
    Private currentTreePath As String = String.Empty
    Private adminClass As String = String.Empty
    Public boxOption As New CORE_BOX_OPTIONS
    Private mycontent As CORE_CONTENT = Nothing
    Private usersHolder As CORE_USER_COLLECTION(Of CORE_USER)
    Private contextHolder As CORE_CONTEXT_COLLECTION(Of CORE_CONTEXT)
    Dim id_key as String = String.Empty
    
'/////////////////////////////////////////////////////////////////////////////////////////

   
        
        
        Sub Page_load()
        
        Dim mybox As CORE_BOX = New CORE_BOX(boxOption.id_box)
        boxStyle = mybox.style
        contents = mybox.contentsCollection
        mybox.Dispose()
        mybox = Nothing
        
		If CORE.MyPage(Me).root_mypage.id_content > 0 Then id_content = CORE.MyPage(Me).root_mypage.id_content

        

        'httpcontext.current.response.write(id_content)
        If id_content > 0 Then
            
           id_key = CORE_CRYPTOGRAPHY.encrypt(id_content)
		   
		  '   httpcontext.current.response.write(id_key)
            
        End If
		
    End Sub
	
   
		
		</script>

<asp:PlaceHolder ID="phDisquis" runat="server" Visible="true">
<script type="text/javascript" language="javascript">
 $(document).ready(function(){
	 setTimeout(function(){
DISQUS.reset({ reload: true,
								  config: function () {  
									this.page.identifier = "<%=id_key%>";
									//this.page.title= "www.zero89.it - Articles - " + _data.values.content[0].title;  
									this.page.url = document.location;
								  }
								});
	 },500);
								
 });
</script>
<div id="box_<%=boxOption.id_box%>" <%=boxOption.serialize_key%> class="template0 draggable">
<div <%=boxStyle%>>

<div id="disqus_thread"></div>

</div>
</div>
</asp:PlaceHolder>