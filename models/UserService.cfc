/**
 * I am a new service
 */
component singleton {

	// DI
       
	/**
	 * Constructor
	 */
	UserService function init(){
		
		return this;
	}
	function createUser( required struct userData ) {
		var user = new User();
		user.setName(userData.name);
		user.setAge(userData.age);
		user.setEmail(userData.email);
	
		// Save user to the database
		entitySave(user);
		ormFlush();
	
		// Return user details as a struct
		// return {
		// 	name = user.getName(),
		// 	age = user.getAge(),
		// 	email = user.getEmail()
		// };
	}
	
	// function getUser(required numeric id){
	// 	var user =entityLoadByPK("User",id);
	// 	var newUser = new User();
	// 	//writeOutput(serializeJSON(user));
	// 	return {
	// 		name = user.getName(),
	// 		age = user.getAge(),
	// 		email = user.getEmail()
	// 	};

		
	// }
	function getUser(required numeric id) {
		// Load the user entity by primary key
		var user = entityLoadByPK("User", id);
	
		// Check if the user is null
		if (!isDefined("user") || isNull(user)) {
			throw("UserNotFoundException", "User with ID " & id & " not found.");
		}
	
		// Return user details as a struct
		return {
			name = user.getName(),
			age = user.getAge(),
			email = user.getEmail()
		};
	}


	// get all users
	
		/**
		 * Fetch all users and return a properly formatted JSON response
		 */
		function getAllUsers() {
			// Fetch all users using ORM
			var users = entityLoad("User");
			
			// Create an array to hold the structured user details
			var userArray = [];
			
			// Loop through each user object and structure the response
			for (var user in users) {
				userArray.append({
					id = user.getId(),
					name = user.getName(),
					age = user.getAge(),
					email = user.getEmail()
				});
			}
			
			// Return the array as an unwrapped JSON response
			return userArray; // Ensure it's an array, not a string
		}

		// Function to delete a user by ID
// function deleteUserById(numeric id) {
//     try {
//         // Load the user entity by ID
//         var user = entityLoadByPK("User", id);

//         // return {
// 		// 	"user": user
// 		// }
//         if (isNull(user)) {
//             throw ("User with ID " & id & " not found.");
//         }
        
//         // Delete the user from the database
//         entityDelete(user);
//         // return {
// 		// 	"result": result
// 		// }
//         // Return a success message
//         // return {
//         //     message: "User deleted successfully",
//         //     status: "success",
// 		// 	result: result
//         // };
//     } catch (any e) {
//         // Handle exceptions and return an error message
//         return {
//             message: e.message,
//             status: "error"
//         };
//     }
// }
function deleteUserById(numeric id) {
    try {
        // Load the user entity by ID
        var user = entityLoadByPK("User", id);

        if (isNull(user)) {
            throw ("User with ID " & id & " not found.");
        }

        // Wrap delete in a transaction block
        transaction {
            entityDelete(user);
            ormFlush(); // Ensure changes are flushed to the database
        }

        // Return success response
        return {
            "message": "User deleted successfully.",
            "status": "success"
        };
    } catch (any e) {
        // Log error for debugging
        writeDump(e);
        return {
            "message": "Failed to delete user: " & e.message,
            "status": "error"
        };
    }
}

            // update user details by id
			function updateUserById(numeric id, required struct userData) {
				if (id <= 0) {
					throw ("Invalid User ID: " & id);
				}
			
				// Load the user entity by ID
				var user = entityLoadByPK("User", id);
				
				// Check if the user exists
				if (isNull(user)) {
					throw ("User with ID " & id & " not found.");
				}
			
				// Update user details
				user.setName(userData.name);
				user.setAge(userData.age);
				user.setEmail(userData.email);
			
				// Save changes to the database
				ormFlush();
			
				// Return success response
				return {
					"message": "User updated successfully.",
					"status": "success"
				};
			}
			

		
	}



