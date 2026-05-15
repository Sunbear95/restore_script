# 42 Dev Setup

Development environment setup script for 42 Gyeongsan Ubuntu environment.

This repository automates:

- goinfre symbolic link setup
- VSCode data relocation
- npm cache relocation
- GitHub SSH-ready git configuration
- lazygit installation
- zsh alias and completion setup
- VSCode profile import

---

# Features

## goinfre Optimization

Automatically moves large cache/data directories into:

```bash
/goinfre/$USER
```

using symbolic links.

Applied targets:

- `~/.cache`
- `~/.npm`
- `~/.vscode`
- `~/.config/Code`
- `~/.cache/Code`

This helps reduce HOME storage usage after 42 resets.

---

## VSCode Setup

Automatically restores:

- VSCode settings
- keybindings
- extensions
- custom profile

using:

```bash
vsc_for_42.code-profile
```

---

## GitHub SSH Setup

Applies:

```bash
git config --global url."git@github.com:".insteadOf "https://github.com/"
```

to avoid repeated GitHub username/password prompts.

---

## lazygit Installation

Installs latest lazygit locally without sudo:

```bash
~/.local/bin/lazygit
```

Includes:

```bash
alias lg="lazygit"
```

---

# Repository Structure

```text
42-dev-setup/
├── setup_42.sh
├── README.md
├── vscode/
│   ├── vsc_for_42.code-profile
│   ├── settings.json
│   ├── keybindings.json
│   └── extensions.txt
└── scripts/
```

---

# Installation

Clone repository:

```bash
git clone git@github.com:Sunbear95/42-dev-setup.git
cd 42-dev-setup
```

Give execute permission:

```bash
chmod +x setup_42.sh
```

Run setup:

```bash
./setup_42.sh
source ~/.zshrc
```

---

# SSH Key Setup

SSH keys are NOT automatically generated for security reasons.

Generate manually:

```bash
ssh-keygen -t ed25519 -C "jyoo@student.42gyeongsan.kr"
```

Copy public key:

```bash
cat ~/.ssh/id_ed25519.pub
```

Register it on GitHub:

```text
GitHub
→ Settings
→ SSH and GPG keys
→ New SSH key
```

Test:

```bash
ssh -T git@github.com
```

---

# VSCode Profile Import

The setup script imports:

```bash
vscode/vsc_for_42.code-profile
```

automatically.

Manual import:

```bash
code --profile "vsc_for_42" --import-profile vscode/vsc_for_42.code-profile
```

---

# Notes

This setup is intended for:

- 42 Gyeongsan
- Ubuntu/Linux
- HOME reset recovery
- goinfre optimization

---

# Warning

Do NOT upload:

```text
~/.ssh/id_ed25519
tokens
.env
private keys
```

---

# License

Personal development environment setup for 42 projects.# 42 Dev Setup

Development environment setup script for 42 Gyeongsan Ubuntu environment.

This repository automates:

- goinfre symbolic link setup
- VSCode data relocation
- npm cache relocation
- GitHub SSH-ready git configuration
- lazygit installation
- zsh alias and completion setup
- VSCode profile import

---

# Features

## goinfre Optimization

Automatically moves large cache/data directories into:

```bash
/goinfre/$USER
```

using symbolic links.

Applied targets:

- `~/.cache`
- `~/.npm`
- `~/.vscode`
- `~/.config/Code`
- `~/.cache/Code`

This helps reduce HOME storage usage after 42 resets.

---

## VSCode Setup

Automatically restores:

- VSCode settings
- keybindings
- extensions
- custom profile

using:

```bash
vsc_for_42.code-profile
```

---

## GitHub SSH Setup

Applies:

```bash
git config --global url."git@github.com:".insteadOf "https://github.com/"
```

to avoid repeated GitHub username/password prompts.

---

## lazygit Installation

Installs latest lazygit locally without sudo:

```bash
~/.local/bin/lazygit
```

Includes:

```bash
alias lg="lazygit"
```

---

# Repository Structure

```text
42-dev-setup/
├── setup_42.sh
├── README.md
├── vscode/
│   ├── vsc_for_42.code-profile
│   ├── settings.json
│   ├── keybindings.json
│   └── extensions.txt
└── scripts/
```

---

# Installation

Clone repository:

```bash
git clone git@github.com:Sunbear95/42-dev-setup.git
cd 42-dev-setup
```

Give execute permission:

```bash
chmod +x setup_42.sh
```

Run setup:

```bash
./setup_42.sh
source ~/.zshrc
```

---

# SSH Key Setup

SSH keys are NOT automatically generated for security reasons.

Generate manually:

```bash
ssh-keygen -t ed25519 -C "jyoo@student.42gyeongsan.kr"
```

Copy public key:

```bash
cat ~/.ssh/id_ed25519.pub
```

Register it on GitHub:

```text
GitHub
→ Settings
→ SSH and GPG keys
→ New SSH key
```

Test:

```bash
ssh -T git@github.com
```

---

# VSCode Profile Import

The setup script imports:

```bash
vscode/vsc_for_42.code-profile
```

automatically.

Manual import:

```bash
code --profile "vsc_for_42" --import-profile vscode/vsc_for_42.code-profile
```

---

# Notes

This setup is intended for:

- 42 Gyeongsan
- Ubuntu/Linux
- HOME reset recovery
- goinfre optimization

---

# Warning

Do NOT upload:

```text
~/.ssh/id_ed25519
tokens
.env
private keys
```

---

# License

Personal development environment setup for 42 projects.