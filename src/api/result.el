;;; -*- coding: utf-8; lexical-binding: t -*-

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; api で success が返すものが reslt です。
;;
;;
;;
;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun hatena-blog-writer.api.result.response (result)
  (plist-get result :data))
