<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Users</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
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
    </style>
</head>
<body>
    <h1>All Users</h1>
    <button id="loadUsersBtn">Load Users</button>
    <div id="userTableContainer">
        <!-- Table will be dynamically populated here -->
    </div>

    <script>
        
            // Function to fetch and render users
            function fetchUsers() {
    $.ajax({
        url: '/users/all', // Backend API endpoint
        method: 'GET',
        dataType: 'json', // Ensure jQuery parses the response as JSON
        success: function (data) {
            if (Array.isArray(data)) {

                console.log(data);
                renderUsersTable(data); // Pass the array of users
            } else {
                alert('Invalid response format');
            }
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
                        </tr>
                    `;
                });

                tableHtml += `
                        </tbody>
                    </table>
                `;

                // Inject the table into the container
                $('#userTableContainer').html(tableHtml);
            }

            // Bind click event to the "Load Users" button
            $('#loadUsersBtn').click(function () {
                fetchUsers();
            });
    </script>
</body>
</html>
