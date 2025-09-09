# 270 POTO dotfiles
Neovim, fish, kitty and starship Dotfiles that comes with customized starship configurations that can be changed easily : 

starp -l will list the profiles for starship, then just type starp <profile> to change


---

## ⚠️ Warning

This configuration **will overwrite your existing Starship configuration**.
If you just want to test it, **make a backup of your current files** first:

```bash
cp ~/.config/starship.toml ~/.config/starship.toml.backup
cp ~/.config/fish/config.fish ~/.config/fish/config.fish.backup
```
---

## ⚡ Quick Installation

```bash
git clone https://github.com/Kraus-Mara/270POTO_dotfiles.git
cd 270POTO_dotfiles
bash setup.sh
```

This script will:

* Copy `starship.toml` to `~/.config/`
* Add Starship initialization to your Fish config (`~/.config/fish/config.fish`)

---

## 🔧 Customization

You can directly modify:

* Colors in each module (`style = "fg:#xxxxxx bg:#xxxxxx"`)
* Powerline symbols (``, ``, etc.)
* The global prompt format (`format = "...$os$directory$git_branch..."`)

For now it only has 2 profiles : ananas and pinky
---

## 🐟 Fish Shell Support Only

This configuration is *designed exclusively for Fish*, cause it's mine, and i use fish.
---

## 💾 Backup & Restore

To restore your previous configuration:

```bash
mv ~/.config/starship.toml.backup ~/.config/starship.toml
mv ~/.config/fish/config.fish.backup ~/.config/fish/config.fish
```

---

Enjoy your beautiful, fully customized Starship prompt in Fish + Kitty!

