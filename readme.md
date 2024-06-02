# camp

### current systems                                                                 
| name | type | details |
| :--: | :--: | :--: |
| [rin](./hosts/rin.nix) | desktop | main system for daily use, dual booting win11|
| [aoi](./hosts/aoi.nix) | server | home server running all my services for now|

<br>

### systems to-do
| type | details |
| :--: | :--: |
| laptop | main laptop, will dual boot windows, maybe wsl? |
| misc | old thinkcentre i plan to use for kodi |

<br>

### file structure

- [hosts](hosts)
- [lib](lib) options/functions, almost entirely from [nu-nu-ko](https://github.com/nu-nu-ko)'s [config](https://github.com/nu-nu-ko/crystal)
- [misc/](misc) misc files that should'nt be imported in flake.nix
  - [images](misc/images) 
  - [pkgs](misc/pkgs)
  - [secrets](misc/secrets) secrets with [agenix](https://github.com/ryantm/agenix)
- [modules/](modules) 
  - [desktop/](modules/desktop) configs that only work/make sense on a system with gui
    - [wm](modules/desktop/wm)  
  - [programs](modules/programs) 
  - [services/](modules/services) specifically self-hosted services only to run on server
    - [web](modules/services/web) services with a web interface using nginx 
  - [themes](modules/themes) colours, packages and configs for different themes
  - [enabled.nix](modules/enabled.nix) options that will almost always be enabled on every system
- [flake.nix](flake.nix) 
  
<br>

### a lot stolen from [nu-nu-ko](https://github.com/nu-nu-ko)'s [config](https://github.com/nu-nu-ko/crystal)

<br>

![](https://raw.githubusercontent.com/pagusupu/camp/main/misc/images/group.jpg)
