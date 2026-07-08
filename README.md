# dotfiles

Shell configuration and Claude Code settings for macOS laptops and Linux Ubuntu servers.

## Bootstrap a new machine

**macOS:**
```bash
git clone https://github.com/cbraun/dotfiles.git ~/dev/github_com/dotfiles
cd ~/dev/github_com/dotfiles && bash install.sh
$EDITOR ~/.extra      # add machine-specific paths and secrets
source ~/.bash_profile
```

**Linux (Ubuntu):**
```bash
sudo apt-get install -y git curl jq bash-completion
git clone https://github.com/cbraun/dotfiles.git ~/dev/github_com/dotfiles
cd ~/dev/github_com/dotfiles && bash install.sh
source ~/.bash_profile
```

## What gets symlinked

| Symlink | Source |
|---------|--------|
| `~/.bash_profile` | `bash_profile` — shared core |
| `~/.bash_profile.macos` | `bash_profile.macos` — macOS only |
| `~/.bash_profile.linux` | `bash_profile.linux` — Linux only |
| `~/.aliases` | `aliases` — shared |
| `~/.aliases.macos` | `aliases.macos` — macOS only |
| `~/.functions` | `functions` |
| `~/.gitconfig` | `gitconfig` |
| `~/.vimrc` | `vimrc` |
| `~/.claude/CLAUDE.md` | `claude/CLAUDE.md` — macOS only |
| `~/.claude/RTK.md` | `claude/RTK.md` — macOS only |
| `~/.claude/statusline-command.sh` | `claude/statusline-command.sh` — macOS only |

## Machine-local config

`~/.extra` is sourced by `bash_profile` but never committed. Put machine-specific `PATH` entries, API keys, and work-specific config there. `extra.example` is a starting template.

`~/.claude/settings.json` accumulates machine-specific Claude Code permissions and is not committed. `claude/settings-base.json` is the shared starting template copied on first install.

## Keeping machines in sync

```bash
# pull latest and re-run to update symlinks
git pull && bash install.sh
```

Symlinks mean you only need to `git pull` for content changes once the symlinks are in place.

## Files not committed

- `extra` / `~/.extra` — machine-local secrets
- `hosts` — custom blocklist, managed separately
- `~/.claude/settings.json` — machine-specific Claude permissions
