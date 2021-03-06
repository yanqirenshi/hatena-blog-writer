;;; -*- coding: utf-8; lexical-binding: t -*-

(defun hatena-blog-writer-make-user (id name)
  (list :id id :name name :class "user"))

(defun hatena-blog-writer-user-p (d)
  (when (listp d)
    (string= "user"
             (plist-get d :class))))

(defun hatena-blog-writer-get-user (user-id)
  (hatena-blog-writer-get-data-at-id user-id
                                     *hatena-blog-writer-users*))

(defun hatena-blog-writer-add-user (user)
  (unless (hatena-blog-writer-user-p user)
    (error "Error: data type is not user. data=%s" user))
  (when (hatena-blog-writer-get-user (plist-get user :id))
    (error "Error: aledy exist this user. data=%s" user))
  (let ((new-users (append *hatena-blog-writer-users* (list user))))
    (setf *hatena-blog-writer-users* new-users)))

(defun hatena-blog-writer-change-user (user-id)
  (let ((user (hatena-blog-writer-get-user user-id)))
    (unless user
      (error "Not exit user. user=%s" user-id))
    (setf *hatena-blog-writer-current-user* user)))
