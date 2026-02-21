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
  "リクエストヘッダを返す。引数は文字列または EIEIO オブジェクト。"
  (%hatena-blog-writer-request-headers (cond ((stringp id-or-user) id-or-user)
                                             ((hbw-user-p id-or-user) (hbw-user-id id-or-user))
                                             (t (error "Invalid id-or-user: %s" id-or-user)))
                                       (cond ((stringp api-key-or-blog) api-key-or-blog)
                                             ((hbw-blog-p api-key-or-blog) (hbw-blog-api-key api-key-or-blog))
                                             (t (error "Invalid api-key-or-blog: %s" api-key-or-blog)))))
