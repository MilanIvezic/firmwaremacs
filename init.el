;; disable startup message
(setq inhibit-startup-message t)

;; Disable tool bar, scroll bar etc.
;; You can always re-enable with M-x toggle-...
(tool-bar-mode -1)
(toggle-scroll-bar -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)

;; set font
(set-face-attribute 'default nil :font "Fira Code Retina" :height 120)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("da186cce19b5aed3f6a2316845583dbee76aea9255ea0da857d1c058ff003546" default))
 '(ivy-mode t)
 '(package-selected-packages
   '(which-key rainbow-delimiters doom-modeline counsel swiper ivy use-package doom-themes)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; add MELPA repository to the list of packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; check for any packages on PC
(unless package-archive-contents
  (package-refresh-contents))

;; Install use-package if not installed
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; install doom-themes and set the theme
(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (load-theme 'doom-molokai t)
  ;; flash mode line on errors
  (doom-themes-visual-bell-config))

;; swiper for isearch
(use-package swiper
  :ensure t)

;; install counsel
(use-package counsel
  :ensure t)

;; Use ivy completion package, diminish from modeline
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)))

;; use ivy mode, use virtual buffers when switching buffers
;; and opening files
(ivy-mode)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)

;; install doom-modeline for a minimalistic modeline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

;; install rainbow delimiters and hook them to prog-mode so every
;; programming mode uses rainbow-delimiters-mode
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; install which-key to describe which keys are available
;; when chaining keybinds
;; :init block executes ALWAYS before the package loads!
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))
