;;; -*- coding: utf-8; lexical-binding: t -*-

(defun hatena-blog-writer-build-post-xml (user
                                          title
                                          contents
                                          categories
                                          draft)
  "POST 用の XML を構築する"
  (princ (format *hatena-blog-writer-request-xml-template*
                 ;; title
                 (xml-escape-string title)
                 ;; author
                 (hbw-user-id user)
                 ;; content
                 (xml-escape-string contents)
                 ;; updated
                 (format-time-string "%Y-%m-%dT%H:%M:%S")
                 ;; category
                 (hatena-blog-writer-request-xml-build-tags categories)
                 ;; draft
                 draft)))

(defun hatena-blog-writer-api-entry-post-success (&rest response)
  "POST 成功時のコールバック"
  (let ((xml-entry (car (plist-get response :data))))
    (when (eq 'entry (car xml-entry))
      (let ((entry (hbw-entry-from-xml xml-entry)))
        (hatena-blog-writer.entry.save.master   entry)
        (hatena-blog-writer.entry.save.contents entry)))))

(defun hatena-blog-writer-api-entry-post-error (&rest response)
  (setq *tmp-post-error* response))

(defun hatena-blog-writer-api-entry-post (user blog xml)
  "エントリーを新規投稿する"
  (let ((user-id (hbw-user-id user))
        (blog-id (hbw-blog-id blog))
        (api-key (hbw-blog-api-key blog)))
    (request (hatena-blog-writer-api-entry-uri user-id blog-id)
             :type "POST"
             :headers (hatena-blog-writer-request-headers user-id api-key)
             :data (encode-coding-string xml 'utf-8)
             :parser *hatena-blog-writer-request-default-callback-parser*
             :success #'hatena-blog-writer-api-entry-post-success
             :error #'hatena-blog-writer-api-entry-post-error)))
