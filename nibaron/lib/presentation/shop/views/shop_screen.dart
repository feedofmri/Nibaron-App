import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../config/theme/app_colors.dart';
import '../../common/widgets/custom_app_bar.dart';

class ShopScreen extends ConsumerStatefulWidget {
  const ShopScreen({super.key});

  @override
  ConsumerState<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends ConsumerState<ShopScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.shop,
        showBackButton: false,
      ),
      body: Column(
        children: [
          // Tab bar for order types
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: TabBar(
              controller: _tabController,
              labelColor: AppColors.lightPrimary,
              unselectedLabelColor: AppColors.lightTextSecondary,
              indicatorColor: AppColors.lightPrimary,
              tabs: [
                Tab(text: l10n.newOrders),
                Tab(text: l10n.acceptedOrders),
                Tab(text: l10n.completedOrders),
              ],
            ),
          ),
          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOrdersList('new', l10n),
                _buildOrdersList('accepted', l10n),
                _buildOrdersList('completed', l10n),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersList(String orderType, AppLocalizations l10n) {
    // Mock orders data - in real app this would come from a provider/API
    final orders = _getMockOrders(orderType);

    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              l10n.noOrdersYet,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.noOrdersDescription,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return _buildOrderCard(order, orderType, l10n);
      },
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order, String orderType, AppLocalizations l10n) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${l10n.buyerName}: ${order['buyerName']}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(orderType).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _getStatusText(orderType, l10n),
                    style: TextStyle(
                      color: _getStatusColor(orderType),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('${l10n.orderDate}: ${order['orderDate']}'),
            Text('${l10n.deliveryDate}: ${order['deliveryDate']}'),
            Text('${l10n.totalAmount}: ৳${order['totalAmount']}'),
            const SizedBox(height: 12),
            Text(
              'Items: ${order['items'].join(', ')}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            // Improved action buttons with better UI
            Column(
              children: [
                // Chat button - full width with enhanced styling
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => _openChat(order['buyerName']),
                    icon: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.lightPrimary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Icon(
                        Icons.chat_bubble_outline,
                        size: 18,
                        color: AppColors.lightPrimary,
                      ),
                    ),
                    label: Text(
                      l10n.chatWithBuyer,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.lightPrimary,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                      side: BorderSide(color: AppColors.lightPrimary, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Action button based on order status
                if (orderType == 'new') ...[
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _acceptOrder(order['id']),
                      icon: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(
                          Icons.check_circle_outline,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                      label: Text(
                        l10n.acceptOrder,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.lightPrimary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        elevation: 3,
                        shadowColor: AppColors.lightPrimary.withValues(alpha: 0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ] else if (orderType == 'accepted') ...[
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _markAsCompleted(order['id']),
                      icon: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(
                          Icons.task_alt,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                      label: Text(
                        l10n.markAsCompleted,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.lightPrimary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        elevation: 3,
                        shadowColor: AppColors.lightPrimary.withValues(alpha: 0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ] else if (orderType == 'completed') ...[
                  // Show completion info for completed orders
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: AppColors.success,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Order Completed Successfully',
                          style: TextStyle(
                            color: AppColors.success,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getMockOrders(String orderType) {
    // Mock data - in real app this would come from API/database
    switch (orderType) {
      case 'new':
        return [
          {
            'id': '1',
            'buyerName': 'Rahman Traders',
            'orderDate': '2025-10-01',
            'deliveryDate': '2025-10-05',
            'totalAmount': '15000',
            'items': ['Rice 50kg', 'Vegetables 20kg'],
          },
          {
            'id': '2',
            'buyerName': 'City Market',
            'orderDate': '2025-10-02',
            'deliveryDate': '2025-10-06',
            'totalAmount': '8500',
            'items': ['Tomatoes 15kg', 'Potatoes 25kg'],
          },
        ];
      case 'accepted':
        return [
          {
            'id': '3',
            'buyerName': 'Fresh Mart',
            'orderDate': '2025-09-28',
            'deliveryDate': '2025-10-03',
            'totalAmount': '12000',
            'items': ['Corn 30kg', 'Cabbage 10kg'],
          },
        ];
      case 'completed':
        return [
          {
            'id': '4',
            'buyerName': 'Green Grocers',
            'orderDate': '2025-09-25',
            'deliveryDate': '2025-09-30',
            'totalAmount': '20000',
            'items': ['Mixed Vegetables 50kg'],
          },
        ];
      default:
        return [];
    }
  }

  Color _getStatusColor(String orderType) {
    switch (orderType) {
      case 'new':
        return Colors.orange;
      case 'accepted':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String orderType, AppLocalizations l10n) {
    switch (orderType) {
      case 'new':
        return 'New';
      case 'accepted':
        return 'In Progress';
      case 'completed':
        return 'Completed';
      default:
        return 'Unknown';
    }
  }

  void _acceptOrder(String orderId) {
    // Implement order acceptance logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Order $orderId accepted successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _markAsCompleted(String orderId) {
    // Implement mark as completed logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Order $orderId marked as completed!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _openChat(String buyerName) {
    // Navigate to chat screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(buyerName: buyerName),
      ),
    );
  }
}

// Simple chat screen for buyer communication
class ChatScreen extends StatefulWidget {
  final String buyerName;

  const ChatScreen({super.key, required this.buyerName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];

  @override
  void initState() {
    super.initState();
    // Add some mock messages
    _messages.addAll([
      {
        'text': 'Hello! I have a question about the order.',
        'isFromBuyer': true,
        'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
      },
      {
        'text': 'Hi! Sure, what would you like to know?',
        'isFromBuyer': false,
        'timestamp': DateTime.now().subtract(const Duration(hours: 1)),
      },
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text('${l10n.chatWithBuyer} - ${widget.buyerName}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessage(message);
              },
            ),
          ),
          _buildMessageInput(l10n),
        ],
      ),
    );
  }

  Widget _buildMessage(Map<String, dynamic> message) {
    final isFromBuyer = message['isFromBuyer'] as bool;
    return Align(
      alignment: isFromBuyer ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        decoration: BoxDecoration(
          color: isFromBuyer ? Colors.grey[200] : AppColors.primary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          message['text'] as String,
          style: TextStyle(
            color: isFromBuyer ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildMessageInput(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: _sendMessage,
            icon: const Icon(Icons.send),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add({
          'text': _messageController.text,
          'isFromBuyer': false,
          'timestamp': DateTime.now(),
        });
      });
      _messageController.clear();
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
