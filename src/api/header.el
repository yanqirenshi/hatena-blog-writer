;;; -*- coding: utf-8; lexical-binding: t -*-

(defun hatena-blog-writer-request-header-auth (hatena-id hatena-blog-api-key)
  "はてなブログ AtomPub の Basic認証 のためのヘッダ: Authorization の値を返す"
  (concat "Basic "
          (base64-encode-string (concat hatena-id ":" hatena-blog-api-key))))

(defun hatena-blog-writer-request-headers (hatena-id hatena-blog-api-key)
  "はてなブログ AtomPub にリクエストを投げるためのヘッダを返す"
  `(("Content-Type" . "application/x-www-form-urlencoded")
    ("Authorization" . ,(hatena-blog-writer-request-header-auth hatena-id hatena-blog-api-key))))
