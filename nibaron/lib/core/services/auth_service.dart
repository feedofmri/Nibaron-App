import 'storage_service.dart';

abstract class AuthService {
  Future<bool> isLoggedIn();
  Future<String?> getUserToken();
  Future<String?> getUserId();
  Future<void> login(String token, String userId);
  Future<void> logout();
  Future<bool> isTokenValid();
  Future<void> refreshToken();
}

class AuthServiceImpl implements AuthService {
  final StorageService _storageService;

  AuthServiceImpl(this._storageService);

  @override
  Future<bool> isLoggedIn() async {
    final token = await getUserToken();
    final isLoggedIn = await _storageService.getBool('is_logged_in') ?? false;
    return token != null && token.isNotEmpty && isLoggedIn;
  }

  @override
  Future<String?> getUserToken() async {
    return await _storageService.getString('user_token');
  }

  @override
  Future<String?> getUserId() async {
    return await _storageService.getString('user_id');
  }

  @override
  Future<void> login(String token, String userId) async {
    await _storageService.setString('user_token', token);
    await _storageService.setString('user_id', userId);
    await _storageService.setBool('is_logged_in', true);
  }

  @override
  Future<void> logout() async {
    await _storageService.remove('user_token');
    await _storageService.remove('user_id');
    await _storageService.setBool('is_logged_in', false);
  }

  @override
  Future<bool> isTokenValid() async {
    final token = await getUserToken();
    if (token == null || token.isEmpty) return false;

    // In a real app, you would validate the token with the server
    // For now, we'll just check if it exists
    return true;
  }

  @override
  Future<void> refreshToken() async {
    // In a real app, you would call the refresh token endpoint
    // and update the stored token
    print('Token refresh not implemented yet');
  }
}
