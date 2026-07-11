# Guide to Installing Python on Linux

Python 3 is already installed on most Linux distributions. If you need development tools, `pip`, or virtual environment support, install them using your distribution's package manager.

## Ubuntu/Debian

```bash
sudo apt update
sudo apt install python3-pip python3-venv python3-dev -y
```

## Fedora

```bash
sudo dnf install python3-pip python3-devel python3-virtualenv -y
```

## Arch Linux

```bash
sudo pacman -S python python-pip
```

---

## Opening a Terminal

If you're using **Hyprland**, use this shortcut to open the terminal:

```text
Super + Q
```

*(Assuming your Hyprland configuration uses the default keybinding.)*

If you're using **KDE**, do this to open the terminal:

1. Press the Super/Meta Key
2. Type 'Terminal'
3. It should say 'Konsole' or 'Kitty' (or the name of your Terminal)
4. Press enter.
5. You're finished.
