(require 'prelude-python)
(add-hook 'python-mode-hook 'blacken-mode)
;; TODO: disable python flycheck as it's creating temp files
