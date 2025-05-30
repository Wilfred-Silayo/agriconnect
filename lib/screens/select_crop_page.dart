// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:agriconnect/utilities/constantscolors.dart';
import 'package:agriconnect/screens/farmerhome.dart';

class SelecteCropPage extends StatefulWidget {
  const SelecteCropPage({super.key});

  @override
  State<SelecteCropPage> createState() => _SelecteCropPageState();
}

class _SelecteCropPageState extends State<SelecteCropPage> {
  final supabase = Supabase.instance.client;

  // To track selected crops, you can adjust this to multi-select if needed
  String? _selectedCrop;

  bool isLoading = false;
  String? errorMessage;

  // List of crops you display
  final List<Map<String, dynamic>> crops = [
    {
      'label': 'Mahindi',
      'imageUrl': 'assets/maize.png',
      'color': Color.fromARGB(174, 255, 214, 64),
    },
    {
      'label': 'Maharage',
      'imageUrl': 'assets/beans.png',
      'color': Color.fromARGB(153, 245, 92, 81),
    },
    {
      'label': 'Tikiti Maji',
      'imageUrl': 'assets/watermelon.png',
      'color': Color.fromARGB(153, 245, 92, 81),
    },
    {
      'label': 'Mpunga',
      'imageUrl': 'assets/rice.png',
      'color': Color.fromARGB(153, 220, 245, 81),
    },
  ];

  Future<void> saveSelectedCrop() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final user = supabase.auth.currentUser;
    if (user == null) {
      setState(() {
        errorMessage = "User not logged in.";
        isLoading = false;
      });
      return;
    }

    if (_selectedCrop == null) {
      setState(() {
        errorMessage = "Tafadhali chagua mazao kwanza.";
        isLoading = false;
      });
      return;
    }

    try {
      // Update user profile with selected crop - adjust table/column as needed
      final updates = {
        'email': user.email,
        'selected_crop': _selectedCrop,
      };

      final response = await supabase
          .from('Users')
          .upsert(updates, onConflict: 'email');

      if (response.error != null) {
        setState(() {
          errorMessage = response.error!.message;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        // Navigate to farmer home page after successful save
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => FarmerPage()));
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ConstantsColors().mainColor(),
          title: const Text('Chagua Mazao'),
        ),
        body: ListView(
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Center(
                child: Text(
                  'Tafadhali chagua Mazao unayojihusishanayo',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
                child: GridView.count(
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 2,
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  children: crops.map((crop) {
                    final isSelected = _selectedCrop == crop['label'];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCrop = crop['label'];
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.blueAccent : crop['color'],
                          borderRadius: BorderRadius.circular(10),
                          border: isSelected
                              ? Border.all(color: Colors.blue, width: 3)
                              : null,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              crop['imageUrl'],
                              height: 40,
                              width: 40,
                            ),
                            SizedBox(width: 10),
                            Text(
                              crop['label'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? Colors.white : Colors.black),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            if (errorMessage != null)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  errorMessage!,
                  style: TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: isLoading ? null : saveSelectedCrop,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  minimumSize: Size(double.infinity, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: isLoading
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : Text(
                        'Endelea',
                        style: TextStyle(
                          fontSize: ConstantsColors().textSizeOne,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
