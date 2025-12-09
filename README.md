# 270 POTO dotfiles for Ubuntu / WSL
Base customization for Starship prompt in Fish shell + Kitty terminal (Wezterm terminal if running on WSL)
starp -l will list the profiles for starship, then just type starp <profile> to change

---

## Installation

```bash
git clone https://github.com/Kraus-Mara/270POTO_dotfiles.git
cd 270POTO_dotfiles
bash setup.sh
```

This script will:

* Install all the dependencies
* Copy `starship.toml` to `~/.config/`
* Add Starship initialization to your Fish config (`~/.config/fish/config.fish`)

---

## Customization (startship.toml)

You can directly modify:

* Colors in each module (`style = "fg:#xxxxxx bg:#xxxxxx"`)
* Powerline symbols (``, ``, etc.)
* The global prompt format (`format = "...$os$directory$git_branch..."`)

For now it only has 3 profiles : ananas and ar-pinky and ar-grey
---

## Fish Shell Support Only

This configuration is designed exclusively for Fish

---


