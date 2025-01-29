    <!DOCTYPE html>
    <html>
        <head>
            <title>Create New User</title>
            <style>
                .form-container {
                    max-width: 500px;
                    margin: 30px auto;
                    padding: 20px;
                    border: 1px solid #ddd;
                    border-radius: 5px;
                    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                }
                .form-group {
                    margin-bottom: 15px;
                }
                label {
                    display: block;
                    margin-bottom: 5px;
                    font-weight: bold;
                }
                input {
                    width: 100%;
                    padding: 8px;
                    border: 1px solid #ddd;
                    border-radius: 4px;
                    box-sizing: border-box;
                }
                .btn-submit {
                    background-color: #4CAF50;
                    color: white;
                    padding: 10px 15px;
                    border: none;
                    border-radius: 4px;
                    cursor: pointer;
                    width: 100%;
                }
                .btn-submit:hover {
                    background-color: #45a049;
                }
                .error {
                    color: red;
                    font-size: 0.9em;
                    margin-top: 5px;
                    display: none;
                }
            </style>
        </head>
        <body>
            <cfoutput>

            <div class="form-container">
                <h2>Create New User</h2>
                <form id="userForm" onsubmit="return handleSubmit(event)">
                    <div class="form-group">
                        <label for="name">Name:</label>
                        <input type="text" id="name" name="name" required>
                        <div id="nameError" class="error">Please enter a valid name</div>
                    </div>
        
                    <div class="form-group">
                        <label for="age">Age:</label>
                        <input type="number" id="age" name="age" required>
                    </div>
        
                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" id="email" name="email" required>
                    </div>
        
                    <button type="submit" class="btn-submit">Create User</button>
                </form>
            </div>
        
            <script>
                function handleSubmit(event) {
                    event.preventDefault();
                    
                    // Reset error messages
                    document.querySelectorAll('.error').forEach(error => error.style.display = 'none');
                    
                    // Get form values
                    const name = document.getElementById('name').value.trim();
                    const age = document.getElementById('age').value;
                    const email = document.getElementById('email').value.trim();
                    
                    // Validate only name
                    let isValid = true;
                    
                    if (name.length < 2) {
                        document.getElementById('nameError').style.display = 'block';
                        isValid = false;
                    }
                    
                    if (isValid) {
                        // Prepare the data
                        const userData = {
                            name: name,
                            age: parseInt(age),
                            email: email
                        };
                        
                        fetch('/users/create', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            },
            body: JSON.stringify(userData)
        })
        .then(response => {
            console.log('Server response:', response);
            if (!response.ok) {
                return response.text().then(text => {
                    console.error('Server response:', text); // Debugging
                    throw new Error('Unexpected server response');
                });
            }
            return response;
        })
        .then(data => {
            alert('User created successfully!');
            document.getElementById('userForm').reset();
        })
        .catch(error => {
            console.error('Error:', error.message);
            alert('Error creating user: ' + error.message);
        });
        
        
                    }
                    
                    return false;
                }
            </script>
            </cfoutput>
        </body>
        </html>

