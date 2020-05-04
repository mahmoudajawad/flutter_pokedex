class Registry {
  Registry();

  Map<String, dynamic> _services = {};

  factory Registry.fromMap(Map<String, dynamic> services) {
    Registry registry = Registry();
    for (var service in services.keys) {
      registry.registerService(service, services[service]);
    }
    return registry;
  }

  void registerService(String name, dynamic service) {
    _services[name] = service;
  }

  dynamic getService(String name) {
    return _services[name];
  }
}