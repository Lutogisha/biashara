import 'package:flutter/material.dart';

class CartItem {
  final String name;
  final double price;
  int qty;
  CartItem(this.name, this.price, this.qty);
}

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final items = <CartItem>[
    CartItem('Headphones', 19.99, 1),
    CartItem('Keyboard', 29.99, 2),
  ];

  double get total => items.fold(0, (s, i) => s + i.price * i.qty);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (_, i) {
                final it = items[i];
                return Card(
                  child: ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.shopping_bag)),
                    title: Text(it.name),
                    subtitle: Text('\$${it.price.toStringAsFixed(2)}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () => setState(() { if (it.qty > 1) it.qty--; }),
                        ),
                        Text('${it.qty}'),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: () => setState(() { it.qty++; }),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Text('Total: \$${total.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.titleLarge),
                  ),
                  FilledButton(onPressed: () {}, child: const Text('Checkout')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
