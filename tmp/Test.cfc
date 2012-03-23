<cfcomponent persistent="true" table="test" output="false" hint="A cool |entity|" extends="coldbox.system.orm.hibernate.ActiveEntity">

	<!--- Primary Key --->
	<cfproperty name="id" fieldtype="id" column="id" generator="native">
	
	<!--- Properties --->
	
	
	<!--- Validation --->
	<cfset this.constraints = {
		<!--- Example: age = { required=true, min="18", type="numeric" --->
	}>
	
	<!--- init --->
    <cffunction name="init" output="false" access="public" returntype="any">
    	<cfscript>
    		
    		return this;
    	</cfscript>
    </cffunction>

	
</cfcomponent>