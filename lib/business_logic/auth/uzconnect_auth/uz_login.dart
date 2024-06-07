//given email and password, this function will authenticate the user and return a token if successful. call login api in urls.dart
import 'package:http/http.dart' as http;
import 'package:firefriday/constants/urls.dart';

Future<String> authenticateUser(String email, String password) async {
  try {
    // Make a POST request to the login API
    print('\n LOGIN --- email: ' + email);
    var response = await http.post(
      Uri.parse(Urls.uzLogin),
      body: {
        'email': email,
        'password': password,
      },
    );

    print("Response: " + response.body.toString());

    // Check if the request was successful
    if (response.statusCode >= 200) {
      // Extract the token from the response
      var token = response.body;

      // Return the token
      return token;
    } else {
      // Handle the error case
      throw Exception('Failed to authenticate user');
    }
  } catch (e) {
    // Handle any exceptions that occur during the request
    throw Exception('Failed to authenticate user: $e');
  }
}
