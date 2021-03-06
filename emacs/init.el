;;; emacs init.el
;;; <synnomy@gmail.com>

;;; el-get settings

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; (package-initialize)
;; (setq package-archives
;;       '(("melpa" . "http://melpa.org/packages/")))

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
	(url-retrieve-synchronously
	  "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
	(goto-char (point-max))
	(eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)

;;; plugins installed with el-get
(el-get-bundle auto-complete)
(el-get-bundle cargo)
(el-get-bundle clojure-mode)
(el-get-bundle cider)
(el-get-bundle company-mode)
(el-get-bundle ac-cider)
(el-get-bundle diminish)
(el-get-bundle editorconfig)
(el-get-bundle emacs-helm/helm)
(el-get-bundle emacs-jp/helm-c-yasnippet)
(el-get-bundle emacs-racer)
(el-get-bundle sequential-command)
(el-get-bundle sequential-command-config)
(el-get-bundle web-mode)
(el-get-bundle smartparens)
(el-get-bundle rainbow-delimiters)
(el-get-bundle helm-projectile)
(el-get-bundle use-package)
(el-get-bundle yasnippet)
(el-get-bundle magit)
(el-get-bundle projectile)
(el-get-bundle rust-mode)
(el-get-bundle emacs-racer)
(el-get-bundle quickrun)
(el-get-bundle haskell-mode)
;; (el-get-bundle paredit)
(el-get-bundle clj-refactor)
(el-get-bundle aggressive-indent-mode)
(el-get-bundle python-mode)
(el-get-bundle jedi)
(el-get-bundle py-autopep8)

;;; theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'molokai t)

;;; window settings
(menu-bar-mode 0) ; hide menu bar
(set-window-margins nil 2) ; one character-sized left margin


;;; global settings
;; disable backup
(setq backup-inhibited t)
;; disable auto-save
(setq auto-save-default nil)
;; scrolling in terminal
(xterm-mouse-mode t)
;(mouse-wheel-mode t)
(global-set-key [mouse-4] '(lambda () (interactive) (scroll-down 1)))
(global-set-key [mouse-5] '(lambda () (interactive) (scroll-up 1)))

;;; paths
(setq edconf-exec-path "/usr/local/bin/editorconfig")

;;; global key config
(bind-key "C-h" 'backward-delete-char)
;; unset suspend button
(bind-key "C-z" nil)

;;; OS-specific settings
;; osx
(when (eq system-type 'darwin)
  (defun pbcopy ()
    (interactive)
    (let ((deactivate-mark t))
      (call-process-region (point) (mark) "pbcopy")))

  (defun pbpaste ()
    (interactive)
    (call-process-region (point) (if mark-active (mark) (point)) "pbpaste" t t))

  (defun pbcut ()
    (interactive)
    (pbcopy)
    (delete-region (region-beginning) (region-end))))

;;; editorconfig settings
(use-package editorconfig
  :init
  (add-hook 'prog-mode-hook (editorconfig-mode 1)))

;;; helm settings
(use-package helm-config
  :config
  :bind
  (("M-x" . helm-M-x)
   ("C-x C-f" . helm-find-files)
   ("C-x C-r" . helm-recentf)
   ("M-y" . helm-show-kill-ring)
   ("C-x C-b" . helm-buffers-list)))

(use-package helm-files
  :config
  (bind-keys :map helm-find-files-map
	     ("TAB" . helm-execute-persistent-action)))

(use-package helm-c-yasnippet
  :config
  (setq helm-yas-space-match-any-greedy t)
  :bind
  (("C-x C-y" . helm-yas-complete)))

(use-package helm-projectile
  :bind
  (("C-x C-p" . helm-projectile)))

;;; auto-complete settings
;;(ac-config-default)
(use-package auto-complete)

;;; company-mode settings
;; this mode is useful for clojure
(use-package company
  :config
  ;;(global-company-mode)
  (setq company-idle-delay 0.1
        company-minimum-prefix-length 2
        company-selection-wrap-around t
	company-tooltip-align-annotations t)

  (bind-keys :map company-mode-map
             ("C-i" . company-complete))
  (bind-keys :map company-active-map
             ("C-n" . company-select-next)
             ("C-p" . company-select-previous)
             ("C-s" . company-search-words-regexp))
  (bind-keys :map company-search-map
             ("C-n" . company-select-next)
             ("C-p" . company-select-previous)))

;;; yasnippet settings
(use-package yasnippet
  :init
  (bind-keys :map yas-minor-mode-map
	     ("<tab>" . nil)
	     ("TAB" . nil)
	     ("C-i" . yas-expand))
  :config
  (setq yas-snippet-dirs
	'("~/.emacs.d/yasnippet-snippets"
	  "~/.emacs.d/snippets"))
  (yas-global-mode t))

;;; smartparens
(use-package smartparens-config)

;;; emacs-lisp-mode settings
(use-package emacs-lisp-mode
  :mode (("\\.el\\'" . emacs-lisp-mode))
  :init
  (bind-keys :map emacs-lisp-mode-map
	     ("C-h" . paredit-backward-delete))
  (add-hook 'emacs-lisp-mode-hook #'yas-minor-mode)
  (add-hook 'emacs-lisp-mode-hook #'subword-mode)
  (add-hook 'emacs-lisp-mode-hook #'eldoc-mode)
  (add-hook 'emacs-lisp-mode-hook #'auto-complete-mode)
  (add-hook 'emacs-lisp-mode-hook #'show-paren-mode)
  ;; (add-hook 'emacs-lisp-mode-hook #'paredit-mode)
  (add-hook 'emacs-lisp-mode-hook #'smartparens-strict-mode)
  :config
  (setq indent-tabs-mode nil))

;;; rust-mode settings
(use-package rust-mode
  :mode (("\\.rs\\'" . rust-mode))
  :init
  (setq racer-rust-src-path
	"~/.multirust/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src/")
  ;; (bind-keys :map rust-mode-map
  ;; 	     ("TAB" . company-indent-or-complete-common))
  (add-hook 'rust-mode-hook #'racer-mode)
  (add-hook 'rust-mode-hook #'cargo-minor-mode)
  (add-hook 'racer-mode-hook #'eldoc-mode)
  (add-hook 'racer-mode-hook #'company-mode))

;;; clojure-mode settings
(use-package clojure-mode
  :mode (("\\.clj\\'" . clojure-mode))
  :init
  (add-hook 'clojure-mode-hook #'yas-minor-mode)
  (add-hook 'clojure-mode-hook #'subword-mode)
  (add-hook 'clojure-mode-hook #'show-paren-mode)
  (add-hook 'clojure-mode-hook #'smartparens-strict-mode)
  (add-hook 'clojure-mode-hook #'auto-complete-mode)
  ;; (add-hook 'clojure-mode-hook #'company-mode)
  ;; (add-hook 'clojure-mode-hook #'paredit-mode)
  :config
  (bind-keys :map clojure-mode-map
	     ("C-h" . paredit-backward-delete)))

;;; clojurescript-mode
(use-package clojurescript-mode
  :mode (("\\.cljs\\'" . clojurescript-mode))
  :init
  (add-hook 'clojurescript-mode-hook #'subword-mode)
  (add-hook 'clojurescript-mode-hook #'show-paren-mode)
  (add-hook 'clojurescript-mode-hook #'smartparens-mode)
  (add-hook 'clojurescript-mode-hook #'auto-complete-mode))

;;; clj-refactor
(use-package clj-refactor)

;;; cider settings (clojure)
(use-package cider
  :init
  (add-hook 'cider-mode-hook #'clj-refactor-mode)
  (add-hook 'cider-mode-hook #'auto-complete-mode)
  (add-hook 'cider-mode-hook #'paredit-mode)
  
  :config
  (setq nrepl-log-messages t
	cider-repl-display-in-current-window t
	cider-prompt-save-file-on-load 'always-save
	cider-font-lock-dynamically '(macro core function var)
	cider-overlays-use-font-lock t)
  (setq cider-cljs-lein-repl
	"(do (require 'figwheel-sidecar.repl-api)
             (figwheel-sidecar.repl-api/start-figwheel!)
             (figwheel-sidecar.repl-api/cljs-repl))")
  (cider-repl-toggle-pretty-printing)

  ;; play-clj
  (defun play-clj-reload ()
    (interactive)
    (cider-interactive-eval
     "(on-gl (set-screen! hello-world-game main-screen))"))
  )

;;; ac-cider settings (clojure)
(use-package ac-cider
  :init
  (add-hook 'cider-mode-hook 'ac-flyspell-workaround)
  (add-hook 'cider-mode-hook 'ac-cider-setup)
  (add-hook 'cider-repl-mode-hook 'ac-cider-setup))



(use-package python-mode
  :mode (("\\.py\\'" . python-mode))
  :init
  (defun python-shell-parse-command ()
    "Return the string used to execute the inferior Python"
    "python3 -i")
  (add-hook 'python-mode-hook #'jedi-mode)
  ;; jedi
  (setq jedi:complete-on-dot t)
  ;; py-autopep8
)


;;; smartparens settings
;; (use-package smartparens-config
;;   :init
;;   (add-hook 'clojure-mode-hook #'smartparens-mode)
;;   (add-hook 'emacs-lisp-mode-hook #'smartparens-mode))

;;; rainbow-delimiters settings
;; (use-package rainbow-delimiters
;;   :init
;;   (add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
;;   (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode))

;;; sequential-command settings
;; C-a(home), C-e(end), M-u(upcase), M-c(Capitalize), M-l(downcase)
(use-package sequential-command-config
  :config
  (sequential-command-setup-keys))

(use-package web-mode
  :mode (("\\.html\\'" . web-mode))
  :config
  (setq web-mode-enable-auto-closing t)
  (setq web-mode-enable-auto-pairing t)
  (setq web-mode-auto-close-style 2)
  (setq web-mode-tag-auto-close-style 2))

;;; mode-line settings
(use-package diminish
  :config
  (diminish 'yas-minor-mode "Yas")
  (diminish 'editorconfig-mode "EConf")
  (diminish 'eldoc-mode "ElDoc"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("9317fb3650f91e0f62021a58530b3af5445b9ee15bf9678ca82fb0b893cb2cab" "0677967bc5ea64ef49f25470962d87c1abaf1668472a5c76d8d170400b336085" "8a9c4d2a2f8ecd8e5e3e9e903d1344e4577a0b7de72d7091e73bd114b5da132d" "c3c0a3702e1d6c0373a0f6a557788dfd49ec9e66e753fb24493579859c8e95ab" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
