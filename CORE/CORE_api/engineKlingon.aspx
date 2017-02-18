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

    Dim responseType As String
       
    Sub page_load()
                  
        responseType = CORE.checkResponse()
        
        Dim doc As New XmlDocument
        doc.Load(Server.MapPath("/core/core_xml/klingon.xml"))
        Dim nodes As XmlNodeList = doc.SelectNodes("root/klingon")
        Randomize()
        Dim r As New Random(System.DateTime.Now.Millisecond)
        Dim random As Integer = r.Next(0, nodes.Count - 1)
        Dim prhase As String = nodes(random).InnerText
        doc = Nothing
        
        Try
                                    
            returnData("<values><message iSay=""" & Server.HtmlEncode(prhase) & """ /><error errorId=""0"" errorLabel=""""/></values>")
                    
        Catch err As Exception
    		                    
            returnData("<values><error errorId=""666"" errorLabel=""Damn Federation Error!"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                    
        Finally
               
                    
        End Try
         
    		
    		
    End Sub
 
    Sub returnData(ByVal myData As String)
        
        If responseType = "json" Then
            Dim Doc As New XmlDocument()
            Doc.LoadXml(myData)
            Response.ContentType = "text/plain"
            Response.Write(JSON.XmlToJSON(Doc))
            Doc = Nothing
        ElseIf responseType = "jsonp" Then
            Dim Doc As New XmlDocument()
            Doc.LoadXml(myData)
            Response.ContentType = "text/plain"
            Response.Write(Request("callback") & "(" & JSON.XmlToJSON(Doc) & ")")
            Doc = Nothing
        ElseIf responseType = "xml" Then
            Response.ContentType = "text/xml"
            Response.Write(myData)
        End If

     		
    End Sub
 	
        
        </script>