;;; -*- coding: utf-8; lexical-binding: t -*-

(defun hatena-blog-writer-load-entry-contents (user blog entry-id)
  "contents.md を読み込み、タイトルと本文の plist を返す。
返り値: (:title \"...\" :contents \"...\")"
  (let ((filename (hatena-blog-writer.entry.file-name.at-id "contents"
                                                            (hbw--extract-id user)
                                                            (hbw--extract-id blog)
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
