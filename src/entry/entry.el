;;; -*- coding: utf-8; lexical-binding: t -*-

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; hbw-entry オブジェクトに対するアクセサ・ユーティリティ
;;
;; hbw-entry-id, hbw-entry-uri, hbw-entry-title 等の基本アクセサは
;; src/classes.el の defclass で自動生成される。
;; ここでは URI パース等の追加ユーティリティを定義する。
;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun hatena-blog-writer.entry.uri.params (uri)
  "はてなブログ AtomPub の URI からパラメータを抽出する"
  (when (string-match "https://blog.hatena.ne.jp/\\(.*\\)/\\(.*\\)/atom/entry/\\(.*\\)"
                      uri)
    (list :hatena-id (match-string 1 uri)
          :hatena-blog-id (match-string 2 uri)
          :hatena-blog-entry-id (match-string 3 uri))))
