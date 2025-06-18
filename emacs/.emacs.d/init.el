(require 'package)
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(dolist (pkg '(use-package))
  (unless (package-installed-p pkg)
    (package-install pkg)))

(require 'use-package)
(setq use-package-always-ensure t)

(setq inhibit-startup-message t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode t)

(setq backup-directory-alist `(("." . "~/.emacs-saves")))
(setq auto-save-file-name-transforms `((".*" "~/.emacs-saves/" t)))


(use-package dracula-theme
  :config
  (load-theme 'dracula t))

(use-package all-the-icons
  :if (display-graphic-p))


(set-frame-font "JetBrains Mono 12" t t)
(set-fontset-font t 'symbol (font-spec :family "Segoe UI Emoji") nil 'prepend)
(set-fontset-font t 'emoji (font-spec :family "Segoe UI Emoji") nil 'prepend)


(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode))

(set-frame-parameter (selected-frame) 'alpha '(90 . 90)) 
(add-to-list 'default-frame-alist '(alpha . (90 . 90)))




(use-package lsp-mode
  :hook ((c-mode c++-mode) . lsp)
  :commands lsp
  :config
  (setq lsp-rust-analyzer-server-command '("rustup" "run" "stable" "rust-analyzer")))



(use-package dap-mode
  :after lsp-mode
  :config
  (dap-auto-configure-mode)
  (require 'dap-lldb)   ;; CodeLLDB için
  ;; (require 'dap-gdb-lldb) ;; GDB için (isteğe bağlı)
)

(use-package company
  :config (global-company-mode))

(use-package flycheck
  :init (global-flycheck-mode))

(use-package clang-format)

;; Apply clang-format
(defun my-c-format-on-save ()
  (when (derived-mode-p 'c-mode 'c++-mode)
    (clang-format-buffer)))

(add-hook 'before-save-hook 'my-c-format-on-save)


(use-package gdb-mi)

(use-package magit)



(use-package which-key
  :init (which-key-mode))


;; LSP for C/C++ 
(setq lsp-clients-clangd-executable "clangd")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files nil)
 '(package-selected-packages
   '(cargo rust-mode cmake-project cmake-mode org-superstar blacken elpy evil-collection evil which-key magit clang-format flycheck lsp-ui lsp-mode company)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;;(use-package evil
;;  :init
;;  (setq evil-want-integration t)
;;  (setq evil-want-keybinding nil) ;; evil-collection kullanacaksan bu gerekli
;;  :config
;;  (evil-mode 1))

;;(use-package evil-collection
;;  :after evil
;;  :config
;;  (evil-collection-init))

(use-package projectile
  :ensure t
  :config
  (projectile-mode +1))

(unless (package-installed-p 'elpy)
  (package-install 'elpy))

(elpy-enable)

;; Flycheck 
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules)) ; Flymake close
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; Black code formating
(unless (package-installed-p 'blacken)
  (package-install 'blacken))

(add-hook 'elpy-mode-hook 'blacken-mode)



(use-package projectile
  :ensure t
  :diminish projectile-mode
  :config
  (projectile-mode 1)
  ;; Proje yolu vermiyoruz
  ;; (setq projectile-project-search-path '("~/code"))
  (setq projectile-completion-system 'auto)
  :bind-keymap
  ("C-c p" . projectile-command-map))

(use-package org
  :ensure t
  :config
  (setq org-startup-indented t)  
  (setq org-hide-leading-stars t) 
  (setq org-log-done 'time)      
)

(use-package org-superstar
  :hook (org-mode . org-superstar-mode))

;; symbols
(setq org-superstar-headline-bullets-list '("◉" "○" "●" "○" "●" "○" "●"))

(with-eval-after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t))))

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner 'logo) ;; official logo
  (setq dashboard-center-content t)
  (setq dashboard-items '((recents  . 5)
                          (projects . 5)
                          (bookmarks . 5)
                          (agenda . 5))))

(use-package cmake-mode
  :ensure t
  :mode ("CMakeLists\\.txt\\'" "\\.cmake\\'")
  )
(use-package cmake-project
  :ensure t)


(use-package rust-mode
  :ensure t
  :hook ((rust-mode . lsp)
         (rust-mode . (lambda ()
                        (setq-default indent-tabs-mode nil)
                        (setq rust-format-on-save t))))
  :config
  (setq rust-format-on-save t))

(use-package cargo
  :hook (rust-mode . cargo-minor-mode))


(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

;;_______________________


(defun my/dap-debug-ask-program ()
  (interactive)
  (let ((program (read-file-name "Debug executable: " nil nil t nil #'file-exists-p))
        (cwd default-directory)
        (args (read-string "Program args (space separated): ")))
    (dap-debug
     (list :type "lldb"
           :request "launch"
           :name "LLDB::Run"
           :program program
           :cwd cwd
           :stopOnEntry t
           :args (if (string-empty-p args) nil (split-string args))))))

(use-package dap-mode
  :ensure t
  :after lsp-mode
  :config
  (dap-auto-configure-mode)
  ;; C/C++ için LLDB
  (require 'dap-lldb)
  (setq dap-lldb-debug-program '("C:/Users/Lenovo/.vscode/extensions/vadimcn.vscode-lldb-1.11.4/adapter/codelldb.exe"))
  (require 'dap-ui)
  (dap-ui-mode 1)

  ;; keybindings
  (define-key dap-mode-map (kbd "<f5>") #'my/dap-debug-ask-program)
  (define-key dap-mode-map (kbd "<f6>") 'dap-continue)
  (define-key dap-mode-map (kbd "<f9>") 'dap-breakpoint-toggle)
  (define-key dap-mode-map (kbd "<f10>") 'dap-next)
  (define-key dap-mode-map (kbd "<f11>") 'dap-step-in)
)

(add-hook 'dap-stopped-hook #'(lambda (_) (dap-ui-show-many-windows t)))
