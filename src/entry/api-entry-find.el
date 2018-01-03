;;; -*- coding: utf-8; lexical-binding: t -*-

(defun %hatena-blog-writer-api-entry-find (user blog success)
  "entry を 複数取得する"
  (assert (hatena-blog-writer-user-p user))
  (assert (hatena-blog-writer-blog-p blog))
  (let ((hatena-id (plist-get user :id))
        (hatena-blog-id (plist-get blog :id))
        (hatena-blog-api-key (plist-get blog :api-key)))
    (hatena-blog-writer-request :get
                                (hatena-blog-writer-api-entry-uri hatena-id
                                                                  hatena-blog-id)
                                hatena-id
                                hatena-blog-id
                                hatena-blog-api-key
                                (list :success success))))

(defun hatena-blog-writer-api-entry-find-success (&rest response)
  "hatena-blog-writer-api-entry-find の success 関数"
  (let ((data (car (plist-get response :data))))
    (dolist (element (car (xml-node-children data)))
      (when (eq 'entry (car element))
        (hatena-blog-writer-save-entry-master element)
        (hatena-blog-writer-save-entry-contents element)))))

(defun hatena-blog-writer-api-entry-find (user blog)
  (let ((success #'hatena-blog-writer-api-entry-find-success))
    (%hatena-blog-writer-api-entry-find user blog success)))
