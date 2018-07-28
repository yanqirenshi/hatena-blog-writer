;;; -*- coding: utf-8; lexical-binding: t -*-

(require 'xml)
(require 'url)
(require 'request)
(require 's)
(require 'f)

(load "./src/variables.el")
(load "./src/utility.el")
;; filer
(load "./src/filer/common.el")
(load "./src/filer/users.el")
(load "./src/filer/blogs.el")
(load "./src/filer/entry-master.el")
(load "./src/filer/entry-contents.el")
;; api
(load "./src/api/xml.el")
(load "./src/api/uri.el")
(load "./src/api/header.el")
(load "./src/api/request.el")
(load "./src/api/result.el")
(load "./src/api/response.el")
;; user and blog
(load "./src/user.el")
(load "./src/blog.el")
;; entry
(load "./src/entry/entry.el")
(load "./src/entry/entry.file.el")
(load "./src/entry/api-entry-get.el")
(load "./src/entry/api-entry-find.el")
(load "./src/entry/api-entry-post.el")
(load "./src/entry/api-entry-put.el")
;; major mode
(load "./src/mode/major-buffer-fields.el")
(load "./src/mode/major-buffer.el")
(load "./src/mode/major.el")

(hatena-blog-writer-load-users)
(hatena-blog-writer-load-blogs)

(provide 'hatena-blog-writer)
