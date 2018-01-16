;;; -*- coding: utf-8; lexical-binding: t -*-

(defun hatena-blog-writer-request-header-auth (hatena-id hatena-blog-api-key)
  "はてなブログ AtomPub の Basic認証 のためのヘッダ: Authorization の値を返す"
  (concat "Basic "
          (base64-encode-string (concat hatena-id ":" hatena-blog-api-key))))

(defun %hatena-blog-writer-request-headers (hatena-id hatena-blog-api-key)
  "はてなブログ AtomPub にリクエストを投げるためのヘッダを返す"
  `(("Content-Type" . "application/x-www-form-urlencoded")
    ("Authorization" . ,(hatena-blog-writer-request-header-auth hatena-id hatena-blog-api-key))))

(defun hatena-blog-writer-request-headers (id-or-user api-key-or-blog)
  (%hatena-blog-writer-request-headers (cond ((stringp id-or-user) id-or-user)
                                             ((listp id-or-user) (plist-get id-or-user :id))
                                             (t (error "Func'n error invalid id-or-user")))
                                       (cond ((stringp api-key-or-blog) api-key-or-blog)
                                             ((listp api-key-or-blog) (plist-get api-key-or-blog :api-key))
                                             (t (error "Func'n error invalid api-key-or-blog")))))
