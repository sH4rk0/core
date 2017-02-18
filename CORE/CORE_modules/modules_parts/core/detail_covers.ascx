<script language="vb" runat="server">
    
    Private boxStyle As String = String.Empty
    Private boxTitle As String = String.Empty
    Private boxDescription As String = String.Empty
    Private contents As SEARCH_VALUE_COLLECTION(Of Int32)
    Private coversNum As Integer = 0
    Private coverWidth As Integer = 0
    Private coverHeight As Integer = 0
    Public boxOption As New CORE_BOX_OPTIONS
    
    
'/////////////////////////////////////////////////////////////////////////////////////////

    Sub Page_load()
        
        
        Dim mybox As CORE_BOX = New CORE_BOX(boxOption.id_box)
        boxStyle = mybox.style
        coverWidth = mybox.width
        coverHeight = mybox.height
        contents = mybox.contentsCollection
        mybox.Dispose()
        mybox = Nothing
		Dim idContent As Integer = CORE.MyPage(Me).root_mypage.id_content
        Dim title As String = String.Empty
		
		'try
		
       
		'httpcontext.current.response.write( CORE.MyPage(Me).root_mypage.treeObject.id_content)
		If idContent > 0 Then title = CORE.MyPage(Me).root_mypage.contentobject.content_title
		If CORE.MyPage(Me).root_mypage.treeObject.id_content > 0 Then 
			idContent = CORE.MyPage(Me).root_mypage.treeObject.id_content
        	Dim mycontent As New CORE_CONTENT(idContent)
            coversNum = mycontent.content_covers
            title = mycontent.content_title
            mycontent.Dispose()
            mycontent = Nothing
		End if
		
		If Not CORE.MyPage(Me).root_mypage.contentObject Is Nothing Then coversNum = CORE.MyPage(Me).root_mypage.contentObject.content_covers
       
		
        
	 'Catch err As Exception

      '     httpcontext.current.response.write(err.ToString())

     'End Try
		
        If contents.Items > 0 Then
            idContent = contents.Item(0)
            Dim mycontent As New CORE_CONTENT(idContent)
            coversNum = mycontent.content_covers
            title = mycontent.content_title
            mycontent.Dispose()
            mycontent = Nothing
        End If
        
       
        
        If idContent > 0 Then
            
            If coversNum > 0 Then
                phCovers.Visible = True
                Dim i As Integer = 0
                Dim covers As StringBuilder = New StringBuilder
               
				
                For i = 1 To coversNum
                  
                    covers.Append("<li>" & CORE.displayCover(idContent, i, title & " - cover " & i, ConfigurationManager.AppSettings("CORE_related_folder").Replace("\", "/") & idContent & "/" & idContent & "_" & i & ".jpg", coverWidth, coverHeight, "cover", CORE.align.random, CORE.coverType.background, "prettyPhoto[gallery1]") & "</li>")
                    
                Next
                
                ltCovers.Text = "<div class=""coversBox""><ul class=""gallery"">" & covers.ToString() & "</ul></div>"
                covers = Nothing
                ltCovers.Dispose()
                ltCovers = Nothing
               
            End If
            
        End If
   
		
    End Sub
	
   
		
		</script>

<asp:PlaceHolder ID="phCovers" runat="server" Visible="false">
	
<div id="box_<%=boxOption.id_box%>" <%=boxOption.serialize_key%> class="template0 draggable">
<div <%=boxStyle%>>

<asp:Literal ID="ltCovers" runat="server" EnableViewState="false"></asp:Literal>

</div>
</div>
</asp:PlaceHolder>