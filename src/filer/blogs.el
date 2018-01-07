;;; -*- coding: utf-8; lexical-binding: t -*-

(defun hatena-blog-writer-save-blogs ()
  (let ((filename "~/.hatena/blog/config/blogs.lisp")
        (blogs *hatena-blog-writer-blogs*))
    (make-directory (file-name-directory filename) t)
    (with-temp-buffer
      (insert (format "%S" blogs))
      (write-file filename))))

(defun hatena-blog-writer-load-blogs ()
  (let ((filename "~/.hatena/blog/config/blogs.lisp"))
    (when (file-exists-p filename)
      (with-temp-buffer
        (insert-file-contents filename)
        (setq *hatena-blog-writer-blogs* (read (buffer-string)))))))
