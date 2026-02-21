;;; -*- coding: utf-8; lexical-binding: t -*-

(defun hatena-blog-writer-get-data-at-id (id data-list)
  "DATA-LIST から ID に一致するオブジェクトを返す。
各要素は id スロットを持つ EIEIO オブジェクトであること。"
  (cl-find id data-list
           :test #'string=
           :key (lambda (d) (slot-value d 'id))))
