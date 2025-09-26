import 'package:flutter/material.dart';
import '../models/xray_config.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});

  @override
  _ConfigScreenState createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  final _formKey = GlobalKey<FormState>();
  final XrayConfig _config = XrayConfig();

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
                onChanged: (value) => _config.title = value,
              ),

              SizedBox(height: 16),

              // Host field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Server Host',
                  hintText: '155.138.160.56',
                ),
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
              // UUID field
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'User UUID',
                  hintText: 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx',
                ),
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
              // Add the other two fields (port, uuid) here
            ],
          ),
        ),
      ),
    );
  }
}
