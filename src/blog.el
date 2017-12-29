(defun hatena-blog-writer-make-blog (id name api-key)
  (list :id id :name name :api-key api-key
        :class "blog"))

(defun hatena-blog-writer-blog-p (d)
  (when (listp d)
    (string= "blog"
             (getf d :class))))
