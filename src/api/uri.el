;;; -*- coding: utf-8; lexical-binding: t -*-

(defun hatena-blog-writer-api-root-uri (hatena-id hatena-blog-id)
  "はてなブログAtomPub のルートの URI を返す"
  (format "https://blog.hatena.ne.jp/%s/%s/atom" hatena-id hatena-blog-id))


;;;
;;; hatena-blog-writer-api-entry-uri
;;;
(defun %hatena-blog-writer-api-entry-uri (hatena-id hatena-blog-id &optional entry_id)
  "はてなブログAtomPub の Entry の URI を返す"
  (let* ((base-uri (hatena-blog-writer-api-root-uri hatena-id hatena-blog-id))
         (entry-uri (concat base-uri "/entry")))
    (if (null entry_id)
        entry-uri
      (format "%s/%s" entry-uri entry_id))))

(defun hatena-blog-writer-api-entry-uri (id-or-user id-or-blog &optional entry_id)
  "はてなブログAtomPub の Entry の URI を返す。引数は文字列または EIEIO オブジェクト。"
  (%hatena-blog-writer-api-entry-uri (cond ((stringp id-or-user) id-or-user)
                                           ((hbw-user-p id-or-user) (hbw-user-id id-or-user))
                                           (t (error "Invalid id-or-user: %s" id-or-user)))
                                     (cond ((stringp id-or-blog) id-or-blog)
                                           ((hbw-blog-p id-or-blog) (hbw-blog-id id-or-blog))
                                           (t (error "Invalid id-or-blog: %s" id-or-blog)))
                                     entry_id))

;;;
;;; hatena-blog-writer-api-category-uri
;;;
(defun hatena-blog-writer-api-category-uri (hatena-id hatena-blog-id)
  "はてなブログAtomPub の カテゴリ の URI を返す"
  (concat (hatena-blog-writer-api-root-uri hatena-id hatena-blog-id)
          "/category"))
