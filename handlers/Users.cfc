component extends="coldbox.system.EventHandler" {
    // Dependency Injection
    property name="userService" inject="models:UserService";

    /**
     * Display user by ID
     */
    function index(event, rc, prc) {
        var userId = rc.id;

        if (!isNumeric(userId)) {
            event.renderData(data=serializeJSON({
                "error": "Missing or invalid 'id' parameter"
            }), type="json", statusCode=400);
            return;
        }

        try {
            var user = userService.getUser(userId);
            var cleanUser = {
                name = user.name,
                age = user.age,
                email = user.email
            };

            event.renderData(data=serializeJSON(cleanUser), type="json", statusCode=200);
        } catch (any e) {
            event.renderData(data=serializeJSON({
                "error": e.message
            }), type="json", statusCode=500);
        }
    }

    /**
     * Show the create user form
     */
    function new(event, rc, prc) {
        event.setView("users/create");
    }

    /**
     * Create new user - handles both JSON API and form submissions
     */
    function create(event, rc, prc) {
       
            var userData = {};
            
            // Check if it's a JSON API request or form submission
            if (event.getValue("formats", "") == "json") {
                // Handle JSON API request
                var requestBody = event.getHTTPContent();
                userData = deserializeJSON(requestBody);
            } else {
                // Handle form submission
                userData = {
                    name = rc.name ?: "",
                    age = val(rc.age) ?: 0,
                    email = rc.email ?: ""
                };
            }

            // Validate required fields
            if (!structKeyExists(userData, "name") || !len(trim(userData.name))) {
                if (event.getValue("formats", "") == "json") {
                    event.renderData(data=serializeJSON({
                        "error": "Name is required"
                    }), type="json", statusCode=400);
                } else {
                    flash.put("error", "Name is required");
                    relocate(event="users.new");
                }
                return;
            }

        //     // Create the user
            var user = userService.createUser(userData);

            // Return appropriate response
            if (event.getValue("formats", "") == "json") {
                event.renderData(data=serializeJSON(user), type="json", statusCode=201);
            } else {
                flash.put("message", "User created successfully!");
                relocate(event="users.new");
            }

        // } catch (any e) {
        //     if (event.getValue("formats", "") == "json") {
        //         event.renderData(data=serializeJSON({
        //             "error": e.message
        //         }), type="json", statusCode=500);
        //     } else {
        //         flash.put("error", e.message);
        //         relocate(event="users.new");
        //     }
        }

		//get all users 
		function all(event, rc, prc) {
           try {
                var users = userService.getAllUsers();
                event.renderData(data=users, type="json", statusCode=200);
            } catch (any e) {
                event.renderData(data=serializeJSON({
                    "error": e.message
                }), type="json", statusCode=500);
            }
            // event.setView("users/all");

           
        }
        function getNew(event, rc, prc) {
            event.setView("users/all");
        }

        function deleteUser(event, rc, prc) {
            try {
                writeOutput("User ID to delete: " & rc.userId); // Debugging
                var userId = rc.userId; // Extract ID from the request
        
                // Call the service to delete the user
                var result = userService.deleteUserById(userId);
        
                // Render success response
                event.renderData(data=result, type="json", statusCode=200);
            } catch (any e) {
                // Render error response with status 500
                event.renderData(data=serializeJSON({
                    "error": e.message
                }), type="json", statusCode=500);
            }
        }
        
        
        
        function deleteThing(event, rc, prc) {
            event.setView("users/delete");
        }


        function updateUser(event, rc, prc) {
            try {
                var userId = val(rc.userId); // Convert userId to a number
        
                if (userId <= 0) {
                    throw "Invalid User ID: Must be a positive number.";
                }
        
                var userData = {
                    "name": rc.name,
                    "age": val(rc.age), // Ensure age is also numeric
                    "email": rc.email
                };
        
                var user = userService.updateUserById(userId, userData);
                event.renderData(data=user, type="json", statusCode=200);
        
            } catch (any e) {
                event.renderData(data=serializeJSON({
                    "error": e.message
                }), type="json", statusCode=500);
            }
        }
        
        

        function updateThing(event, rc, prc) {
            event.setView("users/update");
        }

    }
