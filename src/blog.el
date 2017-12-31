;;; -*- coding: utf-8; lexical-binding: t -*-

(defun hatena-blog-writer-make-blog (id name api-key)
  (list :id id :name name :api-key api-key
        :class "blog"))

(defun hatena-blog-writer-blog-p (d)
  (when (listp d)
    (string= "blog"
             (getf d :class))))

(defun %hatena-blog-writer-get-blog (blog-id blogs)
  (let* ((blog (car blogs))
         (_blog-id (plist-get blog :id)))
    (if (string= blog-id _blog-id)
        blog
      (%hatena-blog-writer-get-blog blog-id (cdr blogs)))))

(defun hatena-blog-writer-get-blog (blog-id)
  (hatena-blog-writer-get-data-at-id blog-id
                                     *hatena-blog-writer-blogs*))

(defun hatena-blog-writer-add-blog (blog)
  (unless (hatena-blog-writer-blog-p blog)
    (error "Error: data type is not blog. data=%s" blog))
  (when (hatena-blog-writer-get-blog (plist-get blog :id))
    (error "Error: aledy exist this blog. data=%s" blog))
  (let ((new-blogs (append *hatena-blog-writer-blogs* (list blog))))
      (setf *hatena-blog-writer-blogs* new-blogs)))

(defun hatena-blog-writer-change-blog (blog-id)
  (let ((blog (hatena-blog-writer-get-blog blog-id)))
    (unless blog
      (error "Not exit blog. blog-id=%s" blog-id))
    (setf *hatena-blog-writer-current-blog* blog)))
