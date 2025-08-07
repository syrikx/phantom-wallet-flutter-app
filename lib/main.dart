import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:phantom_wallet_connector/phantom_wallet_connector.dart';
import 'package:capsule/capsule.dart';

void main() {
  runApp(const PhantomWalletApp());
}

class PhantomWalletApp extends StatelessWidget {
  const PhantomWalletApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phantom Wallet App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        useMaterial3: true,
      ),
      home: const WalletConnectionPage(),
    );
  }
}

class WalletConnectionPage extends StatefulWidget {
  const WalletConnectionPage({super.key});

  @override
  State<WalletConnectionPage> createState() => _WalletConnectionPageState();
}

class _WalletConnectionPageState extends State<WalletConnectionPage> {
  PhantomConnect? _phantomConnect;
  Capsule? _capsule;
  String? _walletAddress;
  bool _isConnecting = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initializeCapsule();
  }

  void _initializeCapsule() async {
    try {
      // Initialize Capsule with required parameters
      _capsule = Capsule(
        environment: Environment.sandbox, // or Environment.prod for production
        apiKey: 'demo-api-key', // In production, use proper API key
      );
      
      // Initialize PhantomConnect
      _phantomConnect = PhantomConnect(
        capsule: _capsule!,
        appUrl: 'https://phantom-wallet-app.example.com',
        deepLink: 'phantom-wallet-app',
      );
      
      setState(() {
        // Successfully initialized
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to initialize Capsule SDK: $e';
      });
    }
  }

  Future<void> _connectWallet() async {
    setState(() {
      _isConnecting = true;
      _error = null;
    });

    try {
      if (_phantomConnect == null) {
        throw Exception('Phantom connector not initialized. Please check your API key.');
      }
      
      // Attempt to connect to Phantom Wallet
      final address = await _phantomConnect!.connect();
      
      setState(() {
        _walletAddress = address;
        _isConnecting = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to connect to Phantom: $e';
        _isConnecting = false;
      });
    }
  }

  void _disconnectWallet() async {
    try {
      if (_phantomConnect != null) {
        await _phantomConnect!.disconnect();
      }
      setState(() {
        _walletAddress = null;
        _error = null;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to disconnect: $e';
      });
    }
  }
  
  Future<void> _launchPhantom() async {
    const url = 'https://phantom.app/';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phantom Wallet Connection'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.account_balance_wallet,
                size: 100,
                color: Colors.purple,
              ),
              const SizedBox(height: 32),
              const Text(
                'Phantom Wallet Connection',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              if (_walletAddress != null) ...[
                const Text(
                  'Connected to:',
                  style: TextStyle(fontSize: 16, color: Colors.green),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _walletAddress!,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'monospace',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _disconnectWallet,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Disconnect'),
                ),
              ] else ...[
                if (_error != null) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _error!,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
                ElevatedButton(
                  onPressed: _isConnecting ? null : _connectWallet,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                  ),
                  child: _isConnecting
                      ? const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 12),
                            Text('Connecting...'),
                          ],
                        )
                      : Text(_phantomConnect == null ? 'Initializing...' : 'Connect to Phantom Wallet'),
                ),
                if (_phantomConnect == null && _error == null)
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Setting up Capsule SDK...',
                      style: TextStyle(color: Colors.orange, fontSize: 12),
                    ),
                  ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _isConnecting ? null : _connectWallet,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  child: const Text('Test Connection'),
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: _launchPhantom,
                  child: const Text('Download Phantom Wallet'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}