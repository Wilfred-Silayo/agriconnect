import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:agriconnect/providers/userdata.dart';
import 'package:agriconnect/screens/makeoderscreen.dart';
import 'package:agriconnect/utilities/constantscolors.dart';
import 'package:provider/provider.dart';

// Page for All Posted in the Market
class MarketPage extends StatefulWidget {
  const MarketPage({super.key});

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    final userRole = Provider.of<UserDetails>(context);

    // Subscribe to realtime stream of 'Posts' table
    final Stream<List<Map<String, dynamic>>> postsStream = supabase
        .from('Posts')
        .stream(primaryKey: ['id']) // Replace 'id' with your primary key column
        .order('created_at', ascending: false)
        .execute()
        .map((payload) => payload as List<Map<String, dynamic>>);

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: ConstantsColors().mainColor(),
        elevation: 0,
        title: Center(child: Text('Sokoni')),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: postsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }

          if (!snapshot.hasData) {
            return Center(child: Text('Loading'));
          }

          final posts = snapshot.data!;

          if (posts.isEmpty) {
            return Center(child: Text('No posts available'));
          }

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final data = posts[index];

              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Container(
                  height: MediaQuery.of(context).size.height / 2.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(data['image'] ?? ''),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Divider(),
                      ListTile(
                        title: Text(
                            '${data['Kipimo'] ?? ''}: ${data['Bei'] ?? ''} Tsh'),
                        subtitle: Text(
                            '${data['Kipimo'] ?? ''} zilizopo: ${data['Stock'] ?? ''}'),
                        trailing: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MakeOrderPage(
                                seleremail: data['Mkulima'] ?? '',
                                bei: data['Bei'] ?? '',
                                zao: data['Mazao'] ?? '',
                                selerphone: data['Simu'] ?? '',
                              ),
                            ));
                          },
                          child: Text('Oda'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
