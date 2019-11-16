; WEB MODE
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
(defun my-web-mode-hook ()
  "Hooks for Web mode."
;  (setq web-mode-markup-indent-offset 2)
;  (setq web-mode-auto-quote-style 2)
;  (setq web-mode-content-types-alist '("jsx" . "\\.js[x]?\\'"))
)
;(add-hook 'web-mode-hook 'my-web-mode-hook)

; (setq web-mode-engines-alist '("jsx" . "\\.js[x]?\\'"))

; (setq web-mode-content-types-alist '(("jsx"  . "~/src/markers/.*\\.js[x]?\\'")))


(setq web-mode-content-types-alist '(("jsx"  . "\\.js[x]?\\'")))
(setq web-mode-enable-auto-quoting nil)
(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq web-mode-code-indent-offset 2)
(setq web-mode-script-padding 2)
(setq web-mode-attr-indent-offset 2)
(setq web-mode-script-padding 2)
(setq web-mode-style-padding 2)
(setq web-mode-block-padding 2)
