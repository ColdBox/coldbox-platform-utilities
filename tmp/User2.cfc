/**
* A cool User entity
*/
component persistent="true" table="users"{

	// Primary Key
	property name="id" fieldtype="id" column="id" generator="native";
	property name="id2" persistent="false";
	
	// Properties
	property name="fname" ormtype="string";	property name="lname" ormtype="string";	property name="isActive" ormtype="boolean";	property name="createdDate" ormtype="date";	property name="updateDate" ormtype="date";	property name="email" ormtype="string";	
	
	// Constructor
	function init(){
	
		return this;
	}
}
