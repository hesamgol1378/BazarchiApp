
import 'package:flutter/material.dart';

void main() => runApp(BazarchiApp());

class BazarchiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'بازارچی',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Vazir',
      ),
      home: WelcomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'به بازارچی خوش آمدید!',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'محل فروش حرفه‌ای محصولات شما در ایران',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SellerDashboard(),
                  ),
                );
              },
              child: Text('ورود به عنوان فروشنده'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShopPage(),
                  ),
                );
              },
              child: Text('ورود به عنوان خریدار'),
            ),
          ],
        ),
      ),
    );
  }
}

class SellerDashboard extends StatefulWidget {
  @override
  _SellerDashboardState createState() => _SellerDashboardState();
}

class _SellerDashboardState extends State<SellerDashboard> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  static List<Map<String, String>> products = [];

  void addProduct() {
    final name = nameController.text;
    final price = priceController.text;

    if (name.isNotEmpty && price.isNotEmpty) {
      setState(() {
        products.add({'name': name, 'price': price});
        nameController.clear();
        priceController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('داشبورد فروشنده')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'نام محصول'),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'قیمت (تومان)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: addProduct,
              child: Text('افزودن محصول'),
            ),
            SizedBox(height: 20),
            Text('محصولات افزوده شده:', style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final p = products[index];
                  return ListTile(
                    title: Text(p['name'] ?? ''),
                    subtitle: Text('${p['price']} تومان'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products = _SellerDashboardState.products;

    return Scaffold(
      appBar: AppBar(title: Text('فروشگاه')),
      body: products.isEmpty
          ? Center(child: Text('محصولی برای نمایش وجود ندارد.'))
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final p = products[index];
                return ListTile(
                  leading: Icon(Icons.shopping_bag),
                  title: Text(p['name'] ?? ''),
                  subtitle: Text('${p['price']} تومان'),
                );
              },
            ),
    );
  }
}
