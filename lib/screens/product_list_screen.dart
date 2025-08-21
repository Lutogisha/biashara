import 'package:flutter/material.dart';

class Product {
  final String name;
  final double price;
  final String imageUrl;
  final String description;
  const Product({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
  });
}

const demoProducts = <Product>[
  Product(
    name: 'Headphones',
    price: 19.99,
    imageUrl: 'lib/images/headphone.PNG',
    description: 'Comfortable on-ear headphones for daily use.',
  ),
  Product(
    name: 'Keyboard',
    price: 29.99,
    imageUrl: 'lib/images/keyboard.PNG',
    description: 'Compact keyboard with smooth keys.',
  ),
  Product(
    name: 'Mouse',
    price: 14.99,
    imageUrl: 'lib/images/mouse.PNG',
    description: 'Wireless mouse with silent clicks.',
  ),
  Product(
    name: 'USB Hub',
    price: 12.49,
    imageUrl: 'lib/images/usb.PNG',
    description: '4-port USB 3.0 hub for expansion.',
  ),
  Product(
    name: 'Webcam',
    price: 39.99,
    imageUrl: 'lib/images/webcam.PNG',
    description: '1080p webcam for meetings and streaming.',
  ),
  Product(
    name: 'Speaker',
    price: 24.99,
    imageUrl: 'lib/images/speaker.PNG',
    description: 'Portable Bluetooth speaker with great sound.',
  ),
];

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: .74,
        ),
        itemCount: demoProducts.length,
        itemBuilder: (_, i) {
          final p = demoProducts[i];
          return Card(
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () => Navigator.pushNamed(context, '/product-detail', arguments: p),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Image.asset(p.imageUrl, fit: BoxFit.cover),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(p.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text('\$${p.price.toStringAsFixed(2)}'),
                        const SizedBox(height: 6),
                        FilledButton(
                          onPressed: () => ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text('${p.name} added to cart'))),
                          child: const Text('Add to Cart'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
