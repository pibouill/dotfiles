# Save ubuntu config
- custom keybinds 
- tweaks settings
- misc. settings

_Fixed with dconf ?_

save config
`dconf dump / > <file>.txt` 

load config
`dconf load / < <file>.txt`

---

Update script for migration -> stow i guess
(binaries and stuff)

---

dircolors creation
xargs brew install < brew_list.txt (git and curl issues)
dconf dump thingg
	decrypt and load (see above)
create alacritty and obsidian
	install alacrittywith cargo (cheeck desktop files) -> `cargo install alacritty`
	install obsidian from source ->
	cp the desktop files to correct location
	correctly add the icons
fix bin/
correctly install nvim (build source or clone or ..)
correctly add all the cli tools
curl installed with brew is fucked
dircolors -> clone dracula one (and move the . file up)


## List of dependencies

- **brew** -> I guess main one for the rest of installs
    - -> brew_install.sh
- nvim
- lua
- luarock
- cargo
- nodejs
- 
