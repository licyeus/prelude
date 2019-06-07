(global-set-key (kbd "C-c C-t") (lambda () (interactive) (find-file "~/org/agenda.org")))

(setq org-agenda-files `("~/org"))
(setq org-agenda-files (directory-files-recursively "~/org/" "\\.org$"))

(setq org-capture-templates
      '(("t" "todo" entry (file+headline "~/Dropbox/org/agenda.org" "tasks")
         "* TODO [#A] %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n")
      ("m" "markers-todo" entry (file+headline "~/Dropbox/org/projects/markers/agenda.org" "backlog")
         "* TODO [#A] %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n")
        )
;      '(("b" "bookmark" entry (file+headline "~/Dropbox/org/bookmarks.org")
;         "* %?\nSAVED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n"))
      )
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
