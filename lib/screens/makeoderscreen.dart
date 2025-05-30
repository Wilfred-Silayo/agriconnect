import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:agriconnect/providers/userdata.dart';
import 'package:agriconnect/services/gerneralservices.dart';
import 'package:agriconnect/utilities/constantscolors.dart';
import 'package:agriconnect/widgets/displayedcrop.dart';
import 'package:provider/provider.dart';

// Page to view Selected Product from the Market place

class MakeOrderPage extends StatefulWidget {
  final String selerphone;
  final String bei;
  final String zao;
  final String seleremail;

  MakeOrderPage({
    super.key,
    required this.seleremail,
    required this.bei,
    required this.zao,
    required this.selerphone,
  });

  @override
  State<MakeOrderPage> createState() => _MakeOrderPageState();
}

TextEditingController _offer = TextEditingController();
TextEditingController _details = TextEditingController();

class _MakeOrderPageState extends State<MakeOrderPage> {
  bool isLoading = false;
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    final _selectedbidhaa = Provider.of<UserDetails>(context);

    // Get current user session from Supabase
    final user = supabase.auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstantsColors().mainColor(),
        elevation: 0,
      ),
      body: ListView(
        children: [
          DisplayedCrop(
            farmeremail: widget.seleremail,
            bei: widget.bei,
            zao: widget.zao,
            phone: widget.selerphone,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ofa Yangu',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.blueGrey,
                  ),
                ),
                const Divider(),
                TextFormField(
                  controller: _offer,
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Kiasi Unachohitaji',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.blueGrey,
                  ),
                ),
                const Divider(),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _details,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: InkWell(
              onTap: () async {
                if (user == null) {
                  // handle unauthenticated user case here
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Tafadhali ingia kwanza')),
                  );
                  return;
                }

                setState(() {
                  isLoading = true;
                });

                // Insert order into Supabase
                final response = await supabase.from('orders').insert({
                  'offer': _offer.text,
                  'details': _details.text,
                  'seller_email': widget.seleremail,
                  'buyer_email': user.email,
                  'seller_phone': widget.selerphone,
                  'created_at': DateTime.now().toIso8601String(),
                });

                if (response.error != null) {
                  // handle error
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'Tatizo la kuwekea oda: ${response.error!.message}')),
                  );
                } else {
                  // Success message or navigation
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Oda imetumwa kwa mafanikio')),
                  );
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
                      ? const CircularProgressIndicator()
                      : Text(
                          'Weka Oda',
                          style: TextStyle(
                            fontSize: ConstantsColors().textSizeOne,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
