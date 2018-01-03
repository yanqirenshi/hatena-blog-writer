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

;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; API-ENTRY-GET
;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun %hatena-blog-writer-api-entry-get (user blog entry-id success)
  "entry を entry-id で取得する。"
  (assert (hatena-blog-writer-user-p user))
  (assert (hatena-blog-writer-blog-p blog))
  (let ((hatena-id (plist-get user :id))
        (hatena-blog-id (plist-get blog :id))
        (hatena-blog-api-key (plist-get blog :api-key)))
    (hatena-blog-writer-request :get
                                (hatena-blog-writer-api-entry-uri hatena-id
                                                                  hatena-blog-id
                                                                  entry-id)
                                hatena-id
                                hatena-blog-id
                                hatena-blog-api-key
                                (list :success success)
                                entry-id)))

(defun hatena-blog-writer-api-entry-get-success (&rest response)
  "hatena-blog-writer-api-entry-get のコールバック(success) 関数"
  (let ((entry (car (plist-get response :data))))
    (when (eq 'entry (car entry))
      (hatena-blog-writer-save-entry-master2 entry)
      (hatena-blog-writer-save-entry-contents2 entry))))

(defun hatena-blog-writer-api-entry-get (user blog entry-id)
  (let ((success #'hatena-blog-writer-api-entry-get-success))
    (%hatena-blog-writer-api-entry-get user blog entry-id success)))

;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; API-ENTRY-FIND
;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun %hatena-blog-writer-api-entry-find (user blog success)
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
                                (list :success success))))

(defun hatena-blog-writer-api-entry-find-success (&rest response)
  "hatena-blog-writer-api-entry-find の success 関数"
  (let ((data (car (plist-get response :data))))
    (dolist (element (car (xml-node-children data)))
      (when (eq 'entry (car element))
        (hatena-blog-writer-save-entry-master2 element)
        (hatena-blog-writer-save-entry-contents2 element)))))

(defun hatena-blog-writer-api-entry-find (user blog)
  (let ((success #'hatena-blog-writer-api-entry-find-success))
    (%hatena-blog-writer-api-entry-find user blog success)))
