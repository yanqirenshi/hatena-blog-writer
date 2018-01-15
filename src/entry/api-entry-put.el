;;; -*- coding: utf-8; lexical-binding: t -*-

(defun hatena-blog-writer-build-put-xml (user
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
                 (xml-escape-string categories)
                 ;; draft
                 draft)))

(defun hatena-blog-writer-put (user blog xml)
  (let ((user-id (plist-get user :id))
        (blog-id (plist-get blog :id))
        (api-key (plist-get blog :api-key)))
    (request (hatena-blog-writer-api-entry-uri user-id blog-id)
             :type "PUT"
             :headers (hatena-blog-writer-request-headers user-id api-key)
             :data (encode-coding-string xml 'utf-8)
             :parser 'buffer-string
             :success (function*
                       (lambda (&key data &allow-other-keys)
                         (message "I sent: %S" (assoc-default 'files data))))
             :error (lambda (&rest response)
                      (message response)))))
