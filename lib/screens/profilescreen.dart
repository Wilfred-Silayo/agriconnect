import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:agriconnect/screens/authscreens/autfunctions.dart';
import 'package:agriconnect/screens/authscreens/loginpage.dart';
import 'package:agriconnect/utilities/constantscolors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final supabase = Supabase.instance.client;
  User? currentUser;
  Map<String, dynamic>? userData;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    currentUser = supabase.auth.currentUser;
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    if (currentUser == null) {
      setState(() {
        errorMessage = "User not logged in";
        isLoading = false;
      });
      return;
    }

  try {
    final data = await supabase
        .from('Users')
        .select()
        .eq('email', currentUser!.email!)
        .single();

    setState(() {
      userData = data;
      isLoading = false;
    });
  } catch (e) {
    setState(() {
      errorMessage = e.toString();
      isLoading = false;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ConstantsColors().mainColor(),
        title: const Text("Profile"),
        automaticallyImplyLeading: false,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : userData == null
                  ? const Center(child: Text("User data not found"))
                  : ListView(
                      children: [
                        const SizedBox(height: 20),
                        CircleAvatar(
                          radius: 60,
                          child: Icon(
                            Icons.person,
                            size: 60,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                            child: Text(
                          userData!['name'] ?? 'No Name',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        )),
                        Center(
                            child: Text(
                          userData!['email'] ?? 'No Email',
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        )),
                        const Divider(
                          color: Colors.black,
                        ),
                        ListTile(
                          leading: const Icon(Icons.home),
                          title: const Text('Nyumbani'),
                          onTap: () => {},
                        ),
                        ListTile(
                          leading: const Icon(Icons.verified_user),
                          title: const Text('Profile'),
                          onTap: () => {Navigator.of(context).pop()},
                        ),
                        ListTile(
                          leading: const Icon(Icons.settings),
                          title: const Text('Mazao Yangu'),
                          onTap: () => {Navigator.of(context).pop()},
                        ),
                        ListTile(
                          leading: const Icon(Icons.border_color),
                          title: const Text('Oder Zangu'),
                          onTap: () => {Navigator.of(context).pop()},
                        ),
                        ListTile(
                          leading: const Icon(Icons.location_on),
                          title: const Text('Makazi'),
                          onTap: () => {Navigator.of(context).pop()},
                        ),
                        ListTile(
                          leading: const Icon(Icons.exit_to_app),
                          title: const Text('Logout'),
                          onTap: () async {
                            await supabase.auth.signOut();
                            AuthFunction().logOut();
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
    );
  }
}
