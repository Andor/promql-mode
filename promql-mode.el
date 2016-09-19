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
   '("abs"
     "absent"
     "ceil"
     "changes"
     "clamp_max"
     "clamp_min"
     "count_scalar"
     "day_of_month"
     "day_of_week"
     "days_in_month"
     "delta"
     "deriv"
     "drop_common_labels"
     "exp"
     "floor"
     "histogram_quantile"
     "holt_winters"
     "hour"
     "idelta"
     "increase"
     "irate"
     "label_replace"
     "ln"
     "log2"
     "log10"
     "month"
     "predict_linear"
     "rate"
     "resets"
     "round"
     "scalar"
     "sort"
     "sort_desc"
     "sqrt"
     "time"
     "vector"
     "year"
     "sum_over_time"
     "min_over_time"
     "max_over_time"
     "avg_over_time"
     "stddev_over_time"
     "stdvar_over_time"
     "count_over_time"
     "quantile_over_time")
   'words)
  "Regexp for matching functions for `promql-mode'.")

;; create list for font-lock
;; each category of keyword is given a particular face
(defvar promql-mode-font-lock-keywords
  `(
    (,promql-mode-aggregations . font-lock-keyword-face)
    (,promql-mode-functions . font-lock-function-name-face))
  "Font lock for `promql-mode'.")

(defvar promql-mode-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?_ "w" table)
    table)
  "Syntax table for `promql-mode'.")

;;;###autoload
(define-derived-mode promql-mode prog-mode
  "promql mode"
  "Major mode for editing prometheus.io query language"
  (set-syntax-table promql-mode-syntax-table)
  (setq font-lock-defaults '(promql-mode-font-lock-keywords))
  )

;; add the mode to the `features' list
(provide 'promql-mode)

;; End:

;;; promql-mode ends here
