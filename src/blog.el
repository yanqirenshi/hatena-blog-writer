;;; -*- coding: utf-8; lexical-binding: t -*-

(defun hatena-blog-writer-make-blog (id name api-key)
  "hbw-blog オブジェクトを生成する"
  (hbw-blog :id id :name name :api-key api-key))

(defun hatena-blog-writer-blog-p (d)
  "D が hbw-blog オブジェクトなら t を返す"
  (hbw-blog-p d))

(defun hatena-blog-writer-get-blog (blog-id)
  "BLOG-ID に一致するブログを返す"
  (hatena-blog-writer-get-data-at-id blog-id
                                     *hatena-blog-writer-blogs*))

(defun hatena-blog-writer-add-blog (blog)
  "ブログを追加する"
  (unless (hbw-blog-p blog)
    (error "Error: data type is not blog. data=%s" blog))
  (when (hatena-blog-writer-get-blog (hbw-blog-id blog))
    (error "Error: already exist this blog. data=%s" blog))
  (let ((new-blogs (append *hatena-blog-writer-blogs* (list blog))))
    (setf *hatena-blog-writer-blogs* new-blogs)))

(defun hatena-blog-writer-change-blog (blog-id)
  "選択中のブログを切り替える"
  (let ((blog (hatena-blog-writer-get-blog blog-id)))
    (unless blog
      (error "Not exist blog. blog-id=%s" blog-id))
    (setf *hatena-blog-writer-current-blog* blog)))
