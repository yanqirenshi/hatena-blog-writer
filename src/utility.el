;;; -*- coding: utf-8; lexical-binding: t -*-

(defun hatena-blog-writer-get-data-at-id (id data-list)
  (let* ((data (car data-list)))
    (when data
      (if (string= id (plist-get data :id))
          data
        (hatena-blog-writer-get-data-at-id id (cdr data-list))))))
