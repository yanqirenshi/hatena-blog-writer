;;; -*- coding: utf-8; lexical-binding: t -*-

(defun hatena-blog-writer-ensure-major-mode-buffer-name ()
  (let ((user *hatena-blog-writer-current-user*))
    (when user
      (format "*hatena-blog: %s*"
              (plist-get user :id)))))

(defun hatena-blog-writer-ensure-major-mode-buffer ()
  "メジャーモードのバッファを返します。"
  (unless *hatena-blog-writer-current-user*
    (error "Not choiced user"))
  (let ((buffer-name (hatena-blog-writer-ensure-major-mode-buffer-name)))
    (get-buffer-create buffer-name)))

(defun hatena-blog-writer-open-major-mode-buffer ()
  "メジャーモードのバッファに切り替えます。"
  (let ((buffer (hatena-blog-writer-ensure-major-mode-buffer)))
    (print buffer)
    (with-current-buffer buffer
      (overwrite-mode)
      ;; cleaning buffer
      (erase-buffer)
      (insert (make-string 6 ?\n))
      ;; print contents
      (hatena-blog-writer-open-major-mode-print-title)
      (hatena-blog-writer-open-major-mode-print-user)
      (hatena-blog-writer-open-major-mode-print-blog)
      (hatena-blog-writer-open-major-mode-print-entries-title)
      (switch-to-buffer buffer))))
