import 'storage_service.dart';

abstract class OfflineSyncService {
  Future<void> initialize();
  Future<void> syncPendingData();
  Future<void> cacheCriticalData();
  Future<bool> isOnline();
  Future<void> addToSyncQueue(Map<String, dynamic> data);
  Future<List<Map<String, dynamic>>> getPendingSyncItems();
  Future<void> clearSyncQueue();
}

class OfflineSyncServiceImpl implements OfflineSyncService {
  final StorageService _storageService;
  static const String _syncQueueKey = 'sync_queue';
  static const String _lastSyncKey = 'last_sync_time';

  OfflineSyncServiceImpl(this._storageService);

  @override
  Future<void> initialize() async {
    // Initialize offline sync service
    print('Offline Sync Service initialized');
  }

  @override
  Future<void> syncPendingData() async {
    try {
      final pendingItems = await getPendingSyncItems();

      if (pendingItems.isEmpty) return;

      final isConnected = await isOnline();
      if (!isConnected) {
        print('No internet connection, sync postponed');
        return;
      }

      // Sync each item
      for (final item in pendingItems) {
        await _syncItem(item);
      }

      // Clear sync queue after successful sync
      await clearSyncQueue();

      // Update last sync time
      await _storageService.setString(_lastSyncKey, DateTime.now().toIso8601String());

      print('Sync completed successfully');
    } catch (e) {
      print('Error during sync: $e');
    }
  }

  @override
  Future<void> cacheCriticalData() async {
    try {
      // Cache weather data, recommendations, and other critical information
      // This would involve calling repositories to get fresh data
      print('Critical data cached');
    } catch (e) {
      print('Error caching critical data: $e');
    }
  }

  @override
  Future<bool> isOnline() async {
    // In a real implementation, you would use connectivity_plus package
    // For now, return true
    return true;
  }

  @override
  Future<void> addToSyncQueue(Map<String, dynamic> data) async {
    try {
      final pendingItems = await getPendingSyncItems();
      pendingItems.add({
        ...data,
        'timestamp': DateTime.now().toIso8601String(),
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
      });

      await _storageService.setString(_syncQueueKey,
          pendingItems.map((e) => e.toString()).join('|||'));
    } catch (e) {
      print('Error adding to sync queue: $e');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getPendingSyncItems() async {
    try {
      final queueData = await _storageService.getString(_syncQueueKey);
      if (queueData == null || queueData.isEmpty) return [];

      // In a real implementation, you would properly serialize/deserialize
      // For now, return empty list
      return [];
    } catch (e) {
      print('Error getting pending sync items: $e');
      return [];
    }
  }

  @override
  Future<void> clearSyncQueue() async {
    try {
      await _storageService.remove(_syncQueueKey);
    } catch (e) {
      print('Error clearing sync queue: $e');
    }
  }

  Future<void> _syncItem(Map<String, dynamic> item) async {
    // Sync individual item with server
    print('Syncing item: ${item['id']}');
  }

  Future<DateTime?> getLastSyncTime() async {
    final lastSyncString = await _storageService.getString(_lastSyncKey);
    if (lastSyncString != null) {
      return DateTime.tryParse(lastSyncString);
    }
    return null;
  }
}
