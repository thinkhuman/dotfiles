(setq inhibit-startup-message t) ; Disable the default Emacs startup screen

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

(package-initialize)



; Bootstrap use-package
(unless (package-installed-p 'use-package)
	(package-refresh-contents)
	(package-install 'use-package))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(beacon-color "#cc6666")
 '(custom-enabled-themes (quote (sanityinc-tomorrow-night)))
 '(custom-safe-themes
   (quote
    ("628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "3f44e2d33b9deb2da947523e2169031d3707eec0426e78c7b8a646ef773a2077" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default)))
 '(fci-rule-color "#373b41")
 '(flycheck-color-mode-line-face-to-color (quote mode-line-buffer-id))
 '(frame-background-mode (quote dark))
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(org-journal-dir "~/Dropbox/logs/journal/")
 '(org-journal-file-format "%m.%d.%Y.org")
 '(package-selected-packages
   (quote
    (zenburn-theme sr-speedbar color-theme neotree auto-complete yasnippet auto-shell-command color-theme-sanityinc-tomorrow markdown-mode jedi flycheck which-key use-package org-edna)))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#cc6666")
     (40 . "#de935f")
     (60 . "#f0c674")
     (80 . "#b5bd68")
     (100 . "#8abeb7")
     (120 . "#81a2be")
     (140 . "#b294bb")
     (160 . "#cc6666")
     (180 . "#de935f")
     (200 . "#f0c674")
     (220 . "#b5bd68")
     (240 . "#8abeb7")
     (260 . "#81a2be")
     (280 . "#b294bb")
     (300 . "#cc6666")
     (320 . "#de935f")
     (340 . "#f0c674")
     (360 . "#b5bd68"))))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(linum ((t (:foreground "#42a5f5" :background "#222222" :box nil)))))

; UI CUSTOMIZATION
(defvar linum-format)
(setq-default cursor-type 'bar)   ; change cursor to bar
(tool-bar-mode -1)                ; tool bar off
(menu-bar-mode -1)                ; menu bar off
(global-visual-line-mode t)       ; word wrap by default
(global-linum-mode t)             ; line numbers by default
(show-paren-mode 1)               ; Highlight parenthesis pairs
(set-cursor-color "#0684ea")      ; set default cursor color
(toggle-scroll-bar -1)            ; Disable vertical scrollbar
(setq linum-format " %d ")        ; Adjust spacing in line numbers
(display-time-mode 1)             ; Display the time
(setq default-frame-alist '((font . "UbuntuMono-12"))) ; set default font
(add-to-list 'default-frame-alist '(fullscreen . maximized)) ; maximise Emacs frame by default
(define-key global-map (kbd "RET") 'newline-and-indent)

; Display buffer's full path name in frame title bar
(setq frame-title-format
      '(buffer-file-name "%b - %f"              ; File buffer
        (dired-directory dired-directory        ; Dired buffer
         (revert-buffer-function "%b"           ; Buffer Menu
          ("%b - Dir: " default-directory)))))  ; Plain buffer
(setq split-height-threshold 0)
(setq split-width-threshold nil)

;; Use which-key to display available key bindings in a popup
(use-package which-key
	:ensure t
	:config
	(which-key-mode))

; Use speedbar and sr-speedbar, for a sidebar file browser
(use-package sr-speedbar
  :ensure t
  :init
(set-variable 'sr-speedbar-right-side nil))
;;(setq speedbar-use-images nil)
(setq speedbar-show-unknown-files t)
(setq sr-speedbar-width 15)
(setq speedbar-directory-unshown-regexp
"^\\(CVS\\|RCS\\|SCCS\\|\\.\\.*$\\)\\'")
(sr-speedbar-open)


(when window-system
  (defadvice sr-speedbar-open (after sr-speedbar-open-resize-frame activate)
    (set-frame-width (selected-frame)
                     (+ (frame-width) sr-speedbar-width)))
  (ad-enable-advice 'sr-speedbar-open 'after 'sr-speedbar-open-resize-frame)

  (defadvice sr-speedbar-close (after sr-speedbar-close-resize-frame activate)
    (sr-speedbar-recalculate-width)
    (set-frame-width (selected-frame)
                     (- (frame-width) sr-speedbar-width)))
(ad-enable-advice 'sr-speedbar-close 'after 'sr-speedbar-close-resize-frame))

; Use Ido mode, for completion
(defvar ido-enable-flex-matching)
(defvar ido-everywhere)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

; Use Flycheck, for syntax checking
(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t))

; Use Jedi, for Python auto-completion
(use-package jedi
  :ensure t
  :init
  (add-hook 'python-mode-hook 'jedi:setup)
  (add-hook 'python-mode-hook 'jedi:ac-setup))

; Configure Markdown syntax coloring and commands
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

; Use Powerline for a fancier mode line, a la Vim.
(use-package powerline
  :ensure t
  :config
  (powerline-default-theme)
  )

; Use Web mode to improve working with HTML, etc.
(use-package web-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.css?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.js?\\'" . web-mode))

(setq web-mode-enable-auto-closing t)
(setq web-mode-enable-auto-quoting t))


; overwrite selected text (by default, Emacs does not do this)
(delete-selection-mode t)

; Keep temp files in one location, instead of cluttering things up
(setq backup-directory-alist
          `(("." . ,(concat user-emacs-directory "backups"))))

; ORG MODE SETTINGS

; Org mode custom key kindings
; The following lines are required, but keys can be customized.
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-switchb)
(global-set-key "\C-ct" 'org-table-create)

; Set the default org directory
(setq org-directory "~/Dropbox/logs")

; Define default todo item states
(setq org-todo-keywords
      '((sequence "TODO" "IN-PROGRESS" "WAITING" "|" "DONE" "CANCELED")))

; Define which files to build the agenda view from
(setq org-agenda-files '(
			 "~/Dropbox/logs/capture.org"
			 "~/Dropbox/logs/todo.org"
			 "~/Dropbox/logs/ticker.org"
			 ))
; Set where to archive completed tasks
(setq org-archive-location "~/Dropbox/logs/archive.org::")

; Define org-capture templates (right now, just for task lists)
(setq org-capture-templates '(("i" "Todo [inbox]" entry
                               (file+headline "~/Dropbox/logs/capture.org" "Tasks")
                               "* TODO %i%?")
                              ("t" "Tickler" entry
                               (file+headline "~/Dropbox/logs/tickler.org" "Tickler")
                               "* %i%? \n %U")))

; Use org-journal for a simple daily journal
(use-package org-journal
  :ensure t
  :custom
      (org-journal-dir "~/Dropbox/logs/journal/")
      (org-journal-file-format "%m.%d.%Y.org"))


; Disable backup files
(setq make-backup-files nil)
(setq auto-save-default nil)
