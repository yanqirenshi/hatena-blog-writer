;;; -*- coding: utf-8; lexical-binding: t -*-

(defun hatena-blog-writer-find-next-page-no (xml-lists)
  (when xml-lists
    (let ((xml-list (car xml-lists)))
      (when (eq (car xml-list) 'link) (print xml-list))
      (if (and (eq (car xml-list) 'link)
               (string= (cdr (assoc 'rel (second xml-list)))
                        "next"))
          (let ((uri (cdr (assoc 'href (second xml-list)))))
            (print uri)
            (string-match ".+?page=\\(.+\\)" uri)
            (match-string 1 uri))
        (hatena-blog-writer-find-next-page-no (cdr xml-lists))))))


(defun %hatena-blog-writer-api-entry-find (user blog success next-page)
  "entry を 複数取得する"
  (assert (hatena-blog-writer-user-p user))
  (assert (hatena-blog-writer-blog-p blog))
  (let ((hatena-id (plist-get user :id))
        (hatena-blog-id (plist-get blog :id))
        (hatena-blog-api-key (plist-get blog :api-key)))
    (hatena-blog-writer-request :get
                                (hatena-blog-writer-api-entry-uri hatena-id
                                                                  hatena-blog-id)
                                hatena-id
                                hatena-blog-id
                                hatena-blog-api-key
                                (list :success success)
                                nil
                                next-page)))

(defun hatena-blog-writer-api-entry-find-success (&rest response)
  "hatena-blog-writer-api-entry-find の success 関数"
  (let ((data (car (plist-get response :data))))
    (dolist (element (car (xml-node-children data)))
      (when (eq 'entry (car element))
        (hatena-blog-writer-save-entry-master element)
        (hatena-blog-writer-save-entry-contents element)))
    ;; (let ((next-page (hatena-blog-writer-find-next-page-no (third data))))
    ;;   (hatena-blog-writer-api-entry-find *hatena-blog-writer-current-user*
    ;;                                      *hatena-blog-writer-current-blog*
    ;;                                      next-page))
    ))

(defun hatena-blog-writer-api-entry-find (user blog &optional next-page)
  (let ((success #'hatena-blog-writer-api-entry-find-success))
    (%hatena-blog-writer-api-entry-find user blog success next-page)))

(defun hatena-blog-writer-fetch-all ()
  (interactive)
  (hatena-blog-writer-api-entry-find *hatena-blog-writer-current-user*
                                     *hatena-blog-writer-current-blog*))
