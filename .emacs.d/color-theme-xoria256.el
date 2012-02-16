;; Port of xoria256.vim by Dmitriy Zotikov, with some liberties taken.

(defun color-theme-xoria256 ()
  (interactive)
  (let ((gray   "#d0d0d0")
        (purple "#dfafdf")
        (blue   "#87afdf")
        (pink   "MediumVioletRed")
        (green  "#afdf87")
        (orange "DarkOrange1")
        (red    "#800000"))
  (color-theme-install
   `(color-theme-xoria256
      ((border-color     . "#d6d1d1")
       (cursor-color     . "#ffaf00")
       (foreground-color . ,gray)
       (background-color . "#1c1c1c")
       (mouse-color      . "black"))

     (fringe                          ((t (:background "black"))))
     (mode-line                       ((t (:foreground "white" :background "#4e4e4e" :bold t))))
     (mode-line-inactive              ((t (:foreground ,gray :background "#3a3a3a"))))
     (minibuffer-prompt               ((t (:foreground "white"))))

     (region                          ((t (:foreground "#005f87" :background "#afdfff"))))
     (isearch                         ((t (:foreground "black" :background "#afdf5f"))))
     (show-paren-match-face           ((t (:foreground "#dfdfdf" :background "#4f87df"))))

     (ido-first-match                 ((t (:foreground "black" :background "#afdf5f" :bold t))))
     (ido-only-match                  ((t (:foreground "black" :background "#afdf5f" :bold t))))
     (ido-subdir                      ((t (:foreground ,blue))))

     (font-lock-builtin-face          ((t (:foreground ,blue))))
     (font-lock-comment-face          ((t (:foreground "#808080"))))
     (font-lock-function-name-face    ((t (:foreground ,gray))))
     (font-lock-keyword-face          ((t (:foreground ,blue))))
     (font-lock-string-face           ((t (:foreground "#fffaf"))))
     (font-lock-constant-face         ((t (:foreground "#fffaf"))))
     (font-lock-type-face             ((t (:foreground "#afafdf"))))
     (font-lock-variable-name-face    ((t (:foreground "#dfafdf"))))
     (font-lock-warning-face          ((t (:foreground ,purple))))
     (font-lock-preprocessor-face     ((t (:foreground ,green))))

     (compilation-info                ((t (:foreground ,green))))
     (compilation-warning             ((t (:foreground ,orange))))

     (tuareg-font-lock-operator-face  ((t (:foreground ,blue))))
     (tuareg-font-lock-governing-face ((t (:foreground ,blue))))

     (magit-item-highlight            ((t (:background "#444444"))))
     (magit-diff-add                  ((t (:foreground ,green :bold t))))
     (magit-diff-del                  ((t (:foreground "#dfdf87" :bold t))))
     (magit-log-sha1                  ((t (:foreground ,blue))))

     (font-latex-sectioning-2-face    ((t (:foreground "black"))))
     (font-latex-bold-face            ((t (:foreground "black" :bold t))))

     (info-xref                       ((t (:foreground ,pink :bold t))))

     (w3m-anchor-face                 ((t (:foreground ,blue :bold t))))
     (w3m-arrived-anchor-face         ((t (:foreground ,purple))))

     (org-level-1                     ((t (:foreground ,blue :bold t))))
     (org-level-2                     ((t (:foreground ,blue :bold t))))
     (org-level-3                     ((t (:foreground ,blue :bold t))))
     (org-todo                        ((t (:foreground ,purple :bold t))))
     (org-done                        ((t (:foreground ,green :bold t))))
     ))))
(provide 'color-theme-xoria256)
