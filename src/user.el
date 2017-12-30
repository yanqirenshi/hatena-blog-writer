;;; -*- coding: utf-8; lexical-binding: t -*-

(defun hatena-blog-writer-make-user (id name)
  (list :id id :name name :class "user"))

(defun hatena-blog-writer-user-p (d)
  (when (listp d)
    (string= "user"
             (getf d :class))))

(defun hatena-blog-writer-set-user (user)
  (custom-set-variables '(*hatena-blog-writer-user* user)))
