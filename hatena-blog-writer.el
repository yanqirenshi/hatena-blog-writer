(require 'xml)
(require 'url)
(require 'request)

(defcustom *hatena-blog-writer-user*  nil
  "はてなユーザー"
  :group 'hatena-blog-writer)

(defcustom *hatena-blog-writer-blogs*  nil
  "はてなユーザーのブログリスト"
  :group 'hatena-blog-writer)

(load "~/prj/hatena-blog-writer/src/xml.el")
(load "~/prj/hatena-blog-writer/src/api.el")
(load "~/prj/hatena-blog-writer/src/user.el")
(load "~/prj/hatena-blog-writer/src/blog.el")
(load "~/prj/hatena-blog-writer/src/entry.el")

(provide 'hatena-blog-writer-mode)
