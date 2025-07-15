{% if grains['os'] == 'Fedora' %}
  {% import 'os/fedora.sls' as target_os %}
{% endif %}
{% if grains['os'] == 'Debian' %}
  {% import 'os/debian.sls' as target_os %}
{% endif %}
{% if grains['os'] == 'Ubuntu' %}
  {% import 'os/ubuntu.sls' as target_os %}
{% endif %}

{% set home_dir = target_os.home_dir %}
{% set clangd_package = target_os.clangd_package %}
