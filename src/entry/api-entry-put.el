;;; -*- coding: utf-8; lexical-binding: t -*-

(defun hatena-blog-writer-build-master-find-tags (master)
  (labels ((find-tags (childs)
                      (when childs
                        (if (eq 'category (xml-node-name (car childs)))
                            (cons (cdr (assoc 'term (xml-node-attributes (car childs))))
                                  (find-tags (cdr childs)))
                          (find-tags (cdr childs))))))
    (find-tags (car (xml-node-children master)))))

(defun hatena-blog-writer-build-master-get-draft (master)
  "汚ないな、、、この関数、、、"
  (caar (xml-node-children
         (assoc 'app:draft
                (car (xml-node-children
                      (assoc 'app:control
                             (car (xml-node-children master)))))))))

(defun hatena-blog-writer-build-put-build-tags-xml (tags)
  "定義場所はここじゃぁないよなぁ。。。。"
  (if (not tags)
      ""
    (concat (format "<category term=\"%s\" />" (xml-escape-string (car tags)))
            (hatena-blog-writer-build-put-build-tags-xml (cdr tags)))))

(defun hatena-blog-writer-build-put-xml (user blog entry-id)
  (let ((contents (hatena-blog-writer-load-entry-contents user blog entry-id))
        (master (hatena-blog-writer-load-entry-master user blog entry-id)))
    (princ (format *hatena-blog-writer-request-xml-template*
                   ;; title
                   (xml-escape-string (plist-get contents :title))
                   ;; author
                   (plist-get user :id)
                   ;; content
                   (xml-escape-string (plist-get contents :contents))
                   ;; updated
                   (format-time-string "%y-%m-%dt%h:%m:%s")
                   ;; category
                   (hatena-blog-writer-request-xml-build-tags
                    (hatena-blog-writer-build-master-find-tags master))
                   ;; draft
                   (hatena-blog-writer-build-master-get-draft master)))))

(defun hatena-blog-writer-api-entry-put-success (&rest response)
  (message "PUT Finished!!")
  (let ((entry (car (plist-get response :data))))
    (when (eq 'entry (car entry))
      (hatena-blog-writer-save-entry-master entry)
      (message "Saved master!")
      (hatena-blog-writer-save-entry-contents entry)
      (message "Saved contents!"))))

(defun %hatena-blog-writer-api-entry-put (user blog entry-id)
  (request (hatena-blog-writer-api-entry-uri user blog entry-id)
           :type "PUT"
           :headers (hatena-blog-writer-request-headers user blog)
           :data (encode-coding-string (hatena-blog-writer-build-put-xml user blog entry-id)
                                       'utf-8)
           :parser *hatena-blog-writer-request-default-callback-parser*
           :success #'hatena-blog-writer-api-entry-put-success
           :error (lambda (&rest response)
                    (message "PUT Failed.\n%s" response))))

(defun hatena-blog-writer-api-entry-put (user blog entry-id)
  "contents.md の内容を WEB 上に PUT します。
最新の master の title と contents のみを変更して put します。"
  (lexical-let ((user user)
                (blog blog)
                (entry-id entry-id))
    (let ((callback (lambda ()
                      (%hatena-blog-writer-api-entry-put user blog entry-id))))
      (hatena-blog-writer-api-entry-get user blog entry-id
                                        :update :master
                                        :callback callback))))
