;; TODO
;; auto install packages with (prelude-require-packages '(some-package some-other-package))
;; auto install helm + conda
;; auto install key-chord

(setq prelude-flyspell nil)

(require 'prelude-evil)
(global-set-key (kbd "C-u") 'evil-scroll-up)

(require 'helm-config)
(helm-mode 1)
(require 'prelude-helm-everywhere)

(scroll-bar-mode -1)
(global-linum-mode t)

(setq default-frame-alist '((font . "Inconsolata XL-12")))

(require 'conda)
(conda-env-initialize-eshell)
(conda-env-autoactivate-mode t)

;; TODO: disable line truncating: toggle-truncate-lines disable

(setq comint-output-filter-functions (remove 'ansi-color-process-output comint-output-filter-functions))
; (add-hook 'shell-mode-hook (lambda () (add-hook 'comint-preoutput-filter-functions 'xterm-color-filter nil t)))

;; enable color in eshell for non-eshell commands
; (require 'eshell)
; (add-hook 'eshell-before-prompt-hook (lambda () (setq xterm-color-preserve-properties t)))
; (add-to-list 'eshell-preoutput-filter-functions 'xterm-color-filter)
; (setq eshell-output-filter-functions (remove 'eshell-handle-ansi-color eshell-output-filter-functions))
; (add-hook 'eshell-mode-hook (lambda () (progn (setenv "TERM" "xterm-256color") (linum-mode 0))))

(get-buffer eshell-buffer-name)

(defun run-in-eshell (command)
  "Insert COMMAND in eshell and execute."
  (interactive)
  (require 'eshell)
  (let ((buf (current-buffer)))
    (unless (get-buffer eshell-buffer-name) (eshell))
    (display-buffer eshell-buffer-name t)
    (switch-to-buffer-other-window eshell-buffer-name)
    (end-of-buffer)
    ;; TODO: clear buffer
    (eshell-kill-input)
    ;; (insert "clear")
    (eshell-send-input)
    (insert command)
    (eshell-send-input)
    (end-of-buffer)
    (switch-to-buffer-other-window buf)))

(global-set-key (kbd "C-c 3") (lambda ()
  (interactive)
  (progn
    (run-in-eshell "psql -U markers_admin -d markers_prod -f ../reset.sql && node index")                  ;
  )
))

(setq ns-use-native-fullscreen nil)
(global-set-key (kbd "M-f") 'toggle-frame-fullscreen)

(setq whitespace-line-column 88)

;; old elfeed config
(setq shr-use-fonts nil)
(setq shr-inhibit-images t)
(setq-default fill-column 100)

(global-set-key (kbd "C-c g") 'comment-region)

(setq org-startup-indented t)

; (setq browse-url-browser-function 'browse-url-generic browse-url-generic-program "chromium-browser")

(global-set-key (kbd "C-c C-c") 'shell-pop)
(use-package shell-pop
  :bind (("C-t" . shell-pop))
  :config
  (setq shell-pop-shell-type (quote ("multi-term" "*multi-term*" (lambda nil (ansi-term shell-pop-term-shell)))))
  (setq shell-pop-term-shell "/bin/zsh")
  ;; need to do this manually or not picked up by `shell-pop'
  (shell-pop--set-shell-type 'shell-pop-shell-type shell-pop-shell-type))

(custom-set-variables '(helm-ag-base-command "rg --no-heading"))

(global-unset-key (kbd "C-c C-f"))
(global-set-key (kbd "C-c C-f") 'helm-ag-project-root)

(key-chord-mode 1)
(setq key-chord-two-keys-delay 0.1)
(setq key-chord-one-key-delay 0.4)
(key-chord-define evil-insert-state-map "jj" 'evil-normal-state)

;; (use-package graphql-mode)

(disable-theme 'zenburn)
;; (load-theme 'sanityinc-tomorrow-night)
(load-theme 'sanityinc-solarized-light)

;; disable highlighting of long lines (line-trail is default)
(setq whitespace-style '(face tabs empty trailing))

;; disable evil mode in magit
;; (eval-after-load 'evil-core '(evil-set-initial-state 'magit-popup-mode 'emacs))

(require 'evil-magit)
