;;; -*- coding: utf-8; lexical-binding: t -*-

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
