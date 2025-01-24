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
		return {
			name = user.getName(),
			age = user.getAge(),
			email = user.getEmail()
		};
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
	


}