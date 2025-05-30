import 'package:flutter/material.dart';
import 'package:agriconnect/screens/makeoderscreen.dart';
import 'package:agriconnect/utilities/constantscolors.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

String linki =
    'https://st.depositphotos.com/2258315/4277/i/950/depositphotos_42770869-stock-photo-harvesting-carrots.jpg';

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ConstantsColors().mainColor(),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(linki), fit: BoxFit.cover)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 30),
            child: Row(
              children: [
                Icon(
                  Icons.person,
                  color: ConstantsColors().mainColor(),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Muuzaji:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text('Juma Mgunda',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Divider(
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 30),
            child: Row(
              children: [
                Icon(
                  Icons.phone_in_talk_outlined,
                  color: ConstantsColors().mainColor(),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Simu:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text('+255 718934183',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Divider(
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 30),
            child: Row(
              children: [
                Icon(
                  Icons.person,
                  color: ConstantsColors().mainColor(),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Bei:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text('11000/Kg',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Divider(
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 30),
            child: Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: ConstantsColors().mainColor(),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Location:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text('Tanzania',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Divider(
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MakeOrderPage(
                          seleremail: '',
                          bei:'',
                          zao: '',
                          selerphone: '',
                        )));
              },
              child: Container(
                width: 130,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.cyan,
                    border: Border.all(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    'Weka Oda',
                    style: TextStyle(
                        fontSize: ConstantsColors().textSizeOne,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
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
