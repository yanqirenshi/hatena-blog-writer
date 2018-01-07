;;; -*- coding: utf-8; lexical-binding: t -*-

(defun hatena-blog-writer-save-entry-contents (entry)
  (multiple-value-bind (user-id blog-id entry-id)
      (hatena-blog-writer-api-entry-get-parse-uri2 entry)
    (flet ((get-val (entry key)
                    (let ((elements (car (xml-node-children entry))))
                      (caar (xml-node-children (assoc key elements))))))
      (with-temp-buffer
        (setq save-buffer-coding-system 'utf-8-unix)
        (insert (format "%s\n" (get-val entry 'title)))
        (insert (format "%s" (get-val entry 'content)))
        (write-file (hatena-blog-writer-save-entry-file-name "contents" entry))))))

(defun hatena-blog-writer-load-entry-contents (user blog entry-id)
  (let ((filename (hatena-blog-writer-save-entry-file-name-at-id "contents"
                                                                 (plist-get user :id)
                                                                 (plist-get blog :id)
                                                                 entry-id)))
    (with-temp-buffer
      (insert-file-contents filename)
      (goto-char (point-min))
      (let ((str (buffer-string)))
        (if (string-match "^\\(.*\\)\n\\(\\(.\\|\n\\)+\\)$" str)
            (list :title (match-string 1 str)
                  :contents (match-string 2 str))
            (list :title "No Title"
                  :contents ""))))))
