;;; -*- coding: utf-8; lexical-binding: t -*-

(defun hatena-blog-writer-dir-hatena-blog (user blog)
  (assert user)
  (assert blog)
  (format "~/.hatena/blog/%s/%s/"
          (plist-get user :id)
          (plist-get blog :id)))

(defun hatena-blog-writer-ensure-dir-hatena ()
  (let ((dir "~/.hatena/"))
    (unless (file-exists-p dir)
      (make-directory dir))
    dir))

(defun hatena-blog-writer-ensure-dir-hatena-blog ()
  (hatena-blog-writer-ensure-dir-hatena)
  (let ((dir "~/.hatena/blog/"))
    (unless (file-exists-p dir)
      (make-directory dir))
    dir))

(defun hatena-blog-writer-ensure-dir-hatena-blog-user (user)
  (hatena-blog-writer-ensure-dir-hatena-blog)
  (let ((dir (format "~/.hatena/blog/%s/" (plist-get user :id))))
    (unless (file-exists-p dir)
      (make-directory dir))
    dir))

(defun hatena-blog-writer-ensure-dir-hatena-blog-blog (user blog)
  (hatena-blog-writer-ensure-dir-hatena-blog-user user)
  (let ((dir (format "~/.hatena/blog/%s/%s/"
                     (plist-get user :id)
                     (plist-get blog :id))))
    (unless (file-exists-p dir)
      (make-directory dir))
    dir))

(defun hatena-blog-writer-ensure-dir-state-keyword2str (state)
  (cond ((keywordp 'state)
         (error "State is not keyword. state=%s" state))
        ((eq :published state) "published")
        ((eq :draft state) "draft")
        (t (error "Bad state. state=%s" state))))

(defun hatena-blog-writer-ensure-dir-hatena-blog-entry (user blog state entry)
  (hatena-blog-writer-ensure-dir-hatena-blog-blog)
  (let ((dir (format "~/.hatena/blog/%s/%s/%s/%s/"
                     (plist-get user :id)
                     (plist-get blog :id)
                     (hatena-blog-writer-ensure-dir-state-keyword2str state)
                     (plist-get entry :id))))
    (unless (file-exists-p dir)
      (make-directory dir))))

(defun hatena-blog-writer-find-entry-dirs (user blog)
  (let ((blog-dir (hatena-blog-writer-ensure-dir-hatena-blog-blog user blog)))
    (remove-if #'(lambda (dir)
                   (or (string= "." dir)
                       (string= ".." dir)))
               (directory-files blog-dir))))
