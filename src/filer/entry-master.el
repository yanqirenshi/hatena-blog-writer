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
