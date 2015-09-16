(require 'package)
(push '("marmalade" . "http://marmalade-repo.org/packages/")
    package-archives )
(push '("melpa" . "http://melpa.milkbox.net/packages/")
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

(use-package js2-mode
    :ensure t)

(use-package json-mode
    :ensure t)

(use-package evil-leader
  :ensure t
  :init (global-evil-leader-mode)
  :config (evil-leader/set-leader "SPC"))

(use-package evil
  :ensure t
  :init (evil-mode 1)
  :config (progn
    (define-key evil-normal-state-map (kbd "w") #'evil-ace-jump-word-mode)
    (define-key evil-normal-state-map (kbd ";") #'evil-ex)
    (evil-leader/set-key "g" #'magit-status)
    (evil-set-initial-state 'magit-popup-mode 'emacs)
    (evil-set-initial-state 'magit-blame-mode 'emacs)
    (define-key evil-normal-state-map (kbd "h") #'evil-ace-jump-char-mode)))

(use-package jade-mode
  :ensure t)

(use-package stylus-mode
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

(setq-default show-paren-delay 0)
(show-paren-mode +1)

(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)


(setq-default make-backup-files nil)

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
