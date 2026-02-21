;;; -*- coding: utf-8; lexical-binding: t -*-

(defun hbw--ensure-user-object (data)
  "DATA が plist なら hbw-user に変換、既に hbw-user ならそのまま返す"
  (cond ((hbw-user-p data) data)
        ((and (listp data) (plist-get data :class))
         (hbw-user :id (plist-get data :id)
                   :name (plist-get data :name)))
        (t (error "不明なユーザーデータ形式: %S" data))))

(defun hatena-blog-writer-save-users ()
  "ユーザーリストをファイルに保存する"
  (let ((filename "~/.hatena/blog/config/users.lisp")
        (users *hatena-blog-writer-users*))
    (make-directory (file-name-directory filename) t)
    (with-temp-buffer
      (insert (format "%S" users))
      (write-file filename))))

(defun hatena-blog-writer-load-users ()
  "ファイルからユーザーリストを読み込む。旧plist形式は自動変換。"
  (let ((filename "~/.hatena/blog/config/users.lisp"))
    (when (file-exists-p filename)
      (with-temp-buffer
        (insert-file-contents filename)
        (let ((data (read (buffer-string))))
          (setq *hatena-blog-writer-users*
                (mapcar #'hbw--ensure-user-object data)))))))
