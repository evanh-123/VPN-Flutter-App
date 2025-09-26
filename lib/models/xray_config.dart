class XrayConfig {
  String title;
  String host;
  String port;
  String uuid;
  String publicKey;
  String shortId;
  String peer;
  bool tls;
  String type;

  XrayConfig({
    this.title = '',
    this.host = '',
    this.port = '443',
    this.uuid = '',
    this.publicKey = '',
    this.shortId = '',
    this.peer = 'www.microsoft.com',
    this.tls = true,
    this.type = 'VLESS',
  });

  // Convert to/from JSON for storage
  Map<String, dynamic> toJson() => {
    'title': title,
    'host': host,
    'port': port,
    'uuid': uuid,
    'publicKey': publicKey,
    'shortId': shortId,
    'peer': peer,
    'tls': tls,
    'type': type,
  };

  factory XrayConfig.fromJson(Map<String, dynamic> json) => XrayConfig(
    title: json['title'] ?? '',
    host: json['host'] ?? '',
    port: json['port'] ?? '443',
    uuid: json['uuid'] ?? '',
    publicKey: json['publicKey'] ?? '',
    shortId: json['shortId'] ?? '',
    peer: json['peer'] ?? 'www.microsoft.com',
    tls: json['tls'] ?? true,
    type: json['type'] ?? 'VLESS',
  );
}
