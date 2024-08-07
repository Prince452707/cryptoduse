// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// final supabase = Supabase.instance.client;

// class ProfilePage extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   final _formKey = GlobalKey<FormState>();
//   final _firstNameController = TextEditingController();
//   final _lastNameController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _bioController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _loadUserProfile();
//   }

//   Future<void> _loadUserProfile() async {
//     final user = supabase.auth.currentUser;
//     if (user != null) {
//       final response = await supabase
//           .from('profiles')
//           .select()
//           .eq('id', user.id)
//           .single();
//       setState(() {
//         _firstNameController.text = response['first_name'] ?? '';
//         _lastNameController.text = response['last_name'] ?? '';
//         _phoneController.text = response['phone'] ?? '';
//         _bioController.text = response['bio'] ?? '';
//       });
//     }
//   }

//   Future<void> _updateProfile() async {
//     if (_formKey.currentState!.validate()) {
//       final user = supabase.auth.currentUser;
//       if (user != null) {
//         await supabase.from('profiles').upsert({
//           'id': user.id,
//           'first_name': _firstNameController.text,
//           'last_name': _lastNameController.text,
//           'phone': _phoneController.text,
//           'bio': _bioController.text,
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Profile updated successfully')),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Profile')),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: CircleAvatar(
//                   radius: 50,
//                   // backgroundImage: NetworkImage(
//                   //   'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y',
//                   // ),
//                 ),
//               ),
//               SizedBox(height: 24),
//               TextFormField(
//                 controller: _firstNameController,
//                 decoration: InputDecoration(labelText: 'First Name'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your first name';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _lastNameController,
//                 decoration: InputDecoration(labelText: 'Last Name'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your last name';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _phoneController,
//                 decoration: InputDecoration(labelText: 'Phone Number'),
//                 keyboardType: TextInputType.phone,
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _bioController,
//                 decoration: InputDecoration(labelText: 'Bio'),
//                 maxLines: 3,
//               ),
//               SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: _updateProfile,
//                 child: Text('Update Profile'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

















// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// final supabase = Supabase.instance.client;

// class ProfilePage extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   final _formKey = GlobalKey<FormState>();
//   final _firstNameController = TextEditingController();
//   final _lastNameController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _bioController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _loadUserProfile();
//   }

//   Future<void> _loadUserProfile() async {
//     final user = supabase.auth.currentUser;
//     if (user != null) {
//       final response = await supabase
//           .from('profiles')
//           .select()
//           .eq('id', user.id)
//           .single();
//       setState(() {
//         _firstNameController.text = response['first_name'] ?? '';
//         _lastNameController.text = response['last_name'] ?? '';
//         _phoneController.text = response['phone'] ?? '';
//         _bioController.text = response['bio'] ?? '';
//       });
//     }
//   }

//   Future<void> _updateProfile() async {
//     if (_formKey.currentState!.validate()) {
//       final user = supabase.auth.currentUser;
//       if (user != null) {
//         await supabase.from('profiles').upsert({
//           'id': user.id,
//           'first_name': _firstNameController.text,
//           'last_name': _lastNameController.text,
//           'phone': _phoneController.text,
//           'bio': _bioController.text,
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Profile updated successfully')),
//         );
//       }
//     }
//   }

//   Future<void> _logout() async {
//     await supabase.auth.signOut();
//     Navigator.of(context).pushReplacementNamed('/login'); // Adjust this route as needed
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: _logout,
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: CircleAvatar(
//                   radius: 50,
//                   // backgroundImage: NetworkImage(
//                   //   'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y',
//                   // ),
//                 ),
//               ),
//               SizedBox(height: 24),
//               TextFormField(
//                 controller: _firstNameController,
//                 decoration: InputDecoration(labelText: 'First Name'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your first name';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _lastNameController,
//                 decoration: InputDecoration(labelText: 'Last Name'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your last name';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _phoneController,
//                 decoration: InputDecoration(labelText: 'Phone Number'),
//                 keyboardType: TextInputType.phone,
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _bioController,
//                 decoration: InputDecoration(labelText: 'Bio'),
//                 maxLines: 3,
//               ),
//               SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: _updateProfile,
//                 child: Text('Update Profile'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
























// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'login.dart'; // Make sure this import points to your login page

// final supabase = Supabase.instance.client;

// class ProfilePage extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   final _formKey = GlobalKey<FormState>();
//   final _firstNameController = TextEditingController();
//   final _lastNameController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _bioController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _loadUserProfile();
//   }

//   Future<void> _loadUserProfile() async {
//     final user = supabase.auth.currentUser;
//     if (user != null) {
//       final response = await supabase
//           .from('profiles')
//           .select()
//           .eq('id', user.id)
//           .single();
//       setState(() {
//         _firstNameController.text = response['first_name'] ?? '';
//         _lastNameController.text = response['last_name'] ?? '';
//         _phoneController.text = response['phone'] ?? '';
//         _bioController.text = response['bio'] ?? '';
//       });
//     }
//   }

//   Future<void> _updateProfile() async {
//     if (_formKey.currentState!.validate()) {
//       final user = supabase.auth.currentUser;
//       if (user != null) {
//         await supabase.from('profiles').upsert({
//           'id': user.id,
//           'first_name': _firstNameController.text,
//           'last_name': _lastNameController.text,
//           'phone': _phoneController.text,
//           'bio': _bioController.text,
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Profile updated successfully')),
//         );
//       }
//     }
//   }

//   Future<void> _logout() async {
//     final shouldLogout = await showDialog<bool>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Logout'),
//         content: Text('Are you sure you want to logout?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(false),
//             child: Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(true),
//             child: Text('Logout'),
//           ),
//         ],
//       ),
//     );

//     if (shouldLogout == true) {
//       await supabase.auth.signOut();
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => SignInPage()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: _logout,
//             tooltip: 'Logout',
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: CircleAvatar(
//                   radius: 50,
//                   backgroundImage: NetworkImage(
//                     'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y',
//                   ),
//                 ),
//               ),
//               SizedBox(height: 24),
//               TextFormField(
//                 controller: _firstNameController,
//                 decoration: InputDecoration(labelText: 'First Name'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your first name';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _lastNameController,
//                 decoration: InputDecoration(labelText: 'Last Name'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your last name';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _phoneController,
//                 decoration: InputDecoration(labelText: 'Phone Number'),
//                 keyboardType: TextInputType.phone,
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _bioController,
//                 decoration: InputDecoration(labelText: 'Bio'),
//                 maxLines: 3,
//               ),
//               SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: _updateProfile,
//                 child: Text('Update Profile'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'main.dart';

// class ProfilePage extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   final _firstNameController = TextEditingController();
//   final _lastNameController = TextEditingController();
//   final _emailController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _loadUserData();
//   }

//   Future<void> _loadUserData() async {
//     final user = supabase.auth.currentUser;
//     if (user != null) {
//       setState(() {
//         _firstNameController.text = user.userMetadata?['first_name'] ?? '';
//         _lastNameController.text = user.userMetadata?['last_name'] ?? '';
//         _emailController.text = user.email ?? '';
//       });
//     }
//   }

//   Future<void> _updateProfile() async {
//     try {
//       await supabase.auth.updateUser(
//         UserAttributes(
//           data: {
//             'first_name': _firstNameController.text,
//             'last_name': _lastNameController.text,
//           },
//         ),
//       );
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Profile updated successfully')),
//       );
//     } catch (error) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to update profile: ${error.toString()}')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             CircleAvatar(
//               radius: 50,
//               backgroundImage: NetworkImage(
//                 'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y',
//               ),
//             ),
//             SizedBox(height: 24),
//             TextField(
//               controller: _firstNameController,
//               decoration: InputDecoration(
//                 labelText: 'First Name',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 16),
//             TextField(
//               controller: _lastNameController,
//               decoration: InputDecoration(
//                 labelText: 'Last Name',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 16),
//             TextField(
//               controller: _emailController,
//               decoration: InputDecoration(
//                 labelText: 'Email',
//                 border: OutlineInputBorder(),
//               ),
//               readOnly: true,
//             ),
//             SizedBox(height: 24),
//             ElevatedButton(
//               onPressed: _updateProfile,
//               child: Text('Update Profile'),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () async {
//                 await supabase.auth.signOut();
//                 Navigator.of(context).pushReplacementNamed('/');
//               },
//               child: Text('Sign Out'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.red,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }






















import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'main.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    setState(() => _isLoading = true);
    final user = supabase.auth.currentUser;
    if (user != null) {
      _firstNameController.text = user.userMetadata?['first_name'] ?? '';
      _lastNameController.text = user.userMetadata?['last_name'] ?? '';
      _emailController.text = user.email ?? '';
    }
    setState(() => _isLoading = false);
  }

  Future<void> _updateProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      await supabase.auth.updateUser(
        UserAttributes(
          data: {
            'first_name': _firstNameController.text,
            'last_name': _lastNameController.text,
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile updated successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update profile: ${error.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
    setState(() => _isLoading = false);
  }

  Future<void> _signOut() async {
    setState(() => _isLoading = true);
    await supabase.auth.signOut();
    Navigator.of(context).pushReplacementNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        elevation: 0,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y',
                        ),
                      ),
                      SizedBox(height: 24),
                      TextFormField(
                        controller: _firstNameController,
                        decoration: InputDecoration(
                          labelText: 'First Name',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _lastNameController,
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your last name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                        readOnly: true,
                      ),
                      SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _isLoading ? null : _updateProfile,
                        child: Text('Update Profile'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _isLoading ? null : _signOut,
                        child: Text('Sign Out'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}