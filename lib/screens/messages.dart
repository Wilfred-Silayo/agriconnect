import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:agriconnect/services/gerneralservices.dart';
import 'package:agriconnect/utilities/constantscolors.dart';

class Messages extends StatefulWidget {
  final String reciver;
  final String pagefrom;
  const Messages({super.key, required this.reciver, required this.pagefrom});

  @override
  State<Messages> createState() => _MessagesState();
}

final supabase = Supabase.instance.client;
final currentUser = supabase.auth.currentUser;
final TextEditingController _messagebody = TextEditingController();

void clearText() {
  _messagebody.clear();
}

class _MessagesState extends State<Messages> {
  // Stream for all messages - will filter locally
  late final Stream<List<Map<String, dynamic>>> _messagesStream;

  @override
  void initState() {
    super.initState();
    _messagesStream = supabase
        .from('Messages')
        .stream(primaryKey: ['id'])
        .order('SentTime', ascending: true)
        .execute()
        .map((event) => (event as List).cast<Map<String, dynamic>>());
  }

  @override
  Widget build(BuildContext context) {
    if (currentUser == null) {
      return Center(child: Text('User not logged in'));
    }

    return Scaffold(
      backgroundColor: Colors.greenAccent[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ConstantsColors().mainColor(),
        title: Text('Sender Address'),
      ),
      body: Stack(
        children: [
          StreamBuilder<List<Map<String, dynamic>>>(
            stream: _messagesStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Something went wrong'));
              }
              if (!snapshot.hasData) {
                return Center(child: Text('Loading'));
              }

              // Filter messages depending on pagefrom and current user & reciver
              final allMessages = snapshot.data!;
              final filteredMessages = allMessages.where((data) {
                final sender = data['Sender'] ?? '';
                final buyer = data['Buyer'] ?? '';
                final farmer = data['Farmer'] ?? '';

                if (widget.pagefrom == 'BuyerPage') {
                  return farmer == widget.reciver && buyer == currentUser!.email;
                } else {
                  return buyer == widget.reciver && farmer == currentUser!.email;
                }
              }).toList();

              return ListView.builder(
                itemCount: filteredMessages.length,
                itemBuilder: (context, index) {
                  final data = filteredMessages[index];
                  final isSentByMe = data['Sender'] == currentUser!.email;

                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      child: isSentByMe
                          ? Padding(
                              padding: const EdgeInsets.only(left: 60, right: 10),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(width: 4, color: Colors.grey),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    data['body'] ?? '',
                                    style: TextStyle(color: Colors.black, fontSize: 16),
                                  ),
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(left: 10, right: 60),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 4,
                                    color: Color.fromARGB(188, 77, 161, 230),
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    data['body'] ?? '',
                                    style: TextStyle(color: Colors.black, fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                    ),
                  );
                },
              );
            },
          ),
          Positioned(
            bottom: 10,
            right: 5,
            left: 5,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width / 1.3,
                    decoration: BoxDecoration(
                      color: Colors.greenAccent[100],
                      border: Border.all(color: Colors.indigoAccent, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextField(
                        controller: _messagebody,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 25,
                  child: Center(
                    child: IconButton(
                      onPressed: () async {
                        final text = _messagebody.text.trim();
                        if (text.isEmpty) return;

                        // Insert new message row into Supabase 'Messages' table
                        try {
                          if (widget.pagefrom == 'BuyerPage') {
                            await supabase.from('Messages').insert({
                              'body': text,
                              'Sender': currentUser!.email,
                              'Buyer': currentUser!.email,
                              'Farmer': widget.reciver,
                              'SentTime': DateTime.now().toIso8601String(),
                            });
                          } else {
                            await supabase.from('Messages').insert({
                              'body': text,
                              'Sender': currentUser!.email,
                              'Buyer': widget.reciver,
                              'Farmer': currentUser!.email,
                              'SentTime': DateTime.now().toIso8601String(),
                            });
                          }
                          clearText();
                        } catch (e) {
                          print('Error sending message: $e');
                        }
                      },
                      icon: Icon(Icons.send, size: 30, color: Colors.indigoAccent),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
