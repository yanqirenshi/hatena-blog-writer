;;; -*- coding: utf-8; lexical-binding: t -*-

(defun hatena-blog-writer-open-major-mode-print-title ()
  (goto-line 1)
  (insert "HATENA BLOG WRITER"))

(defun hatena-blog-writer-open-major-mode-print-user ()
  (goto-line 2)
  (insert (format "User: %s (%s)"
                  (hbw-user-name *hatena-blog-writer-current-user*)
                  (hbw-user-id *hatena-blog-writer-current-user*))))

(defun hatena-blog-writer-open-major-mode-print-blog ()
  (goto-line 3)
  (insert (format "Blog: %s (%s)"
                  (hbw-blog-name *hatena-blog-writer-current-blog*)
                  (hbw-blog-id *hatena-blog-writer-current-blog*))))

(defun hatena-blog-writer-open-major-mode-print-entries-title ()
  (goto-line 5)
  (insert "Entries:")
  (goto-line 7)
  (insert (format "  %9s %s\n" "status" "title"))
  (goto-line 8)
  (insert (format "  %9s %s\n"
                  (make-string 9 ?-)
                  (make-string 88 ?-))))

(defun hatena-blog-writer-open-major-mode-print-entry-contents (entry)
  (insert (format "  %9s %s\n"
                  (hbw-entry-status-string entry)
                  (hbw-entry-title entry))))

(defun hatena-blog-writer-open-major-mode-print-entries-contents (entries)
    (goto-line 9)
    (dolist (entry entries)
      (hatena-blog-writer-open-major-mode-print-entry-contents entry)))
