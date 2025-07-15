{% import 'os/init.sls' as os %}

alacritty:
  pkg.installed

{{ os.home_dir }}/.config/alacritty/alacritty.toml:
  file:
    - managed
    - source: salt://files/alacritty.toml
    - makedirs: True
    - user: {{ pillar['target_user'] }}
    - group: {{ pillar['target_group'] }}
    - require:
      - pkg: alacritty
      - user: {{ pillar['target_user'] }}
