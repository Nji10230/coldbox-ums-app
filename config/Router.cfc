/**
 * This is your application router.  From here you can controll all the incoming routes to your application.
 *
 * https://coldbox.ortusbooks.com/the-basics/routing
 */
component {

	function configure(){
		/**
		 * --------------------------------------------------------------------------
		 * Router Configuration Directives
		 * --------------------------------------------------------------------------
		 * https://coldbox.ortusbooks.com/the-basics/routing/application-router#configuration-methods
		 */
		setFullRewrites( true );

		/**
		 * --------------------------------------------------------------------------
		 * App Routes
		 * --------------------------------------------------------------------------
		 * Here is where you can register the routes for your web application!
		 * Go get Funky!
		 */

		// A nice healthcheck route example
		route( "/healthcheck", function( event, rc, prc ){
			return "Ok!";
		} );

		// A nice RESTFul Route example
		route( "/api/echo", function( event, rc, prc ){
			return { "error" : false, "data" : "Welcome to my awesome API!" };
		} );

		// @app_routes@

		// route( "/users" )
		// 	.rc( "formats", "json" )
		// 	.to( "Users.create" );
		//addRoute( pattern="/getuser", handler="Users", action="index",method="GET" );
		
		
		route("/users/new").to("users.new");
		route("/users/getAll").to("users.getNew");
	  // route("users/all").to("users.all");
	    route("/users/update/:userId").to("users.updateUser");

		//route("users/deleteThing").to("users.delete");

		route("/users/delete/:userId").to("users.deleteUser");
		
	
			route( "/get/:id" )
			.rc( "formats", "json" )
			.to( "Users.index" );

		//route("/get-all-users").to("users.all");
		

		// Conventions-Based Routing
		route( ":handler/:action?" ).end();
	}

}
