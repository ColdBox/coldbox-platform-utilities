<!-----------------------------------------------------------------------
Author 	 :	Sana Ullah
Date     :	August 1, 2009
Description :
---------------------------------------------------------------------->

<cflog file="ColdBoxCFBuilder" text="Running PluginGenerator.cfm #timeFormat(now())#">
<cfparam name="ideeventinfo">
<!--- set plugin properties default values --->
<cfset defaultDescription 	= "I am new Plugin" />
<cfset defaultAuthor		= "" />
<cfset defaultAuthorURL		= "" />
<cfset defaultVersion		= "1.0" />
<cfset defaultCache			= "true" />

 
<cfset data = xmlParse(ideeventinfo)>

<cfset extxmlinput = xmlSearch(data, "/event/user/input")>
<cfset inputstruct = StructNew()>

<cfloop index="i" from="1" to="#arrayLen(extxmlinput)#" >
	<cfset StructInsert(inputstruct,"#extxmlinput[i].xmlAttributes.name#","#extxmlinput[i].xmlAttributes.value#")>
</cfloop>

<!--- ======================================================================= --->
<cfif not len(inputstruct.Name)>
	<cfset message = "The plugin cannot be empty" />
	<cfheader name="Content-Type" value="text/xml">  
	<response status="success" showresponse="true">  
	<ide>  
	<dialog width="550" height="350" />  
	<body>
	<![CDATA[<p style="font-size:12px;"><cfoutput>#message#</cfoutput></p>]]>
	</body>
	</ide>
	</response>
</cfif>
<!--- ======================================================================= --->

<cfset message = "" />
<cfset expandLocation	= data.event.ide.projectview.resource.xmlAttributes.path />
<cfset pluginName		= data.event.user.input.xmlAttributes.value />
		
<cffile action="read" file="#ExpandPath('../')#/files/PluginContent.txt" variable="pluginContent">

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

<cfif inputstruct.Cache>
	<cfset pluginContent = replaceNoCase(pluginContent,"|pluginCache|","true","all") />
<cfelse>
	<cfset pluginContent = replaceNoCase(pluginContent,"|pluginCache|","false","all") />	
</cfif>

<cftry>
	<cffile action="write" file="#expandLocation#/#pluginName#.cfc" mode ="777" output="#pluginContent#">
	<cfset message = pluginName & ".cfc Generated new plugin" />
	
	<cfcatch type="any">
		<cfset message = "There was problem creating plugin: #cfcatch.message#" />
	</cfcatch>
</cftry>

<cfheader name="Content-Type" value="text/xml">  
<response status="success" showresponse="true">  
<ide>  
<dialog width="550" height="350" />  
<body>
<![CDATA[<p style="font-size:12px;"><cfoutput>#message#</cfoutput></p>]]>
</body>
</ide>
</response>

