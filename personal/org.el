(server-start)
(require 'org-protocol)
;; (require 'org-protocol-capture-html)

(global-set-key (kbd "C-c C-t") (lambda () (interactive) (find-file "~/org/agenda.org")))jk

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

(defun make-capture-frame (&optional capture-url)
  "Create a new frame and run org-capture."
  (interactive)
  (make-frame '((name . "capture")
                (width . 120)
                (height . 15)))
  (select-frame-by-name "capture")
  (setq word-wrap 1)
  (setq truncate-lines nil)
  (if capture-url (org-protocol-capture capture-url) (org-capture)))

(defun zin/org-tag-match-context (&optional todo-only match)
  "Identical search to `org-match-sparse-tree', but shows the content of the matches."
  (interactive "P")
  (org-agenda-prepare-buffers (list (current-buffer)))
  (org-overview)
  (org-remove-occur-highlights)
  (org-scan-tags '(progn (org-show-entry)
                         (org-show-context))
                 (cdr (org-make-tags-matcher match)) todo-only))

(add-hook 'org-mode-hook '(lambda ()
                            (visual-line-mode)
                            (set-fringe-mode 0)
                            (linum-mode 0)
                            ))
