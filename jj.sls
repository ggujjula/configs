{% import 'os/init.sls' as os %}

#ripgrep
{{ os.home_dir }}/.cargo/bin/jj:
  file.exists

'cargo install jj-cli':
  cmd.run:
  - onfail:
    - file: {{ os.home_dir }}/.cargo/bin/jj
  - require:
    - file: {{ os.home_dir }}/.cargo/bin/cargo
  - runas: {{ pillar['target_user'] }}
