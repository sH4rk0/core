<%@ Import namespace="System.Data"%>
<%@ Import namespace="System.Data.sqlClient"%>
<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.Xml.Linq" %>
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
		
		
		Select Case Request("who")
    	    
        Case "load"
    	          		
                
        Try
                    Dim doc As New XmlDocument
                    doc.Load(Server.MapPath("/public/core_scores/" + Request("game") + "/scores.xml"))    
                    Dim sw As StringWriter = New StringWriter()
                    Dim xw As XmlTextWriter = New XmlTextWriter(sw)
                    doc.WriteTo(xw)
		
                    returnData(sw.ToString())
                    doc = Nothing
                    xw = Nothing
        Catch err As Exception
    		                    
            returnData("<values><error errorId=""666"" errorLabel=""no score data"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                    
        Finally
              
                    
        End Try
		
		
		Case "loadTopFive"
    	          		
                
        Try
                    Dim doc As New XmlDocument
                    doc.Load(Server.MapPath("/public/core_scores/" + Request("game") + "/scoresTopFive.xml"))    
                    Dim sw As StringWriter = New StringWriter()
                    Dim xw As XmlTextWriter = New XmlTextWriter(sw)
                    doc.WriteTo(xw)
		
                    returnData(sw.ToString())
                    doc = Nothing
                    xw = Nothing
        Catch err As Exception
    		                    
            returnData("<values><error errorId=""666"" errorLabel=""no score data"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                    
        Finally
              
                    
        End Try
         
		 
		Case "save"
    	          		
           Try
		   
		  
		         
        Dim logname As String = String.Empty
		Dim lognameTop As String = String.Empty
		
		logname = ConfigurationManager.AppSettings("CORE_scores").ToString() & "/" & Request("game") &"/scores.xml"
		lognameTop = ConfigurationManager.AppSettings("CORE_scores").ToString() & "/" & Request("game") &"/scoresTopFive.xml"

        If Not CORE_FILESYSTEM.fileExists(logname) Then

            Dim writer As XmlTextWriter = New XmlTextWriter(HttpContext.Current.Server.MapPath(logname), Encoding.UTF8)
            writer.WriteStartDocument()
            writer.WriteStartElement("Root")
            writer.WriteStartElement("Scores")
            writer.WriteAttributeString("name", request("name"))
            writer.WriteAttributeString("score", request("score"))
            writer.WriteAttributeString("date", CORE_formatting.dateFormat(Date.now,"yyyyMMddHHmm"))
            writer.WriteEndElement()
            writer.WriteEndElement()
            writer.WriteEndDocument()
            writer.Close()
			
			Dim writer2 As XmlTextWriter = New XmlTextWriter(HttpContext.Current.Server.MapPath(lognameTop), Encoding.UTF8)
            writer2.WriteStartDocument()
            writer2.WriteStartElement("Root")
            writer2.WriteStartElement("Scores")
            writer2.WriteAttributeString("name", request("name"))
            writer2.WriteAttributeString("score", request("score"))
            writer2.WriteAttributeString("date", CORE_formatting.dateFormat(Date.now,"yyyyMMddHHmm"))
            writer2.WriteEndElement()
            writer2.WriteEndElement()
            writer2.WriteEndDocument()
            writer2.Close()
			

        Else

            Dim doc As New XmlDocument()
            doc.Load(HttpContext.Current.Server.MapPath(logname))
            Dim root As XmlNode = doc.DocumentElement
            Dim elem As XmlElement = doc.CreateElement("Scores")
           
            elem.SetAttribute("name", request("name"))
            elem.SetAttribute("score", request("score"))
            elem.SetAttribute("date", CORE_formatting.dateFormat(Date.now,"yyyyMMddHHmm"))
            root.AppendChild(elem)
            doc.Save(HttpContext.Current.Server.MapPath(logname)) 
			          
            Dim aaa = New CORE_XMLHELPER()
            Dim sorted As XmlDocument = aaa.sort(doc)
            sorted.Save(HttpContext.Current.Server.MapPath(lognameTop))
                       

        End If
		
		 returnData("<values><error errorId="""" errorLabel="""" errorMsg=""""/></values>")

           Catch err As Exception
    		                    
            returnData("<values><error errorId=""666"" errorLabel=""Error inserting score"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                    
        Finally
              
                    
        End Try
		
		End Select  
    		
    		
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