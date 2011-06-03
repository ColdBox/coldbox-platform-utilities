<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldboxframework.com | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author      :	Sana Ullah & Luis Majano
Date        :	08/01/2009

All handlers receive the following:
- data 		  : The data parsed
- inputStruct : A parsed input structure
----------------------------------------------------------------------->

<!--- Expand Locations --->
<cfset expandLocation		= data.event.ide.projectview.resource.xmlAttributes.path />

<!--- Script? --->
<cfset scriptPrefix 		= "">
<cfif inputStruct.Script>
	<cfset scriptPrefix 	= "Script">
</cfif>

<!--- Read in Template --->
<cffile action="read" file="#ExpandPath('../../')#/templates/wirebox/Aspect#scriptPrefix#.txt" variable="aspectContent">

<!--- Start text replacements --->
<cfset aspectContent = replaceNoCase(aspectContent,"|Name|",inputstruct.Name,"all") />
<cfset aspectContent = replaceNoCase(aspectContent,"|Description|",inputstruct.Description,"all") />

<!--- Class & method matchers --->
<cfset matchers = "">
<cfif len(inputStruct.ClassMatcher)>
	<cfset matchers &= ' classMatcher="#inputStruct.ClassMatcher#"'>
</cfif>
<cfif len(inputStruct.methodMatcher)>
	<cfset matchers &= ' methodMatcher="#inputStruct.methodMatcher#"'>
</cfif>
<cfset aspectContent = replaceNoCase(aspectContent,"|matchers|", matchers ,"all") />

<!--- Write out the files --->
<cffile action="write" file="#expandLocation#/#inputstruct.Name#.cfc" mode ="777" output="#aspectContent#">


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
			    <param key="filename" value="#expandLocation#/#inputstruct.Name#.cfc" />
			</params>
		</command>
	</commands>
	<dialog width="550" height="350" title="ColdBox AOP Aspect Wizard" image="includes/images/ColdBox_Icon.png"/>  
	<body><![CDATA[
	<html>
		<head>
			<base href="#controller.getBaseURL()#" />
			<link href="includes/css/styles.css" type="text/css" rel="stylesheet">
			<script type="text/javascript" src="includes/js/jquery.latest.min.js"></script>
		</head>
		<body>
			<div class="messagebox-green">Generated New AOP Aspect!</div>
			<p>
			Make sure you register your aspect in your configuration binder:<br/>
			<pre>
mapAspect("#inputstruct.Name#").to("path.to.#inputstruct.Name#");
			</pre>
			</p>
		</body>
	</html>	
	]]></body>
</ide>
</response>
</cfoutput>
