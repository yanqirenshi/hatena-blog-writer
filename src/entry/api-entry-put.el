;;; -*- coding: utf-8; lexical-binding: t -*-


(defun hatena-blog-writer-build-master-find-tags (master)
  (labels ((find-tags (childs)
                      (when childs
                        (if (eq 'category (xml-node-name (car childs)))
                            (cons (cdr (assoc 'term (xml-node-attributes (car childs))))
                                  (find-tags (cdr childs)))
                          (find-tags (cdr childs))))))
    (find-tags (car (xml-node-children master)))))


(defun hatena-blog-writer-build-put-xml (user blog entry-id)
  (let* ((contents (hatena-blog-writer-load-entry-contents user blog entry-id))
         (master (hatena-blog-writer-load-entry-master user blog entry-id))
         (tags (hatena-blog-writer-build-master-find-tags master)))
    (princ (format *hatena-blog-writer-post-xml-template*
                   ;; title
                   (xml-escape-string (plist-get contents :title))
                   ;; author
                   (plist-get user :id)
                   ;; content
                   (xml-escape-string (plist-get contents :contents))
                   ;; updated
                   (format-time-string "%Y-%m-%dT%H:%M:%S")
                   ;; category
                   ""
                   ;; draft
                   "yes"))))

(defun hatena-blog-writer-put (user blog entry-id)
  ;; reload master
  (hatena-blog-writer-api-entry-get user blog entry-id)
  ;; put request
  (request (hatena-blog-writer-api-entry-uri user blog entry-id)
           :type "PUT"
           :headers (hatena-blog-writer-request-headers user blog)
           :data (encode-coding-string xml
                                       (hatena-blog-writer-build-put-xml user blog entry-id)
                                       'utf-8)
           :parser 'buffer-string
           :success (function*
                     (lambda (&key data &allow-other-keys)
                       (message "I sent: %S" (assoc-default 'files data))))
           :error (lambda (&rest response)
                    (message response))))
