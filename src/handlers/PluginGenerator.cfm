<!-----------------------------------------------------------------------
Author 	 :	Sana Ullah
Date     :	August 1, 2009
Description :
---------------------------------------------------------------------->

<!--- set plugin properties default values --->
<cfset defaultDescription 	= "I am new Plugin" />
<cfset defaultAuthor		= "" />
<cfset defaultAuthorURL		= "" />
<cfset defaultVersion		= "1.0" />
<cfset defaultCache			= "true" />
<cfset defaultCacheTimeout	= "" />

<cfset data			= xmlParse(ideeventinfo)>
<cfset extxmlinput	= xmlSearch(data, "/event/user/input")>
<cfset inputstruct	= StructNew()>

<cfloop index="i" from="1" to="#arrayLen(extxmlinput)#" >
	<cfset StructInsert(inputstruct,"#extxmlinput[i].xmlAttributes.name#","#extxmlinput[i].xmlAttributes.value#")>
</cfloop>

<!--- ======================================================================= --->
<cfif not len(inputstruct.Name)>
	<cfset message = "The plugin name cannot be empty" />
	<cfheader name="Content-Type" value="text/xml">  
	<response status="success" showresponse="true">  
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
<cfset pluginName		= inputstruct.Name />
<cfset scriptPrefix = "">
<!--- Script? --->
<cfif inputStruct.Script>
	<cfset scriptPrefix = "Script">
</cfif>
		
<cffile action="read" file="#ExpandPath('../')#/templates/PluginContent#scriptPrefix#.txt" variable="pluginContent">

<!--- Start Replacings --->
<cfset pluginContent = replaceNoCase(pluginContent,"|pluginName|",pluginName,"all") />

<cfif len(inputstruct.Version)>
	<cfset pluginContent = replaceNoCase(pluginContent,"|pluginVersion|",inputstruct.Version,"all") />
<cfelse>
	<cfset pluginContent = replaceNoCase(pluginContent,"|pluginVersion|",defaultVersion,"all") />	
</cfif>

<cfif len(inputstruct.Description)>
	<cfset pluginContent = replaceNoCase(pluginContent,"|pluginDescription|",inputstruct.Description,"all") />
<cfelse>
	<cfset pluginContent = replaceNoCase(pluginContent,"|pluginDescription|",defaultDescription,"all") />	
</cfif>


<cfif len(inputstruct.Author)>
	<cfset pluginContent = replaceNoCase(pluginContent,"|pluginAuthor|",inputstruct.Author,"all") />
<cfelse>
	<cfset pluginContent = replaceNoCase(pluginContent,"|pluginAuthor|",defaultAuthor,"all") />	
</cfif>

<cfif len(inputstruct.AuthorURL)>
	<cfset pluginContent = replaceNoCase(pluginContent,"|pluginAuthorURL|",inputstruct.AuthorURL,"all") />
<cfelse>
	<cfset pluginContent = replaceNoCase(pluginContent,"|pluginAuthorURL|",defaultAuthorURL,"all") />	
</cfif>

<cfswitch expression="#inputStruct.Persistence#">
	<cfcase value="Transient">
		<cfset persistence = "">
	</cfcase>
	<cfcase value="Time Persisted">
		<cfset persistence = 'cache="true" cacheTimeout="#inputStruct.CacheTimeout#"'>
	</cfcase>
	<cfcase value="Singleton">
		<cfset persistence = 'singleton="true"'>
	</cfcase>
</cfswitch>
<!--- Persistence Update --->
<cfset pluginContent = replaceNoCase(pluginContent,"|pluginPersistence|",persistence) />

<cftry>
	<cffile action="write" file="#expandLocation#/#pluginName#.cfc" mode ="777" output="#pluginContent#">
	<cfset message = pluginName & ".cfc Generated new plugin" />
	
	<cfcatch type="any">
		<cfset message = "There was problem creating plugin: #cfcatch.message#" />
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
			    <param key="filename" value="#expandLocation#/#pluginName#.cfc" />
			</params>
		</command>
	</commands>
	<dialog width="550" height="350" title="ColdBox Plugin Wizard" image="images/ColdBox_Icon.png"/>  
	<body>
	<![CDATA[<p style="font-size:12px;"><cfoutput>#message#</cfoutput></p>]]>
	</body>
</ide>
</response>
</cfoutput>

