import 'package:flutter/material.dart';
import '../models/xray_config.dart';
import '../services/config_service.dart';
import '../services/vpn_service.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});

  @override
  ConfigScreenState createState() => ConfigScreenState();

}

class ConfigScreenState extends State<ConfigScreen> {
  final _formKey = GlobalKey<FormState>();
  final XrayConfig _config = XrayConfig();
  final ConfigService _configService = ConfigService();
  final VpnService _vpnService = VpnService();
  final _titleController = TextEditingController();
  final _hostController = TextEditingController();
  final _portController = TextEditingController();
  final _uuidController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _loadConfig();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _hostController.dispose();
    _portController.dispose();
    _uuidController.dispose();
    super.dispose();
  }
  
  Future<void> _saveConfig() async {
    if(_formKey.currentState!.validate()) {
      bool success = await _configService.saveConfig(_config);

    if(!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Configuration Saved')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to Save Configuration')),
        );
      }
    }
  }

  Future<void> _loadConfig() async {
    XrayConfig? loadedConfig = await _configService.loadConfig();
    if (loadedConfig != null) {
      setState(() {
        _titleController.text = loadedConfig.title;
        _hostController.text = loadedConfig.host;
        _portController.text = loadedConfig.port;
        _uuidController.text = loadedConfig.uuid;
      });
    }
  }

  Future<void> _testConnection() async {
    String result = await _vpnService.ping();
    if(!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Result: $result')),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('VPN Configuration')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Title field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Configuration Name',
                  hintText: 'My VPN Config',
                ),
                controller: _titleController,
                onChanged: (value) => _config.title = value,
              ),
              SizedBox(height: 16),
              // Host field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Server Host',
                  hintText: '155.138.160.56',
                ),
                controller: _hostController,
                onChanged: (value) => _config.host = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter server host';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Port field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Server Port',
                  hintText: '443',
                ),
                keyboardType: TextInputType.number,
                controller: _portController,
                onChanged: (value) =>
                    _config.port = int.tryParse(value)?.toString() ?? '443',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter server port';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              // UUID field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'User UUID',
                  hintText: 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx',
                ),
                controller: _uuidController,
                onChanged: (value) => _config.uuid = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter user UUID';
                  }
                  // Simple UUID format check
                  final uuidRegex = RegExp(
                    r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
                  );
                  if (!uuidRegex.hasMatch(value)) {
                    return 'Please enter a valid UUID';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32),
              // save config
              ElevatedButton(
                onPressed: _saveConfig,
                child: Text('Save Configuration'),
              ),
              SizedBox(height: 16),
              // test connection
              ElevatedButton(
                onPressed: _testConnection
                , child: Text('Test Connection')
              )
            ],
          ),
        ),
      ),
    );
  }
}





