;;; -*- coding: utf-8; lexical-binding: t -*-

(defun hatena-blog-writer-build-post-xml (user
                                          title
                                          contents
                                          categories
                                          draft)
  (princ (format *hatena-blog-writer-request-xml-template*
                 ;; title
                 (xml-escape-string title)
                 ;; author
                 (plist-get user :id)
                 ;; content
                 (xml-escape-string contents)
                 ;; updated
                 (format-time-string "%Y-%m-%dT%H:%M:%S")
                 ;; category
                 (hatena-blog-writer-request-xml-build-tags nil)
                 ;; draft
                 draft)))

(defun hatena-blog-writer-api-entry-post-success (&rest response)
  (let ((entry (car (plist-get response :data))))
    (when (eq 'entry (car entry))
      (hatena-blog-writer-save-entry-master entry)
      (hatena-blog-writer-save-entry-contents entry))))

(defun hatena-blog-writer-api-entry-post-error (&rest response)
  (setq *tmp-post-error* response))

(defun hatena-blog-writer-api-entry-post (user blog xml)
  (let ((user-id (plist-get user :id))
        (blog-id (plist-get blog :id))
        (api-key (plist-get blog :api-key)))
    (request (hatena-blog-writer-api-entry-uri user-id blog-id)
             :type "POST"
             :headers (hatena-blog-writer-request-headers user-id api-key)
             :data (encode-coding-string xml 'utf-8)
             :parser *hatena-blog-writer-request-default-callback-parser*
             :success #'hatena-blog-writer-api-entry-post-success
             :error #'hatena-blog-writer-api-entry-post-error)))
