<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            margin-top: 20px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #f4f4f4;
        }
        button {
            padding: 5px 10px;
            background-color: #ff5c5c;
            color: white;
            border: none;
            cursor: pointer;
        }
        button:hover {
            background-color: #ff3b3b;
        }
    </style>
</head>
<body>
    <h1>User Management</h1>
    <button id="loadUsersBtn">Load Users</button>
    <div id="userTableContainer">
        <!-- Table will be dynamically populated here -->
    </div>

    <script>
        $(document).ready(function () {
            // Function to fetch and render users
            function fetchUsers() {
                $.ajax({
                    url: '/users/all', // Backend API endpoint to fetch users
                    method: 'GET',
                    dataType: 'json',
                    success: function (data) {
                        renderUsersTable(data);
                    },
                    error: function (xhr, status, error) {
                        alert('Failed to fetch users: ' + error);
                    }
                });
            }

            // Render the users table dynamically
            function renderUsersTable(users) {
                if (!users || users.length === 0) {
                    $('#userTableContainer').html('<p>No users found.</p>');
                    return;
                }

                var tableHtml = `
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Age</th>
                                <th>Email</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                `;

                // Loop through users and append rows to the table
                users.forEach(function (user) {
                    tableHtml += `
                        <tr>
                            <td>${user.ID}</td>
                            <td>${user.NAME}</td>
                            <td>${user.AGE}</td>
                            <td>${user.EMAIL}</td>
                            <td><button class="deleteUserBtn" data-id="${user.ID}">Delete</button></td>
                        </tr>
                    `;
                });

                tableHtml += `
                        </tbody>
                    </table>
                `;

                // Inject the table into the container
                $('#userTableContainer').html(tableHtml);

                // Attach click event listeners for delete buttons
                $('.deleteUserBtn').click(function () {
                    var userId = $(this).data('id');
                    deleteUser(userId);
                });
            }

            // Function to delete a user by ID
            function deleteUser(ID) {
                alert('Deleting user with ID: ' + ID);
                if (confirm('Are you sure you want to delete this user?')) {
                    $.ajax({
                        url: `/users/delete/${ID}`, // Backend API endpoint for deletion
                        method: 'POST',
                        success: function (response) {
                            console.log(ID);
                            console.log(response);
                            alert(response.message);
                            fetchUsers(); // Reload the user table after deletion
                        },
                        error: function (xhr, status, error) {
                            alert('Failed to delete user: ' + error);
                        }
                    });
                }
            }

            // Bind click event to the "Load Users" button
            $('#loadUsersBtn').click(function () {
                fetchUsers();
            });
        });
    </script>
</body>
</html>
