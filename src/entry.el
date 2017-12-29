(defun hatena-blog-writer-make-entry (id title)
  (list :id id :title title :class "entry"))

(defun hatena-blog-writer-entry-p (d)
  (when (listp d)
    (string= "entry"
             (getf d :class))))

(defun hatena-blog-writer-api-entry-get (hatena-id hatena-blog-id &optional entry-id)
  (let ((user *hatena-blog-writer-user*)
        (blog (hatena-blog-writer-get-blog hatena-blog-id))
        (uri (hatena-blog-writer-api-entry-uri hatena-id
                                               hatena-blog-id
                                               entry-id)))
    (hatena-blog-writer-request :get
                                uri
                                (plist-get user :id)
                                (plist-get blog :id)
                                (plist-get blog :api-key)
                                (list :success (cl-function
                                                (lambda (&key data &allow-other-keys)
                                                  (setq *tmp* data))))
                                entry-id)))
