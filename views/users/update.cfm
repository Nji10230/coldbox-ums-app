
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update User</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        label {
            font-weight: bold;
        }
        input, button {
            margin-bottom: 10px;
            padding: 8px;
            width: 100%;
        }
        button {
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

    <h2>Update User</h2>

    <form id="updateUserForm">
        <label for="userId">User ID:</label>
        <input type="text" id="userId" name="userId" required>

        <label for="userName">Name:</label>
        <input type="text" id="userName" name="name" required>

        <label for="userAge">Age:</label>
        <input type="number" id="userAge" name="age" required>

        <label for="userEmail">Email:</label>
        <input type="email" id="userEmail" name="email" required>

        <button type="submit">Update User</button>
    </form>

    <script>
    $('#updateUserForm').submit(function (event) {
    event.preventDefault();

    var userId = parseInt($('#userId').val()); // Convert userId to number

    if (isNaN(userId) || userId <= 0) {
        alert("Invalid User ID");
        return;
    }

    var userData = {
        name: $('#userName').val(),
        age: parseInt($('#userAge').val()), // Convert age to number
        email: $('#userEmail').val()
    };

    $.ajax({
        url: `/users/update/${userId}`,  // ✅ Use backticks for proper URL interpolation
        method: 'PUT',
        contentType: 'application/json',
        data: JSON.stringify(userData),
        success: function (response) {
            alert(response.message);
           // alert("successfully updated user");
            //alert(response.message);
        },
        error: function (xhr, status, error) {
            alert('Failed to update user: ' + xhr.responseText);
        }
    });
});

    </script>

</body>
</html>
