# Dotfiles Repo — Claude Context

This repo manages shell config and Claude Code settings across machines:
- **macOS laptops**: full setup (shell + Claude Code config)
- **Linux Ubuntu servers**: shell only (no Claude Code)

## Pending task: restructure for cross-machine sync

The current repo has no install script and all files are macOS-specific. The plan below was drafted on a secondary Mac and should be executed on the **primary Mac laptop** (which has the most up-to-date dotfiles).

### Step 0 — seed git from the primary Mac (do this first)

```bash
cp ~/.bash_profile ~/dev/github_com/dotfiles/bash_profile
cp ~/.aliases      ~/dev/github_com/dotfiles/aliases
cp ~/.functions    ~/dev/github_com/dotfiles/functions
# add any other changed files
git add -A && git commit -m "sync from primary mac" && git push
```

### Step 1 — target repo structure

```
dotfiles/
├── bash_profile            # shared core (env, PS1, sourcing loop, shopt)
├── bash_profile.macos      # macOS: Homebrew, Conda, TeX, Colima, completion
├── bash_profile.linux      # Linux: editor, miniforge conda
├── aliases                 # shared (ls color-detection already cross-platform)
├── aliases.macos           # macOS-only: Finder, flush, afk, softwareupdate
├── functions               # shared (already portable)
├── gitconfig               # shared
├── vimrc                   # shared
├── extra.example           # template for ~/.extra (machine-local, not committed)
├── claude/
│   ├── CLAUDE.md           # → ~/.claude/CLAUDE.md
│   ├── RTK.md              # → ~/.claude/RTK.md
│   ├── statusline-command.sh  # → ~/.claude/statusline-command.sh
│   └── settings-base.json  # shared Claude prefs (template for new machines)
└── install.sh
```

### Step 2 — split `bash_profile`

**Keep in `bash_profile` (shared):** LANG, HISTSIZE, HISTFILESIZE, PS1, CLICOLOR, LSCOLORS, MANPAGER, GREP_OPTIONS, LESS_TERMCAP_md, `shopt -s cdspell`, the `~/.{aliases,functions,extra}` sourcing loop.

Add at bottom:
```bash
case "$(uname -s)" in
  Darwin) [ -f ~/.bash_profile.macos ] && source ~/.bash_profile.macos ;;
  Linux)  [ -f ~/.bash_profile.linux ] && source ~/.bash_profile.linux ;;
esac
```

**`bash_profile.macos`** — move from current `bash_profile`:
- EDITOR, ARCHFLAGS, BASH_SILENCE_DEPRECATION_WARNING
- Homebrew PATH entries (not `/usr/bin:/bin/...` base — that stays shared)
- TeX, PostgreSQL PATH
- HOMEBREW_* vars
- DOCKER_HOST (Colima), DOCKER_DEFAULT_PLATFORM
- Conda initialize block
- Bash completion block

**Remove from `bash_profile.macos`** — move to `~/.extra` (machine-specific):
- `~/dev/github_com/dateh`
- `~/dev/gdal_python_tools`
- `~/dev/hacking/citygml-tools-*`
- `/Applications/3DCityDB-Importer-Exporter/bin`

**`bash_profile.linux`** (new):
```bash
export EDITOR="vim"
export DOCKER_DEFAULT_PLATFORM=linux/amd64
[ -f "$HOME/miniforge3/etc/profile.d/conda.sh" ] && . "$HOME/miniforge3/etc/profile.d/conda.sh"
```

### Step 3 — split `aliases`

Move these to `aliases.macos`: `flush`, `lscleanup`, `show`, `hide`, `hidedesktop`, `showdesktop`, `afk`, `update` (softwareupdate), `mergepdf`.

Add at the bottom of `aliases`:
```bash
[ -f ~/.aliases.macos ] && source ~/.aliases.macos
```

### Step 4 — write `install.sh`

```bash
#!/usr/bin/env bash
set -e
DOTFILES="$(cd "$(dirname "$0")" && pwd)"
OS="$(uname -s)"

link() { ln -sf "$DOTFILES/$1" "$HOME/.$2"; }

link bash_profile bash_profile
link aliases      aliases
link functions    functions
link gitconfig    gitconfig
link vimrc        vimrc

if [[ "$OS" == "Darwin" ]]; then
  link bash_profile.macos bash_profile.macos
  link aliases.macos      aliases.macos
elif [[ "$OS" == "Linux" ]]; then
  link bash_profile.linux bash_profile.linux
fi

if [[ ! -f "$HOME/.extra" ]]; then
  cp "$DOTFILES/extra.example" "$HOME/.extra"
  echo "Created ~/.extra from template — fill in machine-specific paths/secrets"
fi

if [[ "$OS" == "Darwin" ]]; then
  mkdir -p ~/.claude
  ln -sf "$DOTFILES/claude/CLAUDE.md"             ~/.claude/CLAUDE.md
  ln -sf "$DOTFILES/claude/RTK.md"                ~/.claude/RTK.md
  ln -sf "$DOTFILES/claude/statusline-command.sh" ~/.claude/statusline-command.sh
  if [[ ! -f ~/.claude/settings.json ]]; then
    cp "$DOTFILES/claude/settings-base.json" ~/.claude/settings.json
    echo "Created ~/.claude/settings.json from base template"
  fi
fi

echo "Done. Run: source ~/.bash_profile"
```

### Step 5 — populate `claude/` directory

Copy from the primary Mac:
```bash
mkdir -p claude
cp ~/.claude/CLAUDE.md              claude/CLAUDE.md
cp ~/.claude/RTK.md                 claude/RTK.md
cp ~/.claude/statusline-command.sh  claude/statusline-command.sh
```

Create `claude/settings-base.json` with shared prefs only (no machine-specific permissions):
```json
{
  "includeCoAuthoredBy": false,
  "effortLevel": "high",
  "alwaysThinkingEnabled": true,
  "tui": "fullscreen",
  "theme": "auto",
  "editorMode": "normal",
  "enableWorkflows": true,
  "voice": { "enabled": false },
  "worktree": { "baseRef": "fresh" },
  "hooks": {
    "PreToolUse": [
      { "matcher": "Bash", "hooks": [{ "type": "command", "command": "rtk hook claude" }] }
    ]
  },
  "statusLine": {
    "type": "command",
    "command": "bash ~/.claude/statusline-command.sh"
  },
  "permissions": {
    "defaultMode": "default",
    "allow": ["WebSearch", "Bash(git *)", "Bash(rtk *)"]
  }
}
```

### Step 6 — update `.gitignore`

Add: `extra`, `hosts`, `*.local`, `.DS_Store`

### Step 7 — run `install.sh` and verify

```bash
bash install.sh
source ~/.bash_profile
ls -la ~/.bash_profile ~/.aliases ~/.functions ~/.gitconfig ~/.vimrc ~/.claude/CLAUDE.md
```

## What is NOT committed

| File | Reason |
|------|--------|
| `~/.claude/settings.json` | Machine-specific permissions; use `claude/settings-base.json` as template |
| `~/.extra` | Machine-local paths, API keys |
| `hosts` | 327KB custom blocklist |
| `~/.claude/history.jsonl`, `sessions/`, `daemon*` | Runtime state |
