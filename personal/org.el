(server-start)
(require 'org-protocol)
;; (require 'org-protocol-capture-html)

(require 'prelude-org)

(setq org-todo-keywords '((sequence "TODO(t)" "WAIT(w@/!)" "INPR(p)" "|" "DONE(d!)" "CANC(c@)")))

; (setq org-agenda-files '("~/org/agenda.org"))
(setq org-agenda-files (directory-files-recursively "~/org/" "\.org$"))

(setq org-capture-templates
      '(("t" "todo" entry (file+headline "~/org/agenda.org" "buffer")
         "* TODO %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n")
      ("m" "markers-todo" entry (file+headline "~/org/classifier/agenda.org" "backlog")
         "* TODO %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n")
      ("b" "bookmark" entry (file+headline "~/org/bookmarks.org" "bookmarks")
            "* %^{prompt}\nSAVED: %T\n%?")
      ("w" "Web site" entry (file+headline "~/org/agenda.org" "buffer")
       "** %:description\n%:link\n%U\n#+BEGIN_QUOTE\n%:initial\n#+END_QUOTE%?")
      ("v" "Web site (without quote)" entry (file+headline "~/org/agenda.org" "buffer")
       "** %:description\n%:link\n%U\n%?")

      ;; reviews
      ("1" "Review (daily)" entry (file+headline "~/org/review.org" "daily")
        (file "~/org/_templates/daily.org"))
      ("2" "Review (weekly)" entry (file+headline "~/org/review.org" "weekly")
        (file "~/org/_templates/weekly.org"))
      ))
(global-set-key (kbd "C-c c") 'org-capture)

(add-hook 'org-mode-hook '(lambda ()
                            (visual-line-mode)
                            (set-fringe-mode 0)
                            (linum-mode 0)
                            ))
