;;; -*- coding: utf-8; lexical-binding: t -*-

(defun hatena-blog-writer-api-root-uri (hatena-id hatena-blog-id)
  "はてなブログAtomPub のルートの URI を返す"
  (format "https://blog.hatena.ne.jp/%s/%s/atom" hatena-id hatena-blog-id))

(defun hatena-blog-writer-api-entry-uri (hatena-id hatena-blog-id &optional entry_id)
  "はてなブログAtomPub の Entry の URI を返す"
  (let* ((base-uri (hatena-blog-writer-api-root-uri hatena-id hatena-blog-id))
         (entry-uri (concat base-uri "/entry")))
    (if (null entry_id)
        entry-uri
      (format "%s/%s" entry-uri entry_id))))

(defun hatena-blog-writer-api-category-uri (hatena-id hatena-blog-id)
  "はてなブログAtomPub の カテゴリ の URI を返す"
  (concat (hatena-blog-writer-api-root-uri hatena-id hatena-blog-id)
          "/category"))
