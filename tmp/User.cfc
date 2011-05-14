<cfcomponent>
	
	<cfproperty name="id" fieldtype="id" column="id" generator="native">
	
	<cfproperty name="fname" ormtype="string">
	<cfproperty name="lname" ormtype="string">
	<cfproperty name="isActive" ormtype="boolean">
	<cfproperty name="createdDate" ormtype="date">
	<cfproperty name="updateDate" ormtype="date">
	<cfproperty name="email" ormtype="string">
	
</cfcomponent>