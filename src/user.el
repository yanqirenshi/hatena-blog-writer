;;; -*- coding: utf-8; lexical-binding: t -*-

(defun hatena-blog-writer-make-user (id name)
  "hbw-user オブジェクトを生成する"
  (hbw-user :id id :name name))

(defun hatena-blog-writer-user-p (d)
  "D が hbw-user オブジェクトなら t を返す"
  (hbw-user-p d))

(defun hatena-blog-writer-get-user (user-id)
  "USER-ID に一致するユーザーを返す"
  (hatena-blog-writer-get-data-at-id user-id
                                     *hatena-blog-writer-users*))

(defun hatena-blog-writer-add-user (user)
  "ユーザーを追加する"
  (unless (hbw-user-p user)
    (error "Error: data type is not user. data=%s" user))
  (when (hatena-blog-writer-get-user (hbw-user-id user))
    (error "Error: already exist this user. data=%s" user))
  (let ((new-users (append *hatena-blog-writer-users* (list user))))
    (setf *hatena-blog-writer-users* new-users)))

(defun hatena-blog-writer-change-user (user-id)
  "選択中のユーザーを切り替える"
  (let ((user (hatena-blog-writer-get-user user-id)))
    (unless user
      (error "Not exist user. user=%s" user-id))
    (setf *hatena-blog-writer-current-user* user)))
