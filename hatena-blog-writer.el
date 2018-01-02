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
(load "./src/api.el")
(load "./src/user.el")
(load "./src/blog.el")
(load "./src/entry.el")

(hatena-blog-writer-load-users)
(hatena-blog-writer-load-blogs)

(provide 'hatena-blog-writer)
