;;; -*- coding: utf-8; lexical-binding: t -*-

(defun %hatena-blog-writer-post (hatena-id hatena-blog-api-key)
  "Post-request using hatena-blog-API."
  (interactive)
  (let* ((url-request-method "POST")
         (url-request-extra-headers
           (hatena-blog-uri-request-extra-headers hatena-id hatena-blog-api-key))
         (url-request-data
           (encode-coding-string (hatena-blog-build-xml) 'utf-8))
         (post-url (hatena-blog-uri hatena-id hatena-blog-id)))
    (url-retrieve post-url
                  (lambda (data)
                    (with-current-buffer (current-buffer)
                      (cond ((search-forward-regexp "HTTP/1.1 201 Created" nil t)
                             (message "Entry posted.")
                             (if (equal hatena-blog-backup-dir nil)
                                 (kill-buffer (concat "hatena-new-entry." hatena-blog-editing-mode))))
                            (t (message "Failed."))))))))

(defun hatena-blog-writer-post ()
  "Post new entry."
  (interactive)
  (let ((current-blog hatena-blog-current))
    (unless current-blog
      (message "Not selectd Blog"))
    (%hatena-blog-post (plist-get current-blog :hatena-id)
                       (plist-get current-blog :api-key))
    (if (equal hatena-blog-backup-dir nil)
        nil
      (defvar hatena-blog-backup-file (concat (format-time-string "%Y-%m-%d-%H-%M-%S") "." hatena-blog-editing-mode))
      (write-file (concat hatena-blog-backup-dir hatena-blog-backup-file))
      (kill-buffer hatena-blog-backup-file))
    (move-file-to-trash hatena-blog-file-path)))
