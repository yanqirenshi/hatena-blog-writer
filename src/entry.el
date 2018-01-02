;;; -*- coding: utf-8; lexical-binding: t -*-

(defun hatena-blog-writer-make-entry (id title)
  (list :id id :title title :class "entry"))

(defun hatena-blog-writer-entry-p (d)
  (when (listp d)
    (string= "entry"
             (getf d :class))))

(defun hatena-blog-writer-api-entry-get-parse-uri (uri)
  (when (string-match "https://blog.hatena.ne.jp/\\(.*\\)/\\(.*\\)/atom/entry/\\(.*\\)"
                      uri)
    (list :hatena-id (match-string 1 uri)
          :hatena-blog-id (match-string 2 uri)
          :hatena-blog-entry-id (match-string 3 uri))))

(defun hatena-blog-writer-api-entry-get-success (entry)
  (flet ((get-val (key elements)
                  (let ((element (assoc key elements)))
                    (caar (xml-node-children element))))
         (get-uri (element)
                    (cdr (assoc 'href
                                (xml-node-attributes
                                 (assoc 'link
                                        (car (xml-node-children element))))))))
    (print "1-")
    (let ((elements (car (xml-node-children entry)))
          (ids (hatena-blog-writer-api-entry-get-parse-uri (get-uri entry))))
      ;; 1. save master
      (hatena-blog-writer-save-entry-master (plist-get ids :hatena-id)
                                            (plist-get ids :hatena-blog-id)
                                            (plist-get ids :hatena-blog-entry-id)
                                            entry)
      ;; 2. save contents
      (hatena-blog-writer-save-entry-contents (plist-get ids :hatena-id)
                                              (plist-get ids :hatena-blog-id)
                                              (plist-get ids :hatena-blog-entry-id)
                                              (get-val 'title   elements)
                                              (get-val 'content elements)))))

(defun hatena-blog-writer-api-entry-get (user blog entry-id)
  (unless (hatena-blog-writer-user-p user)
    (error "Not user. user=%s" user))
  (unless (hatena-blog-writer-user-p user)
    (error "Not blo. blog=%s" blog))
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
                                (list :success (lambda (&rest response)
                                                 (condition-case e
                                                      (hatena-blog-writer-api-entry-get-success (car (plist-get response :data)))
                                                    (error (print e)))))
                                entry-id)))
