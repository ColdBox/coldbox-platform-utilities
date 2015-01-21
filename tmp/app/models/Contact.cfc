/**
* A cool Contact entity
*/
component persistent="true" table="contact"{

	// Primary Key
	property name="contactID" fieldtype="id" column="contactID" generator="native" setter="false";

	// Properties
	property name="firstname" ormtype="string";	property name="lastname" ormtype="string";	property name="email" ormtype="string";

	// Validation
	this.constraints = {
		// Example: age = { required=true, min="18", type="numeric" }
	};

	// Constructor
	function init(){

		return this;
	}
}
