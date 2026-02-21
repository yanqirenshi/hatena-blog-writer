;;; -*- coding: utf-8; lexical-binding: t -*-

(defun hatena-blog-writer-build-put-xml (user blog entry-id)
  "PUT 用の XML を構築する。
contents.md からタイトルと本文を読み込み、master から既存メタデータを取得してマージする。"
  (let ((contents (hatena-blog-writer-load-entry-contents user blog entry-id))
        (master (hatena-blog-writer-load-entry-master user blog entry-id)))
    (princ (format *hatena-blog-writer-request-xml-template*
                   ;; title
                   (xml-escape-string (plist-get contents :title))
                   ;; author
                   (hbw-user-id user)
                   ;; content
                   (xml-escape-string (plist-get contents :contents))
                   ;; updated
                   (format-time-string "%Y-%m-%dT%H:%M:%S")
                   ;; category
                   (hatena-blog-writer-request-xml-build-tags
                    (hbw-entry-categories master))
                   ;; draft
                   (if (hbw-entry-draft-p master) "yes" "no")))))

(defun hatena-blog-writer-api-entry-put-success (&rest response)
  "PUT 成功時のコールバック"
  (message "PUT Finished!!")
  (let ((xml-entry (car (plist-get response :data))))
    (when (eq 'entry (car xml-entry))
      (let ((entry (hbw-entry-from-xml xml-entry)))
        (hatena-blog-writer.entry.save.master entry)
        (message "Saved master!")
        (hatena-blog-writer.entry.save.contents entry)
        (message "Saved contents!")))))

(defun %hatena-blog-writer-api-entry-put (user blog entry-id)
  (request (hatena-blog-writer-api-entry-uri user blog entry-id)
           :type "PUT"
           :headers (hatena-blog-writer-request-headers user blog)
           :data (encode-coding-string (hatena-blog-writer-build-put-xml user blog entry-id)
                                       'utf-8)
           :parser *hatena-blog-writer-request-default-callback-parser*
           :success #'hatena-blog-writer-api-entry-put-success
           :error (lambda (&rest response)
                    (message "PUT Failed.\n%s" response))))

(defun hatena-blog-writer-api-entry-put (user blog entry-id)
  "contents.md の内容を WEB 上に PUT します。
最新の master の title と contents のみを変更して put します。"
  (let ((user user)
        (blog blog)
        (entry-id entry-id))
    (let ((callback (lambda ()
                      (%hatena-blog-writer-api-entry-put user blog entry-id))))
      (hatena-blog-writer-api-entry-get user blog entry-id
                                        :update :master
                                        :callback callback))))
