(defun hatena-blog-writer-ensure-dir-hatena ()
  (unless (file-exists-p "~/.hatena/")
    (make-directory "~/.hatena/")))

(defun hatena-blog-writer-ensure-dir-hatena-blog ()
  (hatena-blog-writer-ensure-dir-hatena)
  (unless (file-exists-p "~/.hatena/blog/")
    (make-directory "~/.hatena/blog/")))

(defun hatena-blog-writer-ensure-dir-hatena-blog-user (user)
  (hatena-blog-writer-ensure-dir-hatena-blog)
  (let ((dir (format "~/.hatena/blog/%s/" (plist-get user :id))))
    (unless (file-exists-p dir)
      (make-directory dir))))

(defun hatena-blog-writer-ensure-dir-hatena-blog-blog (user blog)
  (hatena-blog-writer-ensure-dir-hatena-blog-user)
  (let ((dir (format "~/.hatena/blog/%s/%s/"
                     (plist-get user :id)
                     (plist-get blog :id))))
    (unless (file-exists-p dir)
      (make-directory dir))))

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
