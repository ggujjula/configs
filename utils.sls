{% import 'os/init.sls' as os %}

#ripgrep
{{ os.home_dir }}/.cargo/bin/rg:
  file.exists

'cargo install ripgrep':
  cmd.run:
  - onfail:
    - file: {{ os.home_dir }}/.cargo/bin/rg
  - require:
    - file: {{ os.home_dir }}/.cargo/bin/cargo
  - runas: {{ pillar['target_user'] }}

plocate:
  pkg.installed

universal-ctags:
  pkg.installed

git:
  pkg.installed

git-doc:
  pkg.installed

#firefox (!headless)
#firefox:
#  pkg.installed

#qemu	(vm)
#qemu-system:
#  pkg.installed

binutils:
  pkg.installed

binutils-doc:
  pkg.installed

bison:
  pkg.installed

bison-doc:
  pkg.installed

flex:
  pkg.installed

flex-doc:
  pkg.installed

#uutils	(experimental)
#uutils:
#  pkg.installed

graphviz:
  pkg.installed

graphviz-doc:
  pkg.installed

fish:
  pkg.installed

#stgit	(experimental)
#stgit:
#  pkg.installed

bpftrace:
  pkg.installed

bpfcc-tools:
  pkg.installed

tmux:
  pkg.installed

linux-headers-amd64:
  pkg.installed
