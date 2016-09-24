;;; test-helper.el --- helper for testing promql-mode

;; Copyright (C) 2016 by Syohei YOSHIDA

;; Author: Syohei YOSHIDA <syohex@gmail.com>

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:

(require 'promql-mode)
(require 'cl)

(defmacro promql--with-temp-buffer (code &rest body)
  "Insert `code' and enable `promql-mode'. cursor is beginning of buffer"
  (declare (indent 0) (debug t))
  `(with-temp-buffer
     (insert ,code)
     (goto-char (point-min))
     (promql-mode)
     (font-lock-fontify-buffer)
     ,@body))

(cl-defun promql--get-face-at-position (position)
  "go to selected position and return face of the current character"
  (goto-char (point-min))
  (forward-char position)
  (or (get-char-property (point) 'read-face-name)
      (get-char-property (point) 'face)))

(provide 'test-helper)

;;; test-helper.el ends here
