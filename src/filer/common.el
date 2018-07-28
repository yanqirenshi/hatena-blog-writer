;;; -*- coding: utf-8; lexical-binding: t -*-

(defun hatena-blog-writer.dir.ensure (dir-name)
  (unless (file-exists-p dir-name)
    (make-directory dir-name))
  dir-name)

(defun hatena-blog-writer.hatena.dir.ensure ()
  (hatena-blog-writer.dir.ensure "~/.hatena/"))

(defun hatena-blog-writer.hatena-blog.dir.ensure ()
  (hatena-blog-writer.hatena.dir.ensure)
  (hatena-blog-writer.dir.ensure "~/.hatena/blog/"))

(defun hatena-blog-writer.user.dir.ensure (user)
  (hatena-blog-writer.hatena-blog.dir.ensure)
  (let ((dir-name (format "~/.hatena/blog/%s/"
                          (if (listp user) (plist-get user :id) user))))
    (hatena-blog-writer.dir.ensure dir-name)))

(defun hatena-blog-writer.blog.dir.ensure (user blog)
  (hatena-blog-writer.user.dir.ensure user)
  (let ((dir-name (format "~/.hatena/blog/%s/%s/"
                     (if (listp user) (plist-get user :id) user)
                     (if (listp blog) (plist-get blog :id) blog))))
    (hatena-blog-writer.dir.ensure dir-name)))

(defun hatena-blog-writer.entry.dir.ensure (user blog entry)
  (hatena-blog-writer.blog.dir.ensure user blog)
  (let ((dir-name (format "~/.hatena/blog/%s/%s/%s/"
                     (if (listp user)  (plist-get user  :id) user)
                     (if (listp blog)  (plist-get blog  :id) blog)
                     (if (listp entry) (plist-get entry :id) entry))))
    (hatena-blog-writer.dir.ensure dir-name)))

(defun hatena-blog-writer-ensure-dir-state-keyword2str (state)
  (cond ((keywordp 'state)
         (error "State is not keyword. state=%s" state))
        ((eq :published state) "published")
        ((eq :draft state) "draft")
        (t (error "Bad state. state=%s" state))))

(defun hatena-blog-writer-ensure-dir-hatena-blog-entry (user blog state entry)
  (hatena-blog-writer.dir.ensure.hatena-blog-user)
  (let ((dir (format "~/.hatena/blog/%s/%s/%s/%s/"
                     (plist-get user :id)
                     (plist-get blog :id)
                     (hatena-blog-writer-ensure-dir-state-keyword2str state)
                     (plist-get entry :id))))
    (unless (file-exists-p dir)
      (make-directory dir))))

(defun hatena-blog-writer-find-entry-dirs (user blog)
  (let ((blog-dir (hatena-blog-writer.dir.ensure.hatena-blog-user user blog)))
    (remove-if #'(lambda (dir)
                   (or (string= "." dir)
                       (string= ".." dir)))
               (directory-files blog-dir))))
