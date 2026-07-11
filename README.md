
<p align="center">
  <a href="https://tposts.mtgoals.cc">
  <img src="http://cdn.mtgoals.cc/images/typepostlogo.gif" width="200" />
</p>

<p align="center">

  <a href="https://discord.gg/WwB6rMYQ2W">
    <img src="https://img.shields.io/discord/1521933938032119889?logo=discord&label=Discord" />
  </a>

  <img src="https://img.shields.io/github/license/opencinnamon/cinnasole" />
  <img src="https://img.shields.io/github/last-commit/opencinnamon/cinnasole" />

  <p align="center">
  <a href="#cinnasole">About</a> •
  <a href="#windows">Windows Port</a> •
  <a href="#install">How to Run</a> •
  <a href="#installing-whois">Whois Installation</a>
</p>

  <br/><br/>

> [!NOTE]
> Cinnasole is currently in beta, so unexpected issues may occur.
> Updates and changes will happen frequently. If you find a bug, please report it to us through Discord.

# Cinnasole

Cinnasole is a remake of the discontinued **Moonlight Addons** Python script originally developed by a friend of mine.

Moonlight Addons was originally designed for both Windows and Linux. Over time, the Windows version became the main focus of development while the Linux version was eventually discontinued. Development later stopped entirely.

Cinnasole is a new project built specifically for **Linux**, bringing back the original idea while focusing on Linux compatibility. It provides various ethical hacking and networking tools, including commands such as `nmap`, `dns`, `whois`, `crack`, and more.

Cinnasole supports most Linux distributions, including (but not limited to):

- Ubuntu
- Debian
- Linux Mint
- Arch Linux
- Fedora
- and more

---

# Windows

There will never be an **official Windows port** of Cinnasole.

You are welcome to create your own Windows port, but unofficial ports are not supported or endorsed by the Cinnasole team. If your computer is compromised, infected with malware, or experiences any other issues while using an unofficial port, the responsibility lies with the creator of that port.

> [!NOTE]
> If someone claims their Windows or macOS version of Cinnasole is official, it is not.
>
> All Windows and macOS ports are completely unofficial.

---

# Install

To install Cinnasole on your Linux computer, visit:

https://console.mtgp.cc/download

Download the latest version of Cinnasole, then follow the steps below.

## 1. Open your terminal and navigate to the Cinnasole folder:

```bash
cd /path/to/cinnasole
```

Replace `/path/to/cinnasole` with the actual location of your Cinnasole folder.

## 2. Run Cinnasole:

```bash
python3 cinnasole.py
```

If Python is not installed, follow the Python installation guide:

[Cinnasole Python Installation Guide](https://github.com/opencinnamon/cinnasole/blob/main/docs/python-installation.md)

## Installing Whois

If Cinnasole requires `whois` and it is not installed:

1. Type `exit` to close Cinnasole.
2. Install `whois` using your distribution's package manager.

Example:

### Ubuntu/Debian

```bash
sudo apt install whois
```

### Fedora

```bash
sudo dnf install whois
```

### Arch Linux

```bash
sudo pacman -S whois
```
