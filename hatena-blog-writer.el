;;; -*- coding: utf-8; lexical-binding: t -*-

(require 'xml)
(require 'url)
(require 'request)

(defcustom *hatena-blog-writer-users*  nil
  "はてなユーザー"
  :group 'hatena-blog-writer)

(defcustom *hatena-blog-writer-blogs*  nil
  "はてなユーザーのブログリスト"
  :group 'hatena-blog-writer)

(defcustom *hatena-blog-writer-current-user*  nil
  "選択されているはてなユーザー"
  :group 'hatena-blog-writer)

(defcustom *hatena-blog-writer-current-blog*  nil
  "選択されているはてなユーザーのブログ"
  :group 'hatena-blog-writer)

(load "./src/utility.el")
(load "./src/filer.el")
(load "./src/xml.el")
(load "./src/api.el")
(load "./src/user.el")
(load "./src/blog.el")
(load "./src/entry.el")

(provide 'hatena-blog-writer)
