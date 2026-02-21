;;; -*- coding: utf-8; lexical-binding: t -*-

(defun %hatena-blog-writer-api-entry-get (user blog entry-id success)
  "entry を entry-id で取得する。"
  (cl-assert (hbw-user-p user))
  (cl-assert (hbw-blog-p blog))
  (let ((hatena-id (hbw-user-id user))
        (hatena-blog-id (hbw-blog-id blog))
        (hatena-blog-api-key (hbw-blog-api-key blog)))
    (hatena-blog-writer-request :get
                                (hatena-blog-writer-api-entry-uri hatena-id
                                                                  hatena-blog-id
                                                                  entry-id)
                                hatena-id
                                hatena-blog-id
                                hatena-blog-api-key
                                (list :success success)
                                entry-id)))

(defun hatena-blog-writer-api-entry-get-success (response update)
  "hatena-blog-writer-api-entry-get のコールバック(success) 関数"
  (let ((xml-entry (car (plist-get response :data))))
    (when (eq 'entry (car xml-entry))
      (let ((entry (hbw-entry-from-xml xml-entry)))
        (when (or (eq update :all) (eq update :master))
          (hatena-blog-writer.entry.save.master entry))
        (when (or (eq update :all) (eq update :contents))
          (hatena-blog-writer.entry.save.contents entry))))))

(defun hatena-blog-writer-api-entry-get (user blog entry-id &rest key-params)
  (let ((update (plist-get key-params :update))
        (callback (plist-get key-params :callback)))
    (%hatena-blog-writer-api-entry-get
     user blog entry-id
     (lambda (&rest response)
       (hatena-blog-writer-api-entry-get-success response update)
       (when (functionp callback)
         (funcall callback))))))
