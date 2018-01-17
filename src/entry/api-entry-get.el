;;; -*- coding: utf-8; lexical-binding: t -*-

(defun %hatena-blog-writer-api-entry-get (user blog entry-id success)
  "entry を entry-id で取得する。"
  (assert (hatena-blog-writer-user-p user))
  (assert (hatena-blog-writer-blog-p blog))
  (let ((hatena-id (plist-get user :id))
        (hatena-blog-id (plist-get blog :id))
        (hatena-blog-api-key (plist-get blog :api-key)))
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
  (let ((entry (car (plist-get response :data))))
    (when (eq 'entry (car entry))
      (when (or (eq update :all) (eq update :master))
        (hatena-blog-writer-save-entry-master entry))
      (when (or (eq update :all) (eq update :contents))
        (hatena-blog-writer-save-entry-contents entry)))))

(defun hatena-blog-writer-api-entry-get (user blog entry-id &rest key-params)
  (lexical-let ((update (plist-get key-params :update))
                (callback (plist-get key-params :callback)))
    (%hatena-blog-writer-api-entry-get
     user blog entry-id
     (lambda (&rest response)
       (hatena-blog-writer-api-entry-get-success response update)
       (when (functionp callback)
         (funcall callback))))))
