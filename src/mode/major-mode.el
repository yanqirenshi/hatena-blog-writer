;;; -*- coding: utf-8; lexical-binding: t -*-

(define-derived-mode hatena-blog-writer nil "hatena-blog-writer" "はてなブログ執筆モード")

;; *hatena-blog: yanqirenshi*
;; これ効いていない。。。
(add-to-list 'auto-mode-alist '("\*hatena-blog: .*\*'" . hatena-blog-writer))

(defun hatena-blog-writer-hook ()
  (print "Enjoy write blog!"))

(defun hatena-blog-writer-ensure-major-mode-buffer-name ()
  (let ((user *hatena-blog-writer-current-user*))
    (when user
      (format "*hatena-blog: %s*"
              (plist-get user :id)))))

(defun hatena-blog-writer-ensure-major-mode-buffer ()
  (unless *hatena-blog-writer-current-user*
    (error "Not choiced user"))
  (let ((buffer-name (hatena-blog-writer-ensure-major-mode-buffer-name)))
    (get-buffer-create buffer-name)))

(defun hatena-blog-writer-open-major-mode-buffer ()
  (let ((buffer (hatena-blog-writer-ensure-major-mode-buffer)))
    (switch-to-buffer buffer)))
