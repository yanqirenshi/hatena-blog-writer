;;; -*- coding: utf-8; lexical-binding: t -*-

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

;;;
;;; save and load users
;;;
(defun hatena-blog-writer-save-users ()
  (let ((filename "~/.hatena/blog/config/users.lisp")
        (users *hatena-blog-writer-users*))
    (with-temp-buffer
      (insert (format "%S" users))
      (write-file filename))))

(defun hatena-blog-writer-load-users ()
  (let ((filename "~/.hatena/blog/config/users.lisp"))
    (with-temp-buffer
      (insert-file-contents filename)
      (setq *hatena-blog-writer-users* (read (buffer-string))))))

;;;
;;; save blogs
;;;
(defun hatena-blog-writer-save-blogs ()
  (let ((filename "~/.hatena/blog/config/blogs.lisp")
        (blogs *hatena-blog-writer-blogs*))
    (with-temp-buffer
      (insert (format "%S" blogs))
      (write-file filename))))

(defun hatena-blog-writer-load-blogs ()
  (let ((filename "~/.hatena/blog/config/blogs.lisp"))
    (with-temp-buffer
      (insert-file-contents filename)
      (setq *hatena-blog-writer-blogs* (read (buffer-string))))))

;;;
;;; save entry
;;;
(defun hatena-blog-writer-save-entry-file-name-at-id (type user-id blog-id entry-id)
  (format "~/.hatena/blog/%s/%s/%s/%s"
          user-id
          blog-id
          entry-id
          (cond ((string= "master" type) "master.el")
                ((string= "contents" type) "contents.md")
                (t error "Funck'n error! bad type. type=%s" type))))

(defun hatena-blog-writer-save-entry-file-name (type entry)
  (multiple-value-bind (user-id blog-id entry-id)
      (hatena-blog-writer-api-entry-get-parse-uri2 entry)
    (hatena-blog-writer-save-entry-file-name-at-id type
                                                   user-id
                                                   blog-id
                                                   entry-id)))

;;;
;;; save entry master
;;;
(defun hatena-blog-writer-save-entry-master (entry)
  (multiple-value-bind (user-id blog-id entry-id)
      (hatena-blog-writer-api-entry-get-parse-uri2 entry)
    (with-temp-buffer
      (insert (format "%S" entry))
      (write-file (hatena-blog-writer-save-entry-file-name "master" entry)))))

;;;
;;; save entry contents
;;;
(defun hatena-blog-writer-save-entry-contents (entry)
  (multiple-value-bind (user-id blog-id entry-id)
      (hatena-blog-writer-api-entry-get-parse-uri2 entry)
    (flet ((get-val (entry key)
                    (let ((elements (car (xml-node-children entry))))
                      (caar (xml-node-children (assoc key elements))))))
      (with-temp-buffer
        (setq save-buffer-coding-system 'utf-8-unix)
        (insert (format "%s\n" (get-val entry 'title)))
        (insert (format "%s" (get-val entry 'content)))
        (write-file (hatena-blog-writer-save-entry-file-name "contents" entry))))))

(defun hatena-blog-writer-load-entry-contents (user blog entry-id)
  (let ((filename (hatena-blog-writer-save-entry-file-name-at-id "contents"
                                                                 (plist-get user :id)
                                                                 (plist-get blog :id)
                                                                 entry-id)))
    (with-temp-buffer
      (insert-file-contents filename)
      (goto-char (point-min))
      (let ((str (buffer-string)))
        (if (string-match "^\\(.*\\)\n\\(\\(.\\|\n\\)+\\)$" str)
            (list :title (match-string 1 str)
                  :contents (match-string 2 str))
            (list :title "No Title"
                  :contents ""))))))
