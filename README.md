# Vagrant Development Environment for Drupal

## Configuration
The default configuration can be found in /config/config.default.yml. 
You can override any parameters in the default configuration by creating
a file /config/config.yml. The format should be the same as config.default.yml.

You don't need to repeat items from the default config, if you want to keep them
the same. So, if you want use a static IP address and install Solr your config.yml
file could look like this:

```
config:
  network: 
    type: private_network
    ip: 172.28.128.150
  solr:
    install: false
```

Note: If you choose to override a section of the config, you must include all the
subkeys from that section. (for example, network must include both type and ip,
even though ip is the only thing changing)
