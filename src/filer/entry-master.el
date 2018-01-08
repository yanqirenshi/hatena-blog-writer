;;; -*- coding: utf-8; lexical-binding: t -*-

(defun hatena-blog-writer-save-entry-file-name-at-id (type user-id blog-id entry-id)
  (format "~/.hatena/blog/%s/%s/%s/%s"
          user-id
          blog-id
          entry-id
          (cond ((string= "master" type) "master.el")
                ((string= "contents" type) "contents.md")
                (t error "Funck'n error! bad type. type=%s" type))))

(defun hatena-blog-writer-save-entry-file-name (type entry)
  (multiple-value-bind (user-id blog-id entry-id)
      (hatena-blog-writer-api-entry-get-parse-uri2 entry)
    (hatena-blog-writer-save-entry-file-name-at-id type
                                                   user-id
                                                   blog-id
                                                   entry-id)))

(defun hatena-blog-writer-save-entry-master (entry)
  (multiple-value-bind (user-id blog-id entry-id)
      (hatena-blog-writer-api-entry-get-parse-uri2 entry)
    (with-temp-buffer
      (insert (format "%S" entry))
      (write-file (hatena-blog-writer-save-entry-file-name "master" entry)))))

(defun hatena-blog-writer-load-entry-master (user blog entry-id)
  (let* ((user-id (plist-get user :id))
         (blog-id (plist-get blog :id))
         (filename (hatena-blog-writer-save-entry-file-name-at-id "master" user-id blog-id entry-id)))
    (when (file-exists-p filename)
      (with-temp-buffer
        (insert-file-contents filename)
        (read (buffer-string))))))

;;;
;;; hatena-blog-writer-load-all-entry-contents
;;;
(defun %hatena-blog-writer-load-all-entry-contents (user blog entries)
  (when entries
    (cons (hatena-blog-writer-load-entry-master user blog (car entries))
          (%hatena-blog-writer-load-all-entry-contents user blog (cdr entries)))))

(defun hatena-blog-writer-load-all-entry-contents (user blog)
  (let ((entries (hatena-blog-writer-find-entry-dirs user blog)))
    (%hatena-blog-writer-load-all-entry-contents user
                                                 blog
                                                 entries)))
