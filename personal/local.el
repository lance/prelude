;; add our lib dir to the load path
(setq personal-lib-dir (concat prelude-personal-dir "/lib/"))
(add-to-list 'load-path personal-lib-dir)

;; setup and use the same path as fish
(let ((path (split-string (shell-command-to-string "/usr/local/bin/fish -c 'echo -n $PATH'") " ")))
  (setenv "PATH" (mapconcat 'identity path ":"))
  (setq exec-path (append exec-path path)))

;; but use bash for executing commands, since fish doesn't like the
;; syntax emacs gives `find`
(setq shell-file-name "/bin/bash")

;; get rid of ui cruft
(menu-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)


;; reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 50000000)

;; use the modeline to indicate the bell instead of sound or a big
;; black block in the middle of the screen (wtf wants that?)
(setq visible-bell t)
(load "echo-area-bell")

;; always show column number in the mode line
(column-number-mode t)

;; everytime a bookmark is added, save the file
(setq bookmark-save-flag 0)

;; prefer utf8
(set-terminal-coding-system 'utf-8)
;;(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; start with an empty scratch buffer
(setq initial-scratch-message nil
      inhibit-startup-message t)

;; Put autosave files (ie #foo#) and backup files (ie foo~) in ~/.emacs.d/.
(custom-set-variables
 '(auto-save-file-name-transforms '((".*" "~/.emacs.d/autosaves/\\1" t)))
 '(backup-directory-alist '((".*" . "~/.emacs.d/backups/"))))

;; don't create lock files (emacs 24.3 and up)
(setq create-lockfiles nil)

;; save my place in visited files
(require 'saveplace)
(setq save-place-file (concat user-emacs-directory "places"))
(set-default 'save-place t)

;; Allow y for yes - I type enough as it is
(defalias 'yes-or-no-p 'y-or-n-p)

;; auto-revert any open buffers if they change on disk, and do the
;; same for dired. In both cases, don't tell me every time
(global-auto-revert-mode t)
(setq global-auto-revert-non-file-buffers t
      auto-revert-verbose                 nil)

;; please don't insert tabs
(set-default 'indent-tabs-mode nil)

;; clean up whitespace before saving
(add-hook 'before-save-hook 'whitespace-cleanup)
;;(setq before-save-hook nil)

;; show as much decoration as possible
(setq font-lock-maximum-decoration t)

;; allow typing to replace the selected region
(delete-selection-mode t)

;; kill entire line (including \n)
(setq kill-whole-line t)

;; always show empty lines at end of buffer
(set-default 'indicate-empty-lines t)

;; Fixes "ls does not support --dired; see `dired-use-ls-dired' for
;; more details." on MacOS w/Homebrew
(let ((gls "/usr/local/bin/gls"))
  (when (file-exists-p gls)
    (setq insert-directory-program gls)))

;; alter the font size for the current buffer
(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)

;; remember window configurations - walk through them with C-c left,
;; C-c right
(winner-mode 1)

;; always pair, electrically
(electric-pair-mode)

;; add the system clipboard to the kill ring
(setq save-interprogram-paste-before-kill t)

;; indent after return
(define-key global-map (kbd "RET") 'newline-and-indent)
