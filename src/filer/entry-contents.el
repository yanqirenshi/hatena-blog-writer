;;; -*- coding: utf-8; lexical-binding: t -*-

(defun hatena-blog-writer-load-entry-contents (user blog entry-id)
  (let ((filename (hatena-blog-writer.entry.file-name.at-id "contents"
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
