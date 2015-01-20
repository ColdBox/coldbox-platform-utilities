/**
* A ColdBox Enabled virtual entity service
*/
component extends="coldbox.system.orm.hibernate.VirtualEntityService" singleton{
	
	/**
	* Constructor
	*/
	public TestService function init(){
		
		// init super class
		super.init(entityName="Test");
		
		// Use Query Caching
	    setUseQueryCaching( false );
	    // Query Cache Region
	    setQueryCacheRegion( 'ORMService.defaultCache' );
	    // EventHandling
	    setEventHandling( true );
	    
	    return this;
	}
	
}