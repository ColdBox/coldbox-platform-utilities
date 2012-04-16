/**
* A cool Test entity
*/
component persistent="true" table="tests" extends="coldbox.system.orm.hibernate.ActiveEntity"{

	// Primary Key
	property name="dd" fieldtype="id" column="dd" generator="native";
	
	// Properties
	property name="asf" ormtype="string";	
	
	// Validation
	this.constraints = {
		// Example: age = { required=true, min="18", type="numeric" }
	};
	
	// Constructor
	function init(){
	
		return this;
	}
}
