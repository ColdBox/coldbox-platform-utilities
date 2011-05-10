<cfcomponent persistent="true" table="contacts" output="false" hint="A cool |entity|">

	<!--- Primary Key --->
	<cfproperty name="id" fieldtype="id" column="id" generator="native">
	
	<!--- Properties --->
	<cfproperty name="fname" ormtype="string">	<cfproperty name="lname" ormtype="string">	<cfproperty name="age" ormtype="numeric">	
	
	<!--- init --->
    <cffunction name="init" output="false" access="public" returntype="any">
    	<cfscript>
    		
    		return this;
    	</cfscript>
    </cffunction>

	
</cfcomponent>