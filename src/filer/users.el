;;; -*- coding: utf-8; lexical-binding: t -*-

(defun hatena-blog-writer-save-users ()
  (let ((filename "~/.hatena/blog/config/users.lisp")
        (users *hatena-blog-writer-users*))
    (make-directory (file-name-directory filename) t)
    (with-temp-buffer
      (insert (format "%S" users))
      (write-file filename))))

(defun hatena-blog-writer-load-users ()
  (let ((filename "~/.hatena/blog/config/users.lisp"))
    (when (file-exists-p filename)
      (with-temp-buffer
        (insert-file-contents filename)
        (setq *hatena-blog-writer-users* (read (buffer-string)))))))
