(add-to-list 'load-path "~/.emacs.d")
(require 'color-theme)
(require 'color-theme-xoria256)
(eval-after-load "color-theme"
    '(progn
        (color-theme-xoria256)))

(setq-default indent-tabs-mode nil)
(setq-default c-basic-offset 2)
(setq-default default-tab-width 2)
(menu-bar-mode nil)
(setq inhibit-startup-message t)
(set-default 'show-trailing-whitespace t)

(setq viper-mode t)
(setq viper-ex-style-editing nil)
(require 'viper)
