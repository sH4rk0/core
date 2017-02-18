<%@ Import namespace="System.Data"%>
<%@ Import namespace="System.Data.sqlClient"%>
<%@ Import Namespace="System.xml" %>
<%@ Import Namespace="System.io" %>
<%@ Import Namespace="System.Drawing" %>
<%@ Import Namespace="System.Drawing.Imaging" %>
<%@ Import Namespace="System.Drawing.Text" %>
<%@ Import Namespace="System.Drawing.Drawing2D" %>
<%@ Import Namespace="System.web.configuration" %>

<script runat="server">

    Dim responseType As String = String.Empty
    Dim searcher As CORE_CONTENT_SEARCHER = Nothing
    
    Sub page_load()
        
        responseType = CORE.checkResponse()
        
        Dim searcher As New CORE_CONTENT_SEARCHER(Request("token"))
                       
        If searcher.isValidToken = False Then returnData("<slide_show><options></options><photo title=""Invalid token request"">/core/core_images/errors/imageNotFound.jpg</photo></slide_show>") : Return
                
        Try
                             
            searcher.ordersCollection.Add(CORE_CONTENT_SEARCHER.order.contentDatePublicationDesc)
            searcher.page = 1
            searcher.searchStatus = CORE_CONTENT_SEARCHER.status.enabled
            
            Dim mycoll As CORE_CONTENT_COLLECTION(Of CORE_CONTENT_HOLDER) = searcher.search()
            Dim myvalues As StringBuilder = New StringBuilder
            Dim co As CORE_CONTENT_HOLDER

            For Each co In mycoll
                
                myvalues.Append("<photo title=""" & co.contentData.content_title & """ href=""" & CORE.makeLink(co.contentData.content_path, co.contentData.id_key, co.contentData.content_title, CORE.pageEvent.detail) & """ target=""_self"">" & Server.HtmlEncode(CORE.displayCoverPath(co.contentData.id_key, co.contentData.content_default_cover, searcher.width, searcher.height)) & "</photo>")

            Next
            
            
            returnData("<slide_show><options></options>" & myvalues.ToString & "</slide_show>")
                    
        Catch err As Exception
    		                    
            returnData("<slide_show><options>" & Server.HtmlEncode(err.ToString) & "</options><photo title=""Xml generated error"">/core/core_images/errors/imageNotFound.jpg</photo></slide_show>")
                    
        Finally
               
            If Not searcher Is Nothing Then searcher.Dispose() : searcher = Nothing
            
        End Try
         
    		
    		
    End Sub
 
    Sub returnData(ByVal myData As String)
        
        If responseType = "json" Then
            Dim Doc As New XmlDocument()
            Doc.LoadXml(myData)
            Response.ContentType = "text/plain"
            Response.Write(JSON.XmlToJSON(Doc))
            Doc = Nothing
        Else
            Response.ContentType = "text/xml"
            Response.Write(myData)
        End If
     		
    End Sub
 	
        
        </script>