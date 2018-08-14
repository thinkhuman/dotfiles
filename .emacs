(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(custom-enabled-themes (quote (sanityinc-tomorrow-night)))
 '(custom-safe-themes
   (quote
    ("06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default)))
 '(org-agenda-files (quote ("~/Dropbox/orgtest.org")))
 '(package-selected-packages
   (quote
    (neotree auto-complete yasnippet auto-shell-command color-theme-sanityinc-tomorrow markdown-mode jedi flycheck which-key use-package org-edna))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(linum ((t (:foreground "#42a5f5" :background "#222222" :box nil)))))


(setq inhibit-startup-message t)

;; UI CUSTOMIZATION
(tool-bar-mode -1) ;; tool bar off
(global-visual-line-mode t) ;; word wrap by default
(global-linum-mode t) ;; line numbers by default
(set-cursor-color "#32cd32") ;; set default cursor color
(add-to-list 'default-frame-alist '(fullscreen . maximized)) ;; maximise window by default
(setq default-frame-alist '((font . "UbuntuMono-12"))) ;; set default font
(toggle-scroll-bar -1) ;; Disable vertical scrollbar
(setq linum-format " %d ") ;; Adjust spacing in line numbers
 ;; Set line number colors
;; Display buffer's full  path name in frame title bar
(setq frame-title-format
      '(buffer-file-name "%b - %f" ; File buffer
        (dired-directory dired-directory ; Dired buffer
         (revert-buffer-function "%b" ; Buffer Menu
          ("%b - Dir: " default-directory))))) ; Plain buffer
(setq split-height-threshold 0)
(setq split-width-threshold nil)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
	(package-refresh-contents)
	(package-install 'use-package))

;; Display available key bindings in a popup
(use-package which-key
	:ensure t
	:config
	(which-key-mode))

;; Ido mode, for completion
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; Flycheck, for syntax checking
(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t))

;; Jedi, for Python auto completion
(use-package jedi
  :ensure t
  :init
  (add-hook 'python-mode-hook 'jedi:setup)
  (add-hook 'python-mode-hook 'jedi:ac-setup))

;; Markdown syntax coloring and commands
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

;; Directory tree display, like Vim's Nerdtree
(use-package neotree
  :ensure t
  :bind (("<f2>" . neotree-toggle))
  :init (setq neo-window-width 25)
  :config (setq neo-smart-open t))

;; Display the time
(display-time-mode 1)

;; Org mode custom key kindings
;; The following lines are always needed.  Choose your own keys.
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-switchb)

;; Disable backup files
(setq make-backup-files nil)
(setq auto-save-default nil)
