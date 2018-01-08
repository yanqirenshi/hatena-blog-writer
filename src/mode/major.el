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
  "メジャーモードのバッファを返します。"
  (unless *hatena-blog-writer-current-user*
    (error "Not choiced user"))
  (let ((buffer-name (hatena-blog-writer-ensure-major-mode-buffer-name)))
    (get-buffer-create buffer-name)))

(defun hatena-blog-writer-open-major-mode-print-title ()
  (goto-line 1)
  (insert "HATENA BLOG WRITER"))

(defun hatena-blog-writer-open-major-mode-print-user ()
  (goto-line 2)
  (insert (format "User: %s (%s)"
                  (plist-get *hatena-blog-writer-current-user* :name)
                  (plist-get *hatena-blog-writer-current-user* :id))))

(defun hatena-blog-writer-open-major-mode-print-blog ()
  (goto-line 3)
  (insert (format "Blog: %s (%s)"
                  (plist-get *hatena-blog-writer-current-blog* :name)
                  (plist-get *hatena-blog-writer-current-blog* :id))))

(defun hatena-blog-writer-open-major-mode-print-entries-title ()
  (goto-line 5)
  (insert (format "Entries:"
                  (plist-get *hatena-blog-writer-current-blog* :name)
                  (plist-get *hatena-blog-writer-current-blog* :id))))

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
