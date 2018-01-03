;;; -*- coding: utf-8; lexical-binding: t -*-

(defun hatena-blog-writer-make-entry (id title)
  (list :id id :title title :class "entry"))

(defun hatena-blog-writer-entry-p (d)
  (when (listp d)
    (string= "entry"
             (getf d :class))))

(defun hatena-blog-writer-entry-get-uri (element)
  "entry の uri を返します。"
  (cdr (assoc 'href
              (xml-node-attributes
               (assoc 'link
                      (car (xml-node-children element)))))))

(defun hatena-blog-writer-api-entry-get-parse-uri (uri)
  (when (string-match "https://blog.hatena.ne.jp/\\(.*\\)/\\(.*\\)/atom/entry/\\(.*\\)"
                      uri)
    (list :hatena-id (match-string 1 uri)
          :hatena-blog-id (match-string 2 uri)
          :hatena-blog-entry-id (match-string 3 uri))))

(defun hatena-blog-writer-api-entry-get-parse-uri2 (entry)
  (let ((uri (hatena-blog-writer-entry-get-uri entry)))
    (when (string-match "https://blog.hatena.ne.jp/\\(.*\\)/\\(.*\\)/atom/entry/\\(.*\\)"
                        uri)
      (values (match-string 1 uri)
              (match-string 2 uri)
              (match-string 3 uri)))))
