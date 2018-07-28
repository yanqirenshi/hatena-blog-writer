;;; -*- coding: utf-8; lexical-binding: t -*-

;;;;
;;;; hatena-blog-writer.entry.file-name
;;;;
(defun hatena-blog-writer.entry.dir-name (user-id blog-id entry-id)
  (let ((dir-name (hatena-blog-writer.entry.dir.ensure user-id blog-id entry-id)))
    (unless (file-exists-p dir-name)
      (make-directory dir-name))
    dir-name))

(defun hatena-blog-writer.entry.file-name.at-id (type user-id blog-id entry-id)
  (format "%s/%s"
          (hatena-blog-writer.entry.dir-name user-id blog-id entry-id)
          (cond ((string= "master" type) "master.el")
                ((string= "contents" type) "contents.md")
                (t error "Funck'n error! bad type. type=%s" type))))

(defun hatena-blog-writer.entry.file-name (type entry)
  (let ((params (hatena-blog-writer.entry.uri.params
                 (hatena-blog-writer.entry.uri entry))))
    (hatena-blog-writer.entry.file-name.at-id type
                                              (plist-get params :hatena-id)
                                              (plist-get params :hatena-blog-id)
                                              (plist-get params :hatena-blog-entry-id))))


;;;;
;;;; hatena-blog-writer.entry.save.master
;;;;
(defun hatena-blog-writer.entry.save.master (entry)
  (let ((file (hatena-blog-writer.entry.file-name "master" entry)))
    (with-temp-buffer
      (setq save-buffer-coding-system 'utf-8-unix)
      (insert (format "%S" entry))
      (write-file file))))


;;;;
;;;; hatena-blog-writer.entry.save.contents
;;;;
(defun hatena-blog-writer.entry.xml.get-val (entry key)
  (let ((elements (car (xml-node-children entry))))
    (caar (xml-node-children (assoc key elements)))))

(defun hatena-blog-writer.entry.save.contents (entry)
  (let ((file (hatena-blog-writer.entry.file-name "contents" entry)))
    (with-temp-buffer
      (setq save-buffer-coding-system 'utf-8-unix)
      (insert (format "%s\n" (hatena-blog-writer.entry.xml.get-val entry 'title)))
      (insert (format "%s"   (hatena-blog-writer.entry.xml.get-val entry 'content)))
      (write-file file))))
