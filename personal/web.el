(use-package tide)

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
;; (add-hook 'before-save-hook 'tide-format-before-save)

;; (add-hook 'typescript-mode-hook #'setup-tide-mode)

;; fix tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq-default js2-basic-offset 2)
(setq javascript-indent-level 2)
(setq js-indent-level 2)
(setq typescript-indent-level 2)
(setq ts-indent-level 2)

; (setq indent-line-function 'insert-tab)
; (setq-default js-expr-indent-offset (- js-indent-level))
(setq-default
  css-indent-offset 2
  web-mode-markup-indent-offset 2
  web-mode-css-indent-offset 2
  web-mode-code-indent-offset 2
  web-mode-script-padding 2
  web-mode-attr-indent-offset 2
  web-mode-enable-css-colorization t
  web-mode-enable-auto-quoting nil)

(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
; (add-to-list 'auto-mode-alist '("\\.(js|jsx|ts|tsx)\\'" . web-mode))

(setq standard-indent 2)

(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq evil-shift-width 2)
  (setup-tide-mode)
  )
(add-hook 'web-mode-hook  'my-web-mode-hook)


; (add-to-list 'auto-mode-alist '("\\.(jsx|tsx)$" . rjsx-mode))
; (setq js2-mode-show-parse-errors nil)
; (setq js2-mode-show-strict-warnings nil)

(setq-default truncate-lines t)

;(setq js2-mode-hook
;  '(lambda () (progn
;    (set-variable 'toggle-truncate-lines nil))))
