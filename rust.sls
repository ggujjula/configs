{% import 'os/init.sls' as os %}

{% set cargo_bin = os.home_dir + '/.cargo/bin/cargo' %}
{% set rustup_bin = os.home_dir + '/.cargo/bin/rustup' %}
{% set rustup_sh_url = "https://sh.rustup.rs" %}
{% set rustup_cmd = "sh /tmp/rustup.sh -y --component rust-src,rust-analyzer" %}

{{ rustup_bin }}:
  file.exists

{{ cargo_bin }}:
  file.exists

temp_rustup:
  file.managed:
    - name: /tmp/rustup.sh
    - source: {{ rustup_sh_url }}
    - skip_verify: True

{{ rustup_cmd }}:
  cmd.run:
  - onfail:
    - file: {{ rustup_bin }}
  - require:
    - file: temp_rustup
  - runas: {{ pillar['target_user'] }}

/tmp/rustup.sh:
  file.absent:
    - watch:
      - cmd: {{ rustup_cmd }}
