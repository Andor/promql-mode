(require 'eldoc)
(require 'promql-mode-words)

(defun promql-eldoc--get-function-arguments (f)
  (gethash f promql-mode--functions))

(defun promql-eldoc--get-symbol-info (symbol)
  (let ((info (gethash symbol promql-mode--functions)))
    info))

(defun promql-eldoc--get-promql-symbol-string ()
  (save-excursion
    (let (start)
      (skip-chars-backward "[:word:]_")
      (setq start (point))
      (skip-chars-forward "[:word:]_")
      (unless (= start (point))
        (buffer-substring-no-properties start (point))))))

(defun promql-eldoc--propertize-cursor-thing (symbol)
  symbol)

(defun promql-eldoc--documentation-function ()
  (let ((symbol (promql-eldoc--get-promql-symbol-string)))
    (when symbol
      (let ((info (promql-eldoc--get-symbol-info symbol)))
        (when info
          (format "%s %s"
                  (promql-eldoc--propertize-cursor-thing symbol)
                  info))))))

;;;###autoload
(defun promql-eldoc-setup ()
  "Set up eldoc function and enable eldoc-mode."
  (interactive)
  (set (make-local-variable 'eldoc-documentation-function)
       'promql-eldoc--documentation-function)
  (eldoc-mode +1))

(provide 'promql-mode-eldoc)
