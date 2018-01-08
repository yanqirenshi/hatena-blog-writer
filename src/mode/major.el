;;; -*- coding: utf-8; lexical-binding: t -*-

(define-derived-mode hatena-blog-writer nil "hatena-blog-writer" "はてなブログ執筆モード")

;; *hatena-blog: yanqirenshi*
;; これ効いていない。。。
(add-to-list 'auto-mode-alist '("\*hatena-blog: .*\*'" . hatena-blog-writer))

(defun hatena-blog-writer-hook ()
  (print "Enjoy write blog!"))
