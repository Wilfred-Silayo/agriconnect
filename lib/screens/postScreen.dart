// ignore_for_file: avoid_unnecessary_containers

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:agriconnect/utilities/constantscolors.dart';

// Initialize Supabase client somewhere globally in your app
final supabase = Supabase.instance.client;

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

final picker = ImagePicker();
File? _imageFile;

TextEditingController _bei = TextEditingController();
TextEditingController _kipimo = TextEditingController();
TextEditingController _stock = TextEditingController();
TextEditingController _simu = TextEditingController();

bool isLoading = false;
String? _mazao;

void disposeControllers() {
  _bei.clear();
  _kipimo.clear();
  _stock.clear();
  _simu.clear();
  _imageFile = null;
}

List<String> _items = [
  'Kilogram',
  'Debe',
  'Gunia',
];

List<String> _mazaoList = [
  'Mahindi',
  'Mchele',
  'Maharage',
  'Ufuta',
  'Mtama',
  'Kahawa',
  'Chai'
];

class _PostPageState extends State<PostPage> {
  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Uza Mazao yako'),
        elevation: 0,
        backgroundColor: ConstantsColors().mainColor(),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.green),
                borderRadius: BorderRadius.circular(10),
              ),
              child: _imageFile == null
                  ? IconButton(
                      onPressed: () async {
                        await _pickImage();
                      },
                      icon: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Gusa hapa kuweka picha,',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                                fontWeight: FontWeight.w600),
                          ),
                          Icon(
                            Icons.camera_alt_outlined,
                            size: 60,
                          ),
                        ],
                      ))
                  : Image.file(_imageFile!),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)),
              child: DropdownButton<String>(
                hint: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Chagua Zao'),
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                value: _mazao,
                onChanged: (value) {
                  setState(() {
                    _mazao = value;
                  });
                },
                items: _mazaoList.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 100, left: 10),
                      child: Text(
                        item,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bei',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueGrey),
                ),
                Container(
                  height: 40,
                  child: TextFormField(
                    controller: _bei,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder()),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)),
              child: DropdownButton<String>(
                hint: Text('Chagua Kipimo'),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                value: _selectedItem,
                onChanged: (value) {
                  setState(() {
                    _selectedItem = value;
                  });
                },
                items: _items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        item,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kiasi Kilichopo',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueGrey),
                  ),
                  Container(
                    height: 40,
                    child: TextFormField(
                      controller: _stock,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder()),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Simu No:',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueGrey),
                ),
                Container(
                  height: 40,
                  child: TextFormField(
                    controller: _simu,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        hintText: '0728 345 695',
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder()),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: InkWell(
              onTap: () async {
                if (_imageFile == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Tafadhali chagua picha")));
                  return;
                }
                if (_mazao == null || _selectedItem == null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Tafadhali chagua zao na kipimo")));
                  return;
                }

                setState(() {
                  isLoading = true;
                });

                try {
                  final user = supabase.auth.currentUser;
                  if (user == null) {
                    throw Exception('User not logged in');
                  }

                  // Upload image to Supabase Storage
                  final imageUrl =
                      await uploadImageToSupabase(_imageFile!, user.id);

                  // Insert data into "Usersss" table (you may want to rename it)
                  final response = await supabase.from('Usersss').insert({
                    'bei': _bei.text,
                    'kipimo': _selectedItem,
                    'user_email': user.email,
                    'stock': _stock.text,
                    'image_url': imageUrl,
                    'mazao': _mazao,
                    'simu': _simu.text,
                    'user_id': user.id,
                    'created_at': DateTime.now().toIso8601String(),
                  });

                  if (response.error != null) {
                    throw response.error!;
                  }

                  disposeControllers();

                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Umeuza mazao yako')));
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Kosa: $e')));
                }

                setState(() {
                  isLoading = false;
                });
              },
              child: Container(
                width: 130,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.cyan,
                    border: Border.all(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                    child: isLoading
                        ? CircularProgressIndicator()
                        : Text(
                            'Uza',
                            style: TextStyle(
                                fontSize: ConstantsColors().textSizeOne,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<String> uploadImageToSupabase(File file, String userId) async {
    final fileName = '${userId}_${DateTime.now().millisecondsSinceEpoch}.jpg';

    try {
      // Upload file to bucket "uploads"
      final res = await supabase.storage.from('uploads').upload(fileName, file);

      // On success, get the public URL
      final publicUrl = supabase.storage.from('uploads').getPublicUrl(fileName);

      return publicUrl;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }
}
