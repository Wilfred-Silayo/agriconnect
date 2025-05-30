// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:agriconnect/screens/messages.dart';
import 'package:agriconnect/services/gerneralservices.dart';
import 'package:agriconnect/utilities/constantscolors.dart';

class SelerOrders extends StatefulWidget {
  const SelerOrders({super.key});

  @override
  State<SelerOrders> createState() => _SelerOrdersState();
}

class _SelerOrdersState extends State<SelerOrders> {
final supabase = Supabase.instance.client;
late final String? userEmail;

Stream<List<Map<String, dynamic>>> getOrdersStream() {
  if (userEmail == null) {
    // Return an empty stream or handle null case accordingly
    return Stream.value([]);
  }

  final stream = supabase
      .from('OrderPres')
      .stream(primaryKey: ['id'])
      .eq('Farmer', userEmail!)
      .order('created_at', ascending: false);

  return stream;
}


  @override
  void initState() {
    super.initState();
    userEmail = supabase.auth.currentUser?.email;
  }

  @override
  Widget build(BuildContext context) {
    if (userEmail == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ConstantsColors().mainColor(),
          title: Text('Orders'),
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: Center(child: Text('User not logged in')),
      );
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 230, 224, 224),
      appBar: AppBar(
        backgroundColor: ConstantsColors().mainColor(),
        title: Text('Orders'),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: getOrdersStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final orders = snapshot.data!;

          if (orders.isEmpty) {
            return Center(child: Text('No orders found.'));
          }

          return ListView(
            children: orders.map((data) {
              return InkWell(
                onTap: () {
                  // Add onTap functionality if needed
                },
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Column(
                    children: [
                      ListTile(
                        minVerticalPadding: 5.0,
                        title: Text(data['Buyer'] ?? ''),
                        subtitle: Row(
                          children: [
                            Text('Bei'),
                            SizedBox(width: 10),
                            Text(data['ofa']?.toString() ?? ''),
                          ],
                        ),
                        trailing: Container(
                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(
                            color: data['Status'] == 'Pending'
                                ? Colors.blueGrey
                                : Colors.green,
                            border: Border.all(width: 2, color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              data['Status'] ?? '',
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 10),
                        child: Row(
                          children: [
                            Text(
                              'Kiasi Kinachohitajika ::',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              data['Kiasi']?.toString() ?? '',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Colors.black26),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: 70,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.cyan,
                                border: Border.all(width: 2, color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  GeneralServices().makingPhoneCall('07456789');
                                },
                                icon: Icon(
                                  Icons.phone_enabled,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: 70,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                border: Border.all(width: 2, color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Messages(
                                      reciver: data['Buyer'] ?? '',
                                      pagefrom: 'Farmer',
                                    ),
                                  ));
                                },
                                icon: Icon(
                                  Icons.sms,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: InkWell(
                              onTap: () {
                                GeneralServices().updateOrder(data['id']);
                                GeneralServices()
                                    .getPostDetails(data['Farmer'], data['Kiasi']);
                              },
                              child: Container(
                                width: 70,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  border: Border.all(width: 2, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    'Pokea',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: InkWell(
                              onTap: () {
                                GeneralServices().rejectOrder(data['id']);
                              },
                              child: Container(
                                width: 60,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  border: Border.all(width: 2, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    'Kataa',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
