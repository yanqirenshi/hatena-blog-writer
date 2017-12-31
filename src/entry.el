;;; -*- coding: utf-8; lexical-binding: t -*-

(defun hatena-blog-writer-make-entry (id title)
  (list :id id :title title :class "entry"))

(defun hatena-blog-writer-entry-p (d)
  (when (listp d)
    (string= "entry"
             (getf d :class))))

(defun hatena-blog-writer-api-entry-get (user
                                         blog
                                         &optional entry-id)
  (unless (hatena-blog-writer-user-p user)
    (error "Not user. user=%s" user))
  (unless (hatena-blog-writer-user-p user)
    (error "Not blo. blog=%s" blog))
  (let ((uri (hatena-blog-writer-api-entry-uri hatena-id
                                               hatena-blog-id
                                               entry-id)))
    (hatena-blog-writer-request :get
                                uri
                                (plist-get user :id)
                                (plist-get blog :id)
                                (plist-get blog :api-key)
                                (list :success (cl-function
                                                (lambda (&key data &allow-other-keys)
                                                  (setq *tmp* data))))
                                entry-id)))
