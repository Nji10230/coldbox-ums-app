/**
 * I am a new handler
 * Implicit Functions: preHandler, postHandler, aroundHandler, onMissingAction, onError, onInvalidHTTPMethod
 */
component extends="coldbox.system.EventHandler"{
	// Dependency Injection
	property name="userService" inject="models:UserService";

	this.prehandler_only 	= "";
	this.prehandler_except 	= "";
	this.posthandler_only 	= "";
	this.posthandler_except = "";
	this.aroundHandler_only = "";
	this.aroundHandler_except = "";
	this.allowedMethods = {};

	//di

	/**
	 * Display a listing of the resource
	 */
	// function index( event, rc, prc ){
	// 	var users = userService.getUser(id);
	// 	var cleanUser = {
	// 		name = users.name,
	// 		age = users.age,
	// 		email = users.email
	// 	};
	// 	event.renderData(data=serialize(cleanUser), format="json", status=200);
	// 	//return users;

	// }

	function index(event, rc, prc) {
		// Extract the 'id' from the route parameter (rc.id)
		var userId = rc.id;
	
		// Validate the 'id'
		if (!isNumeric(userId)) {
			event.renderData(data="Error: Missing or invalid 'id' parameter", format="json", status=400);
			return;
		}
	
		// Fetch the user from the service
		try {
			var user = userService.getUser(userId);
	
			// Prepare the response
			var cleanUser = {
				name = user.name,
				age = user.age,
				email = user.email
			};
	
			event.renderData(data=serialize(cleanUser), format="json", status=200);
		} catch (any e) {
			// Handle exceptions (e.g., user not found)
			event.renderData(data="Error: " & e.message, format="json", status=500);
		}
	}
	
	
	/**
	 * Store a newly created resource in storage
	 */
	// function create( event, rc, prc ){
	// 	//var userService = controller.getWireBox().getInstance("UserService");
	// 	//var userService =new UserService();
	// 	// var user  = userService.createUser( {
	// 	// 	name = "abhiram",
	// 	// 	age = "23",
	// 	// 	email = "pabhiram2001@gmail.com"
	// 	// } );
	// 	// var cleanUser = {
	// 	// 	name = user.getName(),
    //     //     age = user.getAge(),
    //     //     email = user.getEmail()
	// 	// };
		
    // event.renderData(data=serialize(cleanUser), format="json", status=201);

	// }

	// function create( event, rc, prc ) { 
	// 	// Parse incoming JSON data
	// 	var requestData = deserializeJSON(event.getHTTPContent());
	
	// 	// Pass the parsed data to the service
	// 	var user = userService.createUser(requestData);
	
	// 		var cleanUser = {
	// 		name = user.getName(),
    //         age = user.getAge(),
    //         email = user.getEmail()
	// 	};

	// 	writeOutput("Request Data: " & serializeJSON(requestData));

	// 	// Render response as JSON with HTTP status 201
	// 	event.renderData(data=serialize(user), format="json", status=201);
	// }

	function create( event, rc, prc ) { 
		try {
			// Parse the JSON payload into a struct
			var requestData = deserializeJSON(event.getHTTPContent());
	
			// Call the service to create the user and return their details as a struct
			var user = userService.createUser(requestData);
	
			// Directly use the returned struct as the response
			event.renderData(data=serialize(user), format="json", status=201);
		} catch (any e) {
			// Handle errors gracefully
			event.renderData(data="Error: " & e.message, format="json", status=500);
		}
	}
	
	


}

