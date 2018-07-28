;;; -*- coding: utf-8; lexical-binding: t -*-

(defun hatena-blog-writer-load-entry-master (user blog entry-id)
  (let* ((user-id (plist-get user :id))
         (blog-id (plist-get blog :id))
         (filename (hatena-blog-writer.entry.file-name.at-id "master" user-id blog-id entry-id)))
    (when (file-exists-p filename)
      (with-temp-buffer
        (insert-file-contents filename)
        (read (buffer-string))))))

;;;
;;; hatena-blog-writer-load-all-entry-master
;;;
(defun %hatena-blog-writer-load-all-entry-master (user blog entries)
  (when entries
    (cons (hatena-blog-writer-load-entry-master user blog (car entries))
          (%hatena-blog-writer-load-all-entry-master user blog (cdr entries)))))

(defun hatena-blog-writer-load-all-entry-master (user blog)
  (let ((entries (hatena-blog-writer-find-entry-dirs user blog)))
    (%hatena-blog-writer-load-all-entry-master user
                                                 blog
                                                 entries)))
