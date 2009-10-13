<!-----------------------------------------------------------------------
Author 	 :	Sana Ullah
Date     :	August 1, 2009
Description :
---------------------------------------------------------------------->
<!--- set plugin properties default values --->
<cfset defaultDescription 	= "I am a new Model Object" />
<cfset defaultSingleton 	= "false">
<cfset defaultCache			= "false" />
<cfset defaultCacheTimeout  = "" >
 
<cfset data			= xmlParse(ideeventinfo)>
<cfset extxmlinput	= xmlSearch(data, "/event/user/input")>
<cfset inputstruct	= StructNew()>

<cfloop index="i" from="1" to="#arrayLen(extxmlinput)#" >
	<cfset StructInsert(inputstruct,"#extxmlinput[i].xmlAttributes.name#","#extxmlinput[i].xmlAttributes.value#")>
</cfloop>

<!--- ======================================================================= --->
<cfif not len(inputstruct.Name)>
	<cfset message = "The model name cannot be empty" />
	<cfheader name="Content-Type" value="text/xml">  
	<response status="error" showresponse="true">  
		<ide>  
			<dialog width="550" height="350" />  
			<body>
			<![CDATA[<p style="font-size:12px;"><cfoutput>#message#</cfoutput></p>]]>
			</body>
		</ide>
	</response>
	
	<cfabort>
</cfif>
<!--- ======================================================================= --->

<cfset message = "" />
<cfset expandLocation	= data.event.ide.projectview.resource.xmlAttributes.path />
<cfset modelName		= inputstruct.Name />
<cfset scriptPrefix = "">
<!--- Script? --->
<cfif inputStruct.Script>
	<cfset scriptPrefix = "Script">
</cfif>

<cffile action="read" file="#ExpandPath('../')#/templates/ModelContent#scriptPrefix#.txt" variable="modelContent">

<cfset modelContent = replaceNoCase(modelContent,"|modelName|",modelName,"all") />

<cfif len(inputstruct.Description)>
	<cfset modelContent = replaceNoCase(modelContent,"|modelDescription|",inputstruct.Description,"all") />
<cfelse>
	<cfset modelContent = replaceNoCase(modelContent,"|modelDescription|",defaultDescription,"all") />	
</cfif>

<cfswitch expression="#inputStruct.Persistence#">
	<cfcase value="Transient">
		<cfset modelContent = replaceNoCase(modelContent,"|modelPersistence|","","all") />
	</cfcase>
	<cfcase value="Time Persisted">
		<cfset cacheString = 'cache="true"'>
		<cfif len(inputStruct.cacheTimeout)>
			<cfset cacheString = cacheString & ' cacheTimeout="#inputStruct.cacheTimeout#"'>
		</cfif>
		<cfset modelContent = replaceNoCase(modelContent,"|modelPersistence|",cacheString,"all") />
	</cfcase>
	<cfcase value="Singleton">
		<cfset modelContent = replaceNoCase(modelContent,"|modelPersistence|",'singleton="true"',"all") />
	</cfcase>
</cfswitch>

<!--- Write it back out --->
<cftry>
	<cffile action="write" file="#expandLocation#/#modelName#.cfc" mode ="777" output="#modelContent#">
	<cfset message = modelName & ".cfc Generated new model object" />
	
	<cfcatch type="any">
		<cfset message = "There was problem creating model object: #cfcatch.message#" />
	</cfcatch>
</cftry>

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
			    <param key="filename" value="#expandLocation#/#modelName#.cfc" />
			</params>
		</command>
	</commands>
	<dialog width="550" height="350" title="New ColdBox Model Wizard" image="images/ColdBox_Icon.png"/>  
	<body>
	<![CDATA[<p style="font-size:12px;"><cfoutput>#message#</cfoutput></p>]]>
	</body>
</ide>
</response>
</cfoutput>
