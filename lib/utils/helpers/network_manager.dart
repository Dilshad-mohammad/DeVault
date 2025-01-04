import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../popups/loaders.dart';

/// Manages the network connectivity status and provides methods to check and handle connectivity changes.
class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final Rx<ConnectivityResult> _connectionStatus = ConnectivityResult.none.obs;

  /// Initialize the network manager and set up a stream to check the connection status.
  @override
  void onInit() {
    super.onInit();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
  }

  /// Track whether the connection status has been checked at least once
  bool _hasCheckedConnection = false;

  /// Update the connection status based on changes in connectivity and show a relevant popup.
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus.value = result;

    if (!_hasCheckedConnection) {
      // Skip showing the "Internet Connection Restored" snackbar on the first check
      _hasCheckedConnection = true;
      return;
    }

    if (result == ConnectivityResult.none) {
      DLoaders.warningSnackBar(title: 'No Internet Connection');
    } else {
      DLoaders.successSnackBar(title: 'Internet Connection Restored');
    }
  }

  /// Check the Internet connection status.
  /// Return 'true' if connected, 'false' otherwise.
  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      return result != ConnectivityResult.none;
    } on PlatformException catch (_) {
      return false;
    }
  }

  /// Dispose or close the active connectivity stream.
  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }
}
