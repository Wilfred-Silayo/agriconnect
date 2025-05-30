import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:agriconnect/screens/messages.dart';
import 'package:agriconnect/services/gerneralservices.dart';
import 'package:agriconnect/utilities/constantscolors.dart';

class BuyerOrders extends StatefulWidget {
  const BuyerOrders({super.key});

  @override
  State<BuyerOrders> createState() => _BuyerOrdersState();
}

class _BuyerOrdersState extends State<BuyerOrders> {
  // Get the currently authenticated user
  final user = Supabase.instance.client.auth.currentUser;

  // Define the stream of orders for the current user
  Stream<List<Map<String, dynamic>>> getOrdersStream() {
    final email = user?.email;
    if (email == null) {
      // If email is null, return an empty stream
      return const Stream.empty();
    }

    return Supabase.instance.client
        .from('OrderPres')
        .stream(primaryKey: ['id'])
        .eq('Buyer', email)
        .order('created_at', ascending: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstantsColors().mainColor(),
        title: const Text('Orders'),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: getOrdersStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return const Text('Something went wrong');
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final orders = snapshot.data!;
          if (orders.isEmpty) {
            return const Center(child: Text("Hakuna Oda kwa sasa."));
          }

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final data = orders[index];

              return Card(
                child: Column(
                  children: [
                    ListTile(
                      minVerticalPadding: 5.0,
                      title: Text(data['Buyer'] ?? ''),
                      subtitle: Row(
                        children: [
                          const Text('Bei'),
                          const SizedBox(width: 10),
                          Text(data['ofa'] ?? '')
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
                            style: const TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          const Text(
                            'Kiasi Ninachohitaji ::',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            data['Kiasi'].toString(),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    const Divider(color: Colors.black26),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildIconButton(
                          color: Colors.cyan,
                          icon: Icons.phone_enabled,
                          onPressed: () {
                            GeneralServices().makingPhoneCall(data['SellerPhone']);
                          },
                        ),
                        buildIconButton(
                          color: Colors.blueGrey,
                          icon: Icons.sms,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Messages(
                                reciver: data['Farmer'],
                                pagefrom: 'BuyerPage',
                              ),
                            ));
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: InkWell(
                            onTap: () async {
                              await Supabase.instance.client
                                  .from('OrderPres')
                                  .delete()
                                  .eq('id', data['id']);
                            },
                            child: Container(
                              width: 60,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                border: Border.all(width: 2, color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text(
                                  'Futa',
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
              );
            },
          );
        },
      ),
    );
  }

  Widget buildIconButton({
    required Color color,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: 70,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(width: 2, color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }
}
