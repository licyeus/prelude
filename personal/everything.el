;; TODO
;; auto install packages with (prelude-require-packages '(some-package some-other-package))
;; auto install helm + conda

(setq prelude-flyspell nil)

;; fix tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq-default js2-basic-offset 2)
(setq javascript-indent-level 2)
(setq js-indent-level 2)
(setq typescript-indent-level 2)
(setq ts-indent-level 2)
;(setq indent-line-function 'insert-tab)
(setq-default js-expr-indent-offset (- js-indent-level))
(setq-default
  css-indent-offset 2
  web-mode-markup-indent-offset 2
  web-mode-css-indent-offset 2
  web-mode-code-indent-offset 2
  web-mode-attr-indent-offset 2)

(setq-default truncate-lines t)

(add-to-list 'auto-mode-alist '("\\.js$" . rjsx-mode))
(setq js2-mode-show-parse-errors nil)
(setq js2-mode-show-strict-warnings nil)
;(setq js2-mode-hook
;  '(lambda () (progn
;    (set-variable 'toggle-truncate-lines nil))))

(require 'prelude-evil)
(global-set-key (kbd "C-u") 'evil-scroll-up)

(require 'helm-config)
(helm-mode 1)
(require 'prelude-helm-everywhere)

(require 'prelude-org)
(require 'prelude-python)

(scroll-bar-mode -1)
(global-linum-mode t)

(setq default-frame-alist '((font . "Inconsolata XL-11")))

(require 'conda)
(conda-env-initialize-eshell)
(conda-env-autoactivate-mode t)

;; TODO: disable line truncating: toggle-truncate-lines disable

(setq comint-output-filter-functions (remove 'ansi-color-process-output comint-output-filter-functions))
(add-hook 'shell-mode-hook (lambda () (add-hook 'comint-preoutput-filter-functions 'xterm-color-filter nil t)))

;; enable color in eshell for non-eshell commands
(require 'eshell)
(add-hook 'eshell-before-prompt-hook (lambda () (setq xterm-color-preserve-properties t)))
(add-to-list 'eshell-preoutput-filter-functions 'xterm-color-filter)
(setq eshell-output-filter-functions (remove 'eshell-handle-ansi-color eshell-output-filter-functions))
(add-hook 'eshell-mode-hook (lambda () (progn (setenv "TERM" "xterm-256color") (linum-mode 0))))

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
    (insert "clear")
    (eshell-send-input)
    (insert command)
    (eshell-send-input)
    (end-of-buffer)
    (switch-to-buffer-other-window buf)))

(global-set-key (kbd "C-#") (lambda ()
  (interactive)
  (progn

    (run-in-eshell "/Users/aps/anaconda3/envs/pytest_test/bin/pytest")
  )
))

(setq org-todo-keywords '((sequence "TODO(t)" "WAIT(w@/!)" "INPR(p)" "|" "DONE(d!)" "CANC(c@)")))
;; TODO: disable python flycheck as it's creating temp files

(setq ns-use-native-fullscreen nil)

(setq whitespace-line-column 120)

(setq shr-use-fonts nil)
(setq shr-inhibit-images t)
(setq elfeed-show-mode-hook
      '(lambda () (progn
                    (auto-fill-mode))))
    ; (split-window-right)
    ; (disable-theme 'zenburn)
    ; (load-theme 'whiteboard)
    ; (set-variable 'line-spacing 14))))
(setq-default fill-column 100)

(use-package elfeed-org
  :ensure t
  :config
  (elfeed-org)
  (setq rmh-elfeed-org-files (list "/home/aps/Dropbox/org/elfeed.org")))

;; (use-package elfeed
;;   :ensure t
;;   :bind (:map elfeed-search-mode-map
;;               ("A" . bjm/elfeed-show-all)
;;               ("E" . bjm/elfeed-show-emacs)
;;               ("D" . bjm/elfeed-show-daily)
;;               ("q" . bjm/elfeed-save-db-and-bury)))
(evil-set-initial-state 'elfeed-search-mode 'emacs)
(evil-set-initial-state 'elfeed-show-mode 'emacs)

(setq elfeed-search-title-max-width 100)

(global-set-key (kbd "C-c C-r") 'elfeed)
(global-set-key (kbd "C-c g") 'comment-region)
(global-set-key (kbd "C-c C-t") (lambda () (interactive) (find-file "/home/aps/Dropbox/org/home/agenda.org")))

(setq org-startup-indented t)

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "chromium-browser")

(global-set-key (kbd "C-c C-c") 'shell-pop)
(use-package shell-pop
  :bind (("C-t" . shell-pop))
  :config
  (setq shell-pop-shell-type (quote ("multi-term" "*multi-term*" (lambda nil (ansi-term shell-pop-term-shell)))))
  (setq shell-pop-term-shell "/bin/zsh")
  ;; need to do this manually or not picked up by `shell-pop'
  (shell-pop--set-shell-type 'shell-pop-shell-type shell-pop-shell-type))

(setq org-agenda-files (list
                        "~/Dropbox/org/agenda.org"
                        "~/Dropbox/org/classifier/agenda.org"))
(setq org-capture-templates
      '(("t" "todo" entry (file+headline "~/Dropbox/org/agenda.org" "tasks")
         "* TODO [#A] %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n")
      ("m" "markers-todo" entry (file+headline "~/Dropbox/org/classifier/agenda.org" "backlog")
         "* TODO [#A] %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n")
        )
;      '(("b" "bookmark" entry (file+headline "~/Dropbox/org/bookmarks.org")
;         "* %?\nSAVED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n"))
      )
(global-set-key (kbd "C-c c") 'org-capture)

(add-hook 'python-mode-hook 'blacken-mode)
(custom-set-variables '(helm-ag-base-command "rg --no-heading"))

(global-unset-key (kbd "C-c C-f"))
(global-set-key (kbd "C-c C-f") 'helm-ag-project-root)
