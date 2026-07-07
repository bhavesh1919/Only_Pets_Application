// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:only_pets/OrdersScreen/order_success_screen.dart';
// import 'package:only_pets/OrdersScreen/Orderscreen.dart';
// import 'package:only_pets/api/order_service.dart';

// class OrderStatusScreen extends StatefulWidget {
//   final String orderId;

//   const OrderStatusScreen({super.key, required this.orderId});

//   @override
//   State<OrderStatusScreen> createState() => _OrderStatusScreenState();
// }

// class _OrderStatusScreenState extends State<OrderStatusScreen> {
//   final OrderApi _api = OrderApi();

//   Timer? _timer;
//   String _status = 'pending';
//   bool _checking = false;
//   int _attempts = 0;
//   final int _maxAttempts = 60;

//   @override
//   void initState() {
//     super.initState();
//     _checkStatus();
//     _timer =
//         Timer.periodic(const Duration(seconds: 5), (_) => _checkStatus());
//   }

//   Future<void> _checkStatus() async {
//     if (_checking) return;

//     setState(() => _checking = true);

//     try {
//       _attempts++;

//       final status = await _api.getOrderStatus(widget.orderId);

//       setState(() => _status = status);

//       if (status == 'confirmed') {
//         _timer?.cancel();
//         if (!mounted) return;

//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (_) =>
//                 OrderSuccessScreen(orderId: widget.orderId),
//           ),
//         );
//       } else if (status == 'cancelled') {
//         _timer?.cancel();
//         if (!mounted) return;

//         await showDialog(
//           context: context,
//           builder: (_) => AlertDialog(
//             title: const Text('Order Cancelled'),
//             content: const Text(
//                 'Your order was cancelled by admin. Please contact support.'),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text('OK'),
//               ),
//             ],
//           ),
//         );

//         if (mounted) {
//           Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute(
//               builder: (_) => OrdersScreen(orderData: {}),
//             ),
//             (route) => false,
//           );
//         }
//       } else {
//         if (_attempts >= _maxAttempts) {
//           _timer?.cancel();
//           if (mounted) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text(
//                     'Still pending — please check your Orders later.'),
//               ),
//             );
//           }
//         }
//       }
//     } catch (_) {} finally {
//       if (mounted) setState(() => _checking = false);
//     }
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Order Status'),
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               if (_status == 'pending') ...[
//                 const CircularProgressIndicator(),
//                 const SizedBox(height: 16),
//                 const Text(
//                     'Your order is pending admin confirmation.'),
//                 const SizedBox(height: 8),
//                 const Text(
//                     'We will redirect you automatically when admin confirms.'),
//               ] else if (_status == 'confirmed') ...[
//                 const Icon(Icons.check_circle,
//                     size: 72, color: Colors.green),
//                 const SizedBox(height: 16),
//                 const Text('Order confirmed! Redirecting...'),
//               ] else if (_status == 'cancelled') ...[
//                 const Icon(Icons.cancel,
//                     size: 72, color: Colors.red),
//                 const SizedBox(height: 16),
//                 const Text('Order cancelled by admin.'),
//               ],
//               const SizedBox(height: 20),
//               if (_checking) const Text('Checking status...'),
//               const SizedBox(height: 30),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.pushAndRemoveUntil(
//                     context,
//                     MaterialPageRoute(
//                         builder: (_) => OrdersScreen(orderData: {})),
//                     (route) => false,
//                   );
//                 },
//                 child: const Text('Open Orders'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:only_pets/OrdersScreen/order_success_screen.dart';
import 'package:only_pets/OrdersScreen/Orderscreen.dart';
import 'package:only_pets/api/order_service.dart';
import 'package:only_pets/my_orders.dart';

class OrderStatusScreen extends StatefulWidget {
  final String orderId;

  const OrderStatusScreen({super.key, required this.orderId});

  @override
  State<OrderStatusScreen> createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> {
  final OrderApi _api = OrderApi();

  Timer? _timer;
  String _status = 'pending';
  bool _checking = false;
  int _attempts = 0;
  final int _maxAttempts = 60;

  @override
  void initState() {
    super.initState();
    _checkStatus();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) => _checkStatus());
  }

  Future<void> _checkStatus() async {
    if (_checking) return;

    setState(() => _checking = true);

    try {
      _attempts++;

      final status = await _api.getOrderStatus(widget.orderId);
      if (status.isEmpty) return;

      debugPrint("Order ${widget.orderId} status: $status"); // log status

      setState(() => _status = status.toLowerCase());

      if (_status == 'confirm' || _status == 'confirmed') {
        _timer?.cancel();
        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => OrderSuccessScreen(orderId: widget.orderId),
          ),
        );
      } else if (_status == 'cancel' || _status == 'cancelled') {
        _timer?.cancel();
        if (!mounted) return;

        await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Order Cancelled'),
            content: const Text(
                'Your order was cancelled by admin. Please contact support.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );

        if (mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => OrdersScreen(orderData: {}),
            ),
            (route) => false,
          );
        }
      } else {
        if (_attempts >= _maxAttempts) {
          _timer?.cancel();
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content:
                    Text('Still pending — please check your Orders later.'),
              ),
            );
          }
        }
      }
    } catch (e) {
      debugPrint("Error checking order status: $e");
    } finally {
      if (mounted) setState(() => _checking = false);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Status'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_status == 'pending') ...[
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                const Text(
                    'Your order is pending admin confirmation.'),
                const SizedBox(height: 8),
                const Text(
                    'We will redirect you automatically when admin confirms.'),
              ] else if (_status == 'confirm' || _status == 'confirmed') ...[
                const Icon(Icons.check_circle,
                    size: 72, color: Colors.green),
                const SizedBox(height: 16),
                const Text('Order confirmed! Redirecting...'),
              ] else if (_status == 'cancel' || _status == 'cancelled') ...[
                const Icon(Icons.cancel, size: 72, color: Colors.red),
                const SizedBox(height: 16),
                const Text('Order cancelled by admin.'),
              ],
              const SizedBox(height: 20),
              if (_checking) const Text('Checking status...'),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (_) => MyOrders(
          userId: "20", // 👈 pass logged-in user id
        )),
                    (route) => false,
                  );
                },
                child: const Text('Open Orders'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
