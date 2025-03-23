{% import 'os/init.sls' as os %}

neovim_packages:
  pkg.installed:
  - pkgs:
    - neovim
    - fzf
    - {{ os.clangd_package }}

{{ os.home_dir }}/.config/nvim/init.lua:
  file:
    - managed
    - source: salt://files/init.lua
    - makedirs: True
    - user: {{ pillar['target_user'] }}
    - group: {{ pillar['target_group'] }}
    - require:
      - pkg: neovim_packages
      - user: {{ pillar['target_user'] }}

# {{ os.home_dir }}/.local/share/nvim/site/autoload/plug.vim:
#   file:
#     - managed
#     - source: https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
#     - source_hash: 0927fe51213ab3e8764f9f42c744bf92d3e90c4cbdbba834cd07cf900a0740f0c626bb8e038fb2b91c148063856d80a006f2f8b01ec8bda0efd734f462f22332
#     - makedirs: True
#     - user: user
#     - group: user
#     - require:
#       - pkg: neovim
#       - user: {{ pillar['target_user'] }}

