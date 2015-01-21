/**
* Manage Contacts
* It will be your responsibility to fine tune this template, add validations, try/catch blocks, logging, etc.
*/
component{
	
	// DI Virtual Entity Service
	property name="ormService" inject="entityService:Contact";
	
	// HTTP Method Security
	this.allowedMethods = {
		index = "GET", new = "GET", edit = "GET", delete = "POST,DELETE", save = "POST,PUT"
	};
	
	/**
	* preHandler()
	*/
	function preHandler( event, rc, prc ){
		event.paramValue( "format", "html" );
	}
		
	/**
	* Listing
	*/
	function index( event, rc, prc ){
		// Get all Contacts
		prc.Contacts = ormService.getAll();
		// Multi-format rendering
		event.renderData( data=prc.Contacts, formats="xml,json,wddx,html,pdf" );
	}	
	
	/**
	* New Form
	*/
	function new( event, rc, prc ){
		// get new Contact
		prc.Contact = ormService.new();
		
		event.setView( "Contacts/new" );
	}	

	/**
	* Edit Form
	*/
	function edit( event, rc, prc ){
		// get persisted Contact
		prc.Contact = ormService.get( rc.contactID );
		
		event.setView( "Contacts/edit" );
	}	
	
	/**
	* View Contact mostly used for RESTful services only.
	*/
	function show( event, rc, prc ){
		
		// Get requested entity by id
		prc.Contact = ormService.get( rc.contactID );
		
		// Multi-format rendering
		event.renderData( data=prc.Contact, formats="xml,json,wddx" );
	}

	/**
	* Save and Update
	*/
	function save( event, rc, prc ){
		// get Contact to persist or update and populate it with incoming form
		prc.Contact = populateModel( model=ormService.get( rc.contactID ), exclude="contactID", composeRelationships=true );
		
		// Do your validations here
		
		// Save it
		ormService.save( prc.Contact );
		
		// RESTful Handler
		switch(rc.format){
			// xml,json,jsont,wddx are by default.  Add your own or remove
			case "xml" : case "json" : case "jsont" : case "wddx" :{
				event.renderData( data=prc.Contact, type=rc.format, location="/Contacts/show/#prc.Contact.getcontactID()#" );
				break;
			}
			// HTML
			default:{
				// Show a nice notice
				flash.put( "notice", { message="Contact Created", type="success" } );
				// Redirect to listing
				setNextEvent( 'Contacts' );
			}
		}
	}	

	/**
	* Delete
	*/
	function delete( event, rc, prc ){
		// Delete record by ID
		var removed = ormService.delete( ormService.get( rc.contactID ) );
		
		// RESTful Handler
		switch( rc.format ){
			// xml,json,jsont,wddx are by default.  Add your own or remove
			case "xml" : case "json" : case "jsont" : case "wddx" :{
				var restData = { "deleted" = removed };
				event.renderData( data=restData, type=rc.format );
				break;
			}
			// HTML
			default:{
				// Show a nice notice
				flash.put( "notice", { message="Contact Poofed!", type="success" } );
				// Redirect to listing
				setNextEvent( 'Contacts' );
			}
		}
	}	
	
}