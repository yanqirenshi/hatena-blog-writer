;;; -*- coding: utf-8; lexical-binding: t -*-

(define-derived-mode hatena-blog-writer nil "hatena-blog-writer" "はてなブログ執筆モード"
  (define-key hatena-blog-writer (kbd "C-c C-m") 'hatena-blog-writer-cmd-1)
  (define-key hatena-blog-writer (kbd "load") 'hatena-blog-writer-cmd-load))

;; *hatena-blog: yanqirenshi*
;; これ効いていない。。。
(add-to-list 'auto-mode-alist '("\*hatena-blog: .*\*'" . hatena-blog-writer))
