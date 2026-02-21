;;; -*- coding: utf-8; lexical-binding: t -*-

(defun hatena-blog-writer.find-next-page-no (xml-lists)
  "フィード内の次ページリンクからページ番号を取り出す"
  (when xml-lists
    (let ((xml-list (car xml-lists)))
      (if (and (eq (car xml-list) 'link)
               (string= (cdr (assoc 'rel (second xml-list)))
                        "next"))
          (let ((uri (cdr (assoc 'href (second xml-list)))))
            (string-match ".+?page=\\(.+\\)" uri)
            (match-string 1 uri))
        (hatena-blog-writer.find-next-page-no (cdr xml-lists))))))


(defun hatena-blog-writer.api.entry.find.success (&rest result)
  "hatena-blog-writer.api.entry.find の success 関数"
  (let ((response (hatena-blog-writer.api.result.response result)))
    (dolist (xml-entry (hatena-blog-writer.api.response.entries response))
      (let ((entry (hbw-entry-from-xml xml-entry)))
        (hatena-blog-writer.entry.save.master   entry)
        (hatena-blog-writer.entry.save.contents entry)))))

(defun %hatena-blog-writer.api.entry.find (user blog success next-page)
  "entry を 複数取得する"
  (cl-assert (hbw-user-p user))
  (cl-assert (hbw-blog-p blog))
  (let ((hatena-id (hbw-user-id user))
        (hatena-blog-id (hbw-blog-id blog))
        (hatena-blog-api-key (hbw-blog-api-key blog)))
    (hatena-blog-writer-request :get
                                (hatena-blog-writer-api-entry-uri hatena-id
                                                                  hatena-blog-id)
                                hatena-id
                                hatena-blog-id
                                hatena-blog-api-key
                                (list :success success)
                                nil
                                next-page)))

(defun hatena-blog-writer.api.entry.find (user blog &optional next-page)
  (let ((success #'hatena-blog-writer.api.entry.find.success))
    (%hatena-blog-writer.api.entry.find user blog success next-page)))

(defun hatena-blog-writer.entry.fetch.all ()
  (interactive)
  (hatena-blog-writer.api.entry.find *hatena-blog-writer-current-user*
                                     *hatena-blog-writer-current-blog*))
