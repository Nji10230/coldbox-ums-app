/**
 * I model a User
 */
component  table="users" persistent="true"{

	// Properties
	property name="id" fieldtype="id" column="id" generator="native" setter="false";
	property name="name" ormtype="string";
	property name="age" ormtype="string";
	property name="email" ormtype="string";
	

	// Validation Constraints
	this.constraints = {
		// Example: age = { required=true, min="18", type="numeric" }
	};

	// Constraint Profiles
	this.constraintProfiles = {
		"update" : {}
	};

	// Population Control
	this.population = {
		include : [],
		exclude : [ "id" ]
	};

	// Mementifier
	this.memento = {
		// An array of the properties/relationships to include by default
		defaultIncludes = [ "*" ],
		// An array of properties/relationships to exclude by default
		defaultExcludes = [],
		// An array of properties/relationships to NEVER include
		neverInclude = [],
		// A struct of defaults for properties/relationships if they are null
		defaults = {},
		// A struct of mapping functions for properties/relationships that can transform them
		mappers = {}
	};

	/**
	 * Constructor
	 */
	public User function init(){
		super.init( useQueryCaching="false" );
		return this;
	}

	/**
	 * Verify if the model has been loaded from the database
	 */
	function isLoaded(){
		return ( !isNull( variables.id ) && len( variables.id ) );
	}

	public string function getName() {
        return variables.name;
    }

    public string function getAge() {
        return variables.age;
    }

    public string function getEmail() {
        return variables.email;
    }


}