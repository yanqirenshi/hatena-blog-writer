;;; -*- coding: utf-8; lexical-binding: t -*-

(define-derived-mode hatena-blog-writer nil "hatena-blog-writer" "はてなブログ執筆モード")

;; *hatena-blog: yanqirenshi*
;; これ効いていない。。。
(add-to-list 'auto-mode-alist '("\*hatena-blog: .*\*'" . hatena-blog-writer))

(defun hatena-blog-writer-hook ()
  (let ((b (get-buffer-create "*hatena-blog: TEST*")))
    (switch-to-buffer (buffer-name b))
    (hatena-blog-writer-open-major-mode-buffer b)
    (message "Enjoy write blog!")))
