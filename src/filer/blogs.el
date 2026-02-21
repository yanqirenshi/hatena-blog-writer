;;; -*- coding: utf-8; lexical-binding: t -*-

(defun hbw--ensure-blog-object (data)
  "DATA が plist なら hbw-blog に変換、既に hbw-blog ならそのまま返す"
  (cond ((hbw-blog-p data) data)
        ((and (listp data) (plist-get data :class))
         (hbw-blog :id (plist-get data :id)
                   :name (plist-get data :name)
                   :api-key (plist-get data :api-key)))
        (t (error "不明なブログデータ形式: %S" data))))

(defun hatena-blog-writer-save-blogs ()
  "ブログリストをファイルに保存する"
  (let ((filename "~/.hatena/blog/config/blogs.lisp")
        (blogs *hatena-blog-writer-blogs*))
    (make-directory (file-name-directory filename) t)
    (with-temp-buffer
      (insert (format "%S" blogs))
      (write-file filename))))

(defun hatena-blog-writer-load-blogs ()
  "ファイルからブログリストを読み込む。旧plist形式は自動変換。"
  (let ((filename "~/.hatena/blog/config/blogs.lisp"))
    (when (file-exists-p filename)
      (with-temp-buffer
        (insert-file-contents filename)
        (let ((data (read (buffer-string))))
          (setq *hatena-blog-writer-blogs*
                (mapcar #'hbw--ensure-blog-object data)))))))
