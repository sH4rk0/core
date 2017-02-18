<%@ WebService Language ="VB" Class="CoreWebServices" %>
Option Strict Off
Imports System
Imports System.Collections.Generic
Imports System.Web
Imports System.Web.Services
Imports System.Web.Script.Services


<WebService(Namespace:="http://www.paginemediche.it/core_webservices/")> <WebServiceBinding()> <ScriptService()> Public Class CoreWebServices : Inherits WebService
    
    <WebMethod()> Public Function HelloWorld() As String
	
        Return "hello world"
    End Function
	
End Class