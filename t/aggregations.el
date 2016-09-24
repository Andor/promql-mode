(require 'cl-lib)

(require 'ert)
(require 'promql-mode)

(ert-deftest aggregation-without-grouping ()
  "Aggregation have no grouping"
  (promql--with-temp-buffer
   "sum(up)"
   (should (eq (promql--get-face-at-position 1) 'font-lock-keyword-face))))

(ert-deftest aggregation-with-grouping ()
  "Aggregation with grouping with one label"
  (promql--with-temp-buffer
   "sum(up) by (instance)"
   (should (eq (promql--get-face-at-position 1) 'font-lock-keyword-face))
   ;; (should (eq (promql--get-face-at-position 15) 'font-lock-variable-face))
   ))

