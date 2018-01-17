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
  "はてなブログAtomPub の Entry の URI を返す"
  (%hatena-blog-writer-api-entry-uri (cond ((stringp id-or-user) id-or-user)
                                           ((listp id-or-user) (plist-get id-or-user :id))
                                           (t (error "Fuck'n error! Valid id-or-user.")))
                                     (cond ((stringp id-or-blog) id-or-blog)
                                           ((listp id-or-blog) (plist-get id-or-blog :id))
                                           (t (error "Fuck'n error! Valid id-or-blog.")))
                                     entry_id))

;;;
;;; hatena-blog-writer-api-category-uri
;;;
(defun hatena-blog-writer-api-category-uri (hatena-id hatena-blog-id)
  "はてなブログAtomPub の カテゴリ の URI を返す"
  (concat (hatena-blog-writer-api-root-uri hatena-id hatena-blog-id)
          "/category"))
