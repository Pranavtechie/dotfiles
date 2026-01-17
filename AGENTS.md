# Repository Guidelines

## Project Structure & Module Organization
This repo is a macOS-focused dotfiles collection managed with GNU Stow. Key locations:
- `.config/<tool>/`: per-tool config (e.g., `nvim`, `zed`, `raycast`, `gh`, `nushell`).
- `.local/bin/`: personal scripts (e.g., `toggle-apps`).
- Root configs like `.aerospace.toml`, `.gitconfig`, `.gitignore`.

## Build, Test, and Development Commands
- `stow .` — create symlinks into `$HOME` for all stow packages.
- `stow -n .` — dry-run to preview symlink changes before applying.
- `.local/bin/toggle-apps open|quit` — example script for local workflow automation.

## Coding Style & Naming Conventions
- Preserve each tool’s native formatting; don’t rewrap or reorder settings unless required.
- Shell scripts in `.local/bin/` use `bash`; keep 4-space indentation and uppercase constants (e.g., `APPS`).
- Name new tool folders under `.config/` using the tool’s canonical name (e.g., `gh`, `btop`).


## Commit & Pull Request Guidelines
- Commit history mostly follows a conventional style: `fix`, `feat`, optional scopes (`fix(opencode)`), and short imperatives. Prefer that pattern.
- Keep commits focused on a single tool or theme; mention the target app in the message.
- PRs should include: summary of changes, affected tools/paths (e.g., `.config/zed`), and any manual validation steps.

## Security & Configuration Tips
- Do **not** make this repository public; it contains sensitive config (see `README.md`).
- Avoid committing secrets; prefer environment variables or external secret stores when adding new tooling.
