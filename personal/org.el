(require 'prelude-org)

(setq org-todo-keywords '((sequence "TODO(t)" "WAIT(w@/!)" "INPR(p)" "|" "DONE(d!)" "CANC(c@)")))

; (setq org-agenda-files '("~/Dropbox/org"))
(setq org-agenda-files (directory-files-recursively "~/org/markers" "\.org$"))

(setq org-capture-templates
      '(("t" "todo" entry (file+headline "~/Dropbox/org/agenda.org" "tasks")
         "* TODO [#A] %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n")
      ("m" "markers-todo" entry (file+headline "~/Dropbox/org/classifier/agenda.org" "backlog")
         "* TODO [#A] %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n")
      ("b" "bookmark" entry (file+headline "~/Dropbox/org/bookmarks.org" "bookmarks")
            "* %^{prompt}\nSAVED: %T\n%?")
      ; ("f" "Link from browser" entry (file "~/Org/inbox.org")
      ; "* TODO %? |- (%:description) :BOOKMARK:\n:PROPERTIES:\n:CREATED: %U\n:Source: %:link\n:END:\n%i\n" :clock-in t :clock-resume t)
      ;  )
      ))
(global-set-key (kbd "C-c c") 'org-capture)

(add-hook 'org-mode-hook '(lambda () (visual-line-mode)))
