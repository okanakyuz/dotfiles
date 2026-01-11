(setq native-comp-async-report-warnings-errors 'silent)
(electric-pair-mode 1)
(global-display-line-numbers-mode)
(show-paren-mode 1)
(setq inhibit-startup-screen t)
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(xterm-mouse-mode 1)
(global-set-key [mouse-4] (lambda () (interactive) (scroll-down 1)))
(global-set-key [mouse-5] (lambda () (interactive) (scroll-up 1)))

(let ((tmp-dir (expand-file-name "tmp/" user-emacs-directory)))
  (setq backup-directory-alist
        `(("." . ,(expand-file-name "backups/" tmp-dir))))
  (setq auto-save-file-name-transforms
        `((".*" ,(expand-file-name "auto-save/" tmp-dir) t)))
  (dolist (dir (list (expand-file-name "backups/" tmp-dir)
                     (expand-file-name "auto-save/" tmp-dir)))
    (unless (file-exists-p dir)
      (make-directory dir t))))
(setq create-lockfiles nil)

(setq select-enable-clipboard t)
(setq select-enable-primary t)
(unless (display-graphic-p)
  (setq xterm-extra-capabilities '(getSelection setSelection)))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

(defun my-c-style-guide ()
  "C Settings for style"
  (c-set-style "bsd")
  (setq c-basic-offset 8
        tab-width 8
        indent-tabs-mode t))
(setq-default indent-tabs-mode t)
(setq-default tab-width 8)
(setq-default c-basic-offset 8)
(setq-default standard-indent 8)
(add-hook 'c-mode-hook 'my-c-style-guide)

(use-package lsp-mode
  :hook ((c-mode . lsp-deferred)
         (c++-mode . lsp-deferred))
  :commands lsp
  :config
  (setq lsp-clients-clangd-args '("--header-insertion=never" "--compile-commands-dir=."))
  (setq lsp-enable-symbol-highlighting t))

(global-set-key (kbd "C-c o") 'ff-find-other-file)
(global-set-key (kbd "M-.")   'lsp-find-definition)        ; Go to defination
(global-set-key (kbd "M-,")   'pop-tag-mark)               ; Return Back
(global-set-key (kbd "C-c r") 'lsp-find-references)        ; References
(global-set-key (kbd "C-c i") 'lsp-find-implementation)    ; Implementations
(global-set-key (kbd "C-c d") 'lsp-describe-thing-at-point); Documentations
(global-set-key (kbd "C-c a") 'lsp-execute-code-action)    ; Fix-It
(global-set-key (kbd "C-c l r") 'lsp-rename)               ; Rename

(use-package lsp-ui
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-doc-enable t))

(use-package magit
  :bind ("C-x g" . magit-status))

(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("C-c p" . projectile-command-map)))

(use-package which-key
  :ensure t
  :init
  (which-key-mode))

(use-package ffap
  :ensure nil
  :config (ffap-bindings))

(use-package vertico
  :ensure t
  :init
  (vertico-mode))

(use-package erc
  :ensure nil
  :config
  (setq erc-nick "oak")
  (setq erc-autojoin-channels-alist '(( "#netbsd" "#netbsd-code"))))


(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-monokai-pro t)
  (doom-themes-visual-bell-config))
(custom-set-faces
 '(lsp-face-highlight-read ((t (:underline nil :background nil :foreground nil))))
 '(lsp-face-highlight-textual ((t (:underline nil :background nil :foreground nil))))
 '(lsp-face-highlight-write ((t (:underline nil :weight bold :background nil :foreground nil)))))

(use-package smart-mode-line
  :ensure t
  :init
  (setq sml/no-confirm-load-theme t)
  (setq sml/theme 'respectful)
  :config
  (setq sml/no-extra-features t)
  (sml/setup))

(unless (display-graphic-p)
  (setq-default custom-safe-themes t))

(defun my/transparent-background (&optional frame)
    "Make Background Transperent"
    (interactive)
    (unless (display-graphic-p frame)
      (set-face-background 'default "unspecified-bg" frame)
      (set-face-background 'line-number "unspecified-bg" frame)
      (set-face-background 'line-number-current-line "unspecified-bg" frame)
      (set-face-background 'fringe "unspecified-bg" frame)))
(add-hook 'window-setup-hook 'my/transparent-background)
(add-hook 'after-make-frame-functions 'my/transparent-background)
(my/transparent-background)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
