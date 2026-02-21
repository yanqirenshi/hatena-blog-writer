;;; -*- coding: utf-8; lexical-binding: t -*-

(defun hatena-blog-writer.dir.ensure (dir-name)
  "ディレクトリが存在しなければ作成し、パスを返す"
  (unless (file-exists-p dir-name)
    (make-directory dir-name))
  dir-name)

(defun hatena-blog-writer.hatena.dir.ensure ()
  (hatena-blog-writer.dir.ensure "~/.hatena/"))

(defun hatena-blog-writer.hatena-blog.dir.ensure ()
  (hatena-blog-writer.hatena.dir.ensure)
  (hatena-blog-writer.dir.ensure "~/.hatena/blog/"))

(defun hbw--extract-id (obj)
  "文字列ならそのまま、EIEIO オブジェクトなら id スロットの値を返す"
  (cond ((stringp obj) obj)
        ((eieio-object-p obj) (slot-value obj 'id))
        (t (error "Invalid object: %s" obj))))

(defun hatena-blog-writer.user.dir.ensure (user)
  (hatena-blog-writer.hatena-blog.dir.ensure)
  (let ((dir-name (format "~/.hatena/blog/%s/" (hbw--extract-id user))))
    (hatena-blog-writer.dir.ensure dir-name)))

(defun hatena-blog-writer.blog.dir.ensure (user blog)
  (hatena-blog-writer.user.dir.ensure user)
  (let ((dir-name (format "~/.hatena/blog/%s/%s/"
                          (hbw--extract-id user)
                          (hbw--extract-id blog))))
    (hatena-blog-writer.dir.ensure dir-name)))

(defun hatena-blog-writer.entry.dir.ensure (user blog entry)
  (hatena-blog-writer.blog.dir.ensure user blog)
  (let ((dir-name (format "~/.hatena/blog/%s/%s/%s/"
                          (hbw--extract-id user)
                          (hbw--extract-id blog)
                          (if (stringp entry) entry (hbw--extract-id entry)))))
    (hatena-blog-writer.dir.ensure dir-name)))

(defun hatena-blog-writer-find-entry-dirs (user blog)
  "ブログディレクトリ内のエントリーディレクトリ一覧を返す"
  (let ((blog-dir (hatena-blog-writer.blog.dir.ensure user blog)))
    (cl-remove-if (lambda (dir)
                    (or (string= "." dir)
                        (string= ".." dir)))
                  (directory-files blog-dir))))
