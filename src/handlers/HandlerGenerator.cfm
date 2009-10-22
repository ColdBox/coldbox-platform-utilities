<!-----------------------------------------------------------------------
Author 	 :	Sana Ullah
Date     :	August 1, 2009
Description :
---------------------------------------------------------------------->
<!--- set handler properties default values --->
<cfset defaultDescription 	= "I am a new handler" />
<cfset defaultName			= "" />
<cfset message	= "" /> 
<cfset data		= xmlParse(ideeventinfo)>

<!--- Parse Input --->
<cfset extxmlinput = xmlSearch(data, "/event/user/input")>
<cfset inputstruct = StructNew()>
<cfloop index="i" from="1" to="#arrayLen(extxmlinput)#" >
	<cfset StructInsert(inputstruct,"#extxmlinput[i].xmlAttributes.name#","#extxmlinput[i].xmlAttributes.value#")>
</cfloop>

<!--- Expand Locations --->
<cfset expandLocation	= data.event.ide.projectview.resource.xmlAttributes.path />
<cfset handlerName		= inputstruct.Name />

<!--- Script? --->
<cfset scriptPrefix = "">
<cfif inputStruct.Script>
	<cfset scriptPrefix = "Script">
</cfif>

<!--- Read in Templates --->
<cffile action="read" file="#ExpandPath('../')#/templates/HandlerContent#scriptPrefix#.txt" variable="handlerContent">
<cffile action="read" file="#ExpandPath('../')#/templates/ActionContent#scriptPrefix#.txt"  variable="actionContent">
<cffile action="read" file="#ExpandPath('../')#/templates/HandlerTestContent#scriptPrefix#.txt" variable="handlerTestContent">
<cffile action="read" file="#ExpandPath('../')#/templates/HandlerTestCaseContent#scriptPrefix#.txt" variable="handlerTestCaseContent">


<!--- Start text replacements --->
<cfset handlerContent = replaceNoCase(handlerContent,"|Name|",inputstruct.Name,"all") />
<cfset handlerTestContent = replaceNoCase(handlerTestContent,"|appMapping|",inputstruct.appMapping,"all") />

<cfif len(inputstruct.Description)>
	<cfset handlerContent = replaceNoCase(handlerContent,"|Description|",inputstruct.Description,"all") />
<cfelse>
	<cfset handlerContent = replaceNoCase(handlerContent,"|Description|",defaultDescription,"all") />	
</cfif>

<!--- Handle Actions if passed --->
<cfif len(inputstruct.Actions)>
	<cfset allActions = "">
	<cfset allTestsCases = "">
	<cfset thisTestCase = "">
	
	<!--- Loop Over actions generating their functions --->
	<cfloop list="#inputStruct.Actions#" index="thisAction">
		<cfset allActions = allActions & replaceNoCase(actionContent,"|action|",thisAction,"all") & chr(13) & chr(13)/>
		
		<!--- Are we creating views? --->
		<cfif inputStruct.GenerateViews>
			<!--- Check if dir exists? --->
			<cfif NOT directoryExists(inputStruct.ViewsDirectory & "/" & inputStruct.name)>
				<cfdirectory action="create" directory="#inputStruct.ViewsDirectory & "/" & inputStruct.name#" mode="777">
			</cfif>
			<!--- Create View Stub --->
			<cfset fileWrite(inputStruct.ViewsDirectory & "/" & inputStruct.name & "/" & thisAction & ".cfm","<h1>#inputStruct.name#.#thisAction#</h1>")>
		</cfif>
		
		<!--- Are we creating tests cases on actions --->
		<cfif inputStruct.GenerateTest>
			<cfset thisTestCase = replaceNoCase(handlerTestCaseContent,"|action|",thisAction,"all")>
			<cfset thisTestCase = replaceNoCase(thisTestCase,"|event|",inputstruct.Name & "." & thisAction,"all")>
			<cfset allTestsCases = allTestsCases & thisTestCase & chr(13) & chr(13)/>
		</cfif>
		
	</cfloop>
	
	
	<cfset allActions = replaceNoCase(allActions,"|name|",inputStruct.Name,"all") />
	<cfset handlerContent = replaceNoCase(handlerContent,"|EventActions|",allActions,"all") />	
	<cfset handlerTestContent = replaceNoCase(handlerTestContent,"|TestCases|",allTestsCases,"all") />	
<cfelse>
	<cfset handlerContent = replaceNoCase(handlerContent,"|EventActions|",'',"all") />
	<cfset handlerTestContent = replaceNoCase(handlerTestContent,"|TestCases|",'',"all") />	
</cfif>

<!--- Write out the files --->

<cffile action="write" file="#expandLocation#/#handlerName#.cfc" mode ="777" output="#handlerContent#">
<cfif inputStruct.GenerateTest>
	<cffile action="write" file="#inputStruct.TestsDirectory#/#handlerName#Test.cfc" mode ="777" output="#handlerTestContent#">
</cfif>	

<cfheader name="Content-Type" value="text/xml">  
<cfoutput>
<response status="success" showresponse="true">  
<ide>  
	<commands>
		<command type="RefreshProject">
			<params>
			    <param key="projectname" value="#data.event.ide.projectview.xmlAttributes.projectname#" />
			</params>
		</command>
		<command type="openfile">
			<params>
			    <param key="filename" value="#expandLocation#/#handlerName#.cfc" />
			</params>
		</command>
		<cfif inputStruct.generateTest>
		<command type="openfile">
			<params>
			    <param key="filename" value="#inputStruct.TestsDirectory#/#handlerName#Test.cfc" />
			</params>
		</command>
		</cfif>
	</commands>
	<dialog width="550" height="350" title="ColdBox Event Handler Wizard" image="images/ColdBox_Icon.png"/>  
	<body><![CDATA[
	<h2>Generated New Handler!</h2>
	<p>
	Generated new handler called: #handlerName#.cfc<br/>
	<cfif inputStruct.generateTest>
	Generated new integration test called: #handlerName#Test.cfc
	</cfif>
	</p>
	]]></body>
</ide>
</response>
</cfoutput>
