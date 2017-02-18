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
                
                myvalues.Append("<photo imageurl=""" & Server.HtmlEncode(CORE.displayCoverPath(co.contentData.id_key, co.contentData.content_default_cover, searcher.width, searcher.height)) & """ linkurl=""" & CORE.makeLink(co.contentData.content_path, co.contentData.id_key, co.contentData.content_title, CORE.pageEvent.detail) & """><title>" & co.contentData.content_title & "</title><description><![CDATA[" & co.contentData.content_abstract & "]]></description></photo>")
               
            Next
            
            
            returnData("<tiltviewergallery><photos>" & myvalues.ToString & "</photos></tiltviewergallery>")
                    
        Catch err As Exception
    		                    
            returnData("<tiltviewergallery><photo title=""Xml generated error"" imageurl=""/core/core_images/errors/imageNotFound.jpg""><description></description></photo></tiltviewergallery>")
                    
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