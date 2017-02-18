<%@ Control   %>

<script language="vb" runat="server">
    
    '/////////////////////////////////////////////////////////////////////////////////////////
    Dim myOptions As New CORE_TEMPLATE_OPTIONS
    Dim currentTreePath As String = String.Empty
    Sub page_init()
        If Not Session("templateOptions") Is Nothing Then myOptions = Session("templateOptions")
    End Sub
    
    Sub Page_load()
        currentTreePath = "/" & CORE.MyPage(Me).root_mypage.language & "/1/" & CORE_FORMATTING.urlFilter(CORE.MyPage(Me).root_mypage.site_root_tree.tree_title) & "/"
               
    End Sub
    
    Function covers(ByVal contentData As CORE_CONTENT) As String
        Dim mycovers As StringBuilder = Nothing
       
        If contentData.id_key > 0 Then
            
            If contentData.content_covers > 0 Then
               
                Dim i As Integer = 0
                mycovers = New StringBuilder
                            				
                For i = 1 To contentData.content_covers
                    
                    mycovers.Append(CORE.displayCover(contentData.id_key, i, contentData.content_title, CORE.makeLink(contentData.content_path, contentData.id_key, contentData.content_title, CORE.pageEvent.detail), myOptions.coverWidth, myOptions.coverHeight, "cover", CORE.align.random, CORE.coverType.background, ""))
            	
                Next
                              
            End If
            
        End If
        
        Return mycovers.ToString
    End Function
    
    
    
</script><%#covers(CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData)%>