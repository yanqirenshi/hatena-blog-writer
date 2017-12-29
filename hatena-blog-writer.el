(require 'xml)
(require 'url)
(require 'request)

(defcustom *hatena-blog-writer-user*  nil
  "はてなユーザー"
  :group 'hatena-blog-writer)

(defcustom *hatena-blog-writer-blogs*  nil
  "はてなユーザーのブログリスト"
  :group 'hatena-blog-writer)

(provide 'hatena-blog-writer-mode)
