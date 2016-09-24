(require 'cl-lib)

(require 'ert)
(require 'promql-mode-eldoc)

(ert-deftest select-symbol-string ()
  (promql--with-temp-buffer
   "  sum_over_time (up)"
   (goto-char (point-min))
   (forward-char 3)
   (should (string= (promql-eldoc--get-promql-symbol-string) "sum_over_time"))))

(ert-deftest select-symbol-string-failed ()
  (promql--with-temp-buffer
   "  sum_over_time (up)"
   (should (string= (promql-eldoc--get-promql-symbol-string) nil))))

(ert-deftest select-symbol-info ()
  (should (equal (promql-eldoc--get-function-arguments "sum_over_time") '("v range-vector"))))

(ert-deftest select-symbol-info-failed ()
  (should (equal (promql-eldoc--get-function-arguments "sum1_over_time") 'nil)))

(ert-deftest select-symbol-doc ()
  (promql--with-temp-buffer
   "  sum_over_time (up)"
   (goto-char (point-min))
   (forward-char 3)
   (should (string= (promql-eldoc--documentation-function) "sum_over_time (v range-vector)"))))

(ert-deftest select-symbol-doc-failed ()
  (promql--with-temp-buffer
   "  sum_ov2er_time (up)"
   (goto-char (point-min))
   (forward-char 3)
   (should (string= (promql-eldoc--documentation-function) nil))))

