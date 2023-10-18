import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fyp_mobile/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';

class AuthService {
  AuthService._privateConstructor();

  static final AuthService _instance = AuthService._privateConstructor();

  factory AuthService() {
    return _instance;
  }

  // Future<Map<String, dynamic>> signUp(
  //     String fname, lname, String email, String password) async {
  //   final url = Uri.parse('$baseUrl/api/v1/auth/register');
  //   final headers = {'Content-Type': 'application/json'};
  //   final body = jsonEncode({
  //     'firstname': fname,
  //     'lastname': lname,
  //     'email': email,
  //     'password': password
  //   });

  //   final response = await http.post(url, headers: headers, body: body);
  //   final Map<String, dynamic> responseData = jsonDecode(response.body);

  //   if (response.statusCode == 200) {
  //     return responseData;
  //   } else {
  //     throw Exception('Failed to signup: ${response.statusCode}');
  //   }
  // }

  Future<void> setUserInformationFromToken(String token) async {
    try {
      // Decode the JWT token
      Map<String, dynamic> decodedToken = Jwt.parseJwt(token);

      // Extract user information from the decoded token
      String userId = decodedToken['userId'];
      String firstName = decodedToken['firstName'];
      String lastName = decodedToken['lastName'];
      String email = decodedToken['email'];
      String userRole = decodedToken['userRole'];

      // Store user information in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', userId);
      await prefs.setString('firstName', firstName);
      await prefs.setString('lastName', lastName);
      await prefs.setString('email', email);
      await prefs.setString('userRole', userRole);
    } catch (e) {
      throw Exception('Failed to set user information from token: $e');
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final url = Uri.parse('$baseUrl/api/users/login');
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({'email': email, 'password': password});

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final token = responseData['token'];
        try {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
          await setUserInformationFromToken(token);
        } catch (e) {
          throw Exception('Error getting shared preferences: $e');
        }

        return responseData;
      } else {
        throw Exception('Failed to login: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }
  

  Future<void> logout(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.remove('userRole');
      await prefs.remove('firstName');
      await prefs.remove('lastName');
      await prefs.remove('email');
    } catch (e) {
      throw Exception('Error removing shared preferences: $e');
    }

    // ignore: use_build_context_synchronously
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  Future<String> getTokenFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      return token ?? ''; // return an empty string if token is null
    } catch (e) {
      throw Exception('Error while getting token: $e');
    }
  }

  Future<String> getUserRoleFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? role = prefs.getString('userRole');
      return role ?? ''; // return an empty string if token is null
    } catch (e) {
      throw Exception('Error while getting user role: $e');
    }
  }

  Future<String> getUserNameFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? name = prefs.getString('firstName');
      return name ?? ''; // return an empty string if token is null
    } catch (e) {
      throw Exception('Error while getting user name: $e');
    }
  }

    Future<String> getUserEmailFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? email = prefs.getString('email');
      return email ?? ''; // return an empty string if token is null
    } catch (e) {
      throw Exception('Error while getting user email: $e');
    }
  }

  Future<bool> isTokenExpired() async {
    try {
      final token = await getTokenFromPrefs();
      if (token != null && token.isNotEmpty) {
        bool exp = Jwt.isExpired(token);
        return exp;
      }
    } catch (e) {
      throw Exception('Error while checking token expiration: $e');
    }
    return true; // default to true if token is null or empty
  }

  Future<bool> isAdmin() async {
    try {
      final role = await getUserRoleFromPrefs();
      if (role.isNotEmpty) {
        if (role == 'admin') {
          return true;
        }
        return false;
      }
    } catch (e) {
      throw Exception('Error while checking is admin: $e');
    }
    return false;
  }

  Future<String> getUserName() async {
    try {
      final name = await getUserNameFromPrefs();
      if (name != null && name.isNotEmpty) {
        return name;
      }
      return '';
    } catch (e) {
      throw Exception('Error while getting user name: $e');
    }
  }


    Future<String> getUserEmail() async {
    try {
      final email = await getUserEmailFromPrefs();
      if (email != null && email.isNotEmpty) {
        return email;
      }
      return '';
    } catch (e) {
      throw Exception('Error while getting user name: $e');
    }
  }
}
