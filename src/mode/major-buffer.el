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
  (let* ((buffer-name (hatena-blog-writer-ensure-major-mode-buffer-name))
         (b (get-buffer-create buffer-name)))
    (with-current-buffer b
      (setq buffer-read-only t))
    b))

(defun hatena-blog-writer-open-major-mode-buffer-set-mejor-mode (buffer)
  (with-current-buffer buffer
    ;; setq major-mode は良いのか。。。。
    (setq major-mode 'hatena-blog-writer-mode)
    (setq mode-name "hbw-mode")
    (run-hooks 'hatena-blog-writer-mode-hook)))

(defun hatena-blog-writer-open-major-mode-buffer (buffer)
  "メジャーモードのバッファに切り替えます。"
  (with-current-buffer buffer
    (overwrite-mode)
    ;; cleaning buffer
    (erase-buffer)
    (insert (make-string 7 ?\n))
    ;; print contents
    (hatena-blog-writer-open-major-mode-print-title)
    (hatena-blog-writer-open-major-mode-print-user)
    (hatena-blog-writer-open-major-mode-print-blog)
    (hatena-blog-writer-open-major-mode-print-entries-title)
    (goto-line 8)
    (let ((entries (hatena-blog-writer-load-all-entry-master
                    *hatena-blog-writer-current-user*
                    *hatena-blog-writer-current-blog*)))
      (dolist (entry entries)
        (hatena-blog-writer-open-major-mode-print-entry-contents entry))))
  (hatena-blog-writer-open-major-mode-buffer-set-mejor-mode buffer)
  (switch-to-buffer buffer))
