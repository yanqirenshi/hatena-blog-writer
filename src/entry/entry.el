;;; -*- coding: utf-8; lexical-binding: t -*-

(defun hatena-blog-writer.entry.uri (entry)
  "entry の uri を返します。"
  (cdr (assoc 'href
              (xml-node-attributes
               (assoc 'link
                      (car (xml-node-children entry)))))))

(defun hatena-blog-writer.entry.uri.params (uri)
  (when (string-match "https://blog.hatena.ne.jp/\\(.*\\)/\\(.*\\)/atom/entry/\\(.*\\)"
                      uri)
    (list :hatena-id (match-string 1 uri)
          :hatena-blog-id (match-string 2 uri)
          :hatena-blog-entry-id (match-string 3 uri))))

(defun hatena-blog-writer.entry.id (entry)
  "entry の id を返します。"
  (let ((params (hatena-blog-writer.entry.uri.params
                 (hatena-blog-writer.entry.uri entry))))
    (plist-get params :hatena-blog-entry-id)))

(defun hatena-blog-writer.entry.title (entry)
  "entry の title を返します。"
  (caar (xml-node-children
         (assoc 'title
                (car (xml-node-children entry))))))

(defun hatena-blog-writer.entry.val (entry key)
  "entry の uri を返します。"
  (caar (xml-node-children
         (assoc key
                (car (xml-node-children entry))))))

(defun hatena-blog-writer.entry.status (entry)
  (let ((element (hatena-blog-writer.entry.val entry 'app:control)))
    (when (and element
               (eq 'app:draft (xml-node-name element)))
      (let ((val (caar (xml-node-children element))))
        (cond ((string= "no" val)
               "published")
              ((string= "yes" val)
               "draft")
              (t "???"))))))
