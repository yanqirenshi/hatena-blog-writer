;;; -*- coding: utf-8; lexical-binding: t -*-

(require 'xml)
(require 'url)
(require 'request)
(require 's)

(defvar *hatena-blog-writer-users*  nil
  "はてなユーザー")
;;  :group 'hatena-blog-writer

(defvar *hatena-blog-writer-blogs*  nil
  "はてなユーザーのブログリスト")

(defvar *hatena-blog-writer-current-user*  nil
  "選択されているはてなユーザー")

(defvar *hatena-blog-writer-current-blog*  nil
  "選択されているはてなユーザーのブログ")

(load "./src/utility.el")
(load "./src/filer.el")
(load "./src/xml.el")
;; /api
(load "./src/api/uri.el")
(load "./src/api/header.el")
(load "./src/api/request.el")
;; user and blog
(load "./src/user.el")
(load "./src/blog.el")
;; entry
(load "./src/entry/util.el")
(load "./src/entry/api-entry-get.el")
(load "./src/entry/api-entry-find.el")
(load "./src/entry/api-entry-post.el")

(hatena-blog-writer-load-users)
(hatena-blog-writer-load-blogs)

(provide 'hatena-blog-writer)
