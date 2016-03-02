(require 'package)
(push '("marmalade" . "http://marmalade-repo.org/packages/")
  package-archives )
(push '("melpa" . "http://melpa.org/packages/")
  package-archives)
(push '("gnu" . "http://elpa.gnu.org/packages/")
  package-archives)
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

(use-package rainbow-mode
    :ensure t)

(use-package ace-jump-mode
    :ensure t)

(use-package org
    :ensure t
    :config (progn
        (setq org-log-done 'time)
        (define-key global-map "\C-ca" 'org-agenda)
        (setq org-agenda-files (list "~/.org/work"
                                     "~/.org/school" 
                                     "~/.org/home"
                                     "~/.org/personal"))))

(use-package alchemist
    :ensure t
    :init (add-hook 'alchemist-mode-hook #'company-mode))

(use-package js2-mode
    :ensure t)

(use-package company-jedi
    :ensure t
    :init (add-hook 'python-mode-hook #'company-mode))

(use-package json-mode
    :ensure t)

(use-package scss-mode
    :ensure t)

(use-package purescript-mode
    :ensure t
    :init (add-hook 'purescript-mode-hook 'turn-on-purescript-indentation))

(use-package neotree
    :ensure t)

(use-package idris-mode
    :ensure t)

(global-set-key [f8] 'neotree-toggle)


(use-package evil-leader
  :ensure t
  :init (global-evil-leader-mode)
  :config (evil-leader/set-leader "SPC"))

;; remove all keybindings from insert-state keymap
(setcdr evil-insert-state-map nil)
;; but [escape] should switch back to normal state
(define-key evil-insert-state-map [escape] 'evil-normal-state)

(defun set-in-all-evil-states (key def &optional maps)
  (unless maps
    (setq maps (list evil-normal-state-map
                     evil-visual-state-map
                     evil-insert-state-map
                     evil-emacs-state-map
                     evil-motion-state-map)))
  (while maps
    (define-key (pop maps) key def)))

(defun set-in-all-evil-states-but-insert (key def)
  (set-in-all-evil-states key def (list evil-normal-state-map
                                        evil-visual-state-map
                                        evil-emacs-state-map
                                        evil-motion-state-map)))


(use-package evil
  :ensure t
  :init (evil-mode 1)
  :config (progn
    (define-key evil-normal-state-map (kbd "w") #'evil-ace-jump-word-mode)
    (define-key evil-normal-state-map (kbd ";") #'evil-ex)
    (define-key evil-normal-state-map (kbd "j") #'evil-insert-state)
    (evil-leader/set-key "g" #'magit-status)
    (evil-set-initial-state 'magit-popup-mode 'emacs)
    (evil-set-initial-state 'magit-blame-mode 'emacs)
    (define-key evil-normal-state-map (kbd "g") #'evil-ace-jump-char-mode)
    (set-in-all-evil-states-but-insert "n" 'evil-previous-line)
    (set-in-all-evil-states-but-insert "e" 'evil-next-line)
    (set-in-all-evil-states-but-insert "h" 'evil-backward-char)
    (define-key evil-normal-state-map "i" 'evil-forward-char)
    (define-key evil-visual-state-map "i" 'evil-forward-char)

    ;;; Turbo navigation mode
    (set-in-all-evil-states-but-insert "I" '(lambda () (interactive) (evil-forward-char 5)))
    (set-in-all-evil-states-but-insert "H" '(lambda () (interactive) (evil-backward-char 5)))
    (set-in-all-evil-states-but-insert "E" '(lambda () (interactive) (evil-next-line 5)))
    (set-in-all-evil-states-but-insert "N" '(lambda () (interactive) (evil-previous-line 5)))))

(use-package jade-mode
  :ensure t)

(use-package stylus-mode
  :ensure t)

(use-package flymake
  :ensure t)

(use-package virtualenvwrapper
  :ensure t
  :init (setq venv-location "~/envs"))

(use-package extempore-mode
  :ensure t)

(use-package projectile
  :ensure t
  :init (projectile-global-mode)
  :config (progn
    (setq projectile-tags-file-name ".etags")
    (evil-leader/set-key "]" #'projectile-find-tag)
    (evil-leader/set-key "p" #'projectile-find-file)))

(use-package magit
  :ensure t
  :config (progn
    (setq magit-push-always-verify nil)))

(add-hook 'haskell-mode-hook 'haskell-indentation-mode)
(use-package haskell-mode
   :ensure t
   :config (progn
     (setq haskell-indentation-layout-offset 4)
     (setq haskell-indentation-starter-offset 4)
     (setq haskell-indentation-left-offset 4)
     (setq haskell-indentation-ifte-offset 4)
     (setq haskell-indentation-where-pre-offset 4)
     (setq haskell-indentation-where-post-offset 4)))


(unless (getenv "RUST_SRC_PATH")
        (setenv "RUST_SRC_PATH" (expand-file-name "~/builds/rust/rustc-1.3.0/src")))

(add-hook 'rust-mode-hook #'company-mode)
(setq company-tooltip-align-annotations t)

(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'rust-mode-hook #'eldoc-mode)

(use-package racer)

(use-package company
  :ensure t
  :config (progn
    (global-set-key (kbd "TAB") #'company-indent-or-complete-common)))

(use-package company-racer)

(with-eval-after-load 'company
  (add-to-list 'company-backends 'company-racer))

(use-package rust-mode
  :ensure t)

(use-package jsx-mode
  :ensure t)


(setq-default show-paren-delay 0)
(show-paren-mode +1)

(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)


(setq-default make-backup-files nil)
(setq auto-save-default nil)

(global-linum-mode +1)
(setq-default linum-format "%4d ")

(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(blink-cursor-mode -1)
(setq-default inhibit-startup-screen t)


(defun revert-all-buffers ()
  "Refreshes all open buffers from their respective files."
  (interactive)
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      (when (and (buffer-file-name) (file-exists-p (buffer-file-name)) (not (buffer-modified-p)))
        (revert-buffer t t t) )))
  (message "Refreshed open files.") )

(setq backup-directory-alist
  `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
  `((".*" ,temporary-file-directory t)))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (adwaita)))
 '(safe-local-variable-values
   (quote
    ((haskell-process-use-ghci . t)
     (haskell-indent-spaces . 4)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (if (equal web-mode-content-type "javascript")
              (web-mode-set-content-type "jsx")
              (message "now set to: %s" web-mode-content-type))))

(setq web-mode-enable-auto-closing t)
(setq web-mode-enable-auto-pairing t)
(electric-pair-mode 1)

(set-default-font "Source Code Pro")

(load "~/.emacs.d/emacs-fireplace/fireplace")

(defun my/python-mode-hook ()
    (add-to-list 'company-backends 'company-jedi))

(add-hook 'python-mode-hook 'my/python-mode-hook)
