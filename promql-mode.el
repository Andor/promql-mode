;;; promql-mode --- basic major mode for editing files with prometheus.io promql

;; Copyright © Andrew N Golovkov <andrew.golovkov@gmail.com>

;; Author: Andrew N Golovkov ( andrew.golovkov@gmail.com )
;; Version: 0.0.1
;; Created: 08 Aug 2016
;; Keywords: languages
;; Homepage: https://github.com/Andor/promql-mode

;; This file is not part of GNU Emacs.

;;; License:

;; You can redistribute this program and/or modify it under the terms of the GNU General Public License version 2.

;;; Code:

;; for hash-table-keys
(if (version< emacs-version "24.4")
    (defsubst hash-table-keys (hash-table)
      "Return a list of keys in HASH-TABLE."
      (let ((keys '()))
	(maphash (lambda (k _v) (push k keys)) hash-table)
	keys))
  (require 'subr-x))

(require 'promql-mode-words)
(require 'promql-mode-eldoc)

;; generate aggregation operators regexps
(defvar promql-mode-aggregations
  (regexp-opt
   '("sum"
     "min"
     "max"
     "avg"
     "stddev"
     "stdvar"
     "count"
     "count_values"
     "bottomk"
     "topk"
     "quantile")
   'words)
  "Regexp for aggregation functions matching for `promql-mode'.")

;; generate functions regexps
(defvar promql-mode-functions
  (regexp-opt
   (hash-table-keys promql-mode--functions)
   'words)
  "Regexp for matching functions for `promql-mode'.")

;; create list for font-lock
;; each category of keyword is given a particular face
(defvar promql-mode-font-lock-keywords
  `(
    (,promql-mode-functions . font-lock-function-name-face)
    (,promql-mode-aggregations . font-lock-keyword-face))
  "Font lock for `promql-mode'.")

(defvar promql-mode-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?_ "w" table)
    table)
  "Syntax table for `promql-mode'.")

;;;###autoload
(define-derived-mode promql-mode prog-mode "promql" ()
  "Major mode for editing prometheus.io query language"
  (set-syntax-table promql-mode-syntax-table)
  (setq font-lock-defaults '(promql-mode-font-lock-keywords)))

;; add the mode to the `features' list
(provide 'promql-mode)

;; End:

;;; promql-mode ends here
