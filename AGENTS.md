# Dotfiles

This home directory is the working tree of a public dotfiles repo
(github.com/rtlechow/dotfiles). Global agent instructions live in
~/.claude/CLAUDE.md; this file only covers the repo.

- Most of ~ is untracked on purpose, including keys and tokens. Stage
  explicit paths only, never `git add -A`, `git add .` or `git commit -a`,
  and read the staged diff for secrets before committing. Secrets belong in
  fnox (keychain), not in files under ~
- Machine-local env vars and work-specific aliases go in ~/.localrc, which
  .zshrc sources and git ignores
- .claude/ is in .gitignore_global, so tracking a file there needs
  `git add -f`
- Homebrew packages go in Brewfile, macOS settings in .osx.sh, aliases in
  .zsh/aliases.zsh, shell options in .zsh/options.zsh, and autoloaded
  functions in .zsh/functions
- Vim and zsh plugins are git submodules under .vim/pack/foo/start and
  .zsh/plugins
- Commits to this dotfiles repo are short lowercase subjects with no body
  ("gum and peekaboo", "modernize osx.sh"). Other repos keep their own
  commit style
