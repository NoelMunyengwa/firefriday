import 'package:firefriday/business_logic/events/create_event.dart';
import 'package:firefriday/constants/colors.dart';
import 'package:firefriday/constants/product_details.dart';
import 'package:firefriday/dashboard/pages/events/buySell.dart';
import 'package:flutter/material.dart';
import 'package:routerino/routerino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';

class BuyAndSellPage extends StatefulWidget {
  const BuyAndSellPage({super.key});

  @override
  State<BuyAndSellPage> createState() => _BuyAndSellPageState();
}

class _BuyAndSellPageState extends State<BuyAndSellPage> {
  var categories = [
    'Houses',
    'Cars',
    'Electronics',
    'Furniture',
    'Clothes',
    'Other'
  ];
  List<Map<String, dynamic>> buyAndSell = [];

  //Filter buy and sell items by category
  void filterBuyAndSell(String category) {
    List<Map<String, dynamic>> filteredBuyAndSell = [];
    buyAndSell.forEach((item) {
      if (item['category'] == category) {
        filteredBuyAndSell.add(item);
      }
    });
    setState(() {
      buyAndSell = filteredBuyAndSell;
    });
  }

  String prefEmail = '';

  //get email from shared prefs
  getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEmail().then((value) => setState(() {
          prefEmail = value!;
        }));
    getBuyAndSell().then((value) => setState(() {
          buyAndSell = value!;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: MySliverPersistentHeaderDelegate(
              // Your scrollable row content here
              child: Container(
                color: inputColor.withOpacity(0.1),
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    var selectedCategory = categories[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                        ),
                        onPressed: () {
                          // filterBuyAndSell(selectedCategory);
                        },
                        icon: const Icon(
                          UniconsLine.shopping_bag,
                          color: primaryColor,
                        ),
                        label: Text(selectedCategory),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                // Generate a random color for each container
                final color = Color((index * 0x11111111) % 0xFFFFFFFF);
                return ProductDetailsContainer(
                  imageUrl: buyAndSell[index]['image'],
                  name: buyAndSell[index]['name'],
                  location: buyAndSell[index]['location'],
                  description: buyAndSell[index]['details'],
                  price: buyAndSell[index]['price'],
                  phoneNumber: buyAndSell[index]['phone'],
                  email: buyAndSell[index]['owner'],
                  id: buyAndSell[index]['id'].toString(),
                );
              },
              childCount: buyAndSell
                  .length, // Replace with the actual number of containers you want to display
            ),
          ),
        ],
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 20.0, // Adjust for desired bottom spacing
            right: 5.0, // Adjust for desired right spacing
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
              ),
              onPressed: () {
                if (prefEmail.isNotEmpty) {
                  context.push(() => CreateSellPage());
                } else {}
              },
              icon: const Icon(UniconsLine.shopping_bag, color: primaryColor),
              label: const Text(
                'Sell/ rent Item',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // Positioned(
          //   bottom: 20.0, // Adjust for desired bottom spacing
          //   right: 5.0, // Adjust for desired right spacing
          //   child: ElevatedButton.icon(
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: Colors.transparent,
          //       shape: const StadiumBorder(),
          //     ),
          //     onPressed: () {
          //       context.push(() => CreateSellPage());
          //     },
          //     icon: const Icon(UniconsLine.edit_alt, color: primaryColor),
          //     label: const Text(
          //       'Manage Items',
          //       style:
          //           TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  MySliverPersistentHeaderDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 50; // Set the maximum height of the header

  @override
  double get minExtent => 50; // Set the minimum height of the header

  @override
  bool shouldRebuild(covariant MySliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
