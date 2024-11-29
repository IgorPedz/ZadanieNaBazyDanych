<?php
header("Access-Control-Allow-Origin: http://localhost:3000");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

// Initialize response array
$response = array('status' => 'error', 'message' => 'Unknown error');

// Check if the form was submitted with a file
if (isset($_FILES['file']) && isset($_POST['user_id'])) {
    $file = $_FILES['file'];
    $userId = $_POST['user_id'];

    // Define allowed file types (JPG, PNG, JPEG)
    $allowedTypes = ['image/jpeg', 'image/png', 'image/jpg'];

    // Check if the file type is allowed
    if (in_array($file['type'], $allowedTypes)) {
        // Define the upload directory and file name
        $uploadDir = 'uploads/';
        $fileName = uniqid('profile_', true) . '.' . pathinfo($file['name'], PATHINFO_EXTENSION);
        $filePath = $uploadDir . $fileName;

        // Make sure the upload directory exists
        if (!is_dir($uploadDir)) {
            mkdir($uploadDir, 0777, true);
        }

        // Move the uploaded file to the target directory
        if (move_uploaded_file($file['tmp_name'], $filePath)) {
            // Connect to the database
            $host = "localhost";
            $username = "root";
            $password = "";
            $dbname = "socialmedia";

            try {
                $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $username, $password);
                $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

                // Insert the file URL into the database
                $stmt = $pdo->prepare("UPDATE uzytkownicy SET Link_Zdjecia = :Link_Zdjecia WHERE ID_uzytkownika = :user_id");
                $stmt->execute([
                    'Link_Zdjecia' => $filePath,
                    'user_id' => $userId
                ]);

                // If successful, return a success response
                $response['status'] = 'success';
                $response['message'] = 'Profile picture uploaded and updated successfully!';
                $response['file_url'] = $filePath;  // Send the file URL back to the frontend
            } catch (PDOException $e) {
                $response['message'] = "Database error: " . $e->getMessage();
            }
        } else {
            $response['message'] = 'Failed to move the uploaded file.';
        }
    } else {
        $response['message'] = 'Invalid file type. Only JPG, PNG, and JPEG are allowed.';
    }
} else {
    $response['message'] = 'No file or user ID provided.';
}

// Return the response as JSON
echo json_encode($response);
?>
